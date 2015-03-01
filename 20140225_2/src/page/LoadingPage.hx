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
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		var stage: Stage = getWebManager().getLayer("page").stage;
		var stageHeight:Int = stage.stageHeight;
		var stageWidth:Int = stage.stageWidth;
		onResize( 0, 0, stageWidth, stageHeight );
		
		getLoaderManager().addEventListener( LoaderManager.PROGRESS, onProgressLoading );
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ){
				case 'txt_per':
					_txt_per = cast( obj, TextField );
			}
		});
		
		super.onOpenEvent(param, cb);
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
		getLoaderManager().removeEventListener( LoaderManager.PROGRESS, onProgressLoading );
	}
	
	private function onProgressLoading( e:VicEvent ) {
		_txt_per.text = Math.floor( e.data ) + '%';
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