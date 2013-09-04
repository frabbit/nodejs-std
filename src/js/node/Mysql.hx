
package js.node;




/**
 Error -> Rows -> Fields -> Void
 */

typedef QueryError = Dynamic
typedef QueryRows = Array<Dynamic>
typedef QueryFields = Dynamic

typedef QueryCallback = QueryError -> QueryRows -> ?QueryFields -> Void

typedef MysqlConnection = {
	public function connect ():Void;
	public function query (q:String, cb:QueryCallback):Void;
	public function end ():Void;
}

typedef MysqlOptions = {
	host : String,
	user : String,
	password : String,
	?port : Int,
	?database : String
	// more options see https://github.com/frabbit/node-mysql/tree/kp
}

@:native("js_node_Mysql")
extern 
class Mysql {

	public static function createConnection (options:MysqlOptions):MysqlConnection;

	private static inline function __init__(): Void untyped {

		var js_node_Mysql = Node.require("mysql");
	}

}