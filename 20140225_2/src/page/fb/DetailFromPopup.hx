package page.fb;
import flash.display.DisplayObject;
import flash.text.TextField;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class DetailFromPopup extends DefaultPage
{
	private var _mc_circle:DisplayObject;
	private var _txt_name:TextField;
	private var _txt_phone:TextField;
	private var _txt_mail:TextField;

	public function new() 
	{
		super();
		layerName = "popup";
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_circle':
					_mc_circle = obj;
				case 'txt_name':
					_txt_name = cast( obj, TextField );
				case 'txt_phone':
					_txt_phone = cast( obj, TextField );
				case 'txt_mail':
					_txt_mail = cast( obj, TextField );
			}
		});
		
		_mc_circle.x = 100;
		
		var ok = getLoaderManager().getTask( 'Detail' ).getObject( 'Ok', [] );
		getRoot().addChild( ok );
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'Detail', path:'src/Detail.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Detail', path:'Detail' };
	}
}