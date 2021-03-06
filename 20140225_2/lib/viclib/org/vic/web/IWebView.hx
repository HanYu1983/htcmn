package org.vic.web;
import flash.display.MovieClip;

/**
 * @author vic
 */

interface IWebView 
{
	var needLoading:Bool;
	var layerName:String;
	function open( param:Dynamic, cb:Void->Void ):Void;
	function close( cb:Void->Void ):Void;
	function focus():Void;
	function release():Void;
	function addButton( b:BasicButton ):Void;
	function addSlider( s:BasicSlider ):Void;
	function update():Void;
	function execute( n:String, ?org:Dynamic  ):Void;
	function getRoot():MovieClip;
}