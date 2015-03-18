package ;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
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
		var so:SoundChannel;
		sa.addEventListener( Event.COMPLETE, function( e ) {
			trace( e );
			so = sa.play();
			var st = so.soundTransform;
			st.volume = 1;
			so.soundTransform = st;
			
			
		});
		sa.load(new URLRequest( 'sound/dolby.mp3' ));
		
		Lib.current.stage.addEventListener( MouseEvent.CLICK, function( e ) {
			so.stop();
			trace("DD");
		});
		//sa.play();
	}
	
}