package org.vic;

/**
 * ...
 * @author fff
 */
class VicVector
{
	public var x = 0.0;
	public var y = 0.0;
	public var z = 0.0;
	
	public function new( x = 0.0, y = 0.0, z = 0.0 ) 
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	public function add( addv:VicVector ) {
		var retv = new VicVector(x, y, z );
		retv.x += addv.x;
		retv.y += addv.y;
		retv.z += addv.z;
		return retv;
	}
}