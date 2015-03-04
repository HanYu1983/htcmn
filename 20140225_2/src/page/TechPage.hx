package page;
import flash.geom.Point;
import helper.Tool;
import org.vic.web.BasicButton;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class TechPage extends DefaultPage
{
	var _btnF:Map<BasicButton, Point>;
	
	public function new() 
	{
		super();
		layerName = 'page';
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		_btnF = getBtnF();
		disableUnavailableButton();
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
		Tool.center( getRoot(), x, y, w, h, 0.5, 0.1);
		//centerButton( x, y, w, h );
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
		
		Lambda.foreach( disableBtnNames.map( getButton ), enable( false ) );
	}
}