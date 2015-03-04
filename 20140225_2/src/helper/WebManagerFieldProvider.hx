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
	public function set(key:String, value:Dynamic):IWebCommand2 {
		WebManager.inst.setData(key, value);
		return this;
	}
	public function get(key:String):Dynamic {
		WebManager.inst.getData(key);
	}
}