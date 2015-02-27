package page.tech;

import flash.errors.Error;
import helper.IResize;
import helper.TechFramePage;
import helper.Tool;
import org.vic.web.BasicButton;
import org.vic.web.IWebView;
import org.vic.web.WebView;

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
		
		trace(pageClz);
		
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
		var otherNames = Lambda.filter(btnNames, function(name) { return name != nameBelongPage(pageClz); } );
		var btns:List<BasicButton> = Lambda.map(otherNames, getButton);
		Lambda.foreach(btns, enable(true));
		Lambda.foreach(btns, gotoAndPlay("close"));
		
		var thisBtn = getButton(nameBelongPage(pageClz));
		enable(false)(thisBtn);
		gotoAndPlay("open")(thisBtn);
	}
	
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		getWebManager().execute("CloseAllTechPage");
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