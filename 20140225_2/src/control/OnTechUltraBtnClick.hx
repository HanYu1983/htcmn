package control;
import org.vic.web.WebCommand;
import view.tech.TechUltra;

/**
 * ...
 * @author han
 */
class OnTechUltraBtnClick extends WebCommand
{
	override public function execute(?args:Dynamic):Void {
		
		super.execute(args);
		var goto:Dynamic = {
			btn_onTechUltraBtnClick_skip: function() {
				var page = cast( getWebManager().getPage(TechUltra), TechUltra);
				page.skipAnimation();
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
		//trace(targetPage);
	}
}