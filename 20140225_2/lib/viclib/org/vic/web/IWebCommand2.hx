package org.vic.web;
import flash.errors.Error;
import flash.utils.SetIntervalTimer;
/**
 * @author han
 */
interface IFieldProvider {
	function set(key:String, value:Dynamic):IFieldProvider;
	function get(key:String):Dynamic;
}

interface IWebCommand2
{	
	function field():IFieldProvider;
	function set(key:String, value:Dynamic):IWebCommand2;
	function get(key:String):Dynamic;
	function getOr(key:String, obj: Dynamic):Dynamic;
	function invoke( cb: Dynamic ):Void;
}