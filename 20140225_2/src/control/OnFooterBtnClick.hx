package control;
import flash.Lib;
import flash.net.URLRequest;
import helper.Tool;
import org.vic.web.WebCommand;
import view.ActivityPopup;
import view.ExpInfoPage;
import view.FooterUI;
import view.IntroPage;
import view.MoviePage;
import view.ProductPage;
import view.RelativePage;
import view.TechPage;

/**
 * ...
 * @author vic
 */
class OnFooterBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		
		var goto:Dynamic = {
			btn_onFooterBtnClick_use: function() {
				Tool.getURL("http://www.htc.com/tw/terms/terms-of-use/");
			},
			btn_onFooterBtnClick_private: function(){
				Tool.getURL("http://www.htc.com/tw/terms/privacy/");
			},
			btn_onFooterBtnClick_htc: function(){
				Tool.getURL("http://www.htc.com/tw/");
			},
			btn_onFooterBtnClick_fance: function() {
				Tool.getURL("https://www.facebook.com/HTCTaiwan");
			},
			btn_onFooterBtnClick_music: function(){
				var page:FooterUI = cast( getWebManager().getPage( FooterUI ), FooterUI );
				page.switchMusic();
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}