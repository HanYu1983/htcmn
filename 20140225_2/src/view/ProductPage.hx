package view;
import caurina.transitions.Tweener;
import control.SimpleController;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.errors.Error;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import flash.text.TextField;
import helper.Tool;
import model.AppAPI;
import model.Const;
import model.ETMAPI;
import org.han.Async;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class ProductPage extends DefaultPage
{
	var photoBlocks:Array<DisplayObjectContainer> = new Array<DisplayObjectContainer>();
	var photoBelong:Map<String, BitmapData> = new Map<String, BitmapData>();
	var txt_input:TextField;
	
	public function new() 
	{
		super();
		layerName = 'page';
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{	
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'txt_input':
					txt_input = cast( obj , TextField );
				case 'mc_p1' |
					 'mc_p2' |
					 'mc_p3' |
					 'mc_p4' |
					 'mc_p5' |
					 'mc_p6' |
					 'mc_p7' |
					 'mc_p8' |
					 'mc_p9' |
					 'mc_p10' |
					 'mc_p11' |
					 'mc_p12' |
					 'mc_p13' |
					 'mc_p14':
					photoBlocks.push( cast(obj, DisplayObjectContainer) );
			}
		});
		
		fetchPhotoAndDisplay();
		
		onInputFocusOut(null);
		
		for ( block in photoBlocks ) {
			cast( block, MovieClip ).buttonMode = true;
			block.addEventListener( MouseEvent.CLICK, onPhotoBlockClick );
		}
		
		txt_input.addEventListener( FocusEvent.FOCUS_IN, onInputFocusIn );
		txt_input.addEventListener( FocusEvent.FOCUS_OUT, onInputFocusOut );
		txt_input.addEventListener( Event.CHANGE, onInputChange );
		
		super.onOpenEvent(param, cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		for ( block in photoBlocks ) {
			block.removeEventListener( MouseEvent.CLICK, onPhotoBlockClick );
		}
		
		txt_input.removeEventListener( FocusEvent.FOCUS_IN, onInputFocusIn );
		txt_input.removeEventListener( FocusEvent.FOCUS_OUT, onInputFocusOut );
		txt_input.removeEventListener( Event.CHANGE, onInputChange );
		super.onCloseEvent(cb);
	}
	
	function onPhotoBlockClick( e:Event ) {
		SimpleController.onProductPagePhotoBlockClick( this, e.target.name );
		
	}
	
	public function getPhotoWithBlockName( name:String ):BitmapData {
		return photoBelong.get(name);
	}
	
	public function getInput():String {
		return userInput;
	}
	
	var userInput:String = "";
	
	function onInputFocusIn( e:FocusEvent ) {
		if ( userInput == "" ) {
			txt_input.text = "";
		}
	}
	
	function onInputFocusOut( e:FocusEvent ) {
		if ( userInput == "" ) {
			//txt_input.text = Const.MSG_INPUT_FOR_PRODUCT;
			txt_input.text = getWebManager().getData( 'config' ).message.msg_input_for_product;
		}
	}
	
	function onInputChange( e:Event ) {
		userInput = txt_input.text;
	}
	
	function fetchPhotoAndDisplay() {
		function fetchDone( err:Error, photoList:Dynamic ) {
			if ( err != null ) {
				SimpleController.onError( err.message );
				
			} else {
				for ( i in 0...photoList.length ) {
					var photo = cast(photoList[i], Bitmap);
					
					var container = cast( photoBlocks[i].getChildByName("mc_photocontainer"), MovieClip);
					photo.width = photoBlocks[i].width;
					photo.height = photoBlocks[i].height;
					container.mouseChildren = container.mouseEnabled = false;
					container.addChild( photo );
					
					container.alpha = 0;
					Tweener.addTween( container, { alpha:1, time:1, delay: Math.random() * 2 } );
					
					photoBelong.set( photoBlocks[i].name, photo.bitmapData );
				}
				
			}
		}
		AppAPI.fetchPhoto( { mobile: null } ) (fetchDone);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'ProductPage', path:'src/ProductPage.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'ProductPage', path:'ProductPage' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		if ( _mc_item != null ) {
			Tool.centerForce( _mc_item, 1366, 768, x, y, w, h, 0.5, 0.2 );
		}
		if ( _mc_popup != null ) {
			Tool.center(_mc_popup, x, y, w, h);
		}
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
	}
}