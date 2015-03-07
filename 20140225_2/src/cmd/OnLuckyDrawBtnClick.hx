package cmd;

import flash.errors.Error;
import helper.AppAPI;
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
		function closePopop() {
			getWebManager().closePage(LuckyDrawPage);
		}
		
		var func:Dynamic = {
			btn_onLuckyDrawBtnClick_fb: function() {
				AsyncLogic.flow1( { mgr:getWebManager() } )(function(err:Error, result:Dynamic) {
					if ( err != null ) {
						trace(err);
					}
				});
				
			},
			btn_onLuckyDrawBtnClick_data: function() {
				AppAPI.openPage( { mgr:getWebManager(), page: MessagePopup, params: null } ) (null);
		
			},
			btn_onLuckyDrawBtnClick_cancel: function() {
				closePopop();
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
	
}