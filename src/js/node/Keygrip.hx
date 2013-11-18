
package js.node;

extern class Keygrip {

	public function new (?keyList:Array<String>, ?hmacAlgorithm:String, ?encoding:String):Void;

	public function sign (data:Dynamic):String;

	public function index (data:Dynamic, digest:String):Int;

	public function verify (data:Dynamic, digest:String):Bool;

	static inline function __init__ ():Void untyped {
		Keygrip = js.Node.require('keygrip');
	}

}