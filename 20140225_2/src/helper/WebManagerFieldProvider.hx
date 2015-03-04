package helper;
import org.vic.web.IWebCommand2;
import org.vic.web.IWebCommand2.IFieldProvider;
import org.vic.web.WebManager;

/**
 * ...
 * @author han
 */
class WebManagerFieldProvider implements IFieldProvider
{
	public function new() {
		
	}
	public function set(key:String, value:Dynamic):IFieldProvider {
		WebManager.inst.setData(key, value);
		return this;
	}
	public function get(key:String):Dynamic {
		return WebManager.inst.getData(key);
	}
}