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
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import flash.text.TextField;
import flash.ui.Keyboard;
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
	var photoBelong:Map<String, String> = new Map<String, String>();
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
		
		txt_input.addEventListener( KeyboardEvent.KEY_UP, onInputKeyUp );
		
		super.onOpenEvent(param, cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		for ( block in photoBlocks ) {
			block.removeEventListener( MouseEvent.CLICK, onPhotoBlockClick );
		}
		txt_input.removeEventListener( KeyboardEvent.KEY_UP, onInputKeyUp );
		txt_input.removeEventListener( FocusEvent.FOCUS_IN, onInputFocusIn );
		txt_input.removeEventListener( FocusEvent.FOCUS_OUT, onInputFocusOut );
		txt_input.removeEventListener( Event.CHANGE, onInputChange );
		super.onCloseEvent(cb);
	}
	
	function onPhotoBlockClick( e:Event ) {
		SimpleController.onProductPagePhotoBlockClick( this, e.currentTarget.name );
	}
	
	public function getPhotoWithBlockName( name:String ):String {
		return photoBelong.get(name);
	}
	
	public function getInput():String {
		return userInput;
	}
	
	function onInputKeyUp( e:KeyboardEvent ) {
		if ( e.keyCode == Keyboard.ENTER ) {
			SimpleController.onProductPageSearch( this );
		}
	}
	
	var userInput:String = "";
	
	function onInputFocusIn( e:FocusEvent ) {
		if ( userInput == "" ) {
			txt_input.text = "";
		}
	}
	
	function onInputFocusOut( e:FocusEvent ) {
		if ( userInput == "" ) {
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
					var photo = cast(photoList[i].thumb, Bitmap);
					
					var container = cast( photoBlocks[i].getChildByName("mc_photocontainer"), MovieClip);
					photo.width = photoBlocks[i].width;
					photo.height = photoBlocks[i].height;
					container.mouseChildren = container.mouseEnabled = false;
					container.addChild( photo );
					
					container.alpha = 0;
					Tweener.addTween( container, { alpha:1, time:1, delay: Math.random() * 2 } );
					
					photoBelong.set( photoBlocks[i].name, photoList[i].photo );
				}
				
			}
		}
		AppAPI.fetchPhoto( { mobile: null } ) (fetchDone);
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'ProductPage', path:config.swfPath.ProductPage[ config.swfPath.ProductPage.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'ProductPage', path:'ProductPage' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
}