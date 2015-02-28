package page.fb;

import page.DefaultPage;

/**
 * ...
 * @author han
 */
class FBLoginPopup extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = "popup";
		createDebugRoot("FBLoginPopup");
		createDebugButton("btn_onFbLoginClick_login", 0, 0 );
	}
	
}