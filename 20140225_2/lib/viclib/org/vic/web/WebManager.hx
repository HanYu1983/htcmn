package org.vic.web;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Stage;
import flash.errors.Error;
import flash.external.ExternalInterface;
import org.vic.flash.loader.LoaderManager;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author vic
 */
class WebManager
{
	public static var inst:WebManager = new WebManager();
	
	private var _extra:Map<String, Dynamic> = new Map();
	private var _stage:Stage;
	private var _rootLayer:DisplayObjectContainer = new Sprite();
	
	private var _ary_layer:Map<String, DisplayObjectContainer> = new Map();
	private var _ary_page:Map<String, IWebView> = new Map();
	private var _ary_command:Map<String, IWebCommand> = new Map();
	
	private function new() { }
	
	public function init( s:Stage ):Void {
		_stage = s;
		_stage.addChild( _rootLayer );
		
		getLoaderManager().addEventListener( LoaderManager.START_LOADING, onStartLoading );
		getLoaderManager().addEventListener( LoaderManager.STOP_LOADING, onStopLoading );
	}
	
	public function getPages():Map<String, IWebView> {
		return _ary_page;
	}
	
	private function onStartLoading( e ) {
		openLoading();
	}
	
	private function onStopLoading( e ) {
		closeLoading();
	}
	
	public function getStage():Stage {
		return _stage;
	}
	
	public function setData( k:String, v:Dynamic ):Void {
		//trace( 'set extra data, key: ' + k + ', value: ' + v );
		_extra.set( k, v );
	}
	
	public function getData( k:String ):Dynamic {
		//trace( 'get extra data, key: ' + k + ', value: ' + _extra.get( k ) );
		return _extra.get( k );
	}
	
	public function removeData( k:String ):Void {
		//trace( 'remove extra data, key: ' + k );
		_extra.remove( k );
	}
	
	public function openLoading( ?cb:Void->Void):Void {
		if ( _extra.get( 'loadingClass' ) == null )	return;
		if ( !_ary_layer.exists( 'loading' ) )	throw 'does not have layer for loading, please add it!';
		openPage( _extra.get( 'loadingClass' ), cb );
	}
	
	public function closeLoading():Void {
		if ( _extra.get( 'loadingClass' ) == null )	return;
		closePage( _extra.get( 'loadingClass' ) );
	}
	
	public function setMask( mw:Float, mh:Float ):Void {
		var mask:Sprite = new Sprite();
		BasicUtils.drawRect( mask.graphics, 0, 1, mw, mh );
		_rootLayer.addChild( mask );
		_rootLayer.mask = mask;
	}
	
	public function addCommand( c:IWebCommand ):Void {
		if ( _ary_command.exists( c.getName()))	throw 'already have the name of command';
		_ary_command.set( c.getName(), c );
	}
	
	public function addLayer( n:String ):Void {
		if ( _ary_layer.exists( n ))	throw 'already have the name of layer';
		var l:DisplayObjectContainer = new Sprite();
		_ary_layer.set( n, l );
		_rootLayer.addChild( l );
	}
	
	public function getLayer( n:String ):DisplayObjectContainer {
		if ( _ary_layer.exists( n ))	return _ary_layer.get( n );
		return null;
	}
	
	public function getPage( c:Class<Dynamic> ):IWebView {
		var n = Type.getClassName( c );
		return _ary_page.get( n );
	}
	
	public function getLoaderManager():LoaderManager {
		return LoaderManager.inst;
	}
	
	public function openPage( c:Class<Dynamic>, param:Dynamic, ?cb:Void->Void ):Void {
		var n:String = Type.getClassName( c );
		if ( _ary_page.exists( n ))	return;
		var p:IWebView = Type.createInstance( c, [] );
		var ln = p.layerName;
		if ( !_ary_layer.exists( ln ))	throw 'does not have the layer';
		_ary_page.set( n, p );
		p.open( param, cb );
		var l:DisplayObjectContainer = getLayer( ln );
		l.addChild( cast( p, DisplayObject ));
	}
	
	public function closePage( c:Class<Dynamic>, ?cb:Void->Void ):Void {
		var n:String = Type.getClassName( c );
		if ( !_ary_page.exists( n ))	return;
		var p:IWebView = _ary_page.get( n );
		p.close( cb );
		_ary_page.remove( n );
	}
	
	public function closePageByLayer( ln:String ):Void {
		if ( !_ary_layer.exists( ln ))	return;
		for ( p in _ary_page ) {
			if ( p.layerName == ln ) {
				closePage( Type.getClass( p ));
			}
		}
	}
	
	public function execute( cn:String, ?org:Dynamic ):Void {
		if ( _ary_command.exists( cn )) {
			_ary_command.get( cn ).execute( org );
		}else { /*trace( 'does not have the name of command, name: ', cn );*/ }
	}
	
	public function callWeb( fn:String, ?org:Dynamic ):Dynamic {
		try {
			//trace( 'call web: ' + fn );
			return ExternalInterface.call( fn, org );
		}catch ( e:Error ) { return null; }
	}
	
	public function addWebListener( fn:String, func:Dynamic->Void ):Void {
		try {
			//trace( 'addListener: ' + fn );
			ExternalInterface.addCallback( fn, func );
		}catch ( e:Error ) { }
	}
}