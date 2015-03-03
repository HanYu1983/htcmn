package ;

import caurina.transitions.Tweener;
import cmd.CallETMAPI;
import cmd.CallFBLogin;
import cmd.CallFBMe;
import cmd.CallFBShare;
import cmd.ChangePage;
import cmd.ChangeTechPage;
import cmd.CloseAllTechPage;
import cmd.ClosePage;
import cmd.IsFBLogin;
import cmd.OnActiveBtnClick;
import cmd.OnFbLoginClick;
import cmd.OnFooterBtnClick;
import cmd.OnHeaderBtnClick;
import cmd.OnHomeBtnClick;
import cmd.OnIntroBtnClick;
import cmd.OnLuckyDrawBtnClick;
import cmd.OnDetailFormBtnClick;
import cmd.OnMessageBtnClick;
import cmd.OnResize;
import cmd.OnTechContentClick;
import cmd.OnTechFrameBtnClick;
import cmd.OpenPopup;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.errors.Error;
import flash.events.Event;
import flash.Lib;
import flash.media.SoundMixer;
import flash.sampler.NewObjectSample;
import helper.ETMAPI;
import helper.JSInterfaceHelper;
import helper.Tool;
import org.vic.flash.loader.LoaderTask;
import org.vic.utils.BasicUtils;
import page.ActivityPopup;
import page.fb.DetailFromPopup;
import page.fb.FBLoginPopup;
import page.FooterUI;
import page.HeaderUI;
import org.vic.web.WebManager;
import page.IntroPage;
import page.LoadingPage;
import page.LuckyDrawPage;
import page.TechPage;
/**
 * ...
 * @author vic
 */

class Main 
{
	
	static function main() 
	{
		trace('run main2');
		
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		//stage.align = StageAlign.TOP_LEFT;
		// entry point
		
		Tweener.autoOverwrite = false;
		
		WebManager.inst.setData( 'loadingClass', LoadingPage );
		
		WebManager.inst.init( stage );
		WebManager.inst.addLayer( 'page' );
		WebManager.inst.addLayer( 'techpage' );
		WebManager.inst.addLayer( 'techui' );
		WebManager.inst.addLayer( 'ui' );
		WebManager.inst.addLayer( 'popup' );
		WebManager.inst.addLayer( 'loading' );
		
		WebManager.inst.addCommand( new OnTechContentClick("onTechContentClick") );
		WebManager.inst.addCommand( new OnMessageBtnClick("onMessageBtnClick") );
		WebManager.inst.addCommand( new OnHeaderBtnClick("onHeaderBtnClick") );
		WebManager.inst.addCommand( new OnActiveBtnClick("onActiveBtnClick") );
		WebManager.inst.addCommand( new OnHomeBtnClick("onHomeBtnClick") );
		WebManager.inst.addCommand( new OnTechFrameBtnClick("onTechFrameBtnClick") );
		WebManager.inst.addCommand( new OnResize("onResize") );
		WebManager.inst.addCommand( new OnIntroBtnClick("onIntroBtnClick") );
		WebManager.inst.addCommand( new OnLuckyDrawBtnClick("onLuckyDrawBtnClick") );
		WebManager.inst.addCommand( new OnFbLoginClick("onFbLoginClick") );
		WebManager.inst.addCommand( new OnDetailFormBtnClick("onDetailFormBtnClick") );
		WebManager.inst.addCommand( new OnFooterBtnClick("onFooterBtnClick") );
		
		WebManager.inst.addCommand( new ChangeTechPage("ChangeTechPage") );
		WebManager.inst.addCommand( new ClosePage("ClosePage") );
		WebManager.inst.addCommand( new ChangePage("ChangePage") );
		WebManager.inst.addCommand( new OpenPopup("OpenPopup") );
		WebManager.inst.addCommand( new CloseAllTechPage("CloseAllTechPage") );
		
		WebManager.inst.addCommand( new CallFBLogin("CallFBLogin") );
		WebManager.inst.addCommand( new IsFBLogin("IsFBLogin") );
		WebManager.inst.addCommand( new CallFBShare("CallFBShare") );
		WebManager.inst.addCommand( new CallETMAPI("CallETMAPI") );
		WebManager.inst.addCommand( new CallFBMe("CallFBMe") );
		
		function openPageSeries(clz:Array<Class<Dynamic>>, cb:Void->Void) {
			if (clz.length == 0) {
				return function() {
					cb();
				}
			}else{
				return function() {
					WebManager.inst.openPage( clz[0], null, openPageSeries( clz.slice(1, clz.length), cb) );
				}
			}
		}
		
		function finishLoad() {
			stage.addEventListener( Event.RESIZE, onResize );
			//WebManager.inst.execute("OpenPopup", LuckyDrawPage);
		}
		
		BasicUtils.loadSwf( WebManager.inst, {name:'Preload', path:'src/Preload.swf' }, false, function(){
			openPageSeries([HeaderUI, IntroPage, FooterUI], finishLoad)();
		});
		
		JSInterfaceHelper.install( WebManager.inst );
		
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
	}
	
	private static function onResize(e: Event) {
		WebManager.inst.execute("onResize");
	}
	
	
	static function test() {
		
		trace('run test');
		
		function assertIfError(err:Dynamic) {
			if ( err != null ) {
				trace("TEST ERROR!!!");
				trace(err.message);
			}
		}
		
		function assert(b:Bool) {
			if ( !b ) {
				trace("TEST ERROR!!!");
			}
		}
		
		function it(msg:String, fn:Void->Void) {
			try {
				trace("test > " + msg);
				fn();
			}catch (err:Error) {
				trace("TEST ERROR!!!");
				trace(msg);
				trace(err.message);
			}
		}
		
		it("fb login", function() {
			WebManager.inst.execute("CallFBLogin", function(err:Error, success:Bool) {
				assertIfError( err );
				if ( success ) {
					assert( WebManager.inst.getData('fbid') != null );
					assert( WebManager.inst.getData('accessToken') != null );
					
					it("fb is login", function() {
						WebManager.inst.execute("IsFBLogin", function(err:String, success:Bool) {
							assertIfError( err );
							assert( success );
						});
					});
					
					
					it("can get me", function() {
						WebManager.inst.execute("CallFBMe", function(err:String, success:Bool) {
							assertIfError( err );
							assert( success );
							assert( WebManager.inst.getData('fbemail') != null );
							
							it ("call etm api is submitted", function() {
								var params = {
									cmd: 'isEnterInfo'
								};
								
								function handle(err:String, success:Bool) {
									assertIfError(err);
									
									if ( success ) {
										
									} else {
										
										WebManager.inst.setData("name", "");
										WebManager.inst.setData("mobile", "");
										WebManager.inst.setData("gender", "");
										WebManager.inst.setData("is_read_policy", "Y");
										WebManager.inst.setData("is_agree_personal_info", "Y");
										WebManager.inst.setData("is_accept_notice", "Y");
										
										it ("call submit etm api", function() {
											var params = {
												cmd: 'enterInfo'
											};
											
											function handle(err:String, success:Bool) {
												assertIfError(err);
												assert(success);
											}
											
											WebManager.inst.execute("CallETMAPI", [params, handle] );
										});
										
										
									}
								}
								
								WebManager.inst.execute("CallETMAPI", [params, handle] );
							});
							
						});
					});
					
				} else {
					assert( err == null );
					
					it("fb is not login", function() {
						WebManager.inst.execute("IsFBLogin", function(err:String, success:Bool) {
							assertIfError( err );
							assert( success == false );
						});
					});
				}
			});
		});
		
	}
}