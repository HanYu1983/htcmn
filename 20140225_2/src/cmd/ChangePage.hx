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
class ChangePage extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		var pages:Array<Dynamic> = [IntroPage, ExpInfoPage, MoviePage, ProductPage, RelativePage, SellPage, SpecPage, TechPage];
		function closePage(page:Dynamic) {
			getWebManager().closePage(page);
			return true;
		}
		Lambda.foreach( pages, closePage );
		
		var targetPage = args;
		getWebManager().openPage(targetPage, null);
	}
	
}