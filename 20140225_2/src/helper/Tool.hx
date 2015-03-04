package helper;
import flash.display.DisplayObject;
import flash.geom.Point;
import org.vic.web.IWebView;
import page.ActivityPopup;
import page.ExpInfoPage;
import page.fb.DetailFromPopup;
import page.fb.FBLoginPopup;
import page.IntroPage;
import page.LuckyDrawPage;
import page.MoviePage;
import page.ProductPage;
import page.RelativePage;
import page.SellPage;
import page.SpecPage;
import page.tech.TechBlink;
import page.tech.TechBoom;
import page.tech.TechFrame;
import page.tech.TechPerson;
import page.tech.TechPhoto;
import page.tech.TechSitu;
import page.TechPage;
import page.tech.TechCamera;
import page.tech.TechDouble;
import page.tech.TechDuby;
import page.tech.TechUltra;
/**
 * ...
 * @author han
 */
class Tool
{
	public static var allPage:Array<Dynamic> = [IntroPage, ExpInfoPage, MoviePage, ProductPage, RelativePage, SellPage, SpecPage, TechPage, TechFrame, LuckyDrawPage];
	public static var allTechPage:Array<Dynamic> = [TechDouble, TechDuby, TechUltra, TechCamera, TechBlink, TechBoom, TechSitu, TechPerson, TechPhoto];
	public static var allFBPage:Array<Dynamic> = [FBLoginPopup, DetailFromPopup];
	
	public static function centerForce(obj:DisplayObject, tw:Int, th:Int, sx:Int, sy:Int, sw: Int, sh: Int) {
		centerForceX( obj, tw, sx, sw );
		centerForceY( obj, th, sy, sh );
	}
	
	public static function centerForceX(obj:DisplayObject, tw:Int, sx:Int, sw: Int) {
		obj.x = sx+ (sw - tw) / 2;
	}
	
	public static function centerForceY(obj:DisplayObject, th:Int, sy:Int, sh: Int) {
		obj.y = sy+ (sh - th) / 2;
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
}