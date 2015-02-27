package helper;
import flash.display.DisplayObject;

/**
 * ...
 * @author han
 */
class Tool
{
	public static function center(obj:DisplayObject, sx:Int, sy:Int, sw: Int, sh: Int) {
		centerX(obj, sx, sw);
		centerY(obj, sy, sh);
	}
	public static function centerX(obj:DisplayObject, sx:Int, sw: Int) {
		obj.x = sx+ (sw - obj.width) / 2;
	}
	public static function centerY(obj:DisplayObject, sx:Int, sw: Int) {
		obj.y = sx+ (sw - obj.width) / 2;
	}
}