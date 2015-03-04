package org.vic.web;
import flash.errors.Error;
import org.vic.web.IWebCommand2;

/**
 * ...
 * @author han
 */

class MapFieldProvider implements IFieldProvider {
	var _fields:Map<String, Dynamic> = new Map<String, Dynamic>();
	public function set(key:String, value:Dynamic):IWebCommand2 {
		_fields.set(key, value);
	}
	public function get(key:String):Dynamic {
		return _fields.get(key);
	}
}
 
class WebCommand2 implements IWebCommand2
{
	var _field:IFieldProvider;
	var _err:Error = null;
	var _fn: IWebCommand2->Void;
	
	public function setField(field:IFieldProvider):Void {
		_field = field;
	}
	
	public function field():IFieldProvider {
		return _field;
	}
	
	public function set(key:String, value:Dynamic):IWebCommand2 {
		_field.set(key, value);
	}
	
	public function get(key:String):Dynamic {
		return _field.get(key);
	}
	
	public function error():Error {
		return _err;
	}
	public function invoke( cb: IWebCommand2->Void ):Void{
		try {
			executeImpl( cb );
		} catch (e:Error) {
			_err = e;
			cb();
		}
	}
	function executeImpl( cb: IWebCommand2->Void ):Void {
		cb(this);
		
		
		cmd.invoke( function(cmd) {
			if (cmd.error()) {
				
			} else {
				nextCmd().invoke( cb );
			}
		});
		
		
	}

}