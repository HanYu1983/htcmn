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
import view.tech.DefaultTechPage;
/**
 * ...
 * @author han
 */
class AppAPI
{
	
	public static function whichTechPageIsOpen( mgr:WebManager ):Null<IWebView> {
		var tech = Lambda.filter( mgr.getPages(), function( page ) {
			return Std.is( page, DefaultTechPage );
		} );
		if ( tech.length > 0 ) {
			return tech.first();
		} else {
			return null;
		}
	}

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
						function( obj: Dynamic ) {
							return function( cb:Dynamic ) {
								if ( Reflect.field( obj, "thumb" ) != null ) {
									AppAPI.getImageFromURL( { url: Reflect.field( obj, "thumb" ) } )( function( err:Error, bitmap:Bitmap ) {
										cb( err, { thumb: bitmap, photo: Reflect.field( obj, "photo" ) } ); 
									});	
								} else {
									AppAPI.getImageFromURL( { url: Reflect.field( obj, "photo" ) } )( function( err:Error, bitmap:Bitmap ) {
										cb( err, { thumb: bitmap, photo: null } ); 
									});	
								}
								
							}
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
							FBAPI.callFBShare( { name:"sadfas", link:"ddd", picture:"", caption:"dd", description:"ddd" } ) (cb);
						} else {
							cb( new Error("not login"), null );
						}
					}
				},		FBAPI.callFBMe,
				
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
				
				
				function sendShareAndStopIfDidWritten( args: { isWritten: Bool, token: String } ) {
					return function( cb:Dynamic ) {
						ETMAPI.shareLog( { token: args.token, type: null, page: null } ) (function(err, ret){});

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
	
	
	
	public static function flow2( params: { 
		mgr:WebManager,
		shareInfo: { name:String, link:String, picture:String, caption:String, description:String },
		logInfo: { type: String, page: String }
		} ) {
		
		return function( cb:Dynamic ) {
			
			Async.waterfall([
				FBAPI.callFBLogin,
				
				function callFBShare( args: {accessToken: String, fbid: String} ):Dynamic {
					return function( cb:Dynamic ) {
						params.mgr.setData('fbid', args.fbid);
						params.mgr.setData('accessToken', args.accessToken);
						FBAPI.callFBShare( params.shareInfo ) (cb);
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
				
				function shareLogAndStopIfDidWritten( args: { isWritten: Bool, token: String } ) {
					return function( cb:Dynamic ) {
						ETMAPI.shareLog( { token: args.token, type: params.logInfo.type, page: params.logInfo.page } ) (cb);
						if ( args.isWritten ) {
							cb( new Error('isWritten'), null );
						} else {
							params.mgr.setData('etmToken', args.token);
						}
					}
				}
			], cb, params );
		}
		
	}
}