package org.vic.flash.display;

import flash.display.MovieClip;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

/**
 * ...
 * @author VicYu
 */
class FakeMovieClip extends MovieClip
{
	private var _name:TextField;

	public function new( name, width:Float = 100, height:Float = 100 ) 
	{
		super();
		
		var rc:Int =  Std.int( Math.random() * 0xffffff );
		graphics.beginFill( rc );
		graphics.drawRect( 0, 0, width, height );
		graphics.endFill();
		
		_name = new TextField();
		_name.text = name;
		_name.autoSize = TextFieldAutoSize.LEFT;
		_name.selectable = false;
		_name.mouseEnabled = false;
		addChild( _name );
	}
}