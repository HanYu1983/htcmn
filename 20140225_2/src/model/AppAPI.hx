package model;
import flash.errors.Error;
import helper.Tool;
import org.han.Async;
import org.vic.web.IWebView;
import org.vic.web.WebManager;
import view.fb.DetailFromPopup;
import view.fb.FBLoginPopup;

/**
 * ...
 * @author han
 */
class AppAPI
{
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
	
	public static function flow1( params: { mgr:WebManager } ) {
		
		return function( cb:Dynamic ) {
			
			function done( err:Error, result:Dynamic ) {
				if ( err != null ) {
					if ( err.message == 'not login' ) {
						AppAPI.openPage({ 
							mgr: params.mgr, 
							page: FBLoginPopup, 
							params: null }
							
							) (cb);
						
					} else {
						cb( err, null );
						
					}
				} else {
					AppAPI.openPage({ 
							mgr: params.mgr, 
							page: DetailFromPopup, 
							params: null }
							
							) (cb);
					
					
				}
			}
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
				
				function callFBMe( args: {} ):Dynamic {
					return function( cb:Dynamic ) {
						FBAPI.callFBMe( { } ) (cb);
					}
				},
				
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
			], done, params );
		}
		
	}
	
	
	
	public static function flow2( params: { mgr:WebManager } ) {
		
		return function( cb:Dynamic ) {
			
			function done( err:Error, result:Dynamic ) {
				if ( err != null ) {
					if ( err.message == 'not login' ) {
						AppAPI.openPage({ 
							mgr: params.mgr, 
							page: FBLoginPopup, 
							params: null }
							
							) (cb);
							
					} else {
						cb( err, null );
					}
				} else {
					AppAPI.openPage({ 
							mgr: params.mgr, 
							page: DetailFromPopup, 
							params: null }
							
							) (cb);
				}
			}
			
			Async.waterfall([
				FBAPI.callFBLogin,
				
				function callFBShare( args: {accessToken: String, fbid: String} ):Dynamic {
					return function( cb:Dynamic ) {
						params.mgr.setData('fbid', args.fbid);
						params.mgr.setData('accessToken', args.accessToken);
						FBAPI.callFBShare( { } ) (cb);
					}
				},
				
				function callFBMe( args: {} ):Dynamic {
					return function( cb:Dynamic ) {
						FBAPI.callFBMe( {} ) (cb);
					}
				},
				
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
			], done, params );
		}
		
	}
}