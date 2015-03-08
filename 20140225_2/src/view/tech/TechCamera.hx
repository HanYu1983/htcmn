package view.tech;
import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.geom.Point;
import org.vic.utils.BasicUtils;

/**
 * ...
 * @author han
 */
class TechCamera extends DefaultTechPage
{
	//var _mc_controller:MovieClip;
	var _mc_circleButton:MovieClip;
	var _mc_dot:DisplayObject;
	var _mc_bar:DisplayObject;
	var _mc_htcPhoto:DisplayObject;
	var _mc_ohterPhoto:DisplayObject;
	var _mc_htc:DisplayObject;
	var _mc_other:DisplayObject;	
	var _mc_photo:DisplayObjectContainer;

	public function new() 
	{
		super();
	}
	
	override function onOpenEvent(param:Dynamic, cb:Void->Void):Void 
	{
		super.onOpenEvent(param, cb);
		
		BasicUtils.revealObj( getRoot(), function( obj:DisplayObject ) {
			switch( obj.name ) {
				case 'mc_controller':
					_mc_controller = cast( obj, MovieClip );
				case 'mc_circleButton':
					_mc_circleButton = cast( obj, MovieClip );
				case 'mc_htc':
					_mc_htc = obj;
				case 'mc_dot':
					_mc_dot = obj;
				case 'mc_bar':
					_mc_bar = obj;
				case 'mc_htcPhoto':
					_mc_htcPhoto = obj;
				case 'mc_otherPhoto':
					_mc_ohterPhoto = obj;
				case 'mc_other':
					_mc_other = obj;
				case 'mc_photo':
					_mc_photo = cast( obj, DisplayObjectContainer );
					
			}
		});
		
		_originDotX = _mc_dot.x;
		animateForSmartPhone(taggleCircleButton());
		scalePhoto( 0 );
	}
	
	var _originDotX:Float;
	
	public function setDotPosition( v:Float ) {
		var tx = (v-1) * _mc_bar.width +_originDotX;
		Tweener.addTween( _mc_dot, { x: tx, time:.3 } );
	}
	
	
	var _scale = 1.0;
	
	public function scalePhoto( v: Float ) {
		_scale += v;
		_scale = Math.min( _scale, 2 );
		_scale = Math.max( 1, _scale );
		var news = ( _scale - 1 ) * ( 1 - .5 ) + .5;
		Tweener.addTween( _mc_photo, { scaleX: news, scaleY: news, time:.3 } );
		
		setDotPosition( _scale );
	}
	
	function setHTCPhoneVisible( v:Bool ) {
		Tweener.addTween( _mc_htc, { alpha:v ? 1: 0, time:.3 } );
		Tweener.addTween( _mc_htcPhoto, { alpha: v? 1 : 0, time:.3 } );
	}
	
	function setOtherPhoneVisible( v:Bool ) {
		Tweener.addTween( _mc_other, { alpha:v ? 1: 0, time:.3 } );
		Tweener.addTween( _mc_ohterPhoto, { alpha: v? 1 : 0, time:.3 } );
	}
	
	public function animateForSmartPhone( phone:String ) {
		switch( phone ) {
			case 'htc':
				setHTCPhoneVisible( true );
				setOtherPhoneVisible( false );
			case 'other':
				setHTCPhoneVisible( false );
				setOtherPhoneVisible( true );
		}
	}
	
	public function taggleCircleButton(): String {
		var curr = _mc_circleButton.currentLabel;
		getWebManager().log(curr);
		var target = switch( curr ) {
			case 'htc': 'other';
			case 'other': 'htc';
			case _ : 'htc';
		}
		_mc_circleButton.gotoAndPlay( target );
		return target;
	}
	
	override function getSwfInfo():Dynamic 
	{
		return {name:'TechCamera', path:'src/TechCamera.swf' };
	}
	
	override function getRootInfo():Dynamic 
	{
		return {name:'TechCamera', path:'TechCamera' };
	}
}