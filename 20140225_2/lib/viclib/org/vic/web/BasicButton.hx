package org.vic.web;
import flash.display.MovieClip;
/**
 * ...
 * @author fff
 */
class BasicButton 
{
	private var _shape:MovieClip;
	
	public function new( shape:MovieClip ) 
	{
		_shape = shape;
	}
	
	public function setCommandName( cn:String ):Void {
		getShape().commandName = cn;
	}
	
	public function getCommandName():String {
		return getShape().commandName;
	}
	
	public function getShape():MovieClip {
		return _shape;
	}
	
	public function enable( e:Bool ):Void {
		getShape().mouseEnabled = e;
		getShape().mouseChildren = e;
		getShape().enabled = e;
	}
}