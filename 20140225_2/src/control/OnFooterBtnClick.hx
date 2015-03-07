package control;
import org.vic.web.WebCommand;
import view.ActivityPopup;
import view.ExpInfoPage;
import view.FooterUI;
import view.IntroPage;
import view.MoviePage;
import view.ProductPage;
import view.RelativePage;
import view.SellPage;
import view.SpecPage;
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