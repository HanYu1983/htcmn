package cmd;
import helper.JSInterfaceHelper;
import org.vic.web.WebCommand;

/**
 * ...
 * @author han
 */
class CallFBMe extends WebCommand
{
	override public function execute(?args:Dynamic):Void 
	{
		var cb: Dynamic = args;
		JSInterfaceHelper.callJs( getWebManager(), 'getMe', [], function(info:Dynamic) {
			trace(info);
			/*
email: "finalfantasy388@yahoo.com.tw"
first_name: "Vic"
gender: "male"
id: "978883735469878"
last_name: "Yu"
link: "https://www.facebook.com/app_scoped_user_id/978883735469878/"
locale: "zh_TW"
name: "Vic Yu"
timezone: 8
updated_time: "2014-03-22T17:02:59+0000"
verified: true
			*/
			var err = Reflect.field(info, "0");
			var res = Reflect.field(info, "1");
			
			if ( err != null ) {
				cb( err, false );
			}else {
				var email = Reflect.field( res, "email" );
				getWebManager().setData('fbemail', email);
				cb(err, true);
			}
		});
	}
}