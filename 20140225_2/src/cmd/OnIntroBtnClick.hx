package cmd;
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
		getWebManager().execute("ChangePage", TechPage);
	}
	
}