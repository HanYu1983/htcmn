package page;

import helper.IResize;
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
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
		
		var target:Dynamic = Type.getClass(this);
		var shouldHideBar:Bool = target == TechPage || target == TechFrame || Std.is(this, DefaultTechPage);
		if ( shouldHideBar ) {
			var header = cast(getWebManager().getPage(HeaderUI), HeaderUI);
			if (header != null) {
				header.extendButtonVisible(true);
				header.animateShowBar(false);
			}
		}else {
			var header = cast(getWebManager().getPage(HeaderUI), HeaderUI);
			if (header != null) {
				header.extendButtonVisible(false);
				header.animateShowBar(true);
			}
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