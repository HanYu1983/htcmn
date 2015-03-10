package org.vic.flash.loader;
import flash.Lib;
import flash.utils.SetIntervalTimer;
import haxe.Timer;
import org.vic.event.VicEvent;

/**
 * ...
 * @author han
 */
class FakeLoaderTask extends LoaderTask
{
	override public function load() 
	{
		if ( _needLoading ) {
			mediator.dispatchEvent( new VicEvent( LoaderManager.START_LOADING ));
			mediator.dispatchEvent( new VicEvent( LoaderManager.PROGRESS, -1 ));
		}
		Timer.delay( function() {
			if ( _needLoading )	
				mediator.dispatchEvent( new VicEvent( LoaderManager.STOP_LOADING ));
			_cb( this );
		}, 300);
	}	
}