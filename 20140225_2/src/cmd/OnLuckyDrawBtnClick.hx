package cmd;

import org.vic.web.WebCommand;
import page.fb.FBLoginPopup;
import page.fb.PersonDataPopup;

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
		function openDataPopup() {
			getWebManager().execute("OpenPopup", PersonDataPopup);
		}
		
		function callETMAndThen(then:Void->Void) {
			return function() {
				getWebManager().execute("CallETMAPI", then);
			}
		}
		
		function handleFBLoginAndThen(then:Void->Void) {
			return function handleFBLogin(hasLogin:Bool) {
				if (hasLogin) {
					getWebManager().execute("CallFBShare", then);
				}else {
					getWebManager().execute("OpenPopup", FBLoginPopup);
				}
			}
		}
		
		var func:Dynamic = {
			btn_onLuckyDrawBtnClick_fb: function() {
				getWebManager().execute("IsFBLogin", handleFBLoginAndThen(callETMAndThen(openDataPopup)));
			},
			btn_onLuckyDrawBtnClick_data: function() {
				
			},
			btn_onLuckyDrawBtnClick_cancel: function() {
				
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
	
}