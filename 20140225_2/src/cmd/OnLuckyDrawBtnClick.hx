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
		
		function callETMAndThen(then:Void->Void) {
			return function() {
				var params = {
					cmd: 'isEnterInfo'
				};
				
				function handle(err:String, info:Dynamic) {
					getWebManager().execute("OpenPopup", [DetailFromPopup, info, null]);
				}
				
				getWebManager().execute("CallETMAPI", [params, handle] );
			}
		}
		
		function callFBShareAndThen(then:Void->Void) {
			return function() {
				getWebManager().execute("CallFBShare", function(err:String, success:Bool) {
					if (success) {
						then();
					}
				});
			}
		}
		
		function checkFBLoginAndThen(then:Void->Void) {
			getWebManager().execute("IsFBLogin", function(err:String, success:Bool) {
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
				checkFBLoginAndThen( callFBShareAndThen( callETMAndThen( null ) ) );
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