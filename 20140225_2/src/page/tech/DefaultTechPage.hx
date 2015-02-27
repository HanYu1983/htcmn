package page.tech;
import helper.IResize;
import helper.Tool;

/**
 * ...
 * @author han
 */
class DefaultTechPage extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = 'techpage';
	}
	
	override public function onResize(x:Int, y: Int, w:Int, h:Int) {
		Tool.center(this, x, y, w, h);
	}
}