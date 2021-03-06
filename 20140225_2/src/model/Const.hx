package model;
import control.SimpleController;
import de.polygonal.Printf;
import flash.Lib;
import org.vic.web.IWebView;
import view.DefaultPage;
import view.MoviePage;
import view.tech.DefaultTechPage;
import view.tech.TechAssist;
import view.tech.TechBlink;
import view.tech.TechCamera;
import view.tech.TechConnect;
import view.tech.TechDolby;
import view.tech.TechDouble;
import view.tech.TechPhoto;
import view.tech.TechTheme;
import view.tech.TechUltra;

/**
 * ...
 * @author han
 */
class Const
{
	public static var LOCAL_ETMAPI = false;
	
	#if debug
	public static var OPEN_ALL_TECH_PAGE = true;
	#else
	public static var OPEN_ALL_TECH_PAGE = true;
	#end
	
	public static var PEOPLE_PLAY_WAIT_DURATION_SECONDS = 25;	// seconds
	
	public static function getLogInfoWithPage(page:IWebView): { type:String, page:String } { 
		return if ( Std.is( page, TechDouble ) ) {
			{ type:"WEB", page:"01" };
		} else if ( Std.is( page, TechUltra ) ) {
			{ type:"WEB", page:"02" };
		} else if ( Std.is( page, TechDolby ) ) {
			{ type:"WEB", page:"03" };
		} else if ( Std.is( page, TechCamera ) ) {
			{ type:"WEB", page:"04" };
		} else if ( Std.is( page, TechAssist ) ) {
			{ type:"WEB", page:"06" };
		} else if ( Std.is( page, TechPhoto ) ) {
			{ type:"WEB", page:"08" };
		} else if ( Std.is( page, TechConnect ) ) {
			{ type:"WEB", page:"09" };
		} else if ( Std.is( page, TechTheme ) ) {
			{ type:"WEB", page:"05" };
		} else if ( Std.is( page, TechBlink ) ) {
			{ type:"WEB", page:"07" };
		} else if ( Std.is( page, MoviePage ) ) {
			{ type:"VIDEO", page:"99" };
		} else {
			{ type:"UNKNOWN", page:"UNKNOWN" };
		}
	}
	
	public static function getShareInfoWithPage(page:IWebView): { name:String, link:String, picture:String, caption:String, description:String} {
		var configRoot = cast( page, DefaultPage ).getWebManager().getData('config');
		var name = 
			if ( Std.is( page, TechDouble ) ) {
				"TechDouble";
			} else if ( Std.is( page, TechUltra ) ) {
				"TechUltra";
			} else if ( Std.is( page, TechDolby ) ) {
				"TechDolby";
			} else if ( Std.is( page, TechCamera ) ) {
				"TechCamera";
			} else if ( Std.is( page, TechAssist ) ) {
				"TechAssist";
			} else if ( Std.is( page, TechPhoto ) ) {
				"TechPhoto";
			} else if ( Std.is( page, TechConnect ) ) {
				"TechConnect";
			} else if ( Std.is( page, TechTheme ) ) {
				"TechTheme";
			} else if ( Std.is( page, TechBlink ) ) {
				"TechBlink";
			} else if ( Std.is( page, MoviePage ) ) {
				"MoviePage";
			} else {
				null;
			}
			
		if ( name == null ) {
			SimpleController.onError('getShareInfoWithPage: ${name}');
			return {
				name: "name",
				link: "",
				picture: "",
				caption: "caption",
				description: "description"
			}
		}
		var config = Reflect.field( configRoot.share, name );
		
		if ( name == 'MoviePage' ) {
			var moviePage = cast( page, MoviePage);
			var id = moviePage.getCurrentLoadedYoutubeId();
			return { 
				name: config.name, 
				link: Printf.format( config.link, [id] ), 
				picture:config.picture, 
				caption:config.caption, 
				description:config.description }
		} else {
			return { 
				name: config.name, 
				link: config.link, 
				picture:config.picture, 
				caption:config.caption, 
				description:config.description }
		}

		/* // 改成讀取config.json
		if ( Std.is( page, TechDouble ) ) {
			return { 
				name:"", 
				link:"http://rsclient.etmgup.com/htc_hima/#TechDouble", 
				picture:"http://rsclient.etmgup.com/htc_hima/images/share/01.jpg", 
				caption:"HTC One M9 登峰造極 萬中選一 全球首發，即日起在全台HTC專賣店盛大開賣！", 
				description:"HTC One M9擁有精湛雙色調金屬工藝的經典設計，馬上來體驗並分享產品特點就有機會抽大獎喔！"}
		}
		
		if ( Std.is( page, TechUltra ) ) {
			return { 
				name:"", 
				link:"http://rsclient.etmgup.com/htc_hima/#TechUltra", 
				picture:"http://rsclient.etmgup.com/htc_hima/images/share/02.jpg", 
				caption:"HTC One M9 登峰造極 萬中選一 全球首發，即日起在全台HTC專賣店盛大開賣！", 
				description:"HTC One M9擁有HTC UltraPixel™前置相機的低光源下完美自拍功能，馬上來體驗並分享產品特點就有機會抽大獎喔！"}
		}
		
		if ( Std.is( page, TechDolby ) ) {
			return { 
				name:"", 
				link:"http://rsclient.etmgup.com/htc_hima/#TechDolby", 
				picture:"http://rsclient.etmgup.com/htc_hima/images/share/03.jpg", 
				caption:"HTC One M9 登峰造極 萬中選一 全球首發，即日起在全台HTC專賣店盛大開賣！", 
				description:"HTC One M9擁有支援Dolby Audio™的HTC BoomSound™頂級音響，馬上來體驗並分享產品特點就有機會抽大獎喔！"}
		}
		
		if ( Std.is( page, TechCamera ) ) {
			return { 
				name:"", 
				link:"http://rsclient.etmgup.com/htc_hima/#TechCamera", 
				picture:"http://rsclient.etmgup.com/htc_hima/images/share/04.jpg", 
				caption:"HTC One M9 登峰造極 萬中選一 全球首發，即日起在全台HTC專賣店盛大開賣！", 
				description:"HTC One M9擁有2000萬畫素的絕佳主鏡頭，馬上來體驗並分享產品特點就有機會抽大獎喔！"}
		}
		
		if ( Std.is( page, MoviePage ) ) {
			var moviePage = cast( page, MoviePage);
			var id = moviePage.getCurrentLoadedYoutubeId();
			return { 
				name:"", 
				link:"http://rsclient.etmgup.com/htc_hima/#MoviePage/id="+id, 
				picture:"http://rsclient.etmgup.com/htc_hima/images/share/video_share.jpg", 
				caption:"HTC One M9 登峰造極 萬中選一 全球首發，即日起在全台HTC專賣店盛大開賣！", 
				description:"馬上來觀賞精彩影片並分享相關訊息就有機會抽大獎喔！"}
			
		}
		
		return {
			name: "name",
			link: "",
			picture: "",
			caption: "caption",
			description: "description"
		}
		
		*/
	}
}