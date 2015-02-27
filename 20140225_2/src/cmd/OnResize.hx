package cmd;

import flash.display.Stage;
import flash.sampler.NewObjectSample;
import helper.IResize;
import org.vic.web.WebCommand;

/**
 * ...
 * @author ...
 */
class OnResize extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		
		var stage: Stage = getWebManager().getLayer("page").stage;
		var stageHeight:Int = stage.stageHeight;
		var stageWidth:Int = stage.stageWidth;
		
		function doResize(page:Dynamic) {
			if ( Std.is(page, IResize)) {
				var p:IResize = cast(page, IResize);
				p.onResize(0, 0, stageWidth, stageHeight);
			}
			return true;
		}
		
		var pages = getWebManager().getPages();
		Lambda.foreach(pages, doResize);
	}
	
}