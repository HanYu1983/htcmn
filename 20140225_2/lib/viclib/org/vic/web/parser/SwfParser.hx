package org.vic.web.parser;
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.text.TextField;
import org.vic.web.BasicButton;
import org.vic.web.BasicSlider;
import org.vic.web.WebView;

/**
 * ...
 * @author VicYu
 */
class SwfParser
{
	public static function movieClipParser( visitor:WebView, container:DisplayObjectContainer, buttons:Array<BasicButton>, sliders:Array<BasicSlider> ):Void {
		for( i in 0...container.numChildren )
		{
			var childDisObj:DisplayObject = container.getChildAt( i );
			if ( Std.is( childDisObj, IWebView ) ) {
				continue;
			}
			
			processContainer( visitor, childDisObj, buttons, sliders );
			
			if ( Std.is( childDisObj, DisplayObjectContainer ) )
			{
				var childDisObjCon:DisplayObjectContainer = cast( childDisObj, DisplayObjectContainer );
				movieClipParser( visitor, childDisObjCon, buttons, sliders );
			}
		}
	}
	
	private static function processContainer( visitor:WebView, container:DisplayObject, buttons:Array<BasicButton>, sliders:Array<BasicSlider> ):Void {
		var name:String = container.name;
		var ary_name:Array<String> = name.split( "_" );
		var type:String = ary_name[0];
		
		if( ary_name.length == 3 ){
			if ( Std.is( container, MovieClip ) ) {
				var commandName:String = ary_name[1];
				var symbol:String = ary_name[2];
				if ( commandName != null ) {
					cast( container, MovieClip ).commandName = commandName;
					cast( container, MovieClip ).symbol = symbol;
				}
			}
		}
		
		function createBtn():Void {
			var basicButton:BasicButton = new BasicButton( cast( container, MovieClip ) );
			visitor.addButton( basicButton );
		}
		
		function createSlider():Void {
			var basicSlider:BasicSlider = new BasicSlider( visitor, cast( container, MovieClip ) );
			visitor.addSlider( basicSlider );
		}
		
		function createTextField():Void {
			visitor.addTextField( cast( container, TextField ) );
		}
		
		switch( type ) {
			case 'btn':
				createBtn();
			case 'slider':
				createSlider();
			case 'txt':
				createTextField();
		}
		
		
		
	}
	
}