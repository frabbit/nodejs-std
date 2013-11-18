
package js.node;

import js.Node;


private typedef Error = Dynamic;
private typedef Reply = Dynamic;

private typedef RedisCallback = Error->Reply->Void;

extern class RedisClient {
	public function set(key:String, val:String, cb:RedisCallback):Void;
	public function get(key:String, cb:RedisCallback):Void;
	public function hset(hashName:String, field:String, val:Dynamic, cb:RedisCallback):Void;
	public function sadd(setName:String, val:Dynamic, cb:RedisCallback):Void;

	public function hkeys(hashName:String, cb:Error->Array<Reply>->Void):Void;

	public inline function sendCommand (command:String, args:Array<Dynamic>, callback:RedisCallback):Void {
		(this:Dynamic).send_command(command, args, callback);
	}

}

extern class Redis {

	public static function createClient():RedisClient;

	private static inline function __init__(): Void untyped {

		Redis = Node.require("redis");
	}

}