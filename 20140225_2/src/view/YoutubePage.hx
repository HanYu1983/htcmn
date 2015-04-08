package view;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;
import org.vic.web.youTube.events.VideoStateEvent;
import org.vic.web.youTube.YouTube;

/**
 * ...
 * @author vic
 */
class YoutubePage extends DefaultPage
{
	var mc_youtube:DisplayObjectContainer;
	var youtube:YouTube;

	public function new() 
	{
		super();
		layerName = 'popup';
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		BasicUtils.revealObj( getRoot(), function( disobj:DisplayObject ) {
			switch( disobj.name ) {
				case 'mc_youtube':
					mc_youtube = cast( disobj, DisplayObjectContainer );
			}
		});
		
		youtube = new YouTube();
		youtube.addEventListener( Event.INIT, onYoutubeReady );
		youtube.addEventListener( VideoStateEvent.STATE_CHANGE, onYoutubeStateChange );
	}
	
	override public function close(cb:Void->Void):Void 
	{
		super.close(cb);
		
		if ( youtube != null ){
			youtube.removeEventListener( Event.INIT, onYoutubeReady );
			youtube.clear();
			youtube = null;
		}
	}
	
	function onYoutubeReady( e ) {
		mc_youtube.addChild( youtube.getPlayer() );
		youtube.setSize( 840, 473 );
		loadVideo( true );
	}
	
	function onYoutubeStateChange( e:VideoStateEvent ) {
		switch( e.state ) {
			case VideoStateEvent.ENDED:
				//close page
		}
	}
	
	function loadVideo( auto = true ) {
		if ( youtube != null ) {
			youtube.loadVideoById( '5SWjtaUq8Vw', auto );
		}
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'YoutubePage' };
	}
}