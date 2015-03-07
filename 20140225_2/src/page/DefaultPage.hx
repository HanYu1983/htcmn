package page;

import flash.display.DisplayObject;
import helper.IResize;
import helper.SimpleController;
import helper.Tool;
import org.vic.utils.BasicUtils;
import org.vic.web.WebView;
import page.tech.DefaultTechPage;
import page.tech.TechFrame;

/**
 * ...
 * @author han
 */
class DefaultPage extends WebView implements IResize
{
	var _mc_back:DisplayObject;
	var _mc_item:DisplayObject;
	
	public function new() {
		super();
		needLoading = true;
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_back':
					_mc_back = obj;
				case 'mc_item':
					_mc_item = obj;
			}
		});
		
		SimpleController.onPageOpen( getWebManager(), this );
		SimpleController.onResize( getWebManager() );
	}
	
	public function suggestionEnableAutoBarWhenOpen():Null<Bool> {
		return null;
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		SimpleController.onPageClose( getWebManager(), this );
		super.onCloseEvent(cb);
	}
	
	public function onResize(x:Int, y: Int, w:Int, h:Int) {
		if( _mc_item != null ){
			Tool.centerForce( _mc_item, 1366, 768, x, y, w, h );
		}
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
		
		//Tool.center(this, x, y, w, h);
	}
}