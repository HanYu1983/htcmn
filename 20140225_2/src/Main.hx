package ;

import cmd.ChangePage;
import cmd.ChangeTechPage;
import cmd.CloseAllTechPage;
import cmd.ClosePage;
import cmd.OnActiveBtnClick;
import cmd.OnHeaderBtnClick;
import cmd.OnHomeBtnClick;
import cmd.OnIntroBtnClick;
import cmd.OnResize;
import cmd.OnTechFrameBtnClick;
import cmd.OpenPopup;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flash.sampler.NewObjectSample;
import helper.Tool;
import org.vic.flash.loader.LoaderTask;
import page.ActivityPopup;
import page.FooterUI;
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
		WebManager.inst.addLayer( 'techui' );
		WebManager.inst.addLayer( 'ui' );
		WebManager.inst.addLayer( 'popup' );

		WebManager.inst.addCommand( new OnHeaderBtnClick("onHeaderBtnClick") );
		WebManager.inst.addCommand( new OnActiveBtnClick("onActiveBtnClick") );
		WebManager.inst.addCommand( new OnHomeBtnClick("onHomeBtnClick") );
		WebManager.inst.addCommand( new OnTechFrameBtnClick("onTechFrameBtnClick") );
		WebManager.inst.addCommand( new OnResize("onResize") );
		WebManager.inst.addCommand( new OnIntroBtnClick("onIntroBtnClick") );
		
		WebManager.inst.addCommand( new ChangeTechPage("ChangeTechPage") );
		WebManager.inst.addCommand( new ClosePage("ClosePage") );
		WebManager.inst.addCommand( new ChangePage("ChangePage") );
		WebManager.inst.addCommand( new OpenPopup("OpenPopup") );
		WebManager.inst.addCommand( new CloseAllTechPage("CloseAllTechPage") );
		
		function openPageSeries(clz:Array<Class<Dynamic>>, cb:Void->Void) {
			if (clz.length == 0) {
				return function() {
					cb();
				}
			}else{
				return function() {
					WebManager.inst.openPage( clz[0], openPageSeries( clz.slice(1, clz.length), cb) );
				}
			}
		}
		
		function finishLoad() {
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		openPageSeries([IntroPage, HeaderUI, FooterUI], finishLoad)();
	}
	
	private static function onResize(e: Event) {
		WebManager.inst.execute("onResize");
	}
	
}