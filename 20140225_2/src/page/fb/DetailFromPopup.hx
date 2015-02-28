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
	}
	
	function cloneOkMark():DisplayObject {
		return getLoaderManager().getTask( 'Detail' ).getObject( 'Ok', [] );
	}
	
	var mark:Map<String, DisplayObject> = new Map<String, DisplayObject>();
	
	public function markTermInPosition(x:Float, y:Float):Bool {
		var id = Math.floor(x) + "_" +  Math.floor(y);
		if ( mark.exists(id) ) {
			var obj = mark.get(id);
			getRoot().removeChild(obj);
			mark.remove(id);
		}else {
			var obj = cloneOkMark();
			obj.x = x;
			obj.y = y;
			getRoot().addChild(obj);
			mark.set(id, obj);
		}
		var count:Int = 0;
		for ( k in mark.keys() ) {
			count += 1;
		}
		return count == 3;
	}
	
	public function changeCirclePosition(x:Float, y:Float) {
		_mc_circle.x = x;
		_mc_circle.y = y;
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