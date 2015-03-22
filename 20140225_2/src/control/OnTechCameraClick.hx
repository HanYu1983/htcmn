package control;

import org.vic.web.WebCommand;
import view.tech.TechCamera;

/**
 * ...
 * @author han
 */
class OnTechCameraClick extends DefaultCommand
{
	override public function execute(?args:Dynamic):Void {
		super.execute(args);
		var goto:Dynamic = {
			btn_onTechCameraClick_plus: function() {
				var page = cast(getWebManager().getPage(TechCamera), TechCamera);
				page.scalePhoto( 0.2 );
				page.requestWaitAnimation();
			},
			btn_onTechCameraClick_sub: function() {
				var page = cast(getWebManager().getPage(TechCamera), TechCamera);
				page.scalePhoto( -0.2 );
				page.requestWaitAnimation();
			},
			btn_onTechCameraClick_switch: function() {
				var page = cast(getWebManager().getPage(TechCamera), TechCamera);
				page.animateForSmartPhone( page.taggleCircleButton() );
				page.requestWaitAnimation();
			}/*,
			btn_onTechCameraClick_skip:function() {
				var page = cast( getWebManager().getPage(TechCamera), TechCamera);
				page.skipAnimation();
			}*/
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
		getWebManager().log( targetPage );
	}
}