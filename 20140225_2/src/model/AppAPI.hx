package model;
import flash.display.Bitmap;
import flash.errors.Error;
import flash.events.IOErrorEvent;
import haxe.Json;
import helper.Tool;
import org.han.Async;
import org.vic.web.IWebView;
import org.vic.web.WebManager;
import view.fb.DetailFromPopup;
import view.fb.FBLoginPopup;
import flash.display.Loader;
import flash.errors.Error;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.LoaderContext;
/**
 * ...
 * @author han
 */
class AppAPI
{
	public static function getImageFromURL( args: { url:String } ) {
		return function( cb:Dynamic ) {
			var loader = new Loader();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function(e :Event) {
				cb( null, loader.content );
			});
			loader.contentLoaderInfo.addEventListener (IOErrorEvent.IO_ERROR, function(e :IOErrorEvent) {
				cb( new Error(e.toString()), null );
			});
			loader.load ( new URLRequest ( args.url ));
		}
	}
	
	public static function changePage( args: { mgr:WebManager, page:Class<IWebView>, params:Dynamic } ) {
		return function( cb:Dynamic ) {
			function closePage(page:Dynamic) {
				args.mgr.closePage(page);
				return true;
			}
			Lambda.foreach( Tool.allPage, closePage );
			Lambda.foreach( Tool.allFBPage, closePage );
			
			args.mgr.openPage(args.page, args.params, function() {
				if ( cb != null ) {
					cb( null, null );
				}
			});
		}
	}
	
	public static function openPage( args: { mgr:WebManager, page:Class<IWebView>, params:Dynamic } ) {
		return function( cb:Dynamic ) {
			args.mgr.openPage( args.page, args.params, function() {
				if ( cb != null ) {
					cb( null, null );
				}
			} );
		}
	}
	
	public static function closePage( args: { mgr:WebManager, page:Class<IWebView> } ) {
		return function( cb:Dynamic ) {
			args.mgr.closePage( args.page, function() {
				if ( cb != null ) {
					cb( null, null );
				}
			});
		}
	}
	
	public static function closeAllTechPage( args: { mgr:WebManager } ) {
		return function( cb:Dynamic ) {
			function closePage(page:Dynamic) {
				return function( cb:Dynamic ) {
					args.mgr.closePage(page);
					cb( null, null );
				}
			}			
			Async.map( Tool.allTechPage, closePage, cb);
		}
	}
	
	public static function changeTechPage( args: { mgr:WebManager, page:Class<IWebView>, params: Dynamic } ) {
		return function( cb:Dynamic ) {
			Async.parallel([
				AppAPI.closeAllTechPage( { mgr: args.mgr } ),
				AppAPI.openPage( { mgr:args.mgr, page: args.page, params:args.params } )
				],
				cb);
		}
	}
	
	public static function fetchPhoto( args:{ mobile:String } ) {
		return function( cb:Dynamic ) {
			
			function fetchPhoto( args: { data:Dynamic } ) {
				return function( cb:Dynamic ) {
					Async.map( 
						args.data, 
						function( obj: { photo:String } ) {
							return AppAPI.getImageFromURL( { url: obj.photo } );
						},
						cb 
					);
				}
			}
			
			Async.waterfall([
				ETMAPI.getPhotoList,
				fetchPhoto
			], cb, args );
			
		}
	}
	
	public static function flow1( params: { mgr:WebManager } ) {
		
		return function( cb:Dynamic ) {
			
			Async.waterfall([
				FBAPI.isFBLogin,
				
				function callFBShare( args: {isLogin:Bool, fbid: String, accessToken: String} ):Dynamic {
					return function( cb:Dynamic ) {
						if ( args.isLogin ) {
							params.mgr.setData('fbid', args.fbid);
							params.mgr.setData('accessToken', args.accessToken);
							FBAPI.callFBShare( {  } ) (cb);
						} else {
							cb( new Error("not login"), null );
						}
					}
				},
				
				FBAPI.callFBMe,
				
				function checkIsEnterInfo( args: { name: String, email: String, gender: String} ):Dynamic {
					return function( cb:Dynamic ) {
						params.mgr.setData('name', args.name);
						params.mgr.setData('email', args.email);
						params.mgr.setData('gender', args.gender);
						
						ETMAPI.isEnterInfo( { 
							fbid: params.mgr.getData('fbid'),
							email: params.mgr.getData('email')
						} ) (cb);
					}
				},
				
				
				function stopIfDidWritten( args: { isWritten: Bool, token: String } ) {
					return function( cb:Dynamic ) {
						if ( args.isWritten ) {
							cb( new Error('isWritten'), null );
						} else {
							params.mgr.setData('etmToken', args.token);
							cb( null, { } );
						}
					}
				}
			], cb, params );
		}
		
	}
	
	
	
	public static function flow2( params: { mgr:WebManager } ) {
		
		return function( cb:Dynamic ) {
			
			Async.waterfall([
				FBAPI.callFBLogin,
				
				function callFBShare( args: {accessToken: String, fbid: String} ):Dynamic {
					return function( cb:Dynamic ) {
						params.mgr.setData('fbid', args.fbid);
						params.mgr.setData('accessToken', args.accessToken);
						FBAPI.callFBShare( { } ) (cb);
					}
				},
				
				FBAPI.callFBMe,
				
				function checkIsEnterInfo( args: { name: String, email: String, gender: String} ):Dynamic {
					return function( cb:Dynamic ) {
						params.mgr.setData('name', args.name);
						params.mgr.setData('email', args.email);
						params.mgr.setData('gender', args.gender);
						
						ETMAPI.isEnterInfo( { 
							fbid: params.mgr.getData('fbid'),
							email: params.mgr.getData('email')
						} ) (cb);
					}
				},
				
				function stopIfDidWritten( args: { isWritten: Bool, token: String } ) {
					return function( cb:Dynamic ) {
						if ( args.isWritten ) {
							cb( new Error('isWritten'), null );
						} else {
							params.mgr.setData('etmToken', args.token);
							cb( null, { } );
						}
					}
				}
			], cb, params );
		}
		
	}
}