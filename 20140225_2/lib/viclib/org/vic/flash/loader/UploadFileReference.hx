package org.vic.flash.loader;
import flash.display.Bitmap;	
import flash.display.BitmapData;	
import flash.display.Loader;	
import flash.display.Sprite;	
import flash.display.StageAlign;	
import flash.display.StageScaleMode;	
import flash.events.Event;	
import flash.events.MouseEvent;	
import flash.net.FileFilter;
import flash.net.FileReference;	
import flash.text.TextField;	
import flash.text.TextFieldAutoSize;	
import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author fff
	 */
class UploadFileReference 
{
	private var file:FileReference;
	private var loader:Loader;
	
	public var onCompleteHandler:BitmapData -> Void;
	
	public function new() {
		file = new FileReference();
		loader = new Loader();
	}
	
	public function onClick()	
	{	
		var f:FileFilter=new FileFilter("Images", "*.jpg;*.gif;*.png");	
		file.browse([f]);		
		file.addEventListener(Event.SELECT,onSelect);	
	}	
	private function onSelect(event:Event)	
	{	
		file.load();	
		file.addEventListener(Event.COMPLETE,onComplete);	
		file.removeEventListener(Event.SELECT,onSelect);	
	}	
	private function onComplete(event:Event)	
	{	
		file.removeEventListener(Event.COMPLETE,onComplete);	
		loader.loadBytes(file.data);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadComplete);	
	}	
	private function onLoadComplete(event:Event)	
	{	
		var tempData:BitmapData=new BitmapData(Std.int( loader.width ), Std.int( loader.height ),false);	
		tempData.draw(loader);	
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);	
		
		if ( onCompleteHandler != null )
			onCompleteHandler( tempData );
	}	
}
