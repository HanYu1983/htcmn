package view.tech;
import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Point;
import flash.ui.Mouse;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechConnect extends DefaultTechPage
{
	var mc_phone:DisplayObject;
	var mc_finger:DisplayObject;
	var ary_wave:Array<DisplayObject> = [];

	public function new() 
	{
		super();
	}
	
	override function forScript(e) 
	{
		super.forScript(e);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'mc_phone':
					mc_phone = disobj;
				case 'mc_wave_01', 'mc_wave_02', 'mc_wave_03', 'mc_wave_04', 'mc_wave_05',
					 'mc_wave_06', 'mc_wave_07', 'mc_wave_08', 'mc_wave_09', 'mc_wave_10':
						ary_wave.push( disobj );
			}
		});
		
		getWebManager().log( mc_phone );
		getWebManager().log( ary_wave );
		
		addEventListener( Event.ENTER_FRAME, onEnterFrame );
		
		mc_finger = getLoaderManager().getTask( 'TechConnect' ).getObject( 'Finger' );
		mc_finger.alpha = 0;
		getRoot().addChild( mc_finger );
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		removeEventListener( Event.ENTER_FRAME, onEnterFrame );
		super.onCloseEvent(cb);
	}
	
	var waveOpened = false;
	
	function openWave() {
		requestWaitAnimation();
		getRoot().playRespond();
		Lambda.foreach( ary_wave, function( wave:DisplayObject ) {
			wave.alpha = 1;
			return true;
		} );
		waveOpened = true;
	}
	
	var oldPoint:Point;
	var velList = new Array<Point>();
	
	function visibleHand( v:Bool ) {
		Tweener.addTween( mc_finger, { alpha: v? 1:0, time: 1 } );
		if ( v ) {
			Mouse.hide();
		} else {
			Mouse.show();
		}
	}
	
	function onEnterFrame(e) {
		if ( mc_phone.hitTestPoint( stage.mouseX, stage.mouseY ) ) {
			mc_finger.x = stage.mouseX - mc_finger.width/2;
			mc_finger.y = stage.mouseY - mc_finger.height/2;
			recordVelocity();
			if ( waveOpened == false && checkIsMoveUp() ) {
				openWave();
				visibleHand( false );
			}
			if ( waveOpened == false ) {
				visibleHand( true );
			}
		} else {
			visibleHand( false );
		}
	}
	
	function recordVelocity() {
		var newPoint = new Point( stage.mouseX, stage.mouseY );
		if ( oldPoint != null ) {
			var velocity = newPoint.subtract( oldPoint );
			velList.push( velocity );
			if ( velList.length > 10 ) {
				velList.shift();
			}
		}
		oldPoint = newPoint;
	}
	
	function checkIsMoveUp() {
		if ( velList.length < 10 ) {
			return false;
		}
		
		var sum = Lambda.fold( velList, function( vel:Point, sum:Point ) {
			return vel.add(sum);
		}, new Point() );
		var average = new Point( sum.x / 10, sum.y / 10 );
		return average.y < -5 && Math.abs(average.y) / Math.abs( average.x ) > 10;
	}
	
	override function getSwfInfo():Dynamic 
	{
		var config:Dynamic = getWebManager().getData( 'config' );
		return {name:'TechConnect', path:config.swfPath.TechConnect[ config.swfPath.TechConnect.which ] };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechConnect', path:'mc_anim' };
	}
}