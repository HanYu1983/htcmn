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
				if ( !page.isScriptEanbled() ) {
					return;
				}
				page.changeColor( 'a' );
				page.requestWaitAnimation();
			},
			btn_onTechDoubleClick_colorB: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				if ( !page.isScriptEanbled() ) {
					return;
				}
				page.changeColor( 'b' );
				page.requestWaitAnimation();
			},
			btn_onTechDoubleClick_colorC: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				if ( !page.isScriptEanbled() ) {
					return;
				}
				page.changeColor( 'c' );
				page.requestWaitAnimation();
			},
			btn_onTechDoubleClick_sideA: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				if ( !page.isScriptEanbled() ) {
					return;
				}
				page.changeSide( 'a' );
				page.requestWaitAnimation();
			},
			btn_onTechDoubleClick_sideB: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				if ( !page.isScriptEanbled() ) {
					return;
				}
				page.changeSide( 'b' );
				page.requestWaitAnimation();
			},
			btn_onTechDoubleClick_sideC: function() {
				var page:TechDouble = cast( getWebManager().getPage( TechDouble ), TechDouble );
				if ( !page.isScriptEanbled() ) {
					return;
				}
				page.changeSide( 'c' );
				page.requestWaitAnimation();
			}/*,
			btn_onTechDoubleClick_skip:function() {
				var page = cast( getWebManager().getPage(TechDouble), TechDouble);
				if ( !page.isScriptEanbled() ) {
					return;
				}
				page.skipAnimation();
			}*/
		}
		var targetPage:String = args[1].name;
		Reflect.field(goto, targetPage)();
	}
}