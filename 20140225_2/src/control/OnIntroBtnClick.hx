package control;
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
		AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechPage, 
						params: { } 
						
					}) (null);
	}
	
}