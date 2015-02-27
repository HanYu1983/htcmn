package org.vic.utils ;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.FrameLabel;
import flash.display.Graphics;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.errors.SecurityError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.geom.Point;
import flash.Lib;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import haxe.Timer;
/**
 * ...
 * @author vic
 */
class BasicUtils 
{
	public static function drawRect( g:Graphics, color:UInt = 0, alpha:Float = 1, width:Float = 10, height:Float = 10 ):Void {
		g.beginFill( color, alpha );
		g.drawRect( 0, 0, width, height );
		g.endFill();
	}
	
	public static function hasLabel( mc:MovieClip, labelName:String ):Bool {
		var ary_label:Array<FrameLabel> = mc.currentLabels;
		for ( i in 0...ary_label.length ) {
			var ln:String = ary_label[i].name;
			if ( ln == labelName )
				return true;
		}
		return false;
	}
	
	public static function revealObj( disObj:DisplayObject, doFunc:DisplayObject->Void ):Void {
		doFunc( disObj );
		if ( Std.is( disObj, DisplayObjectContainer ) ) {
			var disObjCon:DisplayObjectContainer = cast( disObj, DisplayObjectContainer );
			var max:Int = disObjCon.numChildren;
			for ( i in 0...max ) {
				revealObj( cast( disObjCon.getChildAt( i ), DisplayObject ), doFunc );
			}
		}
	}
	
	public static function delayCall( delay:Int, doFunc:Void->Void ) {
		var timer = new Timer( delay );
		timer.run = function() {
			doFunc();
			timer.stop();
			timer.run = null;
			timer = null;
		}
	}
	
	public static function stopMovieClip( mc:DisplayObject ):Void {
		revealObj( mc, function( disObj:DisplayObject ):Void {
			if ( Std.is( disObj, MovieClip ) ) {
				cast( disObj, MovieClip ).stop();
			}
		});
	}
	
	public static function playMovieClip( mc:DisplayObjectContainer ):Void {
		revealObj( mc, function( disObj:DisplayObject ):Void {
			if ( Std.is( disObj, MovieClip ) ) {
				cast( disObj, MovieClip ).play();
			}
		});
	}
	
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
		
		function onIOError( e ) {
			trace( e );
		}
		
		function onSecurityError( e ) {
			trace( e );
		}
		
		function onProgress( e ) {
			
		}
		
		lr.load( new URLRequest( ary_path.shift() ), new LoaderContext( true ));
		lr.contentLoaderInfo.addEventListener( Event.COMPLETE, comp );
		lr.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
		lr.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
		lr.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
	}
	
	public static function getRescaleDisplayObject( disobj:DisplayObject, con:DisplayObjectContainer ) {
		con.removeChildren();
		var ratio = disobj.width / disobj.height;
		var toRatio = con.width / con.height;
		var fac;
		if ( ratio > toRatio ) {
			fac = con.height / disobj.height;
		}else {
			fac = con.width / disobj.width;
		}
		disobj.scaleX *= fac;
		disobj.scaleY *= fac;
		
		con.addChild( disobj );
		disobj.x = ( con.width - disobj.width ) / 2;
		disobj.y = ( con.height - disobj.height ) / 2;
		return con;
	}
	
	public static function randomArrayItem<T>( ary:Array<T> ) {
		ary.sort( function( ia:T, ib:T ) {
			return Math.random() > .5 ? 1 : -1;
		});
	}
	
	public static function shareToFacebook( url:String ) {
		Lib.getURL( new URLRequest( 'http://www.facebook.com/share.php?u=' + url ));
	}
}