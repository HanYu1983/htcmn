package model;
import control.SimpleController;
import flash.errors.Error;
import flash.errors.IOError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.URLRequest;
import flash.sampler.NewObjectSample;
import flash.utils.Timer;
import model.DolbySoundMediator.SoundType;
import org.vic.web.WebManager;

enum SoundType{
	Normal; HTC;
}
	
/**
 * ...
 * @author han
 */
class DolbySoundMediator
{
	var sound:Map<SoundType, Sound> = new Map<SoundType, Sound>();
	var channel:Map<SoundType, SoundChannel> = new Map<SoundType, SoundChannel>();
	var currtype:SoundType = SoundType.HTC;
	
	public function new( type:SoundType ) {
		currtype = type;
	}
	
	static function onLoadComplete( onLoad:Dynamic ) {
		var count = 0;
		return function( e:Event ) {
			if ( ++count == 2 ) {
				onLoad( null, null );
			}
		}
	}
		
	public function load( path:Dynamic, onLoad:Dynamic ) {
		var onComplete = onLoadComplete( onLoad );
		var soundHTC = new Sound();
		soundHTC.addEventListener( Event.COMPLETE, onComplete );
		soundHTC.addEventListener( IOErrorEvent.IO_ERROR, function( e:IOErrorEvent ) {
			SimpleController.onError( e );
			if ( onLoad != null ) {
				onLoad( new Error( e.toString() ), null );
				onLoad = null;
			}
		});
		soundHTC.load( new URLRequest( path.htc ));
		
		var soundNormal = new Sound();
		soundNormal.addEventListener( Event.COMPLETE, onComplete );
		soundNormal.addEventListener( IOErrorEvent.IO_ERROR, function( e:IOErrorEvent ) {
			SimpleController.onError( e );
			if ( onLoad != null ) {
				onLoad( new Error( e.toString() ), null );
				onLoad = null;
			}
		});
		soundNormal.load( new URLRequest( path.other ));
		
		sound[SoundType.HTC] = soundHTC;
		sound[SoundType.Normal] = soundNormal;
	}
	
	public function play( time:Float = -1) {
		playWithType( currtype, time );
	}
	
	public function stop():Float {
		return stopWithType( currtype );
	}
	
	public function toggle(autoPlay:Bool = true):Float {
		var pos = stop();
		currtype = currtype == SoundType.HTC ? SoundType.Normal : SoundType.HTC;
		if ( autoPlay ) {
			play( pos );
		}
		return pos;
	}
	
	function playWithType( type:SoundType, time:Float = -1 ) {
		if ( time == -1 ) {
			if ( !channel.exists( type ) ) {
				var ch = sound[type].play();
				channel[type] = ch;
			}
			
		} else {
			if ( !channel.exists( type ) ) {
				var ch = sound[type].play( time );
				channel[type] = ch;
			} else {
				stopWithType( type );
				playWithType( type, time );
			}
		}
	}
	
	function stopWithType( type: SoundType ):Float{
		if ( channel.exists( type ) ) {
			var ch = channel[type];
			var pos = ch.position;
			ch.stop();
			channel.remove( type );
			return pos;
		} else {
			return -1;
		}
	}

}