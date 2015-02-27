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
		var pages:Array<Dynamic> = [TechDouble, TechDuby, TechUltra, TechCamera];
		function closePage(page:Dynamic) {
			getWebManager().closePage(page);
			return true;
		}
		Lambda.foreach( pages, closePage );
		
		var targetPage = args;
		getWebManager().openPage(targetPage, null);
	}
}