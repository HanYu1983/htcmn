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
		var param: Dynamic = args[0];
		var cb: Dynamic = args[1];
		cb(null, {});
	}
}