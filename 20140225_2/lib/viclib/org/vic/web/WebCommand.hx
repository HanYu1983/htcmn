package org.vic.web ;
/**
 * ...
 * @author VicYu
 */
class WebCommand implements IWebCommand
{
	private var _name:String;
	
	public function new( name:String = null ) 
	{
		_name = name;
	}
	
	public function getName():String {
		return _name;
	}
	
	public function getWebManager():WebManager {
		return WebManager.inst;
	}
	
	public function execute( ?args:Dynamic ):Void {
		getWebManager().log( 'execute command: ' + getName() );
	}
}