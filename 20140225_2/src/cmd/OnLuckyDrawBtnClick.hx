package cmd;

import org.vic.web.WebCommand;
import page.fb.FBLoginPopup;

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
		
		function callETM() {
			
		}
		
		
		function handleFBLogin(hasLogin:Bool, then: Void -> Void) {
			if (hasLogin) {
				getWebManager().execute("CallFBShare", then);
			}else {
				getWebManager().execute("OpenPopup", FBLoginPopup);
			}
		}
		
		var func:Dynamic = {
			btn_onLuckyDrawBtnClick_fb: function() {
				getWebManager().execute("IsFBLogin", handleFBLogin);
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