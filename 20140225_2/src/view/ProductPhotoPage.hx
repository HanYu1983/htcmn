package view;
import caurina.transitions.Tweener;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import helper.Tool;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class ProductPhotoPage extends DefaultPage
{
	var mc_photoContainer:DisplayObjectContainer;
	var mc_imgmask: DisplayObject;
	var sprite:Sprite = new Sprite();
	var _mc_dot:MovieClip;
	var _mc_bar:MovieClip;
	
	public function new() {
		super();
		layerName = "popup";
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_photoContainer':
					mc_photoContainer = cast( obj, DisplayObjectContainer );
				case 'mc_imgmask':
					mc_imgmask = obj;
				case 'mc_dot':
					_mc_dot = cast( obj, MovieClip );
				case 'mc_bar':
					_mc_bar = cast( obj, MovieClip );
			}
		});
		
		_originDot = _mc_dot.y;
		
		var photo = cast( param.photo, BitmapData );
		var bitmap = new Bitmap( photo );
		bitmap.x = -bitmap.width / 2;
		bitmap.y = -bitmap.height / 2;
		
		sprite.addChild(bitmap);
				
		mc_photoContainer.addChild( sprite );
		
		_mc_bar.buttonMode = true;
		_mc_bar.addEventListener( MouseEvent.CLICK, onMouseClickSlideBar );
		
		_mc_dot.buttonMode = true;
		_mc_dot.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownDot );
		
		sprite.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownMask );
		getRoot().addEventListener( MouseEvent.MOUSE_UP, onMouseUpMask );
		getRoot().addEventListener( Event.ENTER_FRAME, onEnterFrame );
		
		super.onOpenEvent(param, cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		getRoot().removeEventListener( Event.ENTER_FRAME, onEnterFrame );
		sprite.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDownMask );
		getRoot().removeEventListener( MouseEvent.MOUSE_UP, onMouseUpMask );
		_mc_bar.removeEventListener( MouseEvent.CLICK, onMouseClickSlideBar );
		super.onCloseEvent(cb);
	}
	
	function onEnterFrame( e:Event ) {
		if ( isDragOffset ) {
			movePhotoOffset();
		}
		if ( isDragDot ) {
			moveDot();
		}
	}
	
	function moveDot() {
		var local = _mc_bar.globalToLocal( new Point(stage.mouseX, stage.mouseY) );
		// 使用local.x(X)的原因是mc_bar在flash中被旋轉了90%, 所以x和y要對調
		// *scaleX也是因為被縮放過, 使用scaleX也是因為被旋轉了
		var per = 1.0 - (local.x* _mc_bar.scaleX / _mc_bar.height);
		var currScale = per + 1;
		var offsetScale = currScale - _scale;
		
		scalePhoto( offsetScale );
	}
	
	function onMouseClickSlideBar( e:MouseEvent ) {
		moveDot();
	}
	
	var isDragDot = false;
	
	function onMouseDownDot( e:MouseEvent ) {
		isDragDot = true;
	}
	
	var isDragOffset = false;
	var dragOrigin:Point = null;
	var dragOffset:Point = new Point();
	
	function onMouseDownMask( e:MouseEvent ) {
		isDragOffset = true;
		dragOrigin = new Point( stage.mouseX, stage.mouseY );
	}
	
	function onMouseUpMask( e:MouseEvent ) {
		isDragOffset = isDragDot = false;
		dragOffset = new Point( sprite.x, sprite.y );
	}
	
	function movePhotoOffset() {
		var currPoint = new Point( stage.mouseX, stage.mouseY );
		var offset = currPoint.subtract( dragOrigin );
		
		sprite.x = offset.x/ _scale + dragOffset.x;
		sprite.y = offset.y/ _scale + dragOffset.y;
	
		boundingPhotoOffset();
	}
	
	var _originDot:Float;
	
	public function setDotPosition( v:Float ) {
		var ty =  _originDot - (v - 1) * _mc_bar.height;
		Tweener.addTween( _mc_dot, { y: ty, time:.3 } );
	}
	
	function boundingPhotoOffset() {
		Tool.regionBounding( sprite, mc_imgmask );
	}
	
	var _scale = 1.0;
	
	public function scalePhoto( v: Float ) {
		_scale += v;
		_scale = Math.min( _scale, 2 );
		_scale = Math.max( 1, _scale );
		
		var newscale = (_scale - 1) * 1 + 1; // 1 ~ 2
		Tweener.addTween( mc_photoContainer, { scaleX: newscale, scaleY: newscale, time:.3, onUpdate: boundingPhotoOffset } );
		setDotPosition( _scale );
	}
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		if ( _mc_popup != null ) {
			Tool.centerForce(_mc_popup, 829, 494, x, y, w, h );
		}
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'BigPhotoPopup' };
	}
}