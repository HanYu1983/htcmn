package ;

import caurina.transitions.Tweener;
import control.OnActiveBtnClick;
import control.OnFbLoginClick;
import control.OnFooterBtnClick;
import control.OnHeaderBtnClick;
import control.OnHomeBtnClick;
import control.OnIntroBtnClick;
import control.OnLuckyDrawBtnClick;
import control.OnDetailFormBtnClick;
import control.OnMessageBtnClick;
import control.OnMovieBtnClick;
import control.OnProductBtnClick;
import control.OnProductErrorPopupClick;
import control.OnProductPhotoBtnClick;
import control.OnTechDoubleBtnClick;
import control.OnTechCameraClick;
import control.OnTechFrameBtnClick;
import control.OnTechUltraBtnClick;
import flash.accessibility.ISimpleTextSelection;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.errors.Error;
import flash.events.Event;
import flash.external.ExternalInterface;
import flash.Lib;
import flash.media.SoundMixer;
import flash.net.URLLoader;
import flash.sampler.NewObjectSample;
import haxe.Http;
import haxe.Json;
import model.AppAPI;
import model.ETMAPI;
import helper.JSInterfaceHelper;
import control.SimpleController;
import helper.Tool;
import org.han.Async;
import org.vic.flash.loader.LoaderTask;
import org.vic.utils.BasicUtils;
import org.vic.web.IWebCommand2;
import org.vic.web.IWebView;
import view.ActivityPopup;
import view.ExpInfoPage;
import view.fb.DetailFromPopup;
import view.fb.FBLoginPopup;
import view.FooterUI;
import view.HeaderUI;
import org.vic.web.WebManager;
import view.HttpLoadingPage;
import view.IntroPage;
import view.LoadingPage;
import view.LoadingPage2;
import view.LuckyDrawPage;
import view.MessagePopup;
import view.MoviePage;
import view.ProductErrorPopup;
import view.ProductPage;
import view.RelativePage;
import view.TechPage;
import view.tech.TechBlink;
import view.tech.TechBoom;
import view.tech.TechCamera;
import view.tech.TechDouble;
import view.tech.TechDolby;
import view.tech.TechFrame;
import view.tech.TechPerson;
import view.tech.TechPhoto;
import view.tech.TechSitu;
import view.tech.TechUltra;
/**
 * ...
 * @author vic
 */

class Main 
{
	
