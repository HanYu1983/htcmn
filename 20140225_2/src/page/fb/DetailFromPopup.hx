package page.fb;

/**
 * ...
 * @author han
 */
class DetailFromPopup extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = "popup";
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'Detail', path:'src/Detail.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'Detail', path:'Detail' };
	}
}