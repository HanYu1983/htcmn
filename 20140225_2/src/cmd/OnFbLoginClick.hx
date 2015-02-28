package cmd;

import flash.errors.Error;
import org.vic.web.WebCommand;
import page.fb.PersonDataPopup;

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
		
		function callETMAndThen(then:Void->Void) {
			return function() {
				getWebManager().execute("CallETMAPI", function(err:Error, info:Dynamic) {
					getWebManager().execute("OpenPopup", [PersonDataPopup, info, null]);
				});
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
		
		var func:Dynamic = {
			btn_onFbLoginClick_login: function() {
				var handle = callFBLoginAndThen( callFBShareAndThen( callETMAndThen( doNothing ) ));
				handle();
			}
		}
		
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
}