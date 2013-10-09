
package js.node;

import haxe.Constraints.Function;




/**
 Error -> Rows -> Fields -> Void
 */

typedef QueryError = Dynamic
typedef QueryRow = Dynamic
typedef QueryRows = Array<QueryRow>
typedef QueryFields = Dynamic

typedef MysqlErr = Dynamic;

typedef ConnectionError = Dynamic;

typedef QueryCallback = QueryError -> QueryRows -> QueryFields -> Void

abstract EscapedValue(Dynamic) {
	inline function new (d:Dynamic) this = d;

	@:to public inline function toString ():String return this;
}

extern class MysqlConnection 
{
	public function connect ():Void;
	@:overload(function (q:String, escaped:Array<Dynamic>, cb:QueryCallback):Void {})
	public function query (q:String, cb:QueryCallback):Void;

	public function end (cb:ConnectionError->Void):Void;
	public function destroy ():Void;

	public function release ():Void;

	public function pause ():Void;
	public function resume ():Void;
	
	public function format (sql:String, values:Dynamic):String;

	public function escape (v:Dynamic):EscapedValue;
	public function escapeId (v:Dynamic):EscapedValue;

	function on (event:String, cb:Function):MysqlConnection;

	public inline function onError(f:MysqlErr->Void):MysqlConnection {
		return on("error", f);
	}

	public inline function onFields(f:QueryFields->Void):MysqlConnection {
		return on("fields", f);
	}
	public inline function onResult(f:QueryRow->Void):MysqlConnection {
		return on("result", f);
	}	

}

typedef MysqlConnectionOptions = {
	host : String,
	user : String,
	password : String,
	?port : Int,
	?database : String,
	?multipleStatements: Bool
	// more options see https://github.com/frabbit/node-mysql/tree/kp
}

typedef PoolErr = Dynamic;

extern class MysqlPool {
	public function getConnection(f:PoolErr->MysqlConnection->Void):Void;

	public inline function onConnection(f:PoolErr->MysqlConnection->Void):Void {
		(this:Dynamic).on("connection", f);
	}
}

typedef MysqlPoolOptions = { > MysqlConnectionOptions,
	?createConnection : MysqlConnectionOptions -> MysqlConnection,
	?waitForConnections : Bool,
	?connectionLimit : Int,
	?queueLimit : Int
}

@:native("js_node_Mysql")
extern 
class Mysql {

	// TODO createPoolCluster
	public static function createConnection (options:MysqlConnectionOptions):MysqlConnection;
	public static function createPool(options:MysqlPoolOptions):MysqlPool;

	

	private static inline function __init__(): Void untyped {

		var js_node_Mysql = Node.require("mysql");
	}

}