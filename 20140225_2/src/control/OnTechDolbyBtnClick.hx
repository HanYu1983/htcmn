package control;

import org.vic.web.WebCommand;
import view.tech.TechDolby;

/**
 * ...
 * @author vic
 */
class OnTechDolbyBtnClick extends DefaultCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void {
		super.execute( args );
		var goto:Dynamic = {
			/*
			btn_onTechDoubleClick_skip:function() {
				var page = cast( getWebManager().getPage(TechDolby), TechDolby);
				page.skipAnimation();
			}*/
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}