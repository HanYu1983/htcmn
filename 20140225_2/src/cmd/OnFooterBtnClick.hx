package cmd;
import org.vic.web.WebCommand;
import page.ActivityPopup;
import page.ExpInfoPage;
import page.FooterUI;
import page.IntroPage;
import page.MoviePage;
import page.ProductPage;
import page.RelativePage;
import page.SellPage;
import page.SpecPage;
import page.TechPage;

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
				
			},
			btn_onFooterBtnClick_private: function(){
				
			},
			btn_onFooterBtnClick_htc: function(){
				
			},
			btn_onFooterBtnClick_fance: function(){
				
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