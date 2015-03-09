package org.vic.web;
import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.FrameLabel;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.errors.Error;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import org.vic.flash.display.FakeMovieClip;
import org.vic.flash.loader.FakeLoaderTask;
import org.vic.flash.loader.LoaderManager;
import org.vic.flash.loader.LoaderTask;
import org.vic.web.parser.SwfParser;

/**
 * ...
 * @author vic
 */
class WebView extends Sprite implements IWebView
{
	public var needLoading:Bool = false;
	public var useFakeLoading:Bool = false;
	public var layerName:String = 'default';
	
	var _root:MovieClip;
	
	private var _ary_buttons:Array<BasicButton>;
	private var _ary_sliders:Array<BasicSlider>;
	private var _ary_textField:Array<TextField>;

	public function new() 
	{
		super();
	}
	
	public function open(param:Dynamic, cb:Void->Void):Void 
	{
		function _complete( lt:LoaderTask ):Void {
			generateRoot();
			parserRoot();
			onOpenEvent( param, cb );
			addChild( _root );
			focus();
		}
		
		var swfinfo:Dynamic = getSwfInfo();
		if ( swfinfo != null ) {
			var sn:String = swfinfo.name;
			var sp:String = swfinfo.path;
			var config:Dynamic = getWebManager().getData( 'config' );
			var version = function() {
				if ( config == null )	return '';
				if ( config.version == null )	return '';
				return config.version;
			}();
			sp += '?v=';
			sp += version;
			if ( !LoaderManager.inst.hasTask( sn )) {
				LoaderManager.inst.addTask( sn, new LoaderTask( sp, _complete, needLoading ));
			}else {
				if ( useFakeLoading ) {
					var fake = new FakeLoaderTask( 'fake', _complete, needLoading );
					fake.mediator = LoaderManager.inst;
					fake.load();
					
				} else {
					_complete( null );
					
				}
			}
		}else {
			_complete( null );
		}
	}
	
	public function close(cb:Void->Void):Void 
	{
		release();
		onCloseEvent();
		
		function _close():Void {
			while ( numChildren > 0 ) {
				removeChild( getChildAt( 0 ));
			}
			_ary_buttons = null;
			_ary_sliders = null;
			_ary_textField = null;
			if ( cb != null ) {
				cb();
			}
		}
		
		if ( getRoot() == null )	return; 
		
		var closeAni:Bool = false;
		var lary:Array<FrameLabel> = getRoot().currentLabels;
		var max:Int = lary.length;
		for ( i in 0...max ) {
			if ( lary[i].name == 'pageClose' ) {
				closeAni = true;
			}
		}
		
		if( closeAni ){
			getRoot().gotoAndPlay( 'pageClose' );
			getRoot().addFrameScript( getRoot().totalFrames - 1, _close );
		}else {
			Tweener.addTween( this, { alpha:0, time:.5, onComplete:_close } );
		}
	}
	
	public function focus():Void 
	{
		var max:Int;
		if ( getButtons() != null ) {
			max = getButtons().length;
			var btn:BasicButton;
			for ( i in 0...max ){
				btn = getButtons()[i];
				wakeUpButton( btn, false );
			}
		}
		
		if ( getSliders() != null ) {
			max = getSliders().length;
			var sl:BasicSlider;
			for ( i in 0...max ){
				sl = getSliders()[i];
				sl.startFeature();
			}
		}
		
		if ( getTextField() != null ) {
			max = getTextField().length;
			var t:TextField;
			for ( i in 0...max ){
				t = getTextField()[i];
				t.addEventListener(FocusEvent.FOCUS_IN, onTxtFocusIn );
				t.addEventListener(FocusEvent.FOCUS_OUT, onTxtFocusOut );
				t.addEventListener(Event.CHANGE, onTxtChange );
			}
		}
		
		onFocusEvent();
	}
	
	public function execute(n:String, ?org:Array<Dynamic>):Void 
	{
		WebManager.inst.execute( n, org );
	}
	
	public function addButton( b:BasicButton ):Void {
		if ( _ary_buttons == null ) {
			_ary_buttons = new Array<BasicButton>();
		}
		_ary_buttons.push( b );
	}
	
	public function addSlider( s:BasicSlider ):Void {
		if ( _ary_sliders == null ) {
			_ary_sliders = new Array<BasicSlider>();
		}
		_ary_sliders.push( s );
	}
	
	public function addTextField( t:TextField ):Void {
		if ( _ary_textField == null ) {
			_ary_textField = new Array<TextField>();
		}
		_ary_textField.push( t );
	}
	
	function getButtonNameByEvent( e:MouseEvent ):String {
		var mc:MovieClip = cast( e.currentTarget, MovieClip );
		return mc.name;
	}
	
	function createDebugButton( name:String, posx:Float = 0, posy:Float = 0 ):Void {
		var mc:MovieClip = new FakeMovieClip( name, 100, 30 );
		mc.name = name;
		mc.x = posx;
		mc.y = posy;
		getRoot().addChild( mc );
	}
	
	function createDebugRoot( name:String = '', width:Float = 500, height:Float = 500 ):Void {
		_root = new FakeMovieClip( name, width, height );
	}
	
