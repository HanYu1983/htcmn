package org.vic.web;

/**
 * @author vic
 */

interface IWebCommand 
{
	function getName():String;
	function getWebManager():WebManager;
	function execute( ?org:Dynamic ):Void;
}