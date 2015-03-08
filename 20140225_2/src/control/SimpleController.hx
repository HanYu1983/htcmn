package control;
import flash.display.Stage;
import flash.errors.Error;
import flash.external.ExternalInterface;
import flash.media.SoundMixer;
import flash.sampler.NewObjectSample;
import helper.IResize;
import model.AppAPI;
import org.vic.utils.BasicUtils;
import org.vic.web.IWebView;
import org.vic.web.WebManager;
import view.DefaultPage;
import view.FooterUI;
import view.HeaderUI;
import view.HttpLoadingPage;
import view.LoadingPage;
import view.tech.DefaultTechPage;
import view.tech.TechFrame;

/**
 * ...
 * @author han
 */
class SimpleController
{
	
	public static function onPageNew( page:DefaultPage ) {
		function changeLoadingClass( clz:Class<IWebView> ) {
			return function() {
				page.getWebManager().setData('loadingClass', clz);
			}
		}
		
		when( thePageIs( page, DefaultTechPage ), 
			changeLoadingClass(LoadingPage) )
			
		.otherwise( 
			changeLoadingClass(LoadingPage) );
	}
	
	public static function onHttpLoadingStart() {
		WebManager.inst.openPage( HttpLoadingPage, null );
	}
	
	public static function onHttpLoadindEnd() {
		WebManager.inst.closePage( HttpLoadingPage );
	}
	
	public static function onError(msg:Dynamic) {
		try {
			ExternalInterface.call( 'alert', msg );
			ExternalInterface.call( 'console.log', msg );
		} catch (e:Error) {
			onLog(msg);
		}
	}
	
	public static function onLog(msg:Dynamic) {
		#if debug
		trace( msg );
		#else
		try {
			ExternalInterface.call( 'console.log', msg );
		} catch (e:Error) {
		}
		#end
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
		SoundMixer.stopAll();
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
			if ( frame == null ) {
				return;
			}
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
			return {
				otherwise: function( fn: Void->Void ) {
					
				}
			}
		
		} else {
			return {
				otherwise: function( fn: Void->Void ) {
					fn();
				}
			}
		}
		
	}
}