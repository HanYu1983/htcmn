package org.vic.event;
/**
 * ...
 * @author fff
 */
class VicEventDispatcher 
{
	private var observers:Map <String, Array< VicEvent -> Void > > ;
	
	public function new() 
	{
		observers = new Map <String, Array< VicEvent -> Void >  > ();
	}
	
	public function addEventListener( name:String, func:VicEvent -> Void ) {
		if ( observers.exists( name ) )
			observers.get( name ).push( func );
		else
			observers.set( name, [ func ] );
	}
	
	public function removeEventListener( name:String, func:VicEvent -> Void) {
		if ( observers.exists( name ) )
		{
			var arymap = observers.get( name );
			for ( i in 0...arymap.length )
			{
				if ( arymap[i] == func )
					arymap.splice( i, 1 );
			}
		}
		
	}
	
	public function dispatchEvent( e:VicEvent ) {
		if ( observers.exists( e.name ) )
			Lambda.map( observers.get( e.name ), function( f ) { f( e ); } );
	}
}