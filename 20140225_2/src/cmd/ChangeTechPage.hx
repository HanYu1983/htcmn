package cmd;
import org.vic.web.WebCommand;
import page.tech.TechCamera;
import page.tech.TechDouble;
import page.tech.TechDuby;
import page.tech.TechUltra;

/**
 * ...
 * @author han
 */
class ChangeTechPage extends WebCommand
{	
	override public function execute(?args:Dynamic):Void 
	{
		getWebManager().execute("CloseAllTechPage");
		var targetPage = args;
		getWebManager().openPage(targetPage, null);
	}
}