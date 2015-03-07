package view;

/**
 * ...
 * @author han
 */
class MessagePopup extends DefaultPage
{
	public function new() 
	{
		super();
		layerName = "popup";
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'ThanksPopup' };
	}
}