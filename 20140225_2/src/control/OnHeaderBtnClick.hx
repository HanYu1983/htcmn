package control;
import helper.Tool;
import model.AppAPI;
import org.vic.web.WebCommand;
import view.ActivityPopup;
import view.SellMethod;
import view.HtcInPage;
import view.IntroPage;
import view.MoviePage;
import view.ProductPage;
import view.RelativePage;
import view.TechPage;

/**
 * ...
 * @author vic
 */
class OnHeaderBtnClick extends DefaultCommand
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
				var url = getWebManager().getData( 'config' ).url.spec;
				Tool.getURL(url);
			},
			btn_onHeaderBtnClick_Relative: function() {
				// 先使用alert
				SimpleController.onAlert("敬請期待");
				//AppAPI.changePage( { mgr:this.getWebManager(), page: RelativePage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_ExpInfo: function() {
				//var url = getWebManager().getData( 'config' ).url.expinfo;
				var url = getWebManager().getData( 'config' ).url.vip;
				Tool.getURL(url);
			},
			// 銷售通路
			btn_onHeaderBtnClick_Sell: function() {
				var url = getWebManager().getData( 'config' ).url.sell;
				Tool.getURL(url);
			},
			btn_onHeaderBtnClick_Product: function() {
				var url = getWebManager().getData( 'config' ).url.early;
				Tool.getURL(url);
				//AppAPI.changePage( { mgr:this.getWebManager(), page: ProductPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_skip:function() {
				SimpleController.onHeaderSkipButtonClick();
			},
			btn_onHeaderBtnClick_htcin:function() {
				AppAPI.changePage( { mgr:this.getWebManager(), page: HtcInPage, params:{} } ) (null);
			},
			btn_onHeaderBtnClick_SellMethod:function() {
				AppAPI.changePage( { mgr:this.getWebManager(), page: SellMethod, params:{} } ) (null);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}