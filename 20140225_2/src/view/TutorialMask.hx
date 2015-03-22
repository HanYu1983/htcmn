package view;

/**
 * ...
 * @author vic
 */
class TutorialMask extends DefaultPage
{
	public function new() {
		layerName = "popup";
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TutorialMask', path:'src/Preload.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TutorialMask', path:'TutorialMask' };
	}	
}