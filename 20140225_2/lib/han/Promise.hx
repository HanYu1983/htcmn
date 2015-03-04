package han;

/**
 * ...
 * @author han
 */
interface IPromise {
	function success(fn: Dynamic->Void):Void;
	function fail(fn: Error->Void):Void;
	function resolve(data:Dynamic):Void;
	function reject(err:Error):Void;
	function pipe(fn: Dynamic->IPromise ):IPromise;
	function then(fn: Dynamic->Void):Void;
}

class DefaultPromise implements IPromise {
	var _sf:Dynamic->Void;
	var _ff:Error->Void;
	public function new() {
		
	}
	public function success(fn: Dynamic->Void):Void {
		_sf = fn;
	}
	public function fail(fn: Error->Void):Void {
		_ff = fn;
	}
	public function resolve(data:Dynamic):Void {
		_sf(data);
	}
	public function reject(err:Error):Void {
		_ff(err);
	}
	public function pipe(fn: Dynamic->IPromise ):IPromise {
		var promise = new DefaultPromise();
		success( function(data:Dynamic) {
			var next = fn(data);
			next.success( function(data:Dynamic) {
				promise.resolve(data);
			});
			next.fail( function(err:Error) {
				promise.reject(err);
			});
		} );
		fail( function(err:Error) {
			promise.reject(err);
		} );
		return promise;
	}
	public function then(fn: Dynamic->Void):Void {
		success( function(data:Dynamic) {
			fn(data);
		} );
		fail( function(err:Error) {
			fn(err);
		} );
	}
}