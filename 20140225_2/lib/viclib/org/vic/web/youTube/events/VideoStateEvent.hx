
package org.vic.web.youTube.events;
import flash.events.Event;

class VideoStateEvent extends Event {
	public static var UNSTARTED	:String = "unstarted";
	public static var ENDED		:String = "ended";
	public static var PLAYING		:String = "playing";
	public static var PAUSED		:String = "paused";
	public static var BUFFERING	:String = "buffering";
	public static var VIDEO_CUED	:String = "videoCued";
	public static var STATE_CHANGE:String = "stateChange";		
	public var state:String;
	public function new(pType:String, pState:String, pBubble:Bool = false) { 			
		super(pType, pBubble, false);			
		state = pState;
	} 
	
	public override function toString():String { 
		return formatToString("VideoStateEvent", "type","state"); 
	}
	override public function clone():Event {
		return new VideoStateEvent(type, state, bubbles);						
	}
}
	