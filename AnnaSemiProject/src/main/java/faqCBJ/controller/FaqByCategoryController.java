package faqCBJ.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import faqCBJ.model.*;

public class FaqByCategoryController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.getFaqCategoryList(request);
		
		String cnum = request.getParameter("cnum");
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");

		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}

		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}

		InterFaqDAO fdao = new FaqDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("cnum", cnum);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<Object> faqList = fdao.selectFaqByCategory(paraMap);
		request.setAttribute("faqList", faqList);
		
		int totalPage = fdao.getTotalPage(cnum);
		
		String pageBar = "";
		
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		
		if( pageNo != 1 ) {
			pageBar += "<li class='page-item'><a class='page-link' href='faq.an?currentShowPageNo=1&cnum="+cnum+"'>[맨처음]</a></li>"; 
			pageBar += "<li class='page-item'><a class='page-link' href='faq.an?currentShowPageNo="+(pageNo-1)+"&cnum="+cnum+"'>[이전]</a></li>";  
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='faq.an?currentShowPageNo="+pageNo+"&cnum="+cnum+"'>"+pageNo+"</a></li>";   
			}
			
			loop++;
			pageNo++;
		}// end of while---------------------------------
		
		// **** [다음][마지막] 만들기 **** //
		// pageNo ==> 11
		if( pageNo <= totalPage ) {
			pageBar += "<li class='page-item'><a class='page-link' href='faq.an?currentShowPageNo="+pageNo+"&cnum="+cnum+"'>[다음]</a></li>";  
			pageBar += "<li class='page-item'><a class='page-link' href='faq.an?currentShowPageNo="+totalPage+"&cnum="+cnum+"'>[마지막]</a></li>"; 
		}
		
		request.setAttribute("pageBar", pageBar); 
								
		super.setViewPage("/WEB-INF/view/faqCBJ/faqByCategory.jsp");
		
		
	}

}
