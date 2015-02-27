package org.vic.event;
	/**
	 * ...
	 * @author fff
	 */
class VicEvent
{
	public var name:String;
	public var data:Dynamic;
	
	public function new( name, ?data:Dynamic ) {
		this.name = name;
		this.data = data;
	}
	
}