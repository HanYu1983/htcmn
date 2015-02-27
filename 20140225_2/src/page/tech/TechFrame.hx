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
	
	public function nameBelongPage(pageClz:Class<IWebView>):String {
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
	
	public function animateButtonByTechPage( pageClz:Class<IWebView> ) {
		var btnNames:Array<String> = [
			"btn_onTechFrameBtnClick_Double",
			"btn_onTechFrameBtnClick_Duby"
		];
		
		function getButton(name:String):BasicButton {
			return this.getButtonsByName(name);
		}
		
		function enable(v:Bool):Dynamic{
			return function(btn:BasicButton) {
				btn.enable(v);
			}
		}
		
		function gotoAndPlay(label:String):Dynamic {
			return function(btn:BasicButton) {
				btn.getShape().gotoAndPlay(label);
			}
		}
		
		var btns:List<BasicButton> = Lambda.map(btnNames, getButton);
		Lambda.foreach(btns, enable(false));
		Lambda.foreach(btns, gotoAndPlay("close"));
		
		var thisBtn = getButton(this.nameBelongPage(pageClz));
		enable(false)(thisBtn);
		gotoAndPlay("open")(thisBtn);
	}
	
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'Righter', path:'src/Righter.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Righter', path:'Righter' };
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
		getWebManager().execute("CloseAllTechPage");
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {
		getRoot().x = w - getRoot().width;
		Tool.centerY(this, y, h);
	}
}