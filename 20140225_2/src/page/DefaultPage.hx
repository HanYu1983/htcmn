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
		
		var header = cast(getWebManager().getPage(HeaderUI), HeaderUI);
		if (header != null) {
			var hasSuggestion = suggestionEnableAutoBarWhenOpen();
			if ( hasSuggestion == null ) {
				// nothing to do
			}else {
				header.autoBarEnable( hasSuggestion );
			}
		}
		
		getWebManager().execute("onResize");
	}
	
	function suggestionEnableAutoBarWhenOpen():Null<Bool> {
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