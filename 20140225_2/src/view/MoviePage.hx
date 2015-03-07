package view ;

import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;
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
	var _mc_lableContainer_ori_y:Float;
	var _youtubePlayer:YouTube;
	var _list:Array<Dynamic>;
	var _labelName = 'movieLable_';
	var _step:Int = 0;

	public function new() 
	{
		super();
		
		layerName = 'page';
	}
	
	public function moveUp() {
		if ( _step++ >= _list.length - 5 )	{
			_step = _list.length - 5;
			return;
		}
		moveContainer();
	}
	
	public function moveDown() {
		if ( --_step < 0 )	{
			_step = 0;
			return;
		}
		moveContainer();
	}
	
	public function loadVideo( id, auto = true ) {
		if ( _youtubePlayer != null ) {
			_youtubePlayer.loadVideoById( _list[id].id, auto );
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
					_mc_lableContainer_ori_y = _mc_lableContainer.y;
			}
		});
		
		_youtubePlayer = new YouTube();
		_youtubePlayer.addEventListener( Event.INIT, onYoutubeReady );
		
		genLabel();
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
		clearSingleMovie();
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
	
	function moveContainer() {
		Tweener.addTween( _mc_lableContainer, {y:_mc_lableContainer_ori_y + ( -57 * _step ), time:.5 } );
	}
	
	function clearSingleMovie() {
		for ( i in ( _mc_lableContainer.numChildren - 1 )...0 ) {
			var singleLabel:MovieClip = cast( _mc_lableContainer.getChildAt( i ), MovieClip );
			singleLabel.removeEventListener( MouseEvent.CLICK, onMovieLabelClick );
			singleLabel.removeEventListener( MouseEvent.MOUSE_OVER, onMovieLabelOver );
			singleLabel.removeEventListener( MouseEvent.MOUSE_OUT, onMovieLabelOut );
			_mc_lableContainer.removeChild( singleLabel );
		}
	}
	
	function genLabel() {
		for ( i in 0..._list.length ) {
			var singleLabel:MovieClip = cast( getLoaderManager().getTask( 'MoviePage' ).getObject( 'SingleMovie' ), MovieClip );
			singleLabel.y = i * 57;
			singleLabel.name = _labelName + i;
			singleLabel.mc_name.txt_name.text = _list[i].name;
			singleLabel.buttonMode = true;
			singleLabel.addEventListener( MouseEvent.CLICK, onMovieLabelClick );
			singleLabel.addEventListener( MouseEvent.MOUSE_OVER, onMovieLabelOver );
			singleLabel.addEventListener( MouseEvent.MOUSE_OUT, onMovieLabelOut );
			loadImage( i, singleLabel.mc_container );
			_mc_lableContainer.addChild( singleLabel );
		}
	}
	
	function loadImage( id, container:MovieClip ) {
		var loader:Loader = new Loader();
		loader.load( new URLRequest( _list[id].img ));
		loader.contentLoaderInfo.addEventListener( Event.COMPLETE, function( e:Event ) {
			var content:LoaderInfo = cast( e.currentTarget, LoaderInfo );
			container.addChild( content.content );
		});
	}
	
	function onMovieLabelClick( e:MouseEvent ) {
		var singleLabel = e.currentTarget;
		var vid = singleLabel.name.substr( _labelName.length, singleLabel.name.length );
		loadVideo( vid );
	}
	
	function onMovieLabelOver( e:MouseEvent ) {
		var singleLabel = e.currentTarget;
		singleLabel.gotoAndPlay( 'over' );
	}
	
	function onMovieLabelOut( e:MouseEvent ) {
		var singleLabel = e.currentTarget;
		singleLabel.gotoAndPlay( 'out' );
	}
	
	
	function onYoutubeReady( e ) {
		_mc_container.addChild( _youtubePlayer.getPlayer() );
		_youtubePlayer.setSize( _mc_container.width, _mc_container.height - 15 );
		loadVideo( 0, false );
	}
}