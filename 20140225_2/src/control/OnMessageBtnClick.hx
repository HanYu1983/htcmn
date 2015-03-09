package control;

import flash.errors.Error;
import model.AppAPI;
import model.ETMAPI;
import org.han.Async;
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
				
				SimpleController.onHttpLoadingStart();
				
				function handleNext( err:Error, ret:Dynamic ){
					if ( err != null ) {
						SimpleController.onError( err.message );
					}
					SimpleController.onHttpLoadindEnd();
					closeMessagePopop();
				}
				
				Async.waterfall([
					ETMAPI.isEnterInfo,
					function getData( args: { isWritten:Bool, token: String } ) {
						return function( cb:Dynamic ) {
							getWebManager().setData('etmToken', args.token);
							cb( null, { mgr:getWebManager(), page:DetailFromPopup, params:null } );
						}
					},
					AppAPI.openPage
					
				], handleNext, { fbid: '', email: '' } );
				
				
			},
			btn_onMessageBtnClick_cancel: function() {
				closeMessagePopop();
			}
		}
		
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
}