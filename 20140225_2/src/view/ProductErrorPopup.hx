package view;
import helper.IPopup;

/**
 * ...
 * @author han
 */
class ProductErrorPopup extends DefaultPage implements IPopup
{

	public function new() 
	{
		super();
		layerName = "popup";
		//createDebugButton("btn_onInputMobileAgain
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'ProductErrorPopup' };
	}
}