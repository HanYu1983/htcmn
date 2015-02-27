package org.vic.util;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.geom.Point;
import flash.net.URLRequest;

/**
 * ...
 * @author vic
 */
class Util
{
	public static function getCurveYUsing3Point( ary_pos:Array<Point> ):Array<Float> {
		if ( ary_pos.length != 3 )	throw ('只能有三個元素' );
		var m_X:Array<Float> = [];
		var m_Y:Array<Float> = [];
		for ( pt in ary_pos ) {
			m_X.push( pt.x );
			m_Y.push( pt.y );
		}
		
		var mw = Lambda.fold( m_X, function( curr, first ):Float {
			return curr > first ? curr : first;
		}, m_X[0]);
		
		var valA = 	((m_Y[1] - m_Y[0]) * (m_X[0] - m_X[2]) + 
					(m_Y[2] - m_Y[0]) * (m_X[1] - m_X[0])) / 
					((m_X[0] - m_X[2]) * (Math.pow( m_X[1], 2 ) - Math.pow( m_X[0], 2 )) + 
					(m_X[1] - m_X[0]) * (Math.pow( m_X[2], 2 ) - Math.pow( m_X[0], 2 )));
		
		var valB = ((m_Y[1] - m_Y[0]) - valA * (Math.pow( m_X[1], 2 ) - Math.pow( m_X[0], 2 ))) / (m_X[1] - m_X[0]);
		var valC = m_Y[0] - valA * Math.pow( m_X[0], 2 ) - valB * m_X[0];
		
		var ary_ret:Array<Float> = [];
		var cy;
		for ( cx in 0...cast( mw, Int ) ) {
			cy = valA * Math.pow( cx, 2 ) + valB * cx + valC;
			ary_ret.push( cy );
		}
		return ary_ret;
	}
	
	public static function drawBitmapToSpecifyCurve( bmp:BitmapData, curveA:Array<Float>, curveB:Array<Float> ):BitmapData {
		if ( curveA.length != curveB.length )	throw( '兩條曲線的元素數量必需一致' );
		
		var ary_pixels:Array <UInt> = [];
		for ( pw in 0...bmp.width ) {
			for ( ph in 0...bmp.height ) {
				ary_pixels.push( bmp.getPixel32( pw, ph ));
			}
		}
		
		var mh = Lambda.fold( Lambda.concat( curveA, curveB ), function( curr, first ):Float {
			return curr > first ? curr : first;
		}, 0);
		
		var bmp2 = new BitmapData( curveA.length, cast( mh, Int ), true, 0 );
		for ( val in 0...ary_pixels.length ) {
			var dx = cast( val / bmp.height, Int );
			var dy = cast( val % bmp.height, Int );
			var diffPerX = bmp2.width / bmp.width;
			var mapToOriX:Int = cast( dx / bmp.width * bmp2.width, Int );
			var diffPerY = ( curveB[mapToOriX] - curveA[mapToOriX] ) / bmp.height;
			var sy = curveA[mapToOriX];
			bmp2.setPixel32( cast( dx * diffPerX, Int ), cast( dy * diffPerY + sy, Int ), ary_pixels[val] );
		}
		return bmp2;
	}
	
	public static function multiLoader( ary_path:Array<String>, doFunc:Dynamic->Void, cb:Void->Void ):Void {
		var lid:Int = 0;
		var lr:Loader = new Loader();
		
		function comp( e:Event ):Void {
			doFunc( lr.contentLoaderInfo.content );
			if ( ary_path.length > 0 ) {
				lr.load( new URLRequest( ary_path.shift() ));
			}else cb();
		}
		
		lr.load( new URLRequest( ary_path.shift() ));
		lr.contentLoaderInfo.addEventListener( Event.COMPLETE, comp );
	}
}