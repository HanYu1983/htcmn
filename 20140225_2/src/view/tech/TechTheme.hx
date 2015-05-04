package view.tech;
import caurina.transitions.Tweener;
import control.SimpleController;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import helper.Tool;
import org.vic.utils.BasicUtils;
import org.vic.web.BasicButton;

/**
 * ...
 * @author han
 */
class TechTheme extends DefaultTechPage
{
	var ary_btn:Array<BasicButton> = [];
	var ary_screen:Array<MovieClip> = [];

	public function new() 
	{
		super();
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'btn_01', 'btn_02', 'btn_more', 'btn_coca':
					ary_btn.push( new BasicButton( cast( disobj, MovieClip ) ) );
				case 'mc_01', 'mc_02':	// gotoplay 2
					ary_screen.push( cast( disobj, MovieClip ) );
			}
		});
		for ( btn in ary_btn ) {
			wakeUpButton( btn );
			btn.getShape().addEventListener( MouseEvent.CLICK, onBtnClick );
		}
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
			var screenid = "mc_0" + id;
			if ( screen.name == screenid ) {
				screen.gotoAndPlay(2);
				Tweener.addTween( screen, { alpha: 1, time: .3 } );
			} else {
				Tweener.addTween( screen, { alpha: 0, time: .3 } );
			}
		}
	}
	
	function onBtnClick( e:MouseEvent ) {
		var btn = cast( e.currentTarget, DisplayObject );
		
		closeHint();
		
		switch( btn.name ) {
			case "btn_01" | "btn_02":
				if ( btn.name == "btn_02" ) {
					// 改為只會回應一次
					//getRoot().playRespond();
					playRespondOnce();
				}
				var id = btn.name.charAt( btn.name.length - 1);
				showScreen( id );
			case "btn_more":
				var url = getWebManager().getData( 'config' ).url.techThemeMore;
				Tool.getURL(url);
			case "btn_coca":
				var url = getWebManager().getData( 'config' ).url.techThemeCoca;
				Tool.getURL(url);
		}
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
		return {name:'TechTheme', path:config.swfPath.TechTheme[ config.swfPath.TechTheme.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechTheme', path:'mc_anim' };
	}
}