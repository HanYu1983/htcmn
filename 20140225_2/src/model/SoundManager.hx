package model;
import flash.errors.Error;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;

/**
 * ...
 * @author han
 */
class SoundManager
{
	private var sounds = new Map<String, Sound>();
	private var chs = new Array<SoundChannel>();
	
	public function load( list:Array<{key:String, path:String}>, cb:Dynamic ) {
		var countTo = function( num:Int, cb:Dynamic ) {
			var count = 0;
			return function( e:Event ) {
				if ( ++count == num ) {
					cb( null, null );
				}
			}
		} ( list.length, cb );
		
		for ( info in list ) {
			var sound = new Sound();
			sound.addEventListener( Event.COMPLETE, countTo );
			sound.addEventListener( IOErrorEvent.IO_ERROR, function( e:IOErrorEvent ) {
				cb( new Error( "SoundManager Load Error:"+e.toString() ), null );
			});
			sound.load( new URLRequest( info.path ) );
			sounds[info.key] = sound;
		}
	}

	public function play( key:String, startTime : Float = 0, loops : Int = 0, ?sndTransform : SoundTransform) : SoundChannel {
		var ch =  sounds[key].play( startTime, loops, sndTransform );
		chs.push( ch );
		return ch;
	}
	
	public function stopAll() {
		for ( ch in chs ) {
			ch.stop();
		}
		chs = [];
	}
}