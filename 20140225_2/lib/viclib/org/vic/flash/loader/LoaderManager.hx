package org.vic.flash.loader;
import org.vic.event.VicEventDispatcher;

/**
 * ...
 * @author fff
 */
class LoaderManager extends VicEventDispatcher
{
	public static var START_LOADING:String = 'START_LOADING';
	public static var STOP_LOADING:String = 'STOP_LOADING';
	public static var PROGRESS:String = 'progress';
	
	public static var inst = new LoaderManager();
	private var _map_loader:Map<String, LoaderTask>;

	private function new() 
	{
		super();
		_map_loader = new Map();
	}
	
	public function addTask( name, loader:LoaderTask) {
		if ( hasTask( name ))
			return;
		loader.mediator = this;
		loader.load();
		_map_loader.set( name, loader );
	}
	
	/**
	 * getWebManager().getLoaderManager().addQueueTask( [ { name:'MainPage', path:'src/MainPage.swf' }, { name:'IntroPage', path:'src/IntroPage.swf' } ], function() {
			getWebManager().openPage( IntroPage.NAME, 'page' );
		});
	 * @param	ary_path
	 * @param	cb
	 */
	public function addQueueTask( ary_path:Array<Dynamic>, cb:Void->Void) {
		var lt:LoaderTask;
		var nowItem;
		var n:String;
		var p:String;
		
		function loadOne( _lt:LoaderTask ) {
			if ( ary_path.length > 0 ) {
				nowItem = ary_path.shift();
				n = nowItem.name;
				p = nowItem.path;
				lt = new LoaderTask( p, loadOne );
				addTask( n, lt );
			}else cb();
		}
		
		loadOne( null );
	}
	
	public function hasTask( name ) {
		return _map_loader.exists( name );
	}
	
	public function getTask( name ) {
		if ( hasTask( name ))
			return _map_loader.get( name );
		return null;
	}
}