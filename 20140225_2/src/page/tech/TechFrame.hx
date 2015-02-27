package page.tech;

import helper.IResize;
import helper.Tool;
import org.vic.web.WebView;

/**
 * ...
 * @author ...
 */
class TechFrame extends DefaultPage implements IResize
{

	public function new() 
	{
		super();
		layerName = 'page';
		
		this.createDebugRoot("TechFrame", 100, 600);
		
		this.createDebugButton("btn_onTechFrameBtnClick_Double", 0, 0);
		this.createDebugButton("btn_onTechFrameBtnClick_Duby", 0, 20);
		this.createDebugButton("btn_onTechFrameBtnClick_Ultra", 0, 40);
		this.createDebugButton("btn_onTechFrameBtnClick_Camera", 0, 60);
		this.createDebugButton("btn_onTechFrameBtnClick_person", 0, 80);
		this.createDebugButton("btn_onTechFrameBtnClick_situ", 0, 100);
		this.createDebugButton("btn_onTechFrameBtnClick_blink", 0, 120);
		this.createDebugButton("btn_onTechFrameBtnClick_photo", 0, 140);
		this.createDebugButton("btn_onTechFrameBtnClick_boom", 0, 160);
	}
	
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
	}
	
	public function onResize(x:Int, y: Int, w:Int, h:Int) {
		getRoot().x = w - getRoot().width;
		Tool.centerY(this, y, h);
	}
}