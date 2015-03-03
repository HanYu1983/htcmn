package cmd;

import flash.errors.Error;
import org.vic.web.WebCommand;
import page.fb.FBLoginPopup;
import page.fb.DetailFromPopup;
import page.LuckyDrawPage;
import page.MessagePopup;

/**
 * ...
 * @author han
 */
class OnLuckyDrawBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		
		function callOpenDetailForm() {
			return function() {
				getWebManager().execute("OpenPopup", [DetailFromPopup, null, null]);
			}
		}
		
		function callETMAndThen(then:Void->Void) {
			return function() {
				var params = {
					cmd: 'isEnterInfo'
				};
				
				function handle(err:String, isWritten:Bool) {
					if ( err != null ) {
						return;
					} else {
						if ( isWritten ) {
							trace('isWritten');
						} else {
							then();
						}
					}
				}
				
				getWebManager().execute("CallETMAPI", [params, handle] );
			}
		}
		
		function callGetMeAndThen(then:Void->Void) {
			return function() {
				getWebManager().execute("CallFBMe", function(err:Error, success:Bool) {
					if ( err != null ) {
						return;
					}
					if ( success ) {
						then();
					}
				});
			}
		}
		
		function callFBShareAndThen(then:Void->Void) {
			return function() {
				getWebManager().execute("CallFBShare", function(err:String, success:Bool) {
					if ( err != null ) {
						return;
					}
					if (success) {
						then();
					}
				});
			}
		}
		
		function checkFBLoginAndThen(then:Void->Void) {
			getWebManager().execute("IsFBLogin", function(err:String, success:Bool) {
				if ( err != null ) {
					return;
				}
				if (success) {
					then();
				}else {
					getWebManager().execute("OpenPopup", FBLoginPopup);
				}
			});
		}
		
		function closePopop() {
			getWebManager().closePage(LuckyDrawPage);
		}
		
		var func:Dynamic = {
			btn_onLuckyDrawBtnClick_fb: function() {
				checkFBLoginAndThen( 
					callFBShareAndThen(
						callGetMeAndThen(
							callETMAndThen( callOpenDetailForm() ) ) ) );
			},
			btn_onLuckyDrawBtnClick_data: function() {
				getWebManager().execute("OpenPopup", [MessagePopup, {msg:""}, null]);
			},
			btn_onLuckyDrawBtnClick_cancel: function() {
				closePopop();
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
	
}