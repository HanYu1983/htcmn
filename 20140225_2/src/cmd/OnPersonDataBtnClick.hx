package cmd;

import org.vic.web.WebCommand;

/**
 * ...
 * @author han
 */
class OnPersonDataBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		
		var func:Dynamic = {
			btn_onPersonDataBtnClick_submit: function() {
			
			}
		}
		
		var targetPage:String = args[1].name;
		Reflect.field(func, targetPage)();
	}
}