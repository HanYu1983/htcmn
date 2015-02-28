package page;

/**
 * ...
 * @author han
 */
class LuckyDrawPage extends DefaultPage
{

	public function new() 
	{
		super();
		layerName = 'page';
		createDebugButton("btn_onLuckyDrawBtnClick_fb", 0, 0);
		createDebugButton("btn_onDataBtnClick_fb", 0, 20);
		createDebugButton("btn_onDataBtnClick_cancel", 0, 40);
	}
	
}