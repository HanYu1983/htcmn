package page;

import helper.IResize;
import helper.Tool;
import org.vic.web.WebView;

/**
 * ...
 * @author han
 */
class DefaultPage extends WebView implements IResize
{
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
		
		var target:Dynamic = Type.getClass(this);
		if (target == TechPage) {
			var header = cast(getWebManager().getPage(HeaderUI), HeaderUI);
			header.extendButtonVisible(true);
			header.animateShowBar(false);
		}else {
			var header = cast(getWebManager().getPage(HeaderUI), HeaderUI);
			header.extendButtonVisible(false);
			header.animateShowBar(true);
		}
		getWebManager().execute("onResize");
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
	}
	
	public function onResize(x:Int, y: Int, w:Int, h:Int) {
		Tool.center(this, x, y, w, h);
	}
}