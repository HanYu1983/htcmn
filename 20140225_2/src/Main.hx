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
import control.OnTechFrameBtnClick;
import flash.accessibility.ISimpleTextSelection;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.errors.Error;
import flash.events.Event;
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
import view.ActivityPopup;
import view.fb.DetailFromPopup;
import view.fb.FBLoginPopup;
import view.FooterUI;
import view.HeaderUI;
import org.vic.web.WebManager;
import view.IntroPage;
import view.LoadingPage;
import view.LuckyDrawPage;
import view.TechPage;
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
			JSInterfaceHelper.install();
			
			var stage = Lib.current.stage;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			// 沒有這行Tweener會出現例外
			Tweener.autoOverwrite = false;
			WebManager.inst.init( stage );
			cb( null, null );
		}
		
		function setupWebManager( cb:Dynamic ) {
			
			WebManager.inst.log = log;
			
			WebManager.inst.setData( 'loadingClass', LoadingPage );
			
			WebManager.inst.addLayer( 'page' );
			WebManager.inst.addLayer( 'techpage' );
			WebManager.inst.addLayer( 'techui' );
			WebManager.inst.addLayer( 'ui' );
			WebManager.inst.addLayer( 'popup' );
			WebManager.inst.addLayer( 'loading' );
			
			WebManager.inst.addCommand( new OnMessageBtnClick("onMessageBtnClick") );
			WebManager.inst.addCommand( new OnHeaderBtnClick("onHeaderBtnClick") );
			WebManager.inst.addCommand( new OnActiveBtnClick("onActiveBtnClick") );
			WebManager.inst.addCommand( new OnHomeBtnClick("onHomeBtnClick") );
			WebManager.inst.addCommand( new OnTechFrameBtnClick("onTechFrameBtnClick") );
			WebManager.inst.addCommand( new OnIntroBtnClick("onIntroBtnClick") );
			WebManager.inst.addCommand( new OnLuckyDrawBtnClick("onLuckyDrawBtnClick") );
			WebManager.inst.addCommand( new OnFbLoginClick("onFbLoginClick") );
			WebManager.inst.addCommand( new OnDetailFormBtnClick("onDetailFormBtnClick") );
			WebManager.inst.addCommand( new OnFooterBtnClick("onFooterBtnClick") );
			
			cb( null, null );
		}
		
		function loadConfig( cb:Dynamic ) {
			var http = new Http("config.json");
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
			BasicUtils.loadSwf( WebManager.inst, { name:'Preload', path:'src/Preload.swf' }, false, function() {
				cb( null, null );
			});
		}
		
			
		function startApp( err:Error, result:Dynamic ) {
			WebManager.inst.log("startApp");
			WebManager.inst.getStage().addEventListener( Event.RESIZE, onResize );
		}
		
		Async.series(
			[
				setupEnvironment,
				setupWebManager,
				loadConfig,
				loadSwf,
				AppAPI.openPage( { mgr:WebManager.inst, page:HeaderUI, params: null } ),
				AppAPI.openPage( { mgr:WebManager.inst, page:IntroPage, params: null } ),
				AppAPI.openPage( { mgr:WebManager.inst, page:FooterUI, params: null } )
			]
			, startApp );
		
		
		
		
		/*
		BasicUtils.loadSwf( WebManager.inst, {name:'Preload', path:'src/Preload.swf' }, false, function(){
			openPageSeries([HeaderUI, IntroPage, FooterUI], finishLoad)();
		});
		*/
		
		//test fb
		/*
		JSInterfaceHelper.callJs( WebManager.inst, 'isFBLogin', [], function(info:Dynamic) {
			trace(info);
			var err = info[0];
			var success = info[1];
		});
		JSInterfaceHelper.callJs( WebManager.inst, 'loginFB', [], function(info:Dynamic) {
			trace(info);
			var err = info[0];
			var success = info[1];
		});
		JSInterfaceHelper.callJs( WebManager.inst, 'shareFB', [], function(info:Dynamic) {
			trace(info);
			var err = info[0];
			var success = info[1];
		});
		*/
		
		
		/*
		WebManager.inst.addWebListener('callFromHtml', function( params ) {
			trace("callFromHtmlcallFromHtml***");
			trace(params);
		});
		
		WebManager.inst.callWeb('callFromFlash', { id:32413, method: 'loginFB', params:[] } );
		*/
		//test router
		/*
		WebManager.inst.addWebListener( 'router', function( val ) {
			WebManager.inst.callWeb( 'console.log', { fromJs:val } );
			switch( val ) {
				case 'index':
					BasicUtils.loadSwf( WebManager.inst, {name:'Preload', path:'src/Preload.swf' }, false, function(){
						openPageSeries([HeaderUI, IntroPage, FooterUI], finishLoad)();
					});
				case 'tech':
					BasicUtils.loadSwf( WebManager.inst, {name:'Preload', path:'src/Preload.swf' }, false, function(){
						openPageSeries([HeaderUI, TechPage, FooterUI], finishLoad)();
					});
			}
		});
		
		WebManager.inst.addWebListener( 'jsCallFlash', function( val ) {
			WebManager.inst.callWeb( 'console.log', {fromJs:val } );
		});
		WebManager.inst.callWeb( 'flashReady', {} );
		WebManager.inst.callWeb( 'flashCallJs', {abc:'abc' } );
		*/
		
		
		//test();
		//test2();
	}
	
	static function onResize(e: Event) {
		SimpleController.onResize( WebManager.inst );
	}
	static function test2() {

		AppAPI.flow1( { mgr:WebManager.inst } )(function(err:Error, result:Dynamic) {
			trace(err);
		});
		
	}
	
}