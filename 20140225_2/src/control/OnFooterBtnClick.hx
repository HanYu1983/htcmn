package control;
import flash.display.MovieClip;
import flash.Lib;
import flash.net.URLRequest;
import helper.Tool;
import org.vic.web.WebCommand;
import view.ActivityPopup;
import view.SellMethod;
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
			},
			btn_onFooterBtnClick_htcSell:function() {
				var url = getWebManager().getData( 'config' ).url.htcSell;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_chi:function() {
				var url = getWebManager().getData( 'config' ).url.chi;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_far:function() {
				var url = getWebManager().getData( 'config' ).url.far;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_taiwan:function() {
				var url = getWebManager().getData( 'config' ).url.taiwan;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_a:function() {
				var url = getWebManager().getData( 'config' ).url.a;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_star:function() {
				var url = getWebManager().getData( 'config' ).url.star;
				Tool.getURL(url);
			},
			btn_onFooterBtnClick_horse:function() {
				var btn:MovieClip = args[1];
				var url:String = '';
				switch( btn.cardId ) {
					case '1':
						url = getWebManager().getData( 'config' ).url.htcSell;
					case '2':
						url = getWebManager().getData( 'config' ).url.chinese;
					case '3':
						url = getWebManager().getData( 'config' ).url.taiwan;
					case '4':
						url = getWebManager().getData( 'config' ).url.far;
					case '5':
						url = getWebManager().getData( 'config' ).url.star;
					case '6':
						SimpleController.onAlert( '敬請期待' );
						//url = getWebManager().getData( 'config' ).url.asia;
				}
				if( url != '' ) Tool.getURL(url);
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
	
}