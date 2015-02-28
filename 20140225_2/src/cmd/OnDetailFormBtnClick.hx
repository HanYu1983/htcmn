package cmd;

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
		
		var func:Dynamic = {
			btn_onDetailFormBtnClick_defalutCancel: function() {
				getWebManager().closePage(DetailFromPopup);
			},
			btn_onDetailFormBtnClick_cancel: function() {
				getWebManager().closePage(DetailFromPopup);
			},
			btn_onDetailFormBtnClick_confirm: function() {
				function handleETM(err:Error, param:Dynamic) {
					getWebManager().execute("OpenPopup", [MessagePopup, {msg:"Success"}, null]);
				}
				getWebManager().execute("CallETMAPI", [{}, handleETM]);
			},
			btn_onDetailFormBtnClick_boy: function() {
			
			},
			btn_onDetailFormBtnClick_girl: function() {
			
			},
			btn_onDetailFormBtnClick_okA: function() {
			
			},
			btn_onDetailFormBtnClick_okB: function() {
			
			},
			btn_onDetailFormBtnClick_okC: function() {
			
			}
		}
		
		var targetPage:String = args[1].name;
		trace(targetPage);
		Reflect.field(func, targetPage)();
	}
}