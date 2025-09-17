package net.koreate.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import net.koreate.board.service.CommentService;
import net.koreate.board.service.SuggestionService;
import net.koreate.board.vo.BoardVO;
import net.koreate.user.vo.UserVO;

public class AuthorCheckInterceptor implements HandlerInterceptor {

	@Autowired
	private CommentService cs;
	
	@Autowired
	private SuggestionService ss;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		
		HttpSession session = request.getSession(false);
		UserVO user = (UserVO)session.getAttribute("userInfo");
		
		// 현재 로그인 사용자 아이디
		String loginId = user.getId();

		String uri = request.getRequestURI();
		String context = request.getContextPath();
		
		// 건의 사항 수정 / 수정 페이지 요청
		if(uri.startsWith(context + "/suggest/modify")) {

			String strSugNo = request.getParameter("sug_no");
			if(strSugNo == null) {
				// 파라미터로 건의 사항 번호가 넘어오지 않으면 false
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				return false;
			}
			
			int sugNo = Integer.parseInt(strSugNo);
			
			BoardVO suggest = ss.getDetail(sugNo);
			String userId = suggest.getS_userid();
			
			if(loginId.equals(userId)) {
				// 로그인 아이디와 건의사항 작성자 아이디가 같은 경우 true
				return true;
			}
			
			// 로그인 사용자가 건의사항 작성자가 아닌 경우
			return deny(request, response, "게시글 작성자만 이용 가능한 서비스입니다.", HttpServletResponse.SC_FORBIDDEN);

		} // end check suggestion detail&delete
		
		
		// 댓글 수정 요청 ajax
		if (uri.startsWith(context + "/comment/modifyComment/")){
			
			int rpl_no = Integer.parseInt(uri.substring((context + "/comment/modifyComment/").length()));
			String userId = cs.getUserIdByRplNo(rpl_no);
			
			if(loginId.equals(userId)) {
				// 로그인 아이디와 댓글 작성자 아이디가 같은 경우 true
				return true;
			}
		    
		    return deny(request, response, "댓글 작성자만 이용 가능한 서비스입니다.", HttpServletResponse.SC_FORBIDDEN);
		} // end check removeComment
		
		return false;
	} //end preHandle
	
	
	private boolean deny(
			HttpServletRequest req, HttpServletResponse res, 
			String msg, int status) throws Exception{
		
		boolean isAjax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));
		
		if(isAjax) {
			res.setStatus(status);
			res.setContentType("application/json; charset=UTF-8");
			res.getWriter().write("{\"msg\":\""+ msg +"\"}");
			res.getWriter().flush();
		}else {
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().write("<script>alert('" + msg +"'); history.back();</script>");
			res.getWriter().flush();
		}
		
		return false;
	} // end deny

	
}
