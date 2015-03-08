package view;

import org.vic.web.WebView;

/**
 * ...
 * @author han
 */
class HttpLoadingPage extends WebView
{

	public function new() 
	{
		super();
		layerName = 'loading';
		createDebugRoot("loading page");
	}
}