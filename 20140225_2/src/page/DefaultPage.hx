package page;

import org.vic.web.WebView;

/**
 * ...
 * @author han
 */
class DefaultPage extends WebView
{
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
		getWebManager().execute("onResize");
	}
}