package cmd;
import org.vic.web.WebCommand;

/**
 * ...
 * @author han
 */
class CallETMAPI extends WebCommand
{
	override public function execute(?args:Dynamic):Void 
	{
		var cb: Dynamic = args;
		cb(null, {});
	}
}