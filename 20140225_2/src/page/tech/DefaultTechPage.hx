package page.tech;
import haxe.remoting.FlashJsConnection;
import helper.IResize;
import helper.TechFramePage;
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
	
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
		var frame = cast(getWebManager().getPage(TechFrame), TechFrame);
		var clz = Type.getClass(this);
		//frame.animateButtonByTechPage(  );
	}
}