package control;

import flash.display.DisplayObject;
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
class OnDetailFormBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		
		var closeDetailPopop = AppAPI.closePage( { mgr: getWebManager(), page: DetailFromPopup } );
		
		var target:DisplayObject = args[1];
		var targetPage:String = args[1].name;

		var func:Dynamic = {
			btn_onDetailFormBtnClick_defalutCancel: function() {
				closeDetailPopop (null);
			},
			btn_onDetailFormBtnClick_cancel: function() {
				closeDetailPopop (null);
			},
			btn_onDetailFormBtnClick_cancel2:function() {
				closeDetailPopop (null);
			},
			btn_onDetailFormBtnClick_confirm: function() {

				function applyData( cb:Dynamic ) {
					var form:DetailFromPopup = cast(getWebManager().getPage(DetailFromPopup), DetailFromPopup);
					form.applyData();
					cb( null, null );
				}
				
				Async.series([
					applyData,
					ETMAPI.enterInfo(
						{
							token : getWebManager().getData("etmToken"),
							name : getWebManager().getData("name"),
							email : getWebManager().getData("email"),
							gender : getWebManager().getData("gender"),
							mobile : getWebManager().getData("mobile"),
							is_read_policy : getWebManager().getData("is_read_policy"),
							is_agree_personal_info : getWebManager().getData("is_agree_personal_info"),
							is_accept_notice : getWebManager().getData("is_accept_notice")
						}
					)
					
				], function( err:Error, ret:{ success: Bool, msg:String } ) {
					if ( err != null ) {
						getWebManager().log( err.message );
						
					} else {
						if ( ret.success ) {
							closeDetailPopop( null );
						} else {
							getWebManager().log( ret.msg );
						}
						
					}
				});
			},
			btn_onDetailFormBtnClick_boy: function() {
				var form:DetailFromPopup = cast( getWebManager().getPage(DetailFromPopup), DetailFromPopup);
				form.changeCirclePosition( target.x, target.y );
			},
			btn_onDetailFormBtnClick_girl: function() {
				var form:DetailFromPopup = cast( getWebManager().getPage(DetailFromPopup), DetailFromPopup);
				form.changeCirclePosition( target.x, target.y );
			},
			btn_onDetailFormBtnClick_okA: function() {
				var form:DetailFromPopup = cast( getWebManager().getPage(DetailFromPopup), DetailFromPopup);
				form.markTermInPosition(target.x, target.y);
			},
			btn_onDetailFormBtnClick_okB: function() {
				var form:DetailFromPopup = cast( getWebManager().getPage(DetailFromPopup), DetailFromPopup);
				form.markTermInPosition(target.x, target.y);
			},
			btn_onDetailFormBtnClick_okC: function() {
				var form:DetailFromPopup = cast( getWebManager().getPage(DetailFromPopup), DetailFromPopup);
				form.markTermInPosition(target.x, target.y);
			}
		}
		
		
		Reflect.field(func, targetPage)();
	}
}