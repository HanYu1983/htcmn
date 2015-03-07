package cmd;
import helper.AppAPI;
import org.vic.web.WebCommand;
import page.TechPage;

/**
 * ...
 * @author han
 */
class OnIntroBtnClick extends WebCommand
{

	override public function execute(?args:Dynamic):Void 
	{
		AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechPage, 
						params: { } 
						
					}) (null);
	}
	
}