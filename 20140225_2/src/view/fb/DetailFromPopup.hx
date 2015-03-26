package view.fb;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.text.TextField;
import helper.IPopup;
import org.vic.utils.BasicUtils;
import view.DefaultPage;

/**
 * ...
 * @author han
 */
class DetailFromPopup extends DefaultPage implements IPopup
{
	public static var formType:String = "award";
	
	var _mc_circle:DisplayObject;
	var _txt_name:TextField;
	var _txt_phone:TextField;
	var _txt_mail:TextField;
	var _btn_onDetailFormBtnClick_boy: DisplayObject;
	var _btn_onDetailFormBtnClick_girl: DisplayObject;
	var _btn_onDetailFormBtnClick_okA: DisplayObject;
	var _btn_onDetailFormBtnClick_okB: DisplayObject;
	var _btn_onDetailFormBtnClick_okC: DisplayObject;

	public function new() 
	{
		super();
		layerName = "popup";
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		
		
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
					
				case 'btn_onDetailFormBtnClick_boy':
					_btn_onDetailFormBtnClick_boy = obj;
					
				case 'btn_onDetailFormBtnClick_girl':
					_btn_onDetailFormBtnClick_girl = obj;
					
				case 'btn_onDetailFormBtnClick_okA':
					_btn_onDetailFormBtnClick_okA = obj;
					
				case 'btn_onDetailFormBtnClick_okB':
					_btn_onDetailFormBtnClick_okB = obj;
					
				case 'btn_onDetailFormBtnClick_okC':
					_btn_onDetailFormBtnClick_okC = obj;
			}
		});
		super.onOpenEvent(param, cb);
		
		// 有些物件在super.onOpenEvent中取得, 所以除了取物件以外的操作行為都要放在super.onOpenEvent之後比較正確
		initDefaultData();
		markTermInPosition( _btn_onDetailFormBtnClick_okC.x, _btn_onDetailFormBtnClick_okC.y );
	}
	
	function initDefaultData() {
		if ( getWebManager().getData('name') != null ) {
			_txt_name.text = getWebManager().getData('name');
		}
		if ( getWebManager().getData('phone') != null ) {
			_txt_phone.text = getWebManager().getData('phone');
		}
		if ( getWebManager().getData('email') != null ) {
			_txt_mail.text = getWebManager().getData('email');
		}
		if ( getWebManager().getData('gender') != null ) {
			var gender = getWebManager().getData('gender');
			if ( gender == 'male' ) {
				changeCirclePosition( _btn_onDetailFormBtnClick_boy.x, _btn_onDetailFormBtnClick_boy.y );
			} else {
				changeCirclePosition( _btn_onDetailFormBtnClick_girl.x, _btn_onDetailFormBtnClick_girl.y );
			}
		}
	}
	
	public function applyData() {
		getWebManager().setData('name', _txt_name.text);
		getWebManager().setData('phone', _txt_phone.text);
		getWebManager().setData('email', _txt_mail.text);
		if ( theCircleIs( _btn_onDetailFormBtnClick_boy ) ) {
			getWebManager().setData('gender', 'male');
		} else {
			getWebManager().setData('gender', 'female');
		}
		if ( theMarkIs( _btn_onDetailFormBtnClick_okA ) ) {
			getWebManager().setData('is_read_policy', 'Y');
		} else {
			getWebManager().setData('is_read_policy', '');
		}
		if ( theMarkIs( _btn_onDetailFormBtnClick_okB ) ) {
			getWebManager().setData('is_agree_personal_info', 'Y');
		} else {
			getWebManager().setData('is_agree_personal_info', '');
		}
		if ( theMarkIs( _btn_onDetailFormBtnClick_okC ) ) {
			getWebManager().setData('is_accept_notice', 'Y');
		} else {
			getWebManager().setData('is_accept_notice', '');
		}
	}
	
	function cloneOkMark():DisplayObject {
		return getLoaderManager().getTask( 'Preload' ).getObject( 'Ok', [] );
	}
	
	var mark:Map<String, DisplayObject> = new Map<String, DisplayObject>();
	
	function theMarkIs( obj:DisplayObject ):Bool {
		var id = Math.floor(obj.x) + "_" +  Math.floor(obj.y);
		return mark.exists(id);
	}
	
	public function markTermInPosition(x:Float, y:Float):Bool {
		var id = Math.floor(x) + "_" +  Math.floor(y);
		if ( mark.exists(id) ) {
			var obj = mark.get(id);
			cast( _mc_popup, DisplayObjectContainer ).removeChild(obj);
			mark.remove(id);
		}else {
			var obj = cloneOkMark();
			obj.x = x;
			obj.y = y;
			cast( _mc_popup, DisplayObjectContainer ).addChild(obj);
			mark.set(id, obj);
		}
		var count:Int = 0;
		for ( k in mark.keys() ) {
			count += 1;
		}
		return count == 3;
	}
	
	function theCircleIs( obj:DisplayObject ):Bool{
		return Math.floor( _mc_circle.x ) == Math.floor(obj.x) && Math.floor( _mc_circle.y ) == Math.floor(obj.y);
	}
	
	public function changeCirclePosition(x:Float, y:Float) {
		_mc_circle.x = x;
		_mc_circle.y = y;
	}
	
	override function getRootInfo():Dynamic 
	{
		return switch(formType) {
			case "award": { name:'Preload', path:'DetailAward' };
			case _: { name:'Preload', path:'Detail' };
		}
		//return {name:'Preload', path:'Detail' };
	}
}