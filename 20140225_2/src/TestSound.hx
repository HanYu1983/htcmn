package ;
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;

/**
 * ...
 * @author vic
 */
class TestSound
{
	static function main() {
		new TestSound();
	}

	public function new() 
	{
		var sa = new Sound();
		sa.addEventListener( Event.COMPLETE, function( e ) {
			trace( e );
			var so:SoundChannel = sa.play();
			var st = so.soundTransform;
			st.volume = 1;
			so.soundTransform = st;
		});
		sa.load(new URLRequest( 'sound/other.mp3' ));
		
		
		//sa.play();
	}
	
}