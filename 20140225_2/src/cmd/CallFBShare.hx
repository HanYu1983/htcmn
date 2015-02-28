package cmd;
import org.vic.web.WebCommand;

/**
 * ...
 * @author han
 */
class CallFBShare extends WebCommand
{

	override public function execute(?args:Dynamic):Void 
	{
		var cb:Dynamic= args;
		cb(null, true);
	}
	
}