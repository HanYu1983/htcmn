package ;

import cmd.ChangePage;
import cmd.ClosePage;
import cmd.OnActiveBtnClick;
import cmd.OnHeaderBtnClick;
import cmd.OpenPopup;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import page.ActivityPopup;
import page.HeaderUI;
import org.vic.web.WebManager;
import page.IntroPage;
import page.TechPage;
/**
 * ...
 * @author vic
 */

class Main 
{
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		//stage.align = StageAlign.TOP_LEFT;
		// entry point
		
		WebManager.inst.init( stage );
		WebManager.inst.addLayer( 'page' );
		WebManager.inst.addLayer( 'popup' );
		WebManager.inst.addLayer( 'ui' );

		WebManager.inst.addCommand( new OnHeaderBtnClick("onHeaderBtnClick") );
		WebManager.inst.addCommand( new OnActiveBtnClick("onActiveBtnClick") );
		WebManager.inst.addCommand( new ClosePage("ClosePage") );
		WebManager.inst.addCommand( new ChangePage("ChangePage") );
		WebManager.inst.addCommand( new OpenPopup("OpenPopup") );
		
		WebManager.inst.openPage( IntroPage );
		WebManager.inst.openPage( HeaderUI );
		trace("DD");
	}
	
}