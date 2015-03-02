package helper;
import haxe.Http;

/**
 * ...
 * @author han
 */
class ETMAPI
{
	public static function isEnterInfo( fbid:String, fbemail:String, cb: Dynamic ) {
		var http = new Http("http://rsclient.etmgup.com/htc_hima/isEnterInfo.php");
		http.setParameter("fb_id", fbid);
		http.setParameter("fb_email", fbemail);
		http.onData = function(data:String) {
			cb( null, data );
		}
		http.onError = function( err:String ) {
			cb( err, null );
		}
		http.request();
	}
}