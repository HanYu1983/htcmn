package view;
import helper.Tool;

/**
 * ...
 * @author vic
 */
class TutorialMask extends DefaultPage
{
	public function new() {
		super();
		layerName = "techpage";
	}

	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'TutorialMask' };
	}
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		var fix_width = 1366.0;
		var fix_height = 768.0;
		Tool.centerForce( getRoot(), fix_width, fix_height, x, y, w, h );
	}
}