package view.tech;
import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Mouse;
import haxe.Timer;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechConnect extends DefaultTechPage
{
	var mc_phone:MovieClip;
	var mc_finger:MovieClip;
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
					mc_phone = cast(disobj, MovieClip);
				case 'mc_wave_01', 'mc_wave_02', 'mc_wave_03', 'mc_wave_04', 'mc_wave_05',
					 'mc_wave_06', 'mc_wave_07', 'mc_wave_08', 'mc_wave_09', 'mc_wave_10', 'mc_txt1':
						ary_wave.push( disobj );
			}
		});
		
		addEventListener( Event.ENTER_FRAME, onEnterFrame );
		mc_phone.addEventListener( MouseEvent.CLICK, onPhoneClick );
		mc_phone.buttonMode = true;
		
		mc_finger = cast( getLoaderManager().getTask( 'TechConnect' ).getObject( 'Finger' ), MovieClip );
		mc_finger.alpha = 0;
		mc_finger.mouseEnabled = false;
		mc_finger.mouseChildren = false;
		getRoot().addChild( mc_finger );
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		mc_phone.removeEventListener( MouseEvent.CLICK, onPhoneClick );
		removeEventListener( Event.ENTER_FRAME, onEnterFrame );
		super.onCloseEvent(cb);
	}
	
	function onPhoneClick( e ) {
		onTrigger();
	}
	
	var triggered = false;
	var reopenAfter = 10;
	
	function onTrigger() {
		if ( triggered == false ) {
			triggered = true;
			openWave();
			closeHint();
			// 改為只會回應一次
			//requestWaitAnimation();
			//getRoot().playRespond();
			if ( playRespondOnce() ) {
				requestWaitAnimation();
			}
			Timer.delay( function() {
				triggered = false;
				closeWave();
			}, reopenAfter * 1000);
			showHandUpMove();
		}
	}
	
	function showHandUpMove() {
		var global = mc_phone.localToGlobal( new Point() );
		mc_finger.x = global.x + 80;
		mc_finger.y = global.y + 300;
		visibleHand( true );
		Tweener.addTween( mc_finger, { x: mc_finger.x+30, y: mc_finger.y-300, time: 2 } );
		Timer.delay( function() { visibleHand( false ); }, 2000 );
	}
	
	function closeWave() {
		Lambda.foreach( ary_wave, function( wave:DisplayObject ) {
			Tweener.addTween( wave, { alpha:0, time:.5 } );
			return true;
		} );
	}
	
	function openWave() {
		Lambda.foreach( ary_wave, function( wave:DisplayObject ) {
			Tweener.addTween( wave, { alpha:1, time:.5 } );
			return true;
		} );
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
		// 不要向上滑動觸發了
		//handleForCheckTopMove();
	}
	
	function handleForCheckTopMove() {
		if ( mc_phone.hitTestPoint( stage.mouseX, stage.mouseY ) ) {
			mc_finger.x = stage.mouseX - mc_finger.width/2;
			mc_finger.y = stage.mouseY - mc_finger.height/2;
			recordVelocity( 5 );
			if ( triggered == false && checkIsMoveUp() ) {
				onTrigger();
				visibleHand( false );
			}
			if ( triggered == false ) {
				visibleHand( true );
			}
		} else {
			visibleHand( false );
		}
	}
	
	function recordVelocity(cut:Int) {
		var newPoint = new Point( stage.mouseX, stage.mouseY );
		if ( oldPoint != null ) {
			var velocity = newPoint.subtract( oldPoint );
			velList.push( velocity );
			if ( velList.length > cut ) {
				velList.shift();
			}
		}
		oldPoint = newPoint;
	}
	
	function checkIsMoveUp() {
		var sum = Lambda.fold( velList, function( vel:Point, sum:Point ) {
			return vel.add(sum);
		}, new Point() );
		var average = new Point( sum.x / velList.length, sum.y / velList.length );
		return average.y < -2 && Math.abs(average.y) / Math.abs( average.x ) > 2;
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