	public function update():Void {
		
	}
	
	function onCloseEvent( cb:Void->Void = null ):Void {
			
	}
	
	function onFocusEvent():Void {
		
	}
	
	function onReleaseEvent():Void {
		
	}
	
	function onOpenEvent( param:Dynamic, cb:Void -> Void ):Void {
		if ( cb != null )	cb();
	}
	
	function getSwfInfo():Dynamic {
		return null;
	}
	
	function getButtons():Array<BasicButton> {
		return _ary_buttons;
	}

	function getSliders():Array<BasicSlider> {
		return _ary_sliders;
	}

	function getTextField():Array<TextField> {
		return _ary_textField;
	}
	
	function getButtonsByName( name:String ):BasicButton {
		for ( b in _ary_buttons ) {
			if ( b.getShape().name == name )	return b;
		}
		return null;
	}
	
	function getSliderByName( name:String ):BasicSlider {
		for ( s in _ary_sliders ) {
			if ( s.getRoot().name == name )	return s;
		}
		return null;
	}
	
	private function generateRoot( name:String = null, linkage:String = null ):Void {
		if ( getRootInfo() != null ) {
			_root = cast( LoaderManager.inst.getTask( getRootInfo().name ).getObject( getRootInfo().path, [] ), MovieClip );
		}
		addChild( getRoot());
	}
	
	function wakeUpButton( btn:BasicButton, playOut:Bool = false ):Void {
		var mc:MovieClip;
		mc = btn.getShape();
		wakeUpButtonByMc( mc, playOut );
	}
	
	function sleepButton( btn:BasicButton ):Void {
		var mc:MovieClip;
		mc = btn.getShape();
		mc.buttonMode = false;
		mc.removeEventListener(MouseEvent.CLICK, onClick );
		mc.removeEventListener(MouseEvent.MOUSE_OVER, onOver );
		mc.removeEventListener(MouseEvent.MOUSE_OUT, onOut );
	}
	
	function wakeUpButtonByMc( mc:MovieClip, playOut:Bool = false ):Void {
		mc.buttonMode = true;
		if( playOut ){
			if ( mc.currentFrame != 1 && mc.currentFrame != mc.totalFrames ) {
				mc.gotoAndPlay('out' );
			}
		}
		if ( !mc.hasEventListener(MouseEvent.CLICK )) {
			mc.addEventListener(MouseEvent.CLICK, onClick );
			mc.addEventListener(MouseEvent.MOUSE_OVER, onOver );
			mc.addEventListener(MouseEvent.MOUSE_OUT, onOut );
		}
	}
	
	function onOver( e:MouseEvent ):Void {
		var mc:MovieClip = cast( e.currentTarget, MovieClip );
		try{
			mc.gotoAndPlay( 'over' );
		}catch ( e:Error ) { }
	}
	
	function onOut( e:MouseEvent ):Void {
		var mc:MovieClip = cast( e.currentTarget, MovieClip );
		try{
			mc.gotoAndPlay( 'out' );
		}catch ( e:Error ) { }
	}
	
	function onClick( e:MouseEvent ):Void {
		var mc:MovieClip = cast( e.currentTarget, MovieClip );
		var commandName:String = mc.commandName;
		WebManager.inst.execute( commandName, [ this, mc ] );
	}
	
	function onTxtFocusIn( e:FocusEvent ):Void {
		//var t:TextField = cast( e.currentTarget, TextField );
		//t.text = '';
	}
	
	function onTxtFocusOut( e:FocusEvent ):Void {
		
	}
	
	function onTxtChange( e:Event ):Void {
		
	}
	
	public function getWebManager():WebManager {
		return WebManager.inst;
	}
	
	function getLoaderManager():LoaderManager {
		return LoaderManager.inst;
	}
	
	public function release():Void {
		var max:Int;
		if ( getButtons() != null ) {
			max = getButtons().length;
			var btn:BasicButton;
			
			for ( i in 0...max ) {
				btn = getButtons()[i];
				sleepButton( btn );
			}
		}
		
		if ( getSliders() != null ) {
			max = getSliders().length;
			var sl:BasicSlider;
			for ( i in 0...max ) {
				sl = getSliders()[i];
				sl.closeFeatrue();
			}
		}
		
		if ( getTextField() != null ) {
			max = getTextField().length;
			var t:TextField;
			for ( i in 0...max ) {
				t = getTextField()[i];
				t.removeEventListener(FocusEvent.FOCUS_IN, onTxtFocusIn );
				t.removeEventListener(FocusEvent.FOCUS_OUT, onTxtFocusOut );
				t.removeEventListener(Event.CHANGE, onTxtChange );
			}
		}
		
		onReleaseEvent();
	}
	
	private function parserRoot():Void {
		if ( _root != null ) {
			SwfParser.movieClipParser( this, _root, getButtons(), getSliders() );
		}
	}
	
	private function getRootInfo():Dynamic {
		return null;
	}
	
	private function getRoot():MovieClip {
		if ( _root == null )	createDebugRoot();
		return _root;
	}
	
	private function setRoot( shape: MovieClip ):Void {
		_root = shape;
	}
}