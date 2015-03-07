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
	/*
	override function getSwfInfo():Dynamic 
	{
		return {name:'LoginPopup', path:'src/LoginPopup.swf' };
	}
	*/
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'LoginPopup' };
	}
}