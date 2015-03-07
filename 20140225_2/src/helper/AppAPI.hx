package helper;
import flash.errors.Error;
import org.han.Async;
import org.vic.web.IWebView;
import org.vic.web.WebManager;

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
}