package ;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.net.URLRequest;
import org.vic.web.youTube.YouTube;

/**
 * ...
 * @author vic
 */
class TestYoutube extends Sprite
{
	static function main() {
		new TestYoutube();
	}

	public function new() 
	{
		super();
		
		//沒有控制器
		//private static var APIPLAYER_URL	:String = "http://www.youtube.com/apiplayer?version=3&rel=0";
		//有控制器
		//private static var APIPLAYER_CONTROLLER_URL	:String = "http://www.youtube.com/v/pgdgaDdNgwo?version=3&rel=0";
		
		var you = new YouTube();
		Lib.current.stage.addChild( you.getPlayer() );
		
		you.addEventListener( Event.INIT, function( e ) {
			trace("DD");
			you.setSize( 500, 500 );
			you.loadVideoById( '29odTRdULfI' );
		});
		
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(e) {
			you.loadVideoById( '05-c-iy-WnY' );
		});	
		/*
		var _youtubeLoader = new Loader();
		var _youtubePlayer:Dynamic;
		_youtubeLoader.contentLoaderInfo.addEventListener(Event.INIT, function( e ) {
			trace( 'init' );
			_youtubePlayer = _youtubeLoader.content;
			//_youtubePlayer.addEventListener("onReady", _onReadyHandler);
			Reflect.field( _youtubePlayer, 'addEventListener' )( 'onReady', function( e ) {
				Reflect.field( _youtubePlayer, 'loadVideoById' )('29odTRdULfI', 0, 'small');			
			});
			//trace( Reflect.field( _youtubePlayer, 'loadVideoById' ) );
			//Reflect.field( _youtubePlayer, 'loadVideoById' )('29odTRdULfI', 0, 'small');			
		});
		_youtubeLoader.load(new URLRequest( 'http://www.youtube.com/v/pgdgaDdNgwo?version=3&rel=0'));	
		
		Lib.current.stage.addChild( _youtubeLoader );*/
	}
	
}