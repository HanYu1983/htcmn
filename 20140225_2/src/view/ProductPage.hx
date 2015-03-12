package view;
import control.SimpleController;
import flash.display.Loader;
import flash.errors.Error;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import helper.Tool;
import model.AppAPI;
import model.ETMAPI;
import org.han.Async;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class ProductPage extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = 'page';
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		
		function fetchDone( err:Error, photoList:Dynamic ) {
			if ( err != null ) {
				SimpleController.onError( err.message );
				
			} else {
				trace(photoList);
				
			}
		}
		
		function fetchPhoto( args: { data:Dynamic } ) {
			return function( cb:Dynamic ) {
				Async.map( 
					args.data, 
					function( obj: { photo:String } ) {
						return AppAPI.getImageFromURL( { url: obj.photo } );
					},
					cb 
				);
			}
		}
		
		Async.waterfall([
			ETMAPI.getPhotoList,
			fetchPhoto
		], fetchDone, { } );
		
		super.onOpenEvent(param, cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'ProductPage', path:'src/ProductPage.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'ProductPage', path:'ProductPage' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return false;
	}
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		if ( _mc_item != null ) {
			Tool.centerForce( _mc_item, 1366, 768, x, y, w, h, 0.5, 0.2 );
		}
		if ( _mc_popup != null ) {
			Tool.center(_mc_popup, x, y, w, h);
		}
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
	}
}