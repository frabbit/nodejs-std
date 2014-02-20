
package js.node;


// see https://github.com/andris9/Nodemailer

#if true
@:enum 
#end
abstract TransportType(String) {
	var SMTP = "SMTP";
	var SES = "SES";
	var Sendmail = "Sendmail";
	var Pickup = "Pickup";
	var Direct = "Direct";
}

typedef Auth = Dynamic;

typedef CreateTransportOptions = {
	
	?host : String,
	?port : Int,
	?secureConnection : Bool,
	?name : String,
	?auth : Auth,
	?ignoreTLS:Bool,
	?debug:Bool,
	?maxConnections:Int,
	?maxMessages:Int,
	?service : String,
	?directory : String // only when Direct Transport Type
	
}

typedef Attachment = {
	fileName:String,
	cid:String,
	contents:String,
	filePath:String,
	streamSource:Dynamic,
	contentType:String,
	contentDisposition:String,
}

typedef Headers = Dynamic<Dynamic>;

typedef MailOptions = {
	?from : String,
	?to:String,
	?cc : String,
	?bcc:String,
	?replyTo : String,
	?inReplyTo : String,
	?subject : String,
	?text : String,
	?html : String,
	?references : Array<String>,
	?debug : Bool,
	?charset : String,
	?generateTextFromHTML:Bool,
	?headers:Dynamic<String>,
	?attachments : Array<Attachment>,

}


private typedef Err = Dynamic;
private typedef Response = {
	message:String,
	messageId:String
};



class Transports {
	public inline function sendMail(t:Transport, mail:MailOptions, ?callback:Null<Err>->Response->Void):Void {
		(t:Dynamic).sendMail(mail, callback == null ? function (_,_) {} : callback);
	}
}

typedef Transport = {
	public function sendMail (mail:MailOptions, callback:Null<Err>->Response->Void):Void;
	public function close():Void;
}

extern class NodeMailer {

	// TODO createPoolCluster
	public static function createTransport (protocol:TransportType, opt:CreateTransportOptions):Transport;
	
	public static var mail(default, null):MailOptions->?(Null<Err>->Response->Void)->Void;

	private static inline function __init__(): Void untyped {

		NodeMailer = Node.require("nodemailer");
	}


}