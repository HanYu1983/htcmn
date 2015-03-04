package page;
import org.vic.web.BasicButton;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class TechPage extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = 'page';
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		var disableBtnNames:Array<String> = [
			"btn_onHomeBtnClick_blink",
			"btn_onHomeBtnClick_boom",
			"btn_onHomeBtnClick_person",
			"btn_onHomeBtnClick_photo",
			"btn_onHomeBtnClick_situ"
		];
		
		function getButton(name:String):BasicButton {
			return this.getButtonsByName(name);
		}
		
		function enable(v:Bool):Dynamic{
			return function(btn:BasicButton) {
				btn.enable(v);
				return true;
			}
		}
		
		Lambda.foreach( disableBtnNames.map( getButton ), enable( false ) );
		
	}
	
	override function onCloseEvent(cb:Void->Void = null):Void 
	{
		super.onCloseEvent(cb);
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechFront', path:'src/TechFront.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechFront', path:'TechFront' };
	}
	
	override function suggestionEnableAutoBarWhenOpen():Null<Bool> 
	{
		return true;
	}
}