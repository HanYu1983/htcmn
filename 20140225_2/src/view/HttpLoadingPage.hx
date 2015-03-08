package view;

import flash.display.MovieClip;
import flash.display.Shape;
import org.vic.web.WebView;

/**
 * ...
 * @author han
 */
class HttpLoadingPage extends WebView
{
	

	public function new() 
	{
		super();
		layerName = 'loading';

		var shape = new MovieClip();
		shape.graphics.beginFill(0, .5 );
		shape.graphics.drawRect(0, 0, 1920, 1080 );
		shape.graphics.endFill();
		
		setRoot( shape );
	}
}