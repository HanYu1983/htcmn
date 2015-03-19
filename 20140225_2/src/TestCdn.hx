package ;
import flash.display.Loader;
import flash.errors.Error;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.Lib;
import flash.net.URLRequest;
import flash.system.LoaderContext;
import flash.system.Security;
import flash.system.SecurityDomain;
import flash.text.TextField;
import flash.ui.Keyboard;
import org.vic.web.WebManager;
import view.IntroPage;

/**
 * ...
 * @author vic
 */
class TestCdn
{

	public function new() 
	{
		Security.allowDomain("*");
		Security.allowInsecureDomain("*");
		var loader = new Loader();
		var context:LoaderContext = new LoaderContext(true);
		//context.checkPolicyFile = true;
		
		//loader.load( new URLRequest( 'http://eda9962ce4da9c47c32c-6a163228e67308da9664e4f095f00920.r12.cf6.rackcdn.com/src/TechDouble.swf' ));
		loader.load( new URLRequest( 'http://eda9962ce4da9c47c32c-6a163228e67308da9664e4f095f00920.r12.cf6.rackcdn.com/src/TechDolby.swf' ), context);
		//loader.load( new URLRequest( 'src/TechDolby.swf' ));
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function( e ) {
			//trace( e );
			//txt_per.text = e;
		});
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function( e ) {
			trace("DDFFBB");
			try{
			trace( "content", loader.contentLoaderInfo.content );
			Lib.current.stage.addChild( loader.contentLoaderInfo.content );
			}catch ( e:Error ) {
				trace( e.getStackTrace() );
				trace( "content", loader.contentLoaderInfo );
			}
		});
		
		
		loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function( e ) {
			trace( e );
		});
	}
	
	static function main() {
		new TestCdn();
	}
}