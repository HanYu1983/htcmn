package helper;
import flash.display.DisplayObject;
import org.vic.web.IWebView;
import page.ActivityPopup;
import page.ExpInfoPage;
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
	
	public static function center(obj:DisplayObject, sx:Int, sy:Int, sw: Int, sh: Int) {
		centerX(obj, sx, sw);
		centerY(obj, sy, sh);
	}
	public static function centerX(obj:DisplayObject, sx:Int, sw: Int) {
		obj.x = sx+ (sw - obj.width) / 2;
	}
	public static function centerY(obj:DisplayObject, sx:Int, sw: Int) {
		obj.y = sx+ (sw - obj.height) / 2;
	}
}