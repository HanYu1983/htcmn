/**
 * ...
 * @author Krzysztof Rozalski
 */

package helper;
import flash.net.SharedObject;

class Cookie<T> {
	
	var dataHolder:Dynamic;
	public var data(get_data, set_data):T;
	public var isNew(get_isNew, null):Bool;
	var sharedObject:SharedObject;
	var counter(get_counter, set_counter):Null<Int>;
	
	static var cookies = new Map<String, Cookie<Dynamic>>();

	function new(sharedObject, defaultValue:T) {
		this.sharedObject = sharedObject;
		if (counter == null) counter = -1;
		if (data == null)
			sharedObject.data.cookie = defaultValue;
		else
			merge(defaultValue);
	}
	
	public function save() {
		sharedObject.flush();
		counter++;
	}
	
	public function delete() {
		sharedObject.clear();
	}
	
	public static function load<T>(defaultValue:T, ?id="hapi-cookie"):Cookie<T> {
		if (cookies.exists(id)) {
			return cast cookies.get(id);
		}else {
			var sharedObject = SharedObject.getLocal(id, "/");
			var cookie = new Cookie(sharedObject, defaultValue);
			cookie.counter++;
			cookies.set(id, cookie);
			return cast cookie; 
		}
	}
	
	function get_data():T {
		return sharedObject.data.cookie;
	}
	
	function set_data(d:T):T {
		return sharedObject.data.cookie = d;
	}
	
	function get_isNew():Bool {
		return get_counter() <= 0;
	}
	
	function get_counter():Null<Int> {
		return sharedObject.data.__counter;
	}
	
	function set_counter(counter):Null<Int> {
		return sharedObject.data.__counter = counter;
	}
	
	function merge(dataToMerge) {
		var fields = Reflect.fields(dataToMerge);
		for ( f in fields ) {
			var differentType:Bool;
			if ( Reflect.isObject( Reflect.field(dataToMerge, f) ) ) {
				differentType = Type.getClass(Reflect.field(data, f)) != Type.getClass(Reflect.field(dataToMerge, f));
			}else{ 
				differentType = Type.typeof(Reflect.field(data, f)) !=  Type.typeof(Reflect.field(dataToMerge, f));
			}
			var hasNoField = !Reflect.hasField( data, f );
			var nullValue = Reflect.field(data, f) == null;
			if ( hasNoField || nullValue || differentType) {
				var obj:Dynamic = Reflect.field(dataToMerge, f);
				Reflect.setField( data, f, Reflect.field(dataToMerge, f) );
			}
		}
		save();
	}
}