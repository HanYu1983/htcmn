package vic.flash.transition;
import flash.display.DisplayObject;

/**
 * ...
 * @author fff
 */
class EarthQuakeTransition extends Transition
{
	public static var HIGH = 5;
	public static var MIDDLE = 3;
	public static var LOW = 1;
	
	private var _level:Int;

	public function new( g, time, level ) 
	{
		super( g, time );
		
		_level = level;
	}
	
	override private function transitionUpdate():Dynamic 
	{
		getGraphic().x += Math.random() * _level * 2 - _level;
		getGraphic().y += Math.random() * _level * 2 - _level;
	}
}