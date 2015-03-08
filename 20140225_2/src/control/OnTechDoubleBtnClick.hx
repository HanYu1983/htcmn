package control;

import org.vic.web.WebCommand;
import view.tech.TechDouble;

/**
 * ...
 * @author vic
 */
class OnTechDoubleBtnClick extends WebCommand
{

	public function new(name:String=null) 
	{
		super(name);
		
	}
	
	override public function execute(?args:Dynamic):Void 
	{
		var goto:Dynamic = {
			btn_onTechDoubleClick_colorA: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				page.changeColor( 'a' );
			},
			btn_onTechDoubleClick_colorB: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				page.changeColor( 'b' );
			},
			btn_onTechDoubleClick_colorC: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				page.changeColor( 'c' );
			},
			btn_onTechDoubleClick_sideA: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				page.changeSide( 'a' );
			},
			btn_onTechDoubleClick_sideB: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				page.changeSide( 'b' );
			},
			btn_onTechDoubleClick_sideC: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				page.changeSide( 'c' );
			}
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}