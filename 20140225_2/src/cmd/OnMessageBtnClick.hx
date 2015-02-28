package cmd;

import org.vic.web.WebCommand;
import page.fb.DetailFromPopup;
import page.MessagePopup;

/**
 * ...
 * @author han
 */
class OnMessageBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		
		function closeMessagePopop() {
			getWebManager().closePage(MessagePopup);
		}
		
		var func:Dynamic = {
			btn_onMessageBtnClick_confirm: function() {
				getWebManager().execute("OpenPopup", [DetailFromPopup, {}, null]);
				closeMessagePopop();
			},
			btn_onMessageBtnClick_cancel: function() {
				closeMessagePopop();
			}
		}
		
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
}