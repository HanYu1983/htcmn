package control;
import helper.Tool;
import model.AppAPI;
import org.vic.web.WebCommand;
import view.ActivityPopup;
import view.ExpInfoPage;
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
			// 詳細規格
			btn_onHeaderBtnClick_Spec: function() {
				Tool.getURL("http://www.htc.com/tw/smartphones/htc-one-m9/");
				//AppAPI.changePage( { mgr:this.getWebManager(), page: SpecPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_Relative: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: RelativePage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_ExpInfo: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: ExpInfoPage, params:{} } ) (null);
			},
			// 銷售通路
			btn_onHeaderBtnClick_Sell: function() {
				Tool.getURL("http://www.htc.com/tw/go/buy/");
				//AppAPI.changePage( { mgr:this.getWebManager(), page: SellPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_Product: function(){
				AppAPI.changePage( { mgr:this.getWebManager(), page: ProductPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_skip:function() {
				SimpleController.onHeaderSkipButtonClick();
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}