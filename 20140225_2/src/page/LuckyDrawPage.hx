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
		layerName = 'popup';
		createDebugButton("btn_onLuckyDrawBtnClick_fb", 0, 0);
		createDebugButton("btn_onLuckyDrawBtnClick_data", 0, 20);
		createDebugButton("btn_onLuckyDrawBtnClick_cancel", 0, 40);
	}
	
}