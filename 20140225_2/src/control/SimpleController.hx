package control;
import flash.display.Bitmap;
import flash.display.Stage;
import flash.errors.Error;
import flash.external.ExternalInterface;
import flash.media.SoundMixer;
import flash.sampler.NewObjectSample;
import helper.IHasAnimationShouldStop;
import helper.IPopup;
import helper.IResize;
import helper.JSInterfaceHelper;
import model.AppAPI;
import org.vic.utils.BasicUtils;
import org.vic.web.IWebView;
import org.vic.web.WebManager;
import view.DefaultPage;
import view.ExpInfoPage;
import view.FakeStopPage;
import view.FooterUI;
import view.HeaderUI;
import view.HttpLoadingPage;
import view.IntroPage;
import view.LoadingPage;
import view.LoadingPage2;
import view.MoviePage;
import view.ProductPage;
import view.ProductPhotoPage;
import view.RelativePage;
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
	
	public static function onProductPageSearch( page:ProductPage ) {
		OnProductBtnClick.fetchPhotoAndOpenProductPhotoPage( page.getWebManager(), page.getInput() );
		
	}
	
	public static function onFlvBRespondFinished( targetPage :String ) {
		
		function thenOpen(clz:Class<IWebView>) {
			return function(err:Error, result:Dynamic) {
				if ( err != null ) {
					SimpleController.onError( err.message );
					
				} else {
					AppAPI.changeTechPage( { mgr:WebManager.inst, page: clz, params: null } ) (null);
				}
			}
		}
		
		var goto:Dynamic = {
			btn_onHomeBtnClick_Double: function() {
				AppAPI.changePage( 
					{ 
						mgr:WebManager.inst, 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechDouble));
			},
			btn_onHomeBtnClick_Duby: function() {
				AppAPI.changePage( 
					{ 
						mgr:WebManager.inst, 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechDolby));
			},
			btn_onHomeBtnClick_Ultra: function() {
				AppAPI.changePage( 
					{ 
						mgr:WebManager.inst, 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechUltra));
			},
			btn_onHomeBtnClick_Camera: function() {
				AppAPI.changePage( 
					{ 
						mgr:WebManager.inst, 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechCamera));
			},
			btn_onHomeBtnClick_person: function() {
				AppAPI.changePage( 
					{ 
						mgr:WebManager.inst, 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechPerson));
			},
			btn_onHomeBtnClick_situ: function() {
				AppAPI.changePage( 
					{ 
						mgr:WebManager.inst, 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechSitu));
			},
			btn_onHomeBtnClick_blink: function() {
				AppAPI.changePage( 
					{ 
						mgr:WebManager.inst, 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechBlink));
			},
			btn_onHomeBtnClick_photo: function() {
				AppAPI.changePage( 
					{ 
						mgr:WebManager.inst, 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechPhoto));
			},
			btn_onHomeBtnClick_boom: function() {
				AppAPI.changePage( 
					{ 
						mgr:WebManager.inst, 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechBoom));
			}
		}
		Reflect.field(goto, targetPage)();
	}
	
	
	public static function onProductPagePhotoBlockClick( page:ProductPage, name:String ) {
		var url = page.getPhotoWithBlockName( name );
		if ( url == null )
			return;
		onHttpLoadingStart();
		AppAPI.getImageFromURL( { url: url } )( function( err:Error, bitmap:Bitmap ) {
			SimpleController.onHttpLoadindEnd();
			page.getWebManager().openPage( ProductPhotoPage, { photo: bitmap.bitmapData } );
		} );
	}
	
	static function setSkipButtonVisible( b:Bool ) {
		return function() {
			var header = cast( WebManager.inst.getPage(HeaderUI), HeaderUI);
			if (header != null) {
				header.setSkipButtonVisible( b );
			}
		}
	}
	
	public static function onDefaultTechPageAnimationEnded( p:DefaultTechPage ) {
		setSkipButtonVisible( false )();
	}
	
	public static function onHeaderSkipButtonClick() {
		setSkipButtonVisible( false )();
		
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
		
		// 科技相關頁面都是艙門
		when( or( [thePageIs( page, TechPage ), thePageIs( page, DefaultTechPage ) ] ), 
			// 艙門讀取頁
			changeLoadingClass(LoadingPage) )
			
		.otherwise( 
			// 圓圏讀取頁
			changeLoadingClass(LoadingPage2) );
			
	}
	
	public static function onHttpLoadingStart() {
		WebManager.inst.openPage( HttpLoadingPage, null );
	}
	
	public static function onHttpLoadindEnd() {
		WebManager.inst.closePage( HttpLoadingPage );
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
		
		function resumeTechPageAnimation() {
			for ( p in page.getWebManager().getPages() ) {
				if ( Std.is( p, IHasAnimationShouldStop ) ) {
					cast(p , IHasAnimationShouldStop).resumeAllAnimation();
				}
			}
		}
		
		SoundMixer.stopAll();
		
		when( thePageIs(page, TechFrame), closeAllTechPage );
		when( thePageIs(page, IPopup), resumeTechPageAnimation );
	}
	
	public static function onPageOpen( mgr:WebManager, page: DefaultPage ) {
		
		function handleHeaderAndFooterAnimation() {
			var header = cast(mgr.getPage(HeaderUI), HeaderUI);
			if (header != null) {
				var hasSuggestion = page.suggestionEnableAutoBarWhenOpen();
				if ( hasSuggestion == null ) {
					// nothing to do
				}else {
					// 特殊處理: 因為上移到回首頁按鈕時header未必呈打開狀態, 所以強制將它打開
					if ( Std.is( page, IntroPage ) ) {
						header.animateShowBar( true );
						header.extendButtonVisible(false);
					}
					
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
				if (Std.is(page, IntroPage)) {
					"index";
				} else if (Std.is(page, TechPage)) {
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
					
				} else if (Std.is(page, MoviePage)) {
					"MoviePage";
				} else if (Std.is(page, RelativePage)) {
					"RelativePage";
				} else if (Std.is(page, ProductPage)) {
					"ProductPage";
				} else if (Std.is(page, ExpInfoPage)) {
					"ExpInfoPage";
					
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
			if ( Std.is( page, TechFrame ) || Std.is( page, IPopup ) ) {
				// nothing
			} else if ( Std.is( page, DefaultTechPage ) ) {
				setSkipButtonVisible( true ) ();
			} else {
				setSkipButtonVisible( false ) ();
			}
		}
		
		function stopTechPageAnimation() {
			for ( p in page.getWebManager().getPages() ) {
				if ( Std.is( p, IHasAnimationShouldStop ) ) {
					cast(p , IHasAnimationShouldStop).stopAllAnimation();
				}
			}
		}
		
		handleHeaderAndFooterAnimation();
		when( thePageIs(page, DefaultTechPage), handleRighterAnimation );
		handleChangeHash();
		handleSkipButtonVisible();
		when( thePageIs(page, IPopup), stopTechPageAnimation );
	}
	
	public static function onError(msg:Dynamic) {
		try {
			ExternalInterface.call( 'alert', msg );
			ExternalInterface.call( 'console.log', msg );
		} catch (e:Error) {
			onLog(msg);
		}
	}
	
	public static function onAlert(msg:Dynamic) {
		try {
			ExternalInterface.call( 'alert', msg );
		} catch (e:Error) {
		
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
	
	public static function stagePause( stage:Stage ) {
		SoundMixer.stopAll();
		WebManager.inst.openPage( FakeStopPage, BasicUtils.drawDisplayObject( stage ) );
	}
	
	public static function stageStart() {
		WebManager.inst.closePage( FakeStopPage );
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