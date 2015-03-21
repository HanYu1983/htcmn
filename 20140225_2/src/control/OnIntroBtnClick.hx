package control;
import helper.Tool;
import model.AppAPI;
import org.vic.web.WebCommand;
import view.TechPage;

/**
 * ...
 * @author han
 */
class OnIntroBtnClick extends WebCommand
{

	override public function execute(?args:Dynamic):Void 
	{
		var goto:Dynamic = {
			btn_onIntroBtnClick_enter: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechPage, 
						params: { } 
						
					}) (null);
			},
			btn_onIntroBtnClick_early: function(){
				var url = getWebManager().getData( 'config' ).url.early;
				Tool.getURL(url);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}