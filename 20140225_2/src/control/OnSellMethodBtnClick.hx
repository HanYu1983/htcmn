package control;

import helper.Tool;
import org.vic.web.WebCommand;

/**
 * ...
 * @author vic
 */
class OnSellMethodBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		var goto:Dynamic = {
			btn_onSellPageBtnClick_htc:function() {
				var url = getWebManager().getData( 'config' ).url.htcSell;
				Tool.getURL(url);
			},
			btn_onSellPageBtnClick_m1:function() {
				var url = getWebManager().getData( 'config' ).url.chinese;
				Tool.getURL(url);
			},
			btn_onSellPageBtnClick_m2:function() {
				var url = getWebManager().getData( 'config' ).url.taiwan;
				Tool.getURL(url);
			},
			btn_onSellPageBtnClick_m3:function() {
				var url = getWebManager().getData( 'config' ).url.far;
				Tool.getURL(url);
			},
			btn_onSellPageBtnClick_m4:function() {
				var url = getWebManager().getData( 'config' ).url.star;
				Tool.getURL(url);
			},
			btn_onSellPageBtnClick_m5:function() {
				//var url = getWebManager().getData( 'config' ).url.asia;
				//Tool.getURL(url);
				SimpleController.onAlert( '敬請期待' );
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}