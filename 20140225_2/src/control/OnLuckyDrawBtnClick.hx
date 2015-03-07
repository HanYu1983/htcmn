package control;

import flash.errors.Error;
import model.AppAPI;
import org.vic.web.WebCommand;
import view.fb.FBLoginPopup;
import view.fb.DetailFromPopup;
import view.LuckyDrawPage;
import view.MessagePopup;

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
				AppAPI.flow1( { mgr:getWebManager() } )(function(err:Error, result:Dynamic) {
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