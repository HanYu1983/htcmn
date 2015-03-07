package helper;
import flash.errors.Error;
import flash.external.ExternalInterface;
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
	
	public static function install() {
		try {
			ExternalInterface.addCallback( 'callFromHtml', onCallFromHtml );
		}catch ( e:Error ) {
			trace(e.message);
		}
	}
	
	public static function callJs(method:String, params:Array<Dynamic>, cb:Dynamic->Void) {
		var randomId = cbid ++;
		callbackPool.set( randomId+"", cb );
		try {
			return ExternalInterface.call( 'callFromFlash', { id:randomId, method: method, params:params } );
		}catch ( e:Error ) {
			trace(e.message);
			return;
		}
	}
}