	static function main() 
	{
		function log(msg:Dynamic) {
			SimpleController.onLog( msg );
		}
		
		function setupEnvironment( cb:Dynamic ) {
			try {
				try{
					JSInterfaceHelper.install();
				}catch (e:Error) {
					// ignore
				}
				var stage = Lib.current.stage;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				//stage.align = StageAlign.TOP_LEFT;
				// 沒有這行Tweener會出現例外
				Tweener.autoOverwrite = false;
				WebManager.inst.init( stage );
				WebManager.inst.getStage().addEventListener( Event.RESIZE, onResize );
				cb( null, null );
				
			}catch (err:Error) {
				cb( err, null );
				
			}
			
		}
		
		function setupWebManager( cb:Dynamic ) {
			WebManager.inst.log = log;
			WebManager.inst.setData( 'loadingClass', LoadingPage2 );
			
			WebManager.inst.addLayer( 'page' );
			WebManager.inst.addLayer( 'techpage' );
			WebManager.inst.addLayer( 'techui' );
			WebManager.inst.addLayer( 'footerui' );
			WebManager.inst.addLayer( 'ui' );
			WebManager.inst.addLayer( 'fakeStop' );
			WebManager.inst.addLayer( 'popup' );
			WebManager.inst.addLayer( 'loading' );
			
			WebManager.inst.addCommand( new OnMessageBtnClick("onMessageBtnClick") );
			WebManager.inst.addCommand( new OnHeaderBtnClick("onHeaderBtnClick") );
			WebManager.inst.addCommand( new OnActiveBtnClick("onActiveBtnClick") );
			WebManager.inst.addCommand( new OnHomeBtnClick("onHomeBtnClick") );
			WebManager.inst.addCommand( new OnTechFrameBtnClick("onTechFrameBtnClick") );
			WebManager.inst.addCommand( new OnTechDoubleBtnClick("onTechDoubleClick") );
			WebManager.inst.addCommand( new OnIntroBtnClick("onIntroBtnClick") );
			WebManager.inst.addCommand( new OnLuckyDrawBtnClick("onLuckyDrawBtnClick") );
			WebManager.inst.addCommand( new OnFbLoginClick("onFbLoginClick") );
			WebManager.inst.addCommand( new OnDetailFormBtnClick("onDetailFormBtnClick") );
			WebManager.inst.addCommand( new OnFooterBtnClick("onFooterBtnClick") );
			WebManager.inst.addCommand( new OnMovieBtnClick("onMovieBtnClick") );
			WebManager.inst.addCommand( new OnTechUltraBtnClick("onTechUltraBtnClick") );
			WebManager.inst.addCommand( new OnTechCameraClick("onTechCameraClick") );
			WebManager.inst.addCommand( new OnProductPhotoBtnClick("onProductPhotoBtnClick") );
			WebManager.inst.addCommand( new OnProductBtnClick("onProductBtnClick") );
			WebManager.inst.addCommand( new OnProductErrorPopupClick("onProductErrorPopupClick") );
			cb( null, null );
		}
		
		function loadConfig( cb:Dynamic ) {
			var http = new Http("config.json?v=" + Math.random());
			http.onData = function(data:String) {
				WebManager.inst.setData( 'config', Json.parse(data) );
				cb( null, null );
			}
			http.onError = function(err:String) {
				cb( new Error( err ), null );
			}
			http.request();
		}
		
		
		function loadSwf( cb:Dynamic ) {
			var config:Dynamic = WebManager.inst.getData( 'config' );
			BasicUtils.loadSwf( WebManager.inst, { name:'Preload', path:config.swfPath.Preload[ config.swfPath.Preload.which ] }, false, function() {
				BasicUtils.loadSwf( WebManager.inst, { name:'ActivePage', path:config.swfPath.ActivePage[ config.swfPath.ActivePage.which ]}, false, function() {
					cb( null, null );
				});
			});
		}
		
			
		function startApp( err:Error, result:Dynamic ) {
			if ( err != null ) {
				WebManager.inst.log( err.message );
				
			} else {
				WebManager.inst.log("startApp");
			}
		}
		
		function startWith( p:Class<IWebView> ) {
			
			function OpenTechFrameIfNeeded() {
				return switch( p ) {
						case 
							TechBlink |
							TechBoom |
							TechCamera |
							TechDouble |
							TechDolby |
							TechFrame |
							TechPerson |
							TechPhoto |
							TechSitu |
							TechUltra:
							AppAPI.openPage( { mgr:WebManager.inst, page:TechFrame, params: null } );
							
						case _:
							function( cb:Dynamic ) {
								cb( null, null );
							};
				}
			}
			
			Async.series(
				[
					setupEnvironment,
					setupWebManager,
					loadConfig,
					loadSwf,
					AppAPI.openPage( { mgr:WebManager.inst, page:HeaderUI, params: null } ),
					AppAPI.openPage( { mgr:WebManager.inst, page:FooterUI, params: null } ),
					// 這頁要放在HeaderUI, FooterUI後面, 因為會操控它們上升或下沉
					OpenTechFrameIfNeeded(),
					// 只有這頁needLoading=true, 必須要放在最後一個. 因為會動態切換loadingClass, 會導致不會關閉打開的loadingPage
					AppAPI.openPage( { mgr:WebManager.inst, page:p, params: null } )
				]
				, startApp );
		}
		
		try {
			ExternalInterface.addCallback( 'router', function(val) {
				var page : Class<IWebView> = switch( val ) {
					case 'TechPage': TechPage;
					case 'TechBlink': TechBlink;
					case 'TechBoom': TechBoom;
					case 'TechCamera': TechCamera;
					case 'TechDouble': TechDouble;
					case 'TechDolby': TechDolby;
					case 'TechFrame': TechFrame;
					case 'TechPerson': TechPerson;
					case 'TechPhoto': TechPhoto;
					case 'TechSitu': TechSitu;
					case 'TechUltra': TechUltra;
					
					case 'MoviePage': MoviePage;
					case 'RelativePage': RelativePage;
					case 'ProductPage': ProductPage;
					case 'ExpInfoPage': ExpInfoPage;
					
					case _: IntroPage;
				}
				startWith( page );
			});
			
			ExternalInterface.call( 'flashReady', null );
			
		}catch ( e:Error ) { 
			// means not in web
			#if debug
			startWith( TechDolby );
			#else
			startWith( IntroPage );
			#end
		}
	}
	
	static function onResize(e: Event) {
		SimpleController.onResize( WebManager.inst );
	}
}