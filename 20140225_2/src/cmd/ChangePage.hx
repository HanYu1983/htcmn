package cmd;

import helper.Tool;
import org.vic.web.WebCommand;

/**
 * ...
 * @author vic
 */
class ChangePage extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		function closePage(page:Dynamic) {
			getWebManager().closePage(page);
			return true;
		}
		Lambda.foreach( Tool.allPage, closePage );
		
		if ( !Std.is(args, Array) ) {
			var targetPage = args;
			getWebManager().openPage(targetPage, null);
		}else {
			var targetPage = args[0];
			var callback = args[1];
			getWebManager().openPage(targetPage, callback);
		}
	}
	
}