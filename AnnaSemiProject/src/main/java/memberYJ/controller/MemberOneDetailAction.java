package memberYJ.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			// 관리자(admin)로 로그인 했을 경우 
			String userid = request.getParameter("userid");
			
			InterMemberDAO mdao = new MemberDAO();
			MemberVO mvo = mdao.memberOneDetail(userid);
			
			request.setAttribute("mvo", mvo);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/view/member/memberOneDetail.jsp");
		}
	}

}
