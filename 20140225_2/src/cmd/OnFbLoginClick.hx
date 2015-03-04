package cmd;

import flash.errors.Error;
import org.vic.web.WebCommand;
import page.fb.DetailFromPopup;
import page.fb.FBLoginPopup;

/**
 * ...
 * @author han
 */
class OnFbLoginClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	override public function execute(?args:Dynamic):Void 
	{
		/*
		function callETMAndThen(then:Void->Void) {
			return function() {
				function handleETM(err:Error, info:Dynamic) {
					getWebManager().execute("OpenPopup", [DetailFromPopup, info, null]);
				}
				getWebManager().execute("CallETMAPI", [{}, handleETM] );
			}
		}
		
		function callFBShareAndThen(then:Void->Void) {
			return function() {
				getWebManager().execute("CallFBShare", function(err:Error, success:Bool) {
					if (success) {
						then();
					}
				});
			}
		}
		
		function callFBLoginAndThen(then:Void->Void) {
			return function() {
				getWebManager().execute("CallFBLogin", function(err:Error, success:Bool) {
					if (success) {
						then();
					}
				});
			}
		}
		
		var doNothing = null;
		*/
		function closeLoginPopup() {
			getWebManager().closePage(FBLoginPopup);
		}
		
		var func:Dynamic = {
			btn_onFbLoginClick_login: function() {
				/*
				var handle = callFBLoginAndThen( callFBShareAndThen( callETMAndThen( doNothing ) ));
				handle();
				*/
				AsyncLogic.flow2( { mgr:getWebManager() } )(function(err:Error, result:Dynamic) {
					if ( err != null ) {
						trace(err);
					}
				});
				closeLoginPopup();
			},
			btn_onFbLoginClick_no: function(){
				getWebManager().closePage( FBLoginPopup );
			},
			btn_onFbLoginClick_cancel: function(){
				getWebManager().closePage( FBLoginPopup );
			}
		}
		
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
}