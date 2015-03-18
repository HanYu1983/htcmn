package ;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.Lib;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.ui.Keyboard;
import haxe.Timer;
import model.DolbySoundMediator;

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
		test2();
	}
	
	function test2() {
		
		var mediator = new DolbySoundMediator( SoundType.Normal );
		
		mediator.load( { htc:"sound/dolby.mp3", other:"sound/other.mp3" }, function() {
			
			mediator.play();
			var currtime = 0.0;
			
			Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, function( e:KeyboardEvent ) {
				
				switch(e.keyCode) {
					case Keyboard.LEFT | Keyboard.RIGHT:
						mediator.toggle();
					case Keyboard.UP:
						mediator.play( currtime );
					case Keyboard.DOWN:
						currtime = mediator.stop();
				}
				
			});
			
		} );
	}
	
	function test1() {
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