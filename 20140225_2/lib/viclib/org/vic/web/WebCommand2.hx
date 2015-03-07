package org.vic.web;
import flash.errors.Error;
import org.vic.web.IWebCommand2;

/**
 * ...
 * @author han
 */

class MapFieldProvider implements IFieldProvider {
	var _fields:Map<String, Dynamic> = new Map<String, Dynamic>();
	public function set(key:String, value:Dynamic):IFieldProvider {
		_fields.set(key, value);
		return this;
	}
	public function get(key:String):Dynamic {
		return _fields.get(key);
	}
}
 
class WebCommand2 implements IWebCommand2
{
	var _field:IFieldProvider = new MapFieldProvider();
	
	public function setField(field:IFieldProvider):Void {
		_field = field;
	}
	
	public function field():IFieldProvider {
		return _field;
	}
	
	public function set(key:String, value:Dynamic):IWebCommand2 {
		_field.set(key, value);
		return this;
	}
	
	public function get(key:String):Dynamic {
		return _field.get(key);
	}
	
	public function getOr(key:String, def: Dynamic):Dynamic {
		if ( _field.get(key) == null )
			return def;
		else
			return _field.get(key);
	}
	
	public function require( list: Array<String> ) {
		for ( p in list.filter( function(p) { return p.charAt(0) != '?'; } ) ) {
			if ( _field.get(p) == null ) {
				throw new Error("no param:" + p);
			}
		}
	}
	
	public function invoke( cb: Dynamic ):Void{
		try {
			executeImpl( cb );
		} catch (e:Error) {
			cb(e, null);
		}
	}
	
	function executeImpl( cb: Dynamic ):Void {
		cb( null, null );
	}

}