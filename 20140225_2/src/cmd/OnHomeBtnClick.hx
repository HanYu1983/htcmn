package cmd;

import org.vic.web.WebCommand;
import page.tech.TechBlink;
import page.tech.TechBoom;
import page.tech.TechCamera;
import page.tech.TechDouble;
import page.tech.TechDuby;
import page.tech.TechFrame;
import page.tech.TechPerson;
import page.tech.TechPhoto;
import page.tech.TechSitu;
import page.tech.TechUltra;

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
		
		
		function thenOpen(clz:Class<Dynamic>) {
			return function() {
				this.getWebManager().execute("ChangeTechPage", clz);
			}
		}
		
		var goto:Dynamic = {
			btn_onHomeBtnClick_Double: function() {
				this.getWebManager().execute("ChangePage", [TechFrame, thenOpen(TechDouble)]);
			},
			btn_onHomeBtnClick_Duby: function() {
				this.getWebManager().execute("ChangePage", [TechFrame, thenOpen(TechDuby)]);
			},
			btn_onHomeBtnClick_Ultra: function() {
				this.getWebManager().execute("ChangePage", [TechFrame, thenOpen(TechUltra)]);
			},
			btn_onHomeBtnClick_Camera: function() {
				this.getWebManager().execute("ChangePage", [TechFrame, thenOpen(TechCamera)]);
			},
			btn_onHomeBtnClick_person: function() {
				this.getWebManager().execute("ChangePage", [TechFrame, thenOpen(TechPerson)]);
			},
			btn_onHomeBtnClick_situ: function() {
				this.getWebManager().execute("ChangePage", [TechFrame, thenOpen(TechSitu)]);
			},
			btn_onHomeBtnClick_blink: function() {
				this.getWebManager().execute("ChangePage", [TechFrame, thenOpen(TechBlink)]);
			},
			btn_onHomeBtnClick_photo: function() {
				this.getWebManager().execute("ChangePage", [TechFrame, thenOpen(TechPhoto)]);
			},
			btn_onHomeBtnClick_boom: function() {
				this.getWebManager().execute("ChangePage", [TechFrame, thenOpen(TechBoom)]);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}