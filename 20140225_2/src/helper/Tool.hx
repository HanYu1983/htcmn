package helper;
import flash.display.DisplayObject;
import flash.geom.Point;
import org.vic.web.IWebView;
import view.ActivityPopup;
import view.ExpInfoPage;
import view.fb.DetailFromPopup;
import view.fb.FBLoginPopup;
import view.IntroPage;
import view.LuckyDrawPage;
import view.MoviePage;
import view.ProductPage;
import view.RelativePage;
import view.SellPage;
import view.SpecPage;
import view.tech.TechBlink;
import view.tech.TechBoom;
import view.tech.TechFrame;
import view.tech.TechPerson;
import view.tech.TechPhoto;
import view.tech.TechSitu;
import view.TechPage;
import view.tech.TechCamera;
import view.tech.TechDouble;
import view.tech.TechDuby;
import view.tech.TechUltra;
/**
 * ...
 * @author han
 */
class Tool
{
	public static var allPage:Array<Dynamic> = [IntroPage, ExpInfoPage, MoviePage, ProductPage, RelativePage, SellPage, SpecPage, TechPage, TechFrame, LuckyDrawPage];
	public static var allTechPage:Array<Dynamic> = [TechDouble, TechDuby, TechUltra, TechCamera, TechBlink, TechBoom, TechSitu, TechPerson, TechPhoto];
	public static var allFBPage:Array<Dynamic> = [FBLoginPopup, DetailFromPopup];
	
	public static function centerForce(obj:DisplayObject, tw:Int, th:Int, sx:Int, sy:Int, sw: Int, sh: Int, wf:Float = 0.5, hf:Float = 0.5) {
		centerForceX( obj, tw, sx, sw, wf );
		centerForceY( obj, th, sy, sh, hf );
	}
	
	public static function centerForceX(obj:DisplayObject, tw:Int, sx:Int, sw: Int, f: Float = 0.5) {
		obj.x = sx+ (sw - tw) * f;
	}
	
	public static function centerForceY(obj:DisplayObject, th:Int, sy:Int, sh: Int, f: Float = 0.5) {
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
}