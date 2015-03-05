package page ;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;
import org.vic.web.youTube.YouTube;

/**
 * ...
 * @author vic
 */
class MoviePage extends DefaultPage
{
	var _mc_container:DisplayObjectContainer;
	var _mc_lableContainer:DisplayObjectContainer;
	var _youtubePlayer:YouTube;
	var _list:Array<String>;
	var _labelName = 'movieLable_';
	//var _ary_movieLabelContainer: Array;

	public function new() 
	{
		super();
		
		layerName = 'page';
	}
	
	public function loadVideo( id, auto = true ) {
		if ( _youtubePlayer != null ) {
			_youtubePlayer.loadVideoById( _list[id], auto );
		}
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		_list = getWebManager().getData( 'config' ).moviePage.list;
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_container':
					_mc_container = cast( obj, DisplayObjectContainer );
				case 'mc_lableContainer':
					_mc_lableContainer = cast( obj, DisplayObjectContainer );
			}
		});
		
		_youtubePlayer = new YouTube();
		_youtubePlayer.addEventListener( Event.INIT, onYoutubeReady );
		
		genLabel();
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
		_youtubePlayer.removeEventListener( Event.INIT, onYoutubeReady );
		_youtubePlayer.clear();
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'MoviePage', path:'src/MoviePage.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'MoviePage', path:'MoviePage' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
	
	function genLabelContainer() {
		
	}
	
	function genLabel() {
		for ( i in 0..._list.length ) {
			var singleLabel:MovieClip = cast( getLoaderManager().getTask( 'MoviePage' ).getObject( 'SingleMovie' ), MovieClip );
			singleLabel.y = i * 57;
			singleLabel.name = _labelName + i;
			singleLabel.buttonMode = true;
			singleLabel.addEventListener( MouseEvent.CLICK, onMovieLabelClick );
			_mc_lableContainer.addChild( singleLabel );
		}
	}
	
	function onMovieLabelClick( e:MouseEvent ) {
		var singleLabel = e.currentTarget;
		var vid = singleLabel.name.substr( _labelName.length, singleLabel.name.length );
		loadVideo( vid );
	}
	
	function onYoutubeReady( e ) {
		_mc_container.addChild( _youtubePlayer.getPlayer() );
		_youtubePlayer.setSize( _mc_container.width, _mc_container.height - 15 );
		loadVideo( 0, false );
	}
}