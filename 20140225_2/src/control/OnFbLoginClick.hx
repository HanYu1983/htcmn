package control;

import flash.errors.Error;
import model.AppAPI;
import org.han.Async;
import org.vic.web.WebCommand;
import view.fb.DetailFromPopup;
import view.fb.FBLoginPopup;

/**
 * @deprecated
 * ...
 * @author han
 */
class OnFbLoginClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	override public function execute(?args:Dynamic):Void 
	{
		var closeLoginPopup = AppAPI.closePage( { mgr:getWebManager(), page: FBLoginPopup } );
		
		var func:Dynamic = {
			btn_onFbLoginClick_login: function() {
				
				SimpleController.onHttpLoadingStart();
				
				function openNextPage( err:Error, result:Dynamic ) {
					SimpleController.onHttpLoadindEnd();
					closeLoginPopup( null );
					
					if ( err != null ) {
						SimpleController.onError(err.message);
						
					} else {
						AppAPI.openPage({ 
								mgr: getWebManager(), 
								page: DetailFromPopup, 
								params: null }
								) (null);
					}
				}
				
				// AppAPI.flow2( { mgr:getWebManager(), shareInfo: { name:"", link:"", picture:"", caption:"", description:"" } } ) (openNextPage);
				
			},
			btn_onFbLoginClick_no: function(){
				closeLoginPopup( null );
			},
			btn_onFbLoginClick_cancel: function(){
				closeLoginPopup( null );
			}
		}
		
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
}