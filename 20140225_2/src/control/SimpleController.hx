package control;
import flash.display.Stage;
import flash.sampler.NewObjectSample;
import helper.IResize;
import model.AppAPI;
import org.vic.utils.BasicUtils;
import org.vic.web.IWebView;
import org.vic.web.WebManager;
import view.DefaultPage;
import view.FooterUI;
import view.HeaderUI;
import view.tech.DefaultTechPage;
import view.tech.TechFrame;

/**
 * ...
 * @author han
 */
class SimpleController
{
	public static function onLog(msg:Dynamic) {
		trace( msg );
	}
	
	public static function onResize( mgr:WebManager ) {
		var stage: Stage = mgr.getLayer("page").stage;
		var stageHeight:Int = stage.stageHeight;
		var stageWidth:Int = stage.stageWidth;
		
		function doResize(page:Dynamic) {
			if ( Std.is(page, IResize)) {
				var p:IResize = cast(page, IResize);
				p.onResize(0, 0, stageWidth, stageHeight);
			}
			return true;
		}
		
		var pages = mgr.getPages();
		Lambda.foreach(pages, doResize);
	}
	
	public static function onPageClose( mgr:WebManager, page: DefaultPage ) {
		
		function closeAllTechPage() {
			AppAPI.closeAllTechPage( { mgr:mgr } ) (null);
		}
		
		when( thePageIs(page, TechFrame), closeAllTechPage );
	}
	
	
	
	public static function onPageOpen( mgr:WebManager, page: DefaultPage ) {
		
		function handleHeaderAndFooterAnimation() {
			var header = cast(mgr.getPage(HeaderUI), HeaderUI);
			if (header != null) {
				var hasSuggestion = page.suggestionEnableAutoBarWhenOpen();
				if ( hasSuggestion == null ) {
					// nothing to do
				}else {
					header.autoBarEnable( hasSuggestion );
					
					var footerShouldAnimate = !hasSuggestion;
					var footer = cast(mgr.getPage(FooterUI), FooterUI);
					footer.animateShowBar( footerShouldAnimate );
				}
			}
		}
		
		function handleRighterAnimation() {
			var frame = cast(mgr.getPage(TechFrame), TechFrame);
			var clz = Type.getClass(page);
			frame.animateButtonByTechPage(clz);
		}
		
		handleHeaderAndFooterAnimation();
		when( thePageIs(page, DefaultTechPage), handleRighterAnimation );
		
	}
	
	static function thePageIs( page:DefaultPage, type:Class<IWebView>):Void->Bool {
		return function() {
			return Std.is(page, type);
		}
	}
	
	static function when( fn:Void->Bool, fn2: Void->Void ) {
		if ( fn() ) {
			fn2();
		}
	}
}