package cmd;

import flash.display.DisplayObject;
import flash.errors.Error;
import org.vic.web.WebCommand;
import page.fb.DetailFromPopup;
import page.MessagePopup;

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
		
		function closeDetailPopop() {
			getWebManager().closePage(DetailFromPopup);
		}
		
		var target:DisplayObject = args[1];
		var targetPage:String = args[1].name;
		trace(targetPage);
		
		trace(target.x +"," +target.y );
		
		var func:Dynamic = {
			btn_onDetailFormBtnClick_defalutCancel: function() {
				closeDetailPopop();
			},
			btn_onDetailFormBtnClick_cancel: function() {
				closeDetailPopop();
			},
			btn_onDetailFormBtnClick_confirm: function() {
				function handleETM(err:Error, param:Dynamic) {
					//getWebManager().execute("OpenPopup", [MessagePopup, { msg:"Success" }, null]);
					closeDetailPopop();
				}
				getWebManager().execute("CallETMAPI", [{}, handleETM]);
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