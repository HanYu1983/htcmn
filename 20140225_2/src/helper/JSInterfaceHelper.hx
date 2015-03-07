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
		var cb = callbackPool.get( info.id );
		cb( info.params );
		callbackPool.remove( info.id );
	}
	
	static var cbid: UInt = 0;
	
	public static function install() {
		ExternalInterface.addCallback( 'callFromHtml', onCallFromHtml );
	}
	
	public static function callJs(method:String, params:Array<Dynamic>, cb:Dynamic->Void):Bool {
		var randomId = cbid ++;
		callbackPool.set( randomId+"", cb );
		try {
			ExternalInterface.call( 'callFromFlash', { id:randomId, method: method, params:params } );
			return true;
		}catch ( e:Error ) {
			return false;
		}
	}
}