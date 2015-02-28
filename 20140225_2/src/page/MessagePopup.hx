package page;

/**
 * ...
 * @author han
 */
class MessagePopup extends DefaultPage
{
	public function new() 
	{
		super();
		layerName = "popup"
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		var msg:String = param['msg'];
	}
	
}