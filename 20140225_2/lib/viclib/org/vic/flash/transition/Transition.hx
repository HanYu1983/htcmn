package vic.flash.transition;
import flash.display.DisplayObject;
import flash.events.Event;
import org.vic.event.VicEvent;
import org.vic.event.VicEventDispatcher;
import org.vic.VicVector;

/**
 * ...
 * @author fff
 */
class Transition extends VicEventDispatcher
{
	public static var COMPLETE = 'complete';
	
	private var _g:DisplayObject;
	private var _time:Int;
	private var _passTime:Int = 0;
	private var _isDead = false;
	private var _oriX:Float;
	private var _oriY:Float;

	public function new( g, time ) 
	{
		super();
		_g = g;
		_time = time;
		_oriX = _g.x;
		_oriY = _g.y;
	}
	
	public function getOriPostion() {
		return new VicVector( _oriX, _oriY );
	}
	
	public function update() {
		if ( _isDead )
			return;
		else 
			transitionUpdate();
			
		if ( _passTime >= _time )
		{
			_isDead = true;
			backToOriginal();
			dispatchEvent( new VicEvent( COMPLETE ) );
			return;
		}
		else
			_passTime++;
	}
	
	private function transitionUpdate() {
		// for children
	}
	
	private function backToOriginal() {
		var graphic = getGraphic();
		graphic.x = _oriX;
		graphic.y = _oriY;
	}
	
	private function getGraphic():DisplayObject {
		return _g;
	}
}