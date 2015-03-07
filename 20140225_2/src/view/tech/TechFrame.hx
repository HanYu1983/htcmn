package view.tech;

import flash.errors.Error;
import model.AppAPI;
import helper.IResize;
import helper.Tool;
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

	public function new() 
	{
		super();
		layerName = 'techui';
	}
	
	public function nameBelongPage(pageClz:Dynamic):String {
		
		switch(pageClz) {
			case TechDouble:
				return "btn_onTechFrameBtnClick_Double";
			case TechDuby:
				return "btn_onTechFrameBtnClick_Duby";
			case TechUltra:
				return "btn_onTechFrameBtnClick_Ultra";
			case TechCamera:
				return "btn_onTechFrameBtnClick_Camera";
			case TechBlink:
				return "btn_onTechFrameBtnClick_blink";
			case TechBoom:
				return "btn_onTechFrameBtnClick_boom";
			case TechPerson:
				return "btn_onTechFrameBtnClick_person";
			case TechPhoto:
				return "btn_onTechFrameBtnClick_photo";
			case TechSitu:
				return "btn_onTechFrameBtnClick_situ";
			default:
				throw new Error("no this page");
		}
	}
	
	public function animateButtonByTechPage( pageClz:Dynamic ) {
		
		var disableBtnNames:Array<String> = [
			"btn_onTechFrameBtnClick_blink",
			"btn_onTechFrameBtnClick_boom",
			"btn_onTechFrameBtnClick_person",
			"btn_onTechFrameBtnClick_photo",
			"btn_onTechFrameBtnClick_situ"
		];
		
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
		return {name:'Righter', path:'src/Righter.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Righter', path:'Righter' };
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {
		getRoot().x = (w - 254);
		Tool.centerY(this, y, h);
	}
}