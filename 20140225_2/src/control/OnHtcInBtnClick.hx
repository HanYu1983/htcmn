package control;

import flash.display.MovieClip;
import org.vic.web.WebCommand;
import view.LuckyDrawPage;
import view.MoviePage;

/**
 * ...
 * @author vic
 */
class OnHtcInBtnClick extends DefaultCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	
	override public function execute(?args:Dynamic):Void 
	{
		super.execute(args);
		
		var goto:Dynamic = {
			btn_onHtcInBtnClick_more: function() {
				trace( 'btn_onHtcInBtnClick_more' );
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}