package control;

import org.vic.web.WebCommand;
import view.tech.TechCamera;

/**
 * ...
 * @author han
 */
class OnTechCameraClick extends WebCommand
{
	override public function execute(?args:Dynamic):Void {
		super.execute(args);
		var goto:Dynamic = {
			btn_onTechCameraClick_plus: function() {
				var page = cast(getWebManager().getPage(TechCamera), TechCamera);
				page.scalePhoto( 0.2 );
			},
			btn_onTechCameraClick_sub: function() {
				var page = cast(getWebManager().getPage(TechCamera), TechCamera);
				page.scalePhoto( -0.2 );
			},
			btn_onTechCameraClick_switch: function() {
				var page = cast(getWebManager().getPage(TechCamera), TechCamera);
				page.animateForSmartPhone( page.taggleCircleButton() );
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
		getWebManager().log( targetPage );
	}
}