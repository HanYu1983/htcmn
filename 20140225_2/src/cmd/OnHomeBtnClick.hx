package cmd;

import org.vic.web.WebCommand;
import page.tech.TechDouble;
import page.tech.TechFrame;

/**
 * ...
 * @author ...
 */
class OnHomeBtnClick extends WebCommand
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
			btn_onHomeBtnClick_Double: function() {
				this.getWebManager().execute("ChangePage", TechFrame);
			},
			btn_onHomeBtnClick_Duby: function() {
				this.getWebManager().execute("ChangePage", TechFrame);
			},
			btn_onHomeBtnClick_Ultra: function() {
				this.getWebManager().execute("ChangePage", TechFrame);
			},
			btn_onHomeBtnClick_Camera: function() {
				this.getWebManager().execute("ChangePage", TechFrame);
			},
			btn_onHomeBtnClick_person: function() {
				this.getWebManager().execute("ChangePage", TechFrame);
			},
			btn_onHomeBtnClick_situ: function() {
				this.getWebManager().execute("ChangePage", TechFrame);
			},
			btn_onHomeBtnClick_blink: function() {
				this.getWebManager().execute("ChangePage", TechFrame);
			},
			btn_onHomeBtnClick_photo: function() {
				this.getWebManager().execute("ChangePage", TechFrame);
			},
			btn_onHomeBtnClick_boom: function() {
				this.getWebManager().execute("ChangePage", TechFrame);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}