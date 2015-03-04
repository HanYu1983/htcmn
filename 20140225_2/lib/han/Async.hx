package han;
import caurina.transitions.properties.DisplayShortcuts;
import flash.errors.Error;

/**
 * ...
 * @author han
 */
class Async {
	public static function parallel(list:Array<Dynamic>, complete:Dynamic) {
		var count = 0;
		var result:Array = new Array();
		result.length = list.length;
		
		for ( var i:Int = 0; i < result.length; ++i ) {
			function closure(id:Int) {
				return function(err:Error, data:Dynamic) {
					if (err != null) {
						result[id] = err;
					}else {
						result[id] = data;
					}
					if ( ++count == result.length ) {
						complete(result);
					}
				}
			}
			fn( closure(i) );
		}
		
	}
	
	public static function waterfall( list:Array<Dynamic>, complete:Dynamic ) {
		function doOneByOne( list:Array<Dynamic>, result:Dynamic ) {
			if ( list.length == 0 ) {
				complete( null, result );
			} else {
				var fn = list.shift();
				fn(result)(function(err:Error, data:Dynamic) {
					if ( err != null ) {
						complete(err);
					}else {
						doOneByOne( list, data );
					}
				});
			}
		}
		doOneByOne( list, null );
	}
	
}