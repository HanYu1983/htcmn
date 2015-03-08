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
				
				SimpleController.onHttpLoadingStart();
				
				function openNextPage( err:Error, result:Dynamic ) {
					SimpleController.onHttpLoadindEnd();
					
					if ( err != null ) {
						if ( err.message == 'not login' ) {
							AppAPI.openPage({ 
								mgr: getWebManager(), 
								page: FBLoginPopup, 
								params: null 
								}) (null);
							
						} else {
							SimpleController.onError(err.message);
							
						}
						
					} else {
						AppAPI.openPage({ 
								mgr: getWebManager(), 
								page: DetailFromPopup, 
								params: null
								}) (null);
					}
				}
				
				AppAPI.flow1( { mgr:getWebManager() } )(openNextPage);
				
			},
			btn_onLuckyDrawBtnClick_data: function() {
				AppAPI.openPage( { mgr:getWebManager(), page: MessagePopup, params: null } ) (null);
			},
			btn_onLuckyDrawBtnClick_cancel: function() {
				closePopop();
			},
			btn_onLuckyDrawBtnClick_no: function() {
				closePopop();
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
	
}