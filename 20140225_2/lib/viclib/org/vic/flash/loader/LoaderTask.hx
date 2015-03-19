package org.vic.flash.loader;
import flash.display.Loader;
import flash.errors.Error;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.globalization.DateTimeFormatter;
import flash.Lib;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.SecurityDomain;
import org.vic.event.VicEvent;
import org.vic.web.WebManager;

/**
 * ...
 * @author VicYu
 */
class LoaderTask
{
	private var _applicationDomain:ApplicationDomain;
	private var _loader:Loader;
	private var _path:String;
	private var _needLoading:Bool;
	private var _cb:LoaderTask->Void;
	private var _loaderContext:LoaderContext = new LoaderContext( true );
	public var mediator:LoaderManager;
	
	public function new( path:String, cb:LoaderTask -> Void = null, needLoading:Bool = true ) 
	{
		_path = path;
		_cb = cb;
		_needLoading = needLoading;
		
		_loaderContext.applicationDomain = ApplicationDomain.currentDomain;
		_loaderContext.securityDomain = SecurityDomain.currentDomain;
	}
			
	public function load() {
		if( _needLoading )	mediator.dispatchEvent( new VicEvent( LoaderManager.START_LOADING ));
		_loader = new Loader();
		try{
			_loader.load( new URLRequest( getPath() ), _loaderContext);
		}catch ( e:Error ) {
			_loader.load( new URLRequest( getPath() ));
		}
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e) {
			WebManager.inst.log( 'Event.COMPLETE' );
			_applicationDomain = _loader.contentLoaderInfo.applicationDomain;
			_loader.unloadAndStop();
			_loader = null;
			WebManager.inst.log( 'cb:' + _cb );
			if ( _cb != null ) {
				try{
					_cb( this );
					WebManager.inst.log( 'Event.COMPLETE, dispatch' );
					if ( _needLoading )	mediator.dispatchEvent( new VicEvent( LoaderManager.STOP_LOADING ));
				}catch ( e:Error ) {
					WebManager.inst.log( 'error: ' + e.getStackTrace() );
				}
			}
		});
		
		_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function( e:ProgressEvent ) {
			var total:Float = _loader.contentLoaderInfo.bytesTotal;
			var now:Float = _loader.contentLoaderInfo.bytesLoaded;
			var per:Float = now / total * 100;
			if( _needLoading )	mediator.dispatchEvent( new VicEvent( LoaderManager.PROGRESS, per ));
		});
	}
	
	public function getPath() {
		return _path;
	}
	
	public function getCb():LoaderTask -> Void {
		return _cb;
	}
	
	public function getApplicationDomain() {
		return _applicationDomain;
	}
	
	public function getObject( name:String, ?orgs:Array<Dynamic> ):Dynamic {
		return cast( Type.createInstance( getApplicationDomain().getDefinition( name ), orgs == null ? [] : orgs ));
	}
	
}