package view;

/**
 * ...
 * @author han
 */
class LuckyDrawPage extends DefaultPage
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