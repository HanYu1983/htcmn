package org.vic.web.youTube;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLRequest;
import org.vic.web.youTube.events.VideoStateEvent;
/**
 * ...
 * @author VicYu
 */
class YouTube extends EventDispatcher
{
	//沒有控制器
	private static var APIPLAYER_URL	:String = "http://www.youtube.com/apiplayer?version=3&rel=0";
	//有控制器
	private static var APIPLAYER_CONTROLLER_URL	:String = "http://www.youtube.com/v/pgdgaDdNgwo?version=3&rel=0";
	
	var _loader:Loader;
	var _player:Dynamic;
	public function new( haveController:Bool = true ) {
		super();
		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit );
		
		if ( haveController ) _loader.load( new URLRequest( APIPLAYER_CONTROLLER_URL ));
		else _loader.load( new URLRequest( APIPLAYER_CONTROLLER_URL ));
	}
	
	public function getPlayer():DisplayObject {
		return _loader;
	}
	
	public function setSize( w, h ) {
		if ( _player == null )	return;
		_player.setSize(w, h);			
	}
	
	public function clear() {
		if ( _player != null ) {
			_player.removeEventListener( 'onReady', onPlayerReady );
			_player.removeEventListener( 'onStateChange', onPlayerStateChange );
			_player.destroy();	
			_player = null;
		}
		_loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoaderInit );
		_loader.unload();
		_loader = null;
	}
	
	public function loadVideoById( id, auto:Bool = true, startTime:Int = 0, Quality:String = 'small' ) {
		if ( auto )	{
			_player.loadVideoById( id, startTime, Quality );	
		}else{
			_player.cueVideoById( id, startTime, Quality );	
		}
	}
	
	function onLoaderInit( e ) {
		_loader.contentLoaderInfo.removeEventListener(Event.INIT, onLoaderInit );
		_player = _loader.content;
		_player.addEventListener( 'onReady', onPlayerReady );
		_player.addEventListener( 'onStateChange', onPlayerStateChange );
	}
	
	function onPlayerReady( e ) {
		_player.removeEventListener( 'onReady', onPlayerReady );
		dispatchEvent( new Event( Event.INIT ));
	}
	
	function onPlayerStateChange( e ) {
		dispatchEvent(new VideoStateEvent(VideoStateEvent.STATE_CHANGE, getPlayerStateToString() ));				
	}
	
	function getPlayerStateToString():String {			
		var _playerState:Int = _player.getPlayerState();
		switch (_playerState){
			case-1:	return VideoStateEvent.UNSTARTED;
			case 0:	return VideoStateEvent.ENDED;
			case 1:	return VideoStateEvent.PLAYING;
			case 2:	return VideoStateEvent.PAUSED;
			case 3:	return VideoStateEvent.BUFFERING;
			case 5:	return VideoStateEvent.VIDEO_CUED;
		}			
		return null;
	}
}