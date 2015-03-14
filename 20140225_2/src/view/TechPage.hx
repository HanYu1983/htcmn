package view;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.media.SoundMixer;
import helper.IHasAnimationShouldStop;
import helper.Tool;
import org.vic.utils.BasicUtils;
import org.vic.web.BasicButton;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class TechPage extends DefaultPage implements IHasAnimationShouldStop
{
	var _btnF:Map<BasicButton, Point>;
	var mc_person:MovieClip;
	
	public function new() 
	{
		super();
		layerName = 'page';
		useFakeLoading = true;
	}
	
	public function stopAllAnimation() {
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			if ( Std.is( obj, MovieClip ) ) {
				cast( obj, MovieClip).stop();
			}
		});
		SoundMixer.stopAll();
	}
	
	public function resumeAllAnimation() {
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			if ( Std.is( obj, MovieClip ) ) {
				var mc = cast( obj, MovieClip );
				if ( mc.currentFrame > mc.totalFrames ) {
					return;
				}
				mc.play();
			}
		});
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_person':
					mc_person = cast( obj, MovieClip );
			}
		});
		
		super.onOpenEvent(param, cb);
		_btnF = getBtnF();
		disableUnavailableButton();
		
		getRoot().addEventListener( 'on_flv_B_respond_01_finish', on_flv_B_respond_finish );
		getRoot().addEventListener( 'on_flv_B_respond_02_finish', on_flv_B_respond_finish );
		getRoot().addEventListener( 'on_flv_B_respond_03_finish', on_flv_B_respond_finish );
		getRoot().addEventListener( 'on_flv_B_respond_04_finish', on_flv_B_respond_finish );
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechFront', path:'src/TechFront.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechFront', path:'TechFront' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return true;
	}
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		if ( _mc_item != null ) {
			var fix_width = 1366.0;
			var fix_height = 768.0;
			
			if ( w < fix_width ) {
				var scale = Math.max(w, 1024.0) / fix_width;
				_mc_item.scaleX = _mc_item.scaleY = scale;
				Tool.centerForce( _mc_item, fix_width * scale, fix_height * scale, x, y, w, h, .5, .6 );
				_mc_item.y = 50;
			} else {
				_mc_item.scaleX = _mc_item.scaleY = 1;
				Tool.centerForce( _mc_item, fix_width, fix_height, x, y, w, h, .5, .6 );
			}
		}
		
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
			_mc_back.visible = false;
		}
		
		if ( mc_person != null ) {
			Tool.center( mc_person, x, y, w, h, .5, .6 );
		}
		
	}
	
	var btnName = '';
	public function onBtnEnterClick( btnName:String ):Void {
		this.btnName = btnName;
		getRoot().dispatchEvent( new Event( btnName ));
	}
	
	function on_flv_B_respond_finish( e ) {
		//跳頁
		trace( this.btnName );
	}
	
	function getBtnF():Map<BasicButton, Point> {
		var x = getRoot().x;
		var y = getRoot().y;
		var w = getRoot().width;
		var h = getRoot().height;
		
		var disableBtnNames:Array<String> = [
			"btn_onHomeBtnClick_Double",
			"btn_onHomeBtnClick_Duby",
			"btn_onHomeBtnClick_Ultra",
			"btn_onHomeBtnClick_Camera",
			"btn_onHomeBtnClick_blink",
			"btn_onHomeBtnClick_boom",
			"btn_onHomeBtnClick_person",
			"btn_onHomeBtnClick_photo",
			"btn_onHomeBtnClick_situ"
		];
		
		function getButton(name:String):BasicButton {
			return this.getButtonsByName(name);
		}
		
		var btnF = Lambda.fold( 
			disableBtnNames.map( getButton ), 
			function( btn:BasicButton, ops:Map<BasicButton, Point> ):Map<BasicButton, Point> {
				ops.set( btn, new Point( (btn.getShape().x -x) / cast(w, Float), (btn.getShape().y - y) / cast(h, Float)));
				return ops;
			}, 
			new Map<BasicButton, Point>() 
		);
		
		return btnF;
	}
	
	function centerButton(x:Int, y:Int, w:Int, h:Int) {
		if ( _btnF == null )
			return;
		
		var disableBtnNames:Array<String> = [
			"btn_onHomeBtnClick_Double",
			"btn_onHomeBtnClick_Duby",
			"btn_onHomeBtnClick_Ultra",
			"btn_onHomeBtnClick_Camera",
			"btn_onHomeBtnClick_blink",
			"btn_onHomeBtnClick_boom",
			"btn_onHomeBtnClick_person",
			"btn_onHomeBtnClick_photo",
			"btn_onHomeBtnClick_situ"
		];
		
		function getButton(name:String):BasicButton {
			return this.getButtonsByName(name);
		}
		
		function interplot():Dynamic{
			return function(btn:BasicButton) {
				if (!_btnF.exists(btn)) {
					return true;
				}
				var f = _btnF.get(btn);
				btn.getShape().x = x + w * f.x;
				btn.getShape().y = y + h * f.y;
				
				return true;
			}
		}
		
		Lambda.foreach( disableBtnNames.map( getButton ), interplot() );
		
	}
	
	function disableUnavailableButton() {
		var disableBtnNames:Array<String> = [
			"btn_onHomeBtnClick_blink",
			"btn_onHomeBtnClick_boom",
			"btn_onHomeBtnClick_person",
			"btn_onHomeBtnClick_photo",
			"btn_onHomeBtnClick_situ"
		];
		
		function getButton(name:String):BasicButton {
			return this.getButtonsByName(name);
		}
		
		function enable(v:Bool):Dynamic{
			return function(btn:BasicButton) {
				btn.enable(v);
				return true;
			}
		}
		
		function alpha(v:Float):Dynamic {
			return function(btn:BasicButton) {
				btn.getShape().alpha = v;
				return true;
			}
		}
		var btns = disableBtnNames.map( getButton );
		Lambda.foreach( btns, enable( false ) );
		Lambda.foreach( btns, alpha( 0.8 ) );
	}
}