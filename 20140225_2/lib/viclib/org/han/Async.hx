package org.han;
import caurina.transitions.properties.DisplayShortcuts;
import flash.errors.Error;

/**
 * ...
 * @author han
 */
class Async {
	public static function parallel(list:Array<Dynamic>, complete:Dynamic) {
		var count = 0;
		var result:Array<Dynamic> = new Array<Dynamic>();
		
		for ( i in 0...result.length ) {
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
			var fn = list[i];
			fn( closure(i) );
		}
		
	}
	
	public static function waterfall( list:Array<Dynamic>, complete:Dynamic, ?first:Dynamic ) {
		function doOneByOne( list:Array<Dynamic>, result:Dynamic ) {
			if ( list.length == 0 ) {
				complete( null, result );
			} else {
				var fn = list.shift();
				fn(result)(function(err:Error, data:Dynamic) {
					if ( err != null ) {
						complete(err, null);
					}else {
						doOneByOne( list, data );
					}
				});
			}
		}
		doOneByOne( list, first );
	}
	
}