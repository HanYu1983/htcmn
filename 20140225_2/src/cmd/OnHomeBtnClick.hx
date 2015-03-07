package cmd;

import flash.errors.Error;
import flash.sampler.NewObjectSample;
import helper.AppAPI;
import org.vic.web.IWebView;
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

		function thenOpen(clz:Class<IWebView>) {
			return function(err:Error, result:Dynamic) {
				if ( err != null ) {
					getWebManager().log(err.message);
				} else {
					AppAPI.changeTechPage( { mgr:getWebManager(), page: clz, params: null } ) (null);
				}
			}
		}
		
		var goto:Dynamic = {
			btn_onHomeBtnClick_Double: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechDouble));
			},
			btn_onHomeBtnClick_Duby: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechDuby));
			},
			btn_onHomeBtnClick_Ultra: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechUltra));
			},
			btn_onHomeBtnClick_Camera: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechCamera));
			},
			btn_onHomeBtnClick_person: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechPerson));
			},
			btn_onHomeBtnClick_situ: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechSitu));
			},
			btn_onHomeBtnClick_blink: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechBlink));
			},
			btn_onHomeBtnClick_photo: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechPhoto));
			},
			btn_onHomeBtnClick_boom: function() {
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechBoom));
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}