package org.han;
import caurina.transitions.properties.DisplayShortcuts;
import flash.errors.Error;
import haxe.ds.Vector;

/**
 * ...
 * @author han
 */
class Async {
	
	public static function map( ori:Array<Dynamic>, fn:Dynamic->Dynamic, complete:Dynamic ) {
		var result:Vector<Dynamic> = new Vector<Dynamic>( ori.length );
		var resultErr:Error = null;
		var count = 0;
		
		for ( i in 0...ori.length ) {
			function todo(idx:Int) {
				return function( err: Dynamic, res:Dynamic ) {
					if ( err != null ) {
						resultErr = err;
					} else {
						result[idx] = res;
					}
					if ( complete != null ) {
						if ( ++count == result.length ) {
							if ( resultErr != null ) {
								complete( resultErr, null );
							} else {
								complete( null, result );
							}
						}
					}
				}
			}
			fn( ori[i] )( todo(i) );
		}
	}
	
	
	public static function parallel(list:Array<Dynamic>, complete:Dynamic) {
		var count = 0;
		var result:Vector<Dynamic> = new Vector<Dynamic>( list.length );
		
		for ( i in 0...result.length ) {
			function closure(id:Int) {
				return function(err:Error, data:Dynamic) {
					if (err != null) {
						result[id] = err;
					}else {
						result[id] = data;
					}
					if ( complete != null ) {
						if ( ++count == result.length ) {
							complete(result);
						}
					}
				}
			}
			var fn = list[i];
			fn( closure(i) );
		}
		
	}
	
	public static function series( list:Array<Dynamic>, complete:Dynamic ) {
		function doOneByOne( list:Array<Dynamic> ) {
			if ( list.length == 0 ) {
				if( complete != null )
					complete( null, null );
			} else {
				var fn = list.shift();
				fn(function(err:Error, data:Dynamic) {
					if ( err != null ) {
						if( complete != null )
							complete(err, null);
					}else {
						doOneByOne( list );
					}
				});
			}
		}
		doOneByOne( list );
	}
	
	public static function waterfall( list:Array<Dynamic>, complete:Dynamic, ?first:Dynamic ) {
		function doOneByOne( list:Array<Dynamic>, result:Dynamic ) {
			if ( list.length == 0 ) {
				if( complete != null )
					complete( null, result );
			} else {
				var fn = list.shift();
				fn(result)(function(err:Error, data:Dynamic) {
					if ( err != null ) {
						if( complete != null )
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