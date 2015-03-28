package view.tech;
import caurina.transitions.Tweener;
import control.SimpleController;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import org.vic.utils.BasicUtils;
import org.vic.web.BasicButton;

/**
 * ...
 * @author han
 */
class TechPhoto extends DefaultTechPage
{
	var ary_effect:Array<MovieClip> = [];
	var ary_btn:Array<BasicButton> = [];

	public function new() 
	{
		super();
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'mc_effect_01', 'mc_effect_02', 'mc_effect_03',
					 'mc_effect_04', 'mc_effect_05', 'mc_effect_06':
						ary_effect.push( cast( disobj, MovieClip ));
				case 'btn_effect_01', 'btn_effect_02', 'btn_effect_03',
					 'btn_effect_04', 'btn_effect_05', 'btn_effect_06':
						ary_btn.push( new BasicButton( cast( disobj, MovieClip )));
			}
		});
		
		Lambda.foreach( ary_btn, function( btn:BasicButton ) {
			wakeUpButton( btn );
			btn.getShape().addEventListener( MouseEvent.CLICK, onBtnClick );
			return true;
		} );
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		Lambda.foreach( ary_btn, function( btn:BasicButton ) {
			sleepButton( btn );
			btn.getShape().removeEventListener( MouseEvent.CLICK, onBtnClick );
			return true;
		} );
		super.onCloseEvent(cb);
	}
	
	function showEffect( id: String ) {
		var effectId = "mc_effect_0" + id;
		for ( effect in ary_effect ) {
			if ( effect.name == effectId ) {
				effect.gotoAndPlay( 2 );
			}
			Tweener.addTween( effect, { alpha: effect.name == effectId ? 1 : 0, time: 0.3 } );
		}
	}
	
	function onBtnClick( e:MouseEvent ) {
		var btn = cast( e.currentTarget, MovieClip );
		var id = btn.name.charAt( btn.name.length - 1 );
		if ( id == "1" ) {
			getRoot().playRespond();
		}
		showEffect( id );
		for ( basic in ary_btn ) {
			if ( basic.getShape() == btn ) {
				sleepButton( basic );
			} else {
				wakeUpButton( basic );
				basic.getShape().gotoAndStop(1);
			}
		}
		SimpleController.onButtonInteract( btn );
		requestWaitAnimation();
	}
	/*
	function onBtnRollOut( e:MouseEvent ) {
		var btn = cast( e.currentTarget, MovieClip );
		btn.gotoAndPlay("out");
	}
	
	function onBtnRollOver( e:MouseEvent ) {
		var btn = cast( e.currentTarget, MovieClip );
		btn.gotoAndPlay("over");
	}
	*/
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechPhoto', path:config.swfPath.TechPhoto[ config.swfPath.TechPhoto.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechPhoto', path:'mc_anim' };
	}
}