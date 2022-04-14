package memberYJ.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;


public class MemberPointAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
    	  
		if( loginuser == null ) {
			// 로그인을 안하고 접근하려는 경우 로그인 페이지로 이동
			String message = "로그인을 해야 들어올 수 있습니다.";
			String loc = request.getContextPath()+"/login/login.an";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			
		 InterMemberDAO mdao = new MemberDAO();
		 
		 // 1. 페이징 처리를 위해 1페이지당 보여줄 장바구니에 들어간 제품의 갯수를 몇개로 할 것인가를 정한다.
		 //    한 페이지당 보여줄 주문의 갯수는 10개로 한다.
		 int sizePerPage = 10;
  	  
		 // 2.페이징 처리한 데이터 조회 결과물 가져오기
		 int totalPage = 0;
  	  
		 // 주문내역에 들어있는 제품의 총갯수 구하기
		 // 자신이 주문한 내역 조회 해오기
         String userid = loginuser.getUserid();

        // 주문내역 페이징 처리를 위해 자신이 주문한 갯수 알아오기
    	  int totalCountOrder = mdao.getTotalCountOrder(userid);
  	  
    	  totalPage = (int) Math.ceil( (double)totalCountOrder/sizePerPage );
    	//  System.out.println("~~~ 확인용 totalPage : " + totalPage);
  	  
  	   // 조회하고자 하는 페이지번호를 받아오기
        String str_currentShowPageNo = request.getParameter("currentShowPageNo"); 
                 
        int currentShowPageNo = 0;
                 
        try {
             if(str_currentShowPageNo == null) {
               currentShowPageNo = 1; 
             }
             else {
               currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
                
               if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
                  currentShowPageNo = 1;
               }
             }
        } catch (NumberFormatException e) {
                currentShowPageNo = 1;

        }
        // 주문내역 페이징 처리하여 조회 해오기
        List<Map<String,String>> orderList = mdao.getOrderList(userid, currentShowPageNo, sizePerPage);
        
        
        //  페이지바 만들기 
        String url = "memberPoint.an";
        int blockSize = 10;
        //  blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 갯수.
                 
        int loop = 1;
        // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(위의 설명상 지금은 10(==blockSize)까지만 증가하는 용도이다.
        
        int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1; 
       
        String pageBar = "";
        
        // *** [맨처음][이전] 만들기 *** // 
        if(pageNo != 1) {
           pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
           pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
        }
        
        while( !(loop > blockSize || pageNo > totalPage) ) {
           
           if(pageNo == currentShowPageNo) {
              pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";  
           }
           else {
              pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
           }
           
           loop++;
           pageNo++;
        }// end of while----------------------
        
        // *** [다음][마지막] 만들기 *** // 
        if( pageNo <= totalPage ) {
           pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>";
           pageBar += "<li class='page-item'><a class='page-link' href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
        }
        
        
        request.setAttribute("orderList", orderList);
        request.setAttribute("pageBar", pageBar);
      //super.setRedirect(false);
        super.setViewPage("/WEB-INF/view/member/memberPoint.jsp");
   
			
		}
		
	}
	
}
