package page;

import flash.display.DisplayObject;
import flash.display.Stage;
import flash.text.TextField;
import helper.IResize;
import helper.Tool;
import org.vic.event.VicEvent;
import org.vic.flash.loader.LoaderManager;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class LoadingPage extends WebView implements IResize
{
	private var _txt_per:TextField;

	public function new() 
	{
		super();
		
		layerName = 'loading';
	}
	
	override function onOpenEvent(cb:Void->Void):Void 
	{
		super.onOpenEvent(cb);
		getLoaderManager().addEventListener( LoaderManager.PROGRESS, onProgressLoading );
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ){
				case 'txt_per':
					_txt_per = cast( obj, TextField );
			}
		});
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
		getLoaderManager().removeEventListener( LoaderManager.PROGRESS, onProgressLoading );
	}
	
	private function onProgressLoading( e:VicEvent ) {
		_txt_per.text = e.data + '%';
	}
	
	public function onResize(x: Int, y:Int, w:Int, h:Int):Void {
		getRoot().x = w / 2;
		getRoot().y = h / 2;
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Preload', path:'Loading' };
	}
}