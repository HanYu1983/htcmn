package view;

/**
 * ...
 * @author han
 */
class MessagePopup extends DefaultPage
{
	public function new() 
	{
		super();
		layerName = "popup";
		createDebugButton("btn_onMessageBtnClick_confirm", 0, 0 );
		createDebugButton("btn_onMessageBtnClick_cancel", 0, 20 );
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		var msg:String = Reflect.field(param, "msg");
	}
	
}