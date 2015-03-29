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
class OnFooterBtnClick extends DefaultCommand
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
				var url = getWebManager().getData( 'config' ).url.use;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_private: function() {
				var url = getWebManager().getData( 'config' ).url.privacy;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_htc: function() {
				var url = getWebManager().getData( 'config' ).url.htc;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_fance: function() {
				var url = getWebManager().getData( 'config' ).url.fance;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_music: function(){
				var page:FooterUI = cast( getWebManager().getPage( FooterUI ), FooterUI );
				page.switchMusic();
			},
			btn_onFooterBtnClick_sell: function(){
				var url = getWebManager().getData( 'config' ).url.sell;
				Tool.getURL(url);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}