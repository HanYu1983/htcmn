package cmd;
import org.vic.web.WebCommand;
import page.tech.TechCamera;
import page.tech.TechDouble;
import page.tech.TechDuby;
import page.tech.TechUltra;

/**
 * ...
 * @author ...
 */
class OnTechFrameBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		trace(args[1].name);
		
		var goto:Dynamic = {
			btn_onTechFrameBtnClick_Double: function() {
				this.getWebManager().execute("ChangeTechPage", TechDouble);
			},
			btn_onTechFrameBtnClick_Duby: function() {
				this.getWebManager().execute("ChangeTechPage", TechDuby);
			},
			btn_onTechFrameBtnClick_Ultra: function() {
				this.getWebManager().execute("ChangeTechPage", TechUltra);
			},
			btn_onTechFrameBtnClick_Camera: function() {
				this.getWebManager().execute("ChangeTechPage", TechCamera);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}