package externs;

import js.html.Blob;
import js.lib.Promise;

class Fetch {
	public static function fetch<T:{}>(url:String, ?options:FetchOptions):Promise<PromiseResponse<T>> {
		return untyped __js__('fetch')(url, options);
	}
}

extern class PromiseResponse<Data:{}> {
	public var ok:Bool;
	public var url:String;
	public var size:Float;
	public var timeout:Float;
	
	public var status:Int;
	public var statusText:String;
	public var headers:Map<String, Dynamic>;
	public function blob():Promise<Blob>;
	public function text():Promise<String>;
	public function json():Promise<Data>;
}

typedef FetchOptions = {
	@:optional var body:Dynamic;
	@:optional var method:HttpMethod;
	@:optional var headers:{};
	@:optional var compress:Bool;
}

enum abstract HttpMethod(String) from String to String {
	var Request = 'REQUEST';
	var Post = 'POST';
	var Get = 'GET';
	var Head = 'HEAD';
	var Put = 'PUT';
	var Delete = 'DELETE';
	var Trace = 'TRACE';
	var Options = 'OPTIONS';
	var Connect = 'CONNECT';
	var Patch = 'PATCH';
}
