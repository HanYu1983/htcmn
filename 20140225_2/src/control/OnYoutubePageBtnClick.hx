package control;

import model.AppAPI;
import org.vic.web.WebCommand;
import view.YoutubePage;

/**
 * ...
 * @author vic
 */
class OnYoutubePageBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		
		var goto:Dynamic = {
			btn_onYoutubePageBtnClick_close: function() {
				AppAPI.closePage( { mgr:getWebManager(), page:YoutubePage } )( function(){});
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}