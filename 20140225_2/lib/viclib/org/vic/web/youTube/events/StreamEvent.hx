package org.vic.web.youTube.events;
import flash.events.Event;
class StreamEvent extends Event {			
	public static var STREAM_PROGRESS			:String = "streamProgress";
	public static var STREAM_COMPLETE			:String = "streamComplete";	
	public static var FILE_LOAD_COMPLETE		:String = "fileLoadComplete";
	public static var FILE_LOAD_PROGRESS		:String = "fileLoadProgress";		
	/**
	 * 百分比 0 ~ 1
	 */
	private var _percentage:Float;		
	/**
	 * StreamEvent
	 * @param	pType 類型。
	 * @param	pPercentage 百分比
	 */
	public function StreamEvent(pType:String, pPercentage:Float = 0):Void	{				
		super(pType, false, false);			
		percentage = pPercentage;					
	}		
	public override function toString():String {	
		return formatToString("StreamEvent", "type","percentage");			
	}		
	override public function clone():Event {
		return new StreamEvent(type, 0);									
	}
	
	public function percentage():Float { return _percentage; }		
	public function percentage(value:Float):Void {
		_percentage = value;
	}
}