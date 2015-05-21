package view.tech;

import flash.display.DisplayObject;
import flash.errors.Error;
import model.AppAPI;
import helper.IResize;
import helper.Tool;
import model.Const;
import org.vic.utils.BasicUtils;
import org.vic.web.BasicButton;
import org.vic.web.IWebView;
import org.vic.web.WebView;
import view.DefaultPage;

/**
 * ...
 * @author ...
 */

class TechFrame extends DefaultPage
{
	public static var TECH_DOUBLE:Int = 1;
	
	var mc_righterBottom:DisplayObject;
	var mc_righter:DisplayObject;

	public function new() 
	{
		super();
		layerName = 'techui';
		needLoading = false;
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return true;
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_righterBottom':
					mc_righterBottom = obj;
				case 'mc_righter':
					mc_righter = obj;
			}
		});
		
		super.onOpenEvent(param, cb);
	}
	
	public function nameBelongPage(pageClz:Dynamic):String {
		
		switch(pageClz) {
			case TechDouble:
				return "btn_onTechFrameBtnClick_Double";
			case TechDolby:
				return "btn_onTechFrameBtnClick_Duby";
			case TechUltra:
				return "btn_onTechFrameBtnClick_Ultra";
			case TechCamera:
				return "btn_onTechFrameBtnClick_Camera";
			case TechBlink:
				return "btn_onTechFrameBtnClick_blink";
			case TechConnect:
				return "btn_onTechFrameBtnClick_boom";
			case TechTheme:
				return "btn_onTechFrameBtnClick_person";
			case TechPhoto:
				return "btn_onTechFrameBtnClick_photo";
			case TechAssist:
				return "btn_onTechFrameBtnClick_situ";
			default:
				throw new Error("no this page");
		}
	}
	
	public function animateButtonByTechPage( pageClz:Dynamic ) {
		
		var disableBtnNames = if ( Const.OPEN_ALL_TECH_PAGE ) {
				[];
			} else {
				[
					"btn_onTechFrameBtnClick_blink",
					//"btn_onTechFrameBtnClick_boom",
					//"btn_onTechFrameBtnClick_person",
					//"btn_onTechFrameBtnClick_photo",
					//"btn_onTechFrameBtnClick_situ"
				];
			}
		
		var btnNames:Array<String> = [
			"btn_onTechFrameBtnClick_Double",
			"btn_onTechFrameBtnClick_Duby",
			"btn_onTechFrameBtnClick_Ultra",
			"btn_onTechFrameBtnClick_Camera",
			"btn_onTechFrameBtnClick_blink",
			"btn_onTechFrameBtnClick_boom",
			"btn_onTechFrameBtnClick_person",
			"btn_onTechFrameBtnClick_photo",
			"btn_onTechFrameBtnClick_situ"
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
		
		function gotoAndPlay(label:String):Dynamic {
			return function(btn:BasicButton) {
				var isAnimateClose = label == "close";
				var isOpenNow = btn.getShape().currentLabel == "open";
				if ( isAnimateClose ){
					if (isOpenNow)
						btn.getShape().gotoAndPlay(label);
				}else
					btn.getShape().gotoAndPlay(label);
				return true;
			}
		}
		// 播放收回動畫並使按鈕可作用
		var otherNames = Lambda.filter(btnNames, function(name) { return name != nameBelongPage(pageClz); } );
		var btns:List<BasicButton> = Lambda.map(otherNames, getButton);
		Lambda.foreach(btns, enable(true));
		Lambda.foreach(btns, gotoAndPlay("close"));
		
		// 將這頁所代表的鈕按播放打開動畫並使按鈕無作用
		var thisBtn = getButton(nameBelongPage(pageClz));
		enable(false)(thisBtn);
		gotoAndPlay("open")(thisBtn);
		
		// 關閉還沒開放的按鈕
		btns =  Lambda.map( disableBtnNames, getButton );
		Lambda.foreach( btns, enable( false ) );
		Lambda.foreach( btns, alpha(0.3) );
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'Righter', path:config.swfPath.Righter[ config.swfPath.Righter.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Righter', path:'Righter' };
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {
		if( mc_righter != null ){
			mc_righter.x = (w - 254);
			Tool.centerForceY(mc_righter, 590, y, h, 0.7 );
		}
		
		if ( mc_righterBottom != null ) {
			mc_righterBottom.x =  w - mc_righterBottom.width - 22;
			mc_righterBottom.y = h - 56;
		}
	}
}