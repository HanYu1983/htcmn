package control;
import model.AppAPI;
import org.vic.web.WebCommand;
import view.LuckyDrawPage;
import view.tech.TechBlink;
import view.tech.TechConnect;
import view.tech.TechCamera;
import view.tech.TechDouble;
import view.tech.TechDolby;
import view.tech.TechTheme;
import view.tech.TechPhoto;
import view.tech.TechAssist;
import view.tech.TechUltra;

/**
 * ...
 * @author ...
 */
class OnTechFrameBtnClick extends DefaultCommand
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
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechDolby, params: null } ) (null);
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
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechConnect, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_person: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechTheme, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_photo: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechPhoto, params: null } ) (null);
			},
			btn_onTechFrameBtnClick_situ: function() {
				AppAPI.changeTechPage( { mgr:getWebManager(), page: TechAssist, params: null } ) (null);
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
	}
	
}