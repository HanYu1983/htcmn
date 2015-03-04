package cmd;
import org.vic.web.WebCommand;
import page.LuckyDrawPage;
import page.tech.TechBlink;
import page.tech.TechBoom;
import page.tech.TechCamera;
import page.tech.TechDouble;
import page.tech.TechDuby;
import page.tech.TechPerson;
import page.tech.TechPhoto;
import page.tech.TechSitu;
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
			},
			btn_onTechFrameBtnClick_blink: function() {
				this.getWebManager().execute("ChangeTechPage", TechBlink);
			},
			btn_onTechFrameBtnClick_boom: function() {
				this.getWebManager().execute("ChangeTechPage", TechBoom);
			},
			btn_onTechFrameBtnClick_person: function() {
				this.getWebManager().execute("ChangeTechPage", TechPerson);
			},
			btn_onTechFrameBtnClick_photo: function() {
				this.getWebManager().execute("ChangeTechPage", TechPhoto);
			},
			btn_onTechFrameBtnClick_situ: function() {
				this.getWebManager().execute("ChangeTechPage", TechSitu);
			},
			btn_onTechFrameBtnClick_share: function() {
				this.getWebManager().execute("OpenPopup", LuckyDrawPage);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
		trace(targetPage);
	}
	
}