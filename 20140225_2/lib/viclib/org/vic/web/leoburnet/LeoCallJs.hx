package org.vic.web.leoburnet; 
import flash.errors.Error;
import flash.external.ExternalInterface;
/**
 * ...
 * @author fff
 */
class LeoCallJs
{
	public static function fbLogin() {
		callFunc( 'fnFBLogin' );
	}
	
	/**
	 * 
	 * @param	value	要分享的圖的檔名
	 */
	public static function fnFBSharing( value:String ) {
		callFunc( 'fnFBSharing', value );
	}
	
	public static function fnGetAlbums() {
		callFunc( 'fnGetAlbums' );
	}
	
	public static function trackingButton( value:String ) {
		callFunc( '_gaCK', value );
	}

	public static function trackingPage( value:String ) { 	
		callFunc( '_gaPV', value );
	}
	
	private static function callFunc( fn, ?v ) {
		try {
			trace( 'call web: ' + fn + ', value: ' + v );
			ExternalInterface.call( fn, v );
		}catch ( e:Error ) {  }
	}
}
