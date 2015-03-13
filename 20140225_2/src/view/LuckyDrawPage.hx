package view;
import helper.IPopup;

/**
 * ...
 * @author han
 */
class LuckyDrawPage extends DefaultPage implements IPopup
{

	public function new() 
	{
		super();
		layerName = 'popup';
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'LuckyDrawPopup' };
	}
}