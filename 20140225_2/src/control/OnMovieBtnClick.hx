package control;

import flash.display.MovieClip;
import org.vic.web.WebCommand;
import view.LuckyDrawPage;
import view.MoviePage;

/**
 * ...
 * @author vic
 */
class OnMovieBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		
		var goto:Dynamic = {
			btn_onMovieBtnClick_up: function() {
				var page:MoviePage = cast( getWebManager().getPage( MoviePage ), MoviePage);
				page.moveDown();
			},
			btn_onMovieBtnClick_down: function(){
				var page:MoviePage = cast( getWebManager().getPage( MoviePage ), MoviePage);
				page.moveUp();
			},
			btn_onMovieBtnClick_share: function() {
				getWebManager().openPage( LuckyDrawPage, null );
			},
			btn_onMovieBtnClick_movie: function() {
				trace("DFF");
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}