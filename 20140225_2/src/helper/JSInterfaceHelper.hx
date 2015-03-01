package helper;
import org.vic.web.WebManager;

/**
 * ...
 * @author han
 */
class JSInterfaceHelper
{
	static var callbackPool:Map<String, Dynamic->Void> = new Map<String, Dynamic->Void>();
	
	static function onCallFromHtml( info ) {
		//trace('onCallFromHtml');
		var cb = callbackPool.get( info.id );
		//trace(cb);
		cb( info.params );
		callbackPool.remove( info.id );
	}
	
	static var cbid: UInt = 0;
	
	public static function install(mgr:WebManager) {
		mgr.addWebListener('callFromHtml', onCallFromHtml);
	}
	
	public static function callJs(mgr:WebManager, method:String, params:Array<Dynamic>, cb:Dynamic->Void) {
		var randomId = cbid ++;
		callbackPool.set( randomId+"", cb );
		mgr.callWeb('callFromFlash', { id:randomId, method: method, params:params } );
	}
}