package cmd;

import org.vic.web.WebCommand;

/**
 * ...
 * @author han
 */
class OnTechContentClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		var goto:Dynamic = {
			btn_onTechFrameBtnClick_Double: function() {
				//this.getWebManager().execute("ChangeTechPage", TechDouble);
			}
		}
		var targetPage:String = args[1].name;
		trace(targetPage);
		//Reflect.field(goto, targetPage)();
	}
}