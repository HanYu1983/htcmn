package cmd;
import org.vic.web.WebCommand;
import page.ActivityPopup;
import page.ExpInfoPage;
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
class OnHeaderBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		
		var goto:Dynamic = {
			btn_onHeaderBtnClick_home: function() {
				this.getWebManager().execute("ChangePage", IntroPage);
			},
			btn_onHeaderBtnClick_tech: function(){
				this.getWebManager().execute("ChangePage", TechPage);
			},
			btn_onHeaderBtnClick_movie: function(){
				this.getWebManager().execute("ChangePage", MoviePage);
			},
			btn_onHeaderBtnClick_active: function(){
				this.getWebManager().execute("OpenPopup", ActivityPopup);
			},
			btn_onHeaderBtnClick_Spec: function(){
				this.getWebManager().execute("ChangePage", SpecPage);
			},
			btn_onHeaderBtnClick_Relative: function(){
				this.getWebManager().execute("ChangePage", RelativePage);
			},
			btn_onHeaderBtnClick_ExpInfo: function(){
				this.getWebManager().execute("ChangePage", ExpInfoPage);
			},
			btn_onHeaderBtnClick_Sell: function(){
				this.getWebManager().execute("ChangePage", SellPage);
			},
			btn_onHeaderBtnClick_Product: function(){
				this.getWebManager().execute("ChangePage", ProductPage);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}