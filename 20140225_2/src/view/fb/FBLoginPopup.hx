package view.fb;

import view.DefaultPage;

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
		
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'LoginPopup' };
	}
}