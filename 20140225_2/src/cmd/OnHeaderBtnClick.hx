package cmd;
import helper.AppAPI;
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
				AppAPI.changePage( { mgr:this.getWebManager(), page: IntroPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_tech: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: TechPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_movie: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: MoviePage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_active: function(){
				AppAPI.openPage( { mgr:this.getWebManager(), page: ActivityPopup, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_Spec: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: SpecPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_Relative: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: RelativePage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_ExpInfo: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: ExpInfoPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_Sell: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: SellPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_Product: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: ProductPage, params:{} } ) (null);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}