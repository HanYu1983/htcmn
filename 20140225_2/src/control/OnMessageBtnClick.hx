package control;

import model.AppAPI;
import org.vic.web.WebCommand;
import view.fb.DetailFromPopup;
import view.MessagePopup;

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
				AppAPI.openPage( {
					mgr:getWebManager(),
					page: DetailFromPopup,
					params: null
					
				} ) (null);
				
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