package control;
import flash.display.Stage;
import flash.errors.Error;
import flash.external.ExternalInterface;
import flash.media.SoundMixer;
import flash.sampler.NewObjectSample;
import helper.IResize;
import helper.JSInterfaceHelper;
import model.AppAPI;
import org.vic.utils.BasicUtils;
import org.vic.web.IWebView;
import org.vic.web.WebManager;
import view.DefaultPage;
import view.FooterUI;
import view.HeaderUI;
import view.HttpLoadingPage;
import view.LoadingPage;
import view.LoadingPage2;
import view.tech.DefaultTechPage;
import view.tech.TechBlink;
import view.tech.TechBoom;
import view.tech.TechCamera;
import view.tech.TechDolby;
import view.tech.TechDouble;
import view.tech.TechFrame;
import view.tech.TechPerson;
import view.tech.TechPhoto;
import view.tech.TechSitu;
import view.tech.TechUltra;
import view.TechPage;
using Lambda;

/**
 * ...
 * @author han
 */
class SimpleController
{
	
	public static function onDefaultTechPageAnimationEnded( p:DefaultTechPage ) {
		function setSkipButtonVisible( b:Bool ) {
			return function() {
				var header = cast(p.getWebManager().getPage(HeaderUI), HeaderUI);
				if (header != null) {
					header.setSkipButtonVisible( b );
				}
			}
		}
		
		setSkipButtonVisible( false )();
	}
	
	public static function onHeaderSkipButtonClick() {
		for ( page in WebManager.inst.getPages() ) {
			if ( Std.is(page, DefaultTechPage) ) {
				var p = cast(page, DefaultTechPage);
				p.skipAnimation();
				
				SoundMixer.stopAll();
			}
		}
	}
	/**
	 * 將新頁將被開啟時觸發. 用來處理動態切換讀取頁的效果
	 * @param	page 將被開啟的那頁
	 */
	public static function onPageNew( page:DefaultPage ) {
		function changeLoadingClass( clz:Class<IWebView> ) {
			return function() {
				page.getWebManager().setData('loadingClass', clz);
			}
		}
		
		when( or( [thePageIs( page, TechPage ), thePageIs( page, DefaultTechPage ) ] ), 
			changeLoadingClass(LoadingPage) )
			
		.otherwise( 
			changeLoadingClass(LoadingPage2) );
			
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
		try {
			ExternalInterface.call( 'console.log', msg );
		} catch (e:Error) {
		
		}
		#else
		
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
		
		function handleChangeHash() {
			var hash =
				if (Std.is(page, TechPage)) {
					"TechPage";
				} else if (Std.is(page, TechBlink)) {
					"TechBlink";
				} else if (Std.is(page, TechBoom)) {
					"TechBoom";
				} else if (Std.is(page, TechCamera)) {
					"TechCamera";
				} else if (Std.is(page, TechDouble)) {
					"TechDouble";
				} else if (Std.is(page, TechDolby)) {
					"TechDolby";
				} else if (Std.is(page, TechPerson)) {
					"TechPerson";
				} else if (Std.is(page, TechPhoto)) {
					"TechPhoto";
				} else if (Std.is(page, TechSitu)) {
					"TechSitu";
				} else if (Std.is(page, TechUltra)) {
					"TechUltra";
				} else {
					null;
				}
			if( hash != null )
				JSInterfaceHelper.callJs( 'changeHash', [hash], function(info:Dynamic) {});
		}
		
		function handleSkipButtonVisible() {
			
			function setSkipButtonVisible( b:Bool ) {
				return function() {
					var header = cast(mgr.getPage(HeaderUI), HeaderUI);
					if (header != null) {
						header.setSkipButtonVisible( b );
					}
				}
			}
			
			// 必須略過TechFrame, 不然它又呼叫setSkipButtonVisible( false ). 因為有時候TechFrame的open會在DefaultTechPage的open之後(!?)
			if ( Std.is( page, TechFrame ) ) {
				// nothing
			} else if ( Std.is( page, DefaultTechPage ) ) {
				setSkipButtonVisible( true ) ();
			} else {
				setSkipButtonVisible( false ) ();
			}
		}
		
		handleHeaderAndFooterAnimation();
		when( thePageIs(page, DefaultTechPage), handleRighterAnimation );
		handleChangeHash();
		handleSkipButtonVisible();
	}
	
	
	static function and( fns:Array<Dynamic> ) {
		return function():Bool {
			return [for (fn in fns) fn()].exists( function(item:Bool) { return item == false; } ) == false;
		}
	}
	
	static function or( fns:Array<Dynamic> ) {
		return function():Bool {
			return [for (fn in fns) fn()].exists( function(item:Bool) { return item == true; } );
		}
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