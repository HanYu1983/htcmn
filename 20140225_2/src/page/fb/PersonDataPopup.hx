package page.fb;

/**
 * ...
 * @author han
 */
class PersonDataPopup extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = "popup";
		createDebugRoot("PersonDataPopup");
		createDebugButton("btn_onPersonDataBtnClick_submit", 0, 0);
	}
	
}