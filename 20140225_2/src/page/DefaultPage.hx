package page;

import helper.IResize;
import helper.SimpleController;
import helper.Tool;
import org.vic.web.WebView;
import page.tech.DefaultTechPage;
import page.tech.TechFrame;

/**
 * ...
 * @author han
 */
class DefaultPage extends WebView implements IResize
{
	public function new() {
		super();
		needLoading = true;
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		SimpleController.onPageOpen( getWebManager(), this );
		
		getWebManager().execute("onResize");
	}
	
	public function suggestionEnableAutoBarWhenOpen():Null<Bool> {
		return null;
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
	}
	
	public function onResize(x:Int, y: Int, w:Int, h:Int) {
		Tool.center(this, x, y, w, h);
	}
}