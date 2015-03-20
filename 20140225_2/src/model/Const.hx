package model;
import org.vic.web.IWebView;
import view.tech.TechCamera;
import view.tech.TechDolby;
import view.tech.TechDouble;
import view.tech.TechUltra;

/**
 * ...
 * @author han
 */
class Const
{
	public static var PEOPLE_PLAY_WAIT_DURATION_SECONDS = 25;	// seconds
	
	
	public static function getShareInfoWithPage(page:IWebView): { name:String, link:String, picture:String, caption:String, description:String} {
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
				description:"HTC One M9擁有2000萬畫素的絕佳主鏡頭絕佳鏡頭，馬上來體驗並分享產品特點就有機會抽大獎喔！"}
		}
		
		return {
			name: "name",
			link: "",
			picture: "",
			caption: "caption",
			description: "description"
		}
	}
}