package helper;
import flash.display.DisplayObject;
import flash.geom.Point;
import flash.Lib;
import flash.net.URLRequest;
import org.vic.web.IWebView;
import view.ActivityPopup;
import view.SellMethod;
import view.fb.DetailFromPopup;
import view.fb.FBLoginPopup;
import view.HtcInPage;
import view.IntroPage;
import view.LuckyDrawPage;
import view.MoviePage;
import view.ProductPage;
import view.RelativePage;
import view.tech.TechBlink;
import view.tech.TechConnect;
import view.tech.TechFrame;
import view.tech.TechTheme;
import view.tech.TechPhoto;
import view.tech.TechAssist;
import view.TechPage;
import view.tech.TechCamera;
import view.tech.TechDouble;
import view.tech.TechDolby;
import view.tech.TechUltra;
/**
 * ...
 * @author han
 */
class Tool
{
	public static var allPage:Array<Dynamic> = [IntroPage, SellMethod, MoviePage, ProductPage, RelativePage, TechPage, TechFrame, LuckyDrawPage, HtcInPage];
	public static var allTechPage:Array<Dynamic> = [TechDouble, TechDolby, TechUltra, TechCamera, TechBlink, TechConnect, TechAssist, TechTheme, TechPhoto];
	public static var allFBPage:Array<Dynamic> = [FBLoginPopup, DetailFromPopup];
	
	public static function getURL(url:String, target:String = "_blank") {
		Lib.getURL(new URLRequest(url), target);
	}
	
	public static function centerForce(obj:DisplayObject, tw:Float, th:Float, sx:Float, sy:Float, sw: Float, sh: Float, wf:Float = 0.5, hf:Float = 0.5) {
		centerForceX( obj, tw, sx, sw, wf );
		centerForceY( obj, th, sy, sh, hf );
	}
	
	public static function centerForceX(obj:DisplayObject, tw:Float, sx:Float, sw: Float, f: Float = 0.5) {
		obj.x = sx+ (sw - tw) * f;
	}
	
	public static function centerForceY(obj:DisplayObject, th:Float, sy:Float, sh: Float, f: Float = 0.5) {
		obj.y = sy+ (sh - th) * f;
	}
	
	public static function center(obj:DisplayObject, sx:Float, sy:Float, sw: Float, sh: Float, wf:Float = 0.5, hf:Float = 0.5) {
		centerX(obj, sx, sw, wf);
		centerY(obj, sy, sh, hf);
	}
	
	public static function centerX(obj:DisplayObject, sx:Float, sw: Float, f: Float = 0.5) {
		obj.x = sx + (sw - obj.width) * f;
	}
	
	public static function centerY(obj:DisplayObject, sx:Float, sw: Float, f: Float = 0.5) {
		obj.y = sx+ (sw - obj.height) * f;
	}
	
	public static function interplot( p1:Float, p2:Float, f:Float ):Float {
		return p1 + (p2 - p1) * f;
	}
	
	public static function interplotPosition( obj:DisplayObject, target:Point, f:Float ) {
		obj.x = interplot( obj.x, target.x, f );
		obj.y = interplot( obj.y, target.y, f );
	}
	
	/**
	 * 專案客制函式, 非專案間共用
	 * 第一張圖必須錨點在左上角
	 * 第二張圖錨點在中間
	 * 第一張會被限制到第二張的區域範圍內
	 * @param	mc_photoOffset
	 * @param	mc_photoMask
	 * @param	err 這個錯誤係數是因為這個專案的SWF內部有一層不預期的縮放了2倍, 所以要以這個係數乘回來
	 */
	public static function regionBounding( mc_photoOffset: DisplayObject, mc_photoMask: DisplayObject, err: Float = 1 ) {
		
		// 有*2和/2(*err和/err)的係數是因為在flash的階層中, mc_photoOffset的子層被放大的二倍, 而那層沒被計算到, 所以要乘回來
		
		// 錨點在圖片中間, 算出左上角的點的世界坐標
		var origin1 = new Point( -mc_photoOffset.width/2 *err, -mc_photoOffset.height/2 *err); // 乘2的係數
		var global1 = mc_photoOffset.localToGlobal( origin1 );
		
		// 錨點在圖片左上角, 算出左上角的點的世界坐標
		var globalMask1 = mc_photoMask.localToGlobal( new Point() );

		if ( global1.x > globalMask1.x ) {
			var local = mc_photoOffset.globalToLocal( new Point(globalMask1.x, 0) );
			var offset = local.subtract( origin1 );
			mc_photoOffset.x += offset.x / err;	// 除2的係數
		}
		
		if ( global1.y > globalMask1.y ) {
			var local = mc_photoOffset.globalToLocal( new Point(0,globalMask1.y ) );
			var offset = local.subtract( origin1 );
			mc_photoOffset.y += offset.y / err;	// 除2的係數
		}
		
		// 錨點在圖片中間, 算出右下角的點的世界坐標
		var origin2 = new Point(mc_photoOffset.width/2 *err, mc_photoOffset.height/2 *err);
		var global2 = mc_photoOffset.localToGlobal( origin2 );
		
		// 錨點在圖片左上角, 算出有下角的點的世界坐標
		var globalMask2 = mc_photoMask.localToGlobal( new Point(mc_photoMask.width, mc_photoMask.height) );

		if ( global2.x < globalMask2.x ) {
			var local = mc_photoOffset.globalToLocal( new Point(globalMask2.x, 0) );
			var offset = local.subtract( origin2 );
			mc_photoOffset.x += offset.x / err;	// 除2的係數
		}
		if ( global2.y < globalMask2.y ) {
			var local = mc_photoOffset.globalToLocal( new Point(0, globalMask2.y) );
			var offset = local.subtract( origin2 );
			mc_photoOffset.y += offset.y / err;	// 除2的係數
		}
		
		
	}
}