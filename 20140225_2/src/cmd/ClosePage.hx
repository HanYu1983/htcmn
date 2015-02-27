package cmd;
import org.vic.web.WebCommand;

/**
 * ...
 * @author vic
 */
class ClosePage extends WebCommand
{
	override public function execute(?args:Dynamic):Void 
	{
		var targetPage = args;
		getWebManager().closePage( targetPage );
	}
}