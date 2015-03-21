package control;

import flash.errors.Error;
import model.AppAPI;
import model.Const;
import model.ETMAPI;
import org.han.Async;
import org.vic.web.IWebView;
import org.vic.web.WebCommand;
import view.fb.FBLoginPopup;
import view.fb.DetailFromPopup;
import view.LuckyDrawPage;
import view.MessagePopup;
import view.MoviePage;

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
				
				
				// 會先判斷FB有沒有登入的流程. 先留著
				/*
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
				*/
				
				SimpleController.onHttpLoadingStart();
				
				function openNextPage( err:Error, result:Dynamic ) {
					SimpleController.onHttpLoadindEnd();
					
					if ( err != null ) {
						if ( err.message == 'isWritten' ) {
							SimpleController.onAlert( getWebManager().getData( 'config' ).message.msg_submit_data_already );
							closePopop();
							
						} else {
							SimpleController.onError(err.message);
						}
						
						
					} else {
						AppAPI.openPage({ 
								mgr: getWebManager(), 
								page: DetailFromPopup, 
								params: null }
								) (null);
					}
				}
				
				var page = AppAPI.whichTechPageIsOpen(getWebManager());
				// 如果不是從科技頁來的, 就代表是從影片頁來的
				if ( page == null ) {
					page = getWebManager().getPage( MoviePage );
				}
				AppAPI.flow2( { 
					mgr:getWebManager(), 
					shareInfo: Const.getShareInfoWithPage( page ) 
				} ) (openNextPage);
			},
			btn_onLuckyDrawBtnClick_data: function() {
				// 不打開多餘的這頁. 這行先留著, 可能後來又會改
				//AppAPI.openPage( { mgr:getWebManager(), page: MessagePopup, params: null } ) (null);
				
				SimpleController.onHttpLoadingStart();
				
				function handleNext( err:Error, ret:Dynamic ){
					if ( err != null ) {
						SimpleController.onError( err.message );
						
					} else {
						
					}
					SimpleController.onHttpLoadindEnd();
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