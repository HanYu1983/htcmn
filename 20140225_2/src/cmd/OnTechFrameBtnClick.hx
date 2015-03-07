package cmd;
import helper.AppAPI;
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
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechDouble, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_Duby: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechDuby, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_Ultra: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechUltra, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_Camera: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechCamera, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_blink: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechBlink, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_boom: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechBoom, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_person: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechPerson, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_photo: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechPhoto, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_situ: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechSitu, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_share: function() {
				AppAPI.openPage( {
					mgr: getWebManager(),
					page: LuckyDrawPage,
					params: null
					
				}) (null);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
		trace(targetPage);
	}
	
}