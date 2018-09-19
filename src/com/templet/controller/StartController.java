package com.templet.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.templet.service.DrawService;
import com.templet.util.MyUtil;
import com.templet.vo.BliudVo;
import com.templet.vo.CctvVo;
import com.templet.vo.DrawBoardVo;
import com.templet.vo.EmbVo;
import com.templet.vo.JibunVo;
import com.templet.vo.LayerVo;
import com.templet.vo.UserVo;

import net.nice19.smboard.board.model.BoardModel;
import net.sf.json.JSONArray;

import org.apache.commons.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.DiskFileUpload;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StartController {
	private ApplicationContext appContext = new ClassPathXmlApplicationContext("/config/applicationContext.xml");
	private DrawService drawService = (DrawService) appContext.getBean("drawService");
	private int currentPage = 1;
	//private int showArticleLimit = 10; // change value if want to show more articles by one page
	private int showPageLimit = 1000; // change value if want to show more page links
	private int startArticleNum = 0;
	private int endArticleNum = 0;
	//private int totalNum = 0;	
	
	//private MyUtil myUtil;
	//private String pageNum;
	


	private String uploadPath = "C:\\";
	

	@RequestMapping("/main.do")
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		String name = "";
		String id = request.getParameter("userId");
		if(request.getParameter("userName") == null && request.getParameter("userName") == null){
			name = "작성자";
			id="";
		}else{
			name = URLDecoder.decode(request.getParameter("userName"), "UTF-8");
		}
		
		List<LayerVo> list_layer = drawService.getLayerList();
		model.addAttribute("list_layer", JSONArray.fromObject(list_layer));
		
		List<LayerVo> second_level = drawService.listClsInfo();
		model.addAttribute("second_level", JSONArray.fromObject(second_level));
		
		UserVo uservo = new UserVo();
		uservo.setId(id);
		uservo.setName(name);
		HttpSession session = request.getSession(true);
		session.setAttribute("USERID", id);
		session.setAttribute("USERNAME", name);
				
		ModelAndView mav = new ModelAndView();
		//mav.addObject("list_layer", list_layer);
		mav.setViewName("/main/main");
		
		return mav;
	}
	
	@RequestMapping("/base.do")
	public String base() {
		return "/content/base";
	}

	
	@RequestMapping("/tool.do")
	public String tool() {
		return "/content/tool";
	}

	@RequestMapping("/searchJibun.do")
	public String searchJibun() {
		return "/content/Search/search01";
	}
	@RequestMapping("/searchbuild.do")
	public String searchbuild() {
		return "/content/Search/search02";
	}
	@RequestMapping("/searchCctv.do")
	public String searchCctv() {
		return "/content/Search/search03";
	}	

	@RequestMapping("/situationUp.do")
	public String situationUp() {
		return "/content/situation/situation01";
	}	
	@RequestMapping("/situationDown.do")
	public String situationDown() {
		return "/content/situation/situation02";
	}		

	@RequestMapping("/blinkList.do")
	public String blink() {
		return "/content/Search/blinkList";
	}	
	
	@RequestMapping("/blinksituation.do")
	public String blinkObject() {
		return "/content/situation/blinksituation";
	}
	@RequestMapping("/progress.do")
	public String progress() {
		return "/content/situation/progress";
	}	

	@RequestMapping("/layer.do")
	public ModelAndView layer() {
		List<LayerVo> boardList;
		boardList = drawService.getLayerList();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("boardList", boardList);
		mav.setViewName("/content/layer/layer");
		return mav;

	}	
	
	@RequestMapping(value="/writeObject.do", method=RequestMethod.POST)
	public String objectWrite(@ModelAttribute("DrawBoardVo") DrawBoardVo drawBoardVo, MultipartHttpServletRequest request){	
		drawService.writeObejct(drawBoardVo);		
		return "redirect:situationUp.do";
	}
	
	@RequestMapping("/jibunSearch")
	@ResponseBody
	public JSONArray nSearch(@ModelAttribute EmbVo vo) throws Exception {
		//List a = drawService.listEmb(vo.getEname());
		JSONArray jsonarr = JSONArray.fromObject(drawService.listEmb(vo.getEname()));
		return jsonarr;
	}

	@RequestMapping("/classSearch")
	@ResponseBody
	public JSONArray classSearch(@ModelAttribute BliudVo vo) throws Exception {
		//List a = drawService.listClass(vo.getEname());
		JSONArray jsonarr = JSONArray.fromObject(drawService.listClass(vo.getEname()));
		return jsonarr;
	}	
	
	@RequestMapping("/jibunList.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response){
		String cp = request.getContextPath();
		int numPerPage   = 10;
		String type = null;
		String keyword = null;	
		
		String pnuCode  = request.getParameter("pnuCode");
		String pageNum  = request.getParameter("pageNum");
		System.out.println("pageNum" + pageNum);
	    if(pageNum != null && !(pageNum.equals(""))){
	    	currentPage = Integer.parseInt(pageNum);
	    }else{
	    	currentPage = 1;
	    }
		// expression article variables value
	    int showArticleLimit = 7;
		startArticleNum = (currentPage - 1) * showArticleLimit + 1;
		endArticleNum = startArticleNum + showArticleLimit -1;
		//
		
		// get boardList and get page html code
		List<JibunVo> boardList;
		boardList = drawService.getJibunList(startArticleNum, endArticleNum, pnuCode);
		int totalNum = drawService.getJinbunTotalNum(pnuCode);
		
		
		int total_page = 0;
		MyUtil myUtil = new MyUtil();
		
		if(totalNum != 0)
		   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
		
		System.out.println("total_page : "+total_page);
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        String urlView = cp+"/jibunList.do?pnuCode=" + pnuCode;

		//StringBuffer pageHtml = getPageHtml(currentPage, totalNum, showArticleLimit, showPageLimit, type, keyword, "jibunList.do");

		ModelAndView mav = new ModelAndView();
		mav.addObject("boardList", boardList);
		mav.addObject("total_page", Integer.toString(total_page));
		mav.addObject("total_dataCount", totalNum);
		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView));
		mav.setViewName("/content/Search/list");
		
		return mav;
	}	
	
	private StringBuffer getPageHtml(int currentPage, int totalNum, int showArticleLimit, int showPageLimit, String type, String keyword, String url) {
		StringBuffer pageHtml = new StringBuffer();
		int startPage = 0;
		int lastPage = 0;
		
		// expression page variables
		startPage = ((currentPage-1) / showPageLimit) * showPageLimit + 1;
		lastPage = startPage + showPageLimit - 1;
		
		if(lastPage > totalNum / showArticleLimit) {
			lastPage = (totalNum / showArticleLimit) + 1;
		}
		    
			if(currentPage == 10){
				pageHtml.append("");
			} else {
				pageHtml.append("<li><a href=\""+url+"?page=" + (currentPage-10) + "\"><img src='./images/bbs/page_prev.gif' alt='10페이지 앞으로' class='vmiddle mar_l5' /></a></li>");
				//pageHtml.append("<span><a href=\""+url+"?page=" + (currentPage-10) + "\"><이전></a>&nbsp;&nbsp;");
			}
			
			for(int i = currentPage ; i <= currentPage+9 ; i++) {
					if(i == currentPage){
						pageHtml.append("<strong>");
						pageHtml.append("<font style=font-size:8pt><a href=\""+url+"?page=" +i + "\" class=\"page\">" + i + "</a></font>");
						pageHtml.append("</strong>");
					} else {
						pageHtml.append("&nbsp;<font style=font-size:7pt><a href=\""+url+"?page=" +i + "\" class=\"page\">" + i + "</a></font>&nbsp;");
					}
								
			}

			if(currentPage == lastPage){
				pageHtml.append("");
			} else {
				pageHtml.append("<li><a href=\""+url+"?page=" + (currentPage+10) + "\"><img src='./images/bbs/page_prev.gif' alt='10페이지 앞으로' class='vmiddle mar_l5' /></a></li>");
				//pageHtml.append(".&nbsp;&nbsp;<a href=\""+url+"?page=" + (currentPage+10) + "\"><다음></a></span>");
			}
		//		
		return pageHtml;
	}	
	
	@RequestMapping("/objectList.do")
	public ModelAndView objectList(HttpServletRequest request, HttpServletResponse response){
		String cp = request.getContextPath();
		int numPerPage   = 10;
		//System.out.println("pnuCode" + pnuCode);
		int startDate = Integer.parseInt(request.getParameter("datepicker")); 
		int endDate = Integer.parseInt(request.getParameter("datepicker2")); 
		System.out.println("startDate :" + startDate);
		System.out.println("endDate :" + endDate);
		String pageNum  = request.getParameter("pageNum");
	    if(pageNum != null && !(pageNum.equals(""))){
	    	currentPage = Integer.parseInt(pageNum);
	    }else{
	    	currentPage = 1;
	    }
	    int showArticleLimit = 10;
		// expression article variables value
		startArticleNum = (currentPage - 1) * showArticleLimit + 1;
		endArticleNum = startArticleNum + showArticleLimit -1;
		//
		
		// get boardList and get page html code
		List<DrawBoardVo> boardList;
		boardList = drawService.getObjectList(startArticleNum, endArticleNum, startDate, endDate);
		for(int i=0 ; i < boardList.size(); i++){
			System.out.println(boardList.get(i).getObjectFileName());
		}
		int totalNum = drawService.getObjectTotalNum(startDate, endDate);

		
		
		int total_page = 0;
		MyUtil myUtil = new MyUtil();
		
		if(totalNum != 0)
		   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        String urlView = cp+"/objectList.do?datepicker=" + startDate+"&datepicker2="+endDate;

		//StringBuffer pageHtml = getPageHtml(currentPage, totalNum, showArticleLimit, showPageLimit, type, keyword, "jibunList.do");

        
		ModelAndView mav = new ModelAndView();
		mav.addObject("boardList", boardList);
		mav.addObject("total_page", Integer.toString(total_page));
		mav.addObject("total_dataCount", totalNum);
		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView));
		mav.setViewName("/content/situation/situationList");
		
		return mav;
	}	
	
	@RequestMapping("/buildList.do")
	public ModelAndView buildList(HttpServletRequest request, HttpServletResponse response){
		String cp = request.getContextPath();
	
		int numPerPage   = 5;
		String classnew  = request.getParameter("classnew");
		String classnow  = request.getParameter("classnow");
		String embNm  = request.getParameter("embNm");
		String buildSearch  = request.getParameter("buildSearch");
		String pageNum  = request.getParameter("pageNum");
		System.out.println(classnew+","+classnow+","+embNm+","+buildSearch);
		System.out.println("pageNum" + pageNum);
	    if(pageNum != null && !(pageNum.equals(""))){
	    	currentPage = Integer.parseInt(pageNum);
	    }else{
	    	currentPage = 1;
	    }
	    int showArticleLimit = 5;
	    //showArticleLimit = 5;
		// expression article variables value
		startArticleNum = (currentPage - 1) * showArticleLimit + 1;
		endArticleNum = startArticleNum + showArticleLimit -1;
		//
		
		// get boardList and get page html code
		System.out.println("startArticleNum : "+startArticleNum);
		System.out.println("endArticleNum : "+endArticleNum);
		List<BliudVo> boardList;
		boardList = drawService.getbuildList(startArticleNum, endArticleNum, classnew, classnow, embNm, buildSearch);
		int totalNum = drawService.getbuildTotalNum(classnew, classnow, embNm, buildSearch);
		
		
		int total_page = 0;
		MyUtil myUtil = new MyUtil();
		
		if(totalNum != 0)
		   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        String urlView = cp+"/buildList.do?classnew="+classnew+"&classnow="+classnow+"&embNm="+embNm+"&buildSearch="+buildSearch;

		//StringBuffer pageHtml = getPageHtml(currentPage, totalNum, showArticleLimit, showPageLimit, type, keyword, "jibunList.do");

		ModelAndView mav = new ModelAndView();
		mav.addObject("boardList", boardList);
		mav.addObject("total_page", Integer.toString(total_page));
		mav.addObject("total_dataCount", totalNum);
		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView));
		mav.setViewName("/content/Search/bullist");

		return mav;
	}
	
	@RequestMapping("/cctvList.do")
	public ModelAndView cctvList(HttpServletRequest request, HttpServletResponse response){
		String cp = request.getContextPath();
		int numPerPage   = 5;
		String type = null;
		String keyword = null;	
		String embNm  = request.getParameter("embNm");
		String addrName  = request.getParameter("addrName");
		String pageNum  = request.getParameter("pageNum");
		System.out.println("pageNum" + pageNum);
	    if(pageNum != null && !(pageNum.equals(""))){
	    	currentPage = Integer.parseInt(pageNum);
	    }else{
	    	currentPage = 1;
	    }
	    int showArticleLimit = 5;
		// expression article variables value
		startArticleNum = (currentPage - 1) * showArticleLimit + 1;
		endArticleNum = startArticleNum + showArticleLimit -1;
		//
		
		// get boardList and get page html code
		List<CctvVo> boardList;
		boardList = drawService.getCctvList(startArticleNum, endArticleNum, addrName, embNm);
		int totalNum = drawService.getCctvTotalNum(addrName, embNm);
		
		
		int total_page = 0;
		MyUtil myUtil = new MyUtil();
		
		if(totalNum != 0)
		   total_page = myUtil.getPageCount(numPerPage,  totalNum) ;
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        String urlView = cp+"/cctvList.do?addrName=" + addrName+"&embNm="+embNm;

		//StringBuffer pageHtml = getPageHtml(currentPage, totalNum, showArticleLimit, showPageLimit, type, keyword, "jibunList.do");

		ModelAndView mav = new ModelAndView();
		mav.addObject("boardList", boardList);
		mav.addObject("total_page", Integer.toString(total_page));
		mav.addObject("total_dataCount", totalNum);
		mav.addObject("pageIndexList", myUtil.pageIndexList(currentPage, total_page, urlView));
		mav.setViewName("/content/Search/cctvlist");
		
		return mav;
	}


}


