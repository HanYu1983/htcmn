package control;

import flash.errors.Error;
import flash.sampler.NewObjectSample;
import model.AppAPI;
import org.vic.web.IWebView;
import org.vic.web.WebCommand;
import view.tech.TechBlink;
import view.tech.TechBoom;
import view.tech.TechCamera;
import view.tech.TechDouble;
import view.tech.TechDolby;
import view.tech.TechFrame;
import view.tech.TechPerson;
import view.tech.TechPhoto;
import view.tech.TechSitu;
import view.tech.TechUltra;
import view.TechPage;

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
					SimpleController.onError( err.message );
					
				} else {
					AppAPI.changeTechPage( { mgr:getWebManager(), page: clz, params: null } ) (null);
				}
			}
		}
		
		var goto:Dynamic = {
			btn_onHomeBtnClick_Double: function() {
				cast( getWebManager().getPage( TechPage ), TechPage ).onBtnEnterClick( 'btn_onHomeBtnClick_Double' );
				/*
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechDouble));
					*/
			},
			btn_onHomeBtnClick_Duby: function() {
				cast( getWebManager().getPage( TechPage ), TechPage ).onBtnEnterClick( 'btn_onHomeBtnClick_Duby' );
				/*
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechDolby));
					*/
			},
			btn_onHomeBtnClick_Ultra: function() {
				cast( getWebManager().getPage( TechPage ), TechPage ).onBtnEnterClick( 'btn_onHomeBtnClick_Ultra' );
				/*
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechUltra));
					*/
			},
			btn_onHomeBtnClick_Camera: function() {
				cast( getWebManager().getPage( TechPage ), TechPage ).onBtnEnterClick( 'btn_onHomeBtnClick_Camera' );
				/*
				AppAPI.changePage( 
					{ 
						mgr:this.getWebManager(), 
						page: TechFrame, 
						params: { } 
						
					}) (thenOpen(TechCamera));*/
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