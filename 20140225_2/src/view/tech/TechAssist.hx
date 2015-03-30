package view.tech;
import caurina.transitions.Tweener;
import control.SimpleController;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import org.vic.utils.BasicUtils;
import org.vic.web.BasicButton;

/**
 * ...
 * @author han
 */
class TechAssist extends DefaultTechPage
{
	var ary_btn:Array<BasicButton> = [];
	var ary_screen:Array<MovieClip> = [];
	var ary_bg:Array<MovieClip> = [];
	var ary_describe:Array<MovieClip> = [];
	
	public function new() 
	{
		super();
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'btn_01', 'btn_02', 'btn_03':	
					ary_btn.push( new BasicButton( cast( disobj, MovieClip ) ) );
				case 'mc_screen_01', 'mc_screen_02', 'mc_screen_03':	// fadein fadeout
					ary_screen.push( cast( disobj, MovieClip ) );
				case 'mc_bg_01', 'mc_bg_02', 'mc_bg_03':	// gotoplay 2
					ary_bg.push( cast( disobj, MovieClip ) );
				case 'mc_describe01', 'mc_describe02', 'mc_describe03':
					ary_describe.push( cast( disobj, MovieClip ) );
			}
		});
		
		for ( btn in ary_btn ) {
			wakeUpButton( btn );
			btn.getShape().addEventListener( MouseEvent.CLICK, onBtnClick );
		}
		
		getWebManager().log( ary_btn );
		getWebManager().log( ary_screen );
		getWebManager().log( ary_bg );
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		for ( btn in ary_btn ) {
			sleepButton( btn );
			btn.getShape().removeEventListener( MouseEvent.CLICK, onBtnClick );
		}
		super.onCloseEvent(cb);
	}
	
	function showScreen( id:String ) {
		
		for ( screen in ary_screen ) {
			var screenid = "mc_screen_0" + id;
			if ( screen.name == screenid ) {
				Tweener.addTween( screen, { alpha: 1, time: .3 } );
			} else {
				Tweener.addTween( screen, { alpha: 0, time: .3 } );
			}
		}
		
		for ( bg in ary_bg ) {
			var bgid = "mc_bg_0" + id;
			if ( bg.name == bgid ) {
				bg.gotoAndPlay(2);
			} else {
				bg.gotoAndPlay(1);
			}
		}
		
		for ( describe in ary_describe ) {
			var desid = "mc_describe0" + id;
			if ( describe.name == desid ) {
				Tweener.addTween( describe, { alpha: 1, time: .3 } );
			} else {
				Tweener.addTween( describe, { alpha: 0, time: .3 } );
			}
		}
	}
	
	function onBtnClick( e:MouseEvent ) {
		var btn = cast( e.currentTarget, DisplayObject );
		
		switch( btn.name ) {
			case "btn_01": getRoot().playRespond2();
			case "btn_02": getRoot().playRespond();
			case "btn_03": getRoot().playRespond3();
		}
		
		var id = btn.name.charAt( btn.name.length - 1);
		showScreen( id );
		for ( basic in ary_btn ) {
			if ( basic.getShape() == btn ) {
				sleepButton( basic );
			} else {
				wakeUpButton( basic, true );
			}
		}
		
		SimpleController.onButtonInteract( btn );
		requestWaitAnimation();
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechAssist', path:config.swfPath.TechAssist[ config.swfPath.TechAssist.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechAssist', path:'mc_anim' };
	}
}