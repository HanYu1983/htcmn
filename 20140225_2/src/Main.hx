package ;

import cmd.ChangePage;
import cmd.ChangeTechPage;
import cmd.ClosePage;
import cmd.OnActiveBtnClick;
import cmd.OnHeaderBtnClick;
import cmd.OnHomeBtnClick;
import cmd.OnResize;
import cmd.OnTechFrameBtnClick;
import cmd.OpenPopup;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flash.sampler.NewObjectSample;
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
		WebManager.inst.addLayer( 'techpage' );
		WebManager.inst.addLayer( 'popup' );
		WebManager.inst.addLayer( 'ui' );

		WebManager.inst.addCommand( new OnHeaderBtnClick("onHeaderBtnClick") );
		WebManager.inst.addCommand( new OnActiveBtnClick("onActiveBtnClick") );
		WebManager.inst.addCommand( new OnHomeBtnClick("onHomeBtnClick") );
		WebManager.inst.addCommand( new OnTechFrameBtnClick("onTechFrameBtnClick") );
		WebManager.inst.addCommand( new OnResize("onResize") );
		
		WebManager.inst.addCommand( new ChangeTechPage("ChangeTechPage") );
		WebManager.inst.addCommand( new ClosePage("ClosePage") );
		WebManager.inst.addCommand( new ChangePage("ChangePage") );
		WebManager.inst.addCommand( new OpenPopup("OpenPopup") );
		
		WebManager.inst.openPage( IntroPage );
		WebManager.inst.openPage( HeaderUI );

		stage.addEventListener( Event.RESIZE, onResize );
	}
	
	private static function onResize(e: Event) {
		WebManager.inst.execute("onResize");
	}
	
}