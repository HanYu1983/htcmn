package view ;

import helper.IPopup;
import helper.Tool;
import org.vic.web.WebView;

/**
 * ...
 * @author vic
 */
class ActivityPopup extends DefaultPage implements IPopup
{

	public function new() 
	{
		super();
		
		layerName = 'popup';
	}
	
	override public function onResize(x:Int, y:Int, w:Int, h:Int) 
	{
		if( _mc_popup != null ){
			Tool.centerForce( _mc_popup, _mc_popup.width, 560, x, y, w, h );
		}
		
		if ( _mc_back != null ) {
			_mc_back.width = w;
			_mc_back.height = h;
		}
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'ActivePage', path:'src/ActivePage.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'ActivePage', path:'ActivePage' };
	}
}