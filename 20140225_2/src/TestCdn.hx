package ;
import flash.Lib;
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
		WebManager.inst.init( Lib.current.stage );
		WebManager.inst.addLayer( 'page' );
		
		WebManager.inst.openPage( IntroPage, null );
	}
	
	static function main() {
		new TestCdn();
	}
}