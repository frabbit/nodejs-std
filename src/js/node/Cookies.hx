
package js.node;


import js.html.Node;
import js.Node.NodeHttpServerReq;
import js.Node.NodeHttpServerResp;


// see https://github.com/BungartBessler/cookies for documentation

typedef CookieGetOptions = {
	signed : Bool
}

typedef CookieSetOptions = {
	?signed : Bool, 
	?expires: Date, 
	?domain : String,
	?secure : Bool,
	?secureProxy : Bool,
	?httpOnly : Bool,
	?overwrite : Bool,
}

extern class Cookies {

	public function new (request:NodeHttpServerReq, response:NodeHttpServerResp, ?keygrip : Keygrip):Void;

	public function get (name:String, ?options:CookieGetOptions):Dynamic;

	public function set (name:String, value:Dynamic, ?options:CookieSetOptions):Cookies;

	static function __init__ ():Void untyped {
		Cookies = js.Node.require('cookies');
	}

	

}