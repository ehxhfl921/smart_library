package net.koreate.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import net.koreate.board.service.CommentService;
import net.koreate.board.service.SuggestionService;
import net.koreate.board.vo.BoardVO;
import net.koreate.room.service.RoomService;
import net.koreate.user.vo.UserVO;

public class CheckAdminOrAuthorInterceptor implements HandlerInterceptor {

	@Autowired
	private RoomService rs;
	
	@Autowired
	private SuggestionService ss;
	
	@Autowired
	private CommentService cs;
	
	@Override
	public boolean preHandle(
			HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		
		HttpSession session = request.getSession(false);
		UserVO user = (UserVO)session.getAttribute("userInfo");
		
		// 현재 로그인 사용자 아이디
		String loginId = user.getId();

		String uri = request.getRequestURI();
		String context = request.getContextPath();
		
		if(loginId.equals("admin")) {
			// 로그인 사용자가 관리자인 경우 true
			return true;
		}
		
		// 스터디룸 예약 취소 (사용자 본인 확인) ajax
		if(uri.startsWith(context + "/studyroom/cancel/")) {
			// 스터디룸 예약 번호
			int rno = Integer.parseInt(uri.substring((context + "/studyroom/cancel/").length()));
			// 전달 받은 예약 번호로 예약자 아이디 조회
			String userId = rs.getUserIdByRno(rno);
			
			if(loginId.equals(userId)) {
				// 로그인 아이디와 예약자 아이디가 같은 경우 true
				return true;
			} // end loginId eq userId
		
			return deny(request, response, "예약 취소 권한이 없습니다.", HttpServletResponse.SC_FORBIDDEN);
		} // end check studyroom cancel
		
		
		// 건의 사항 상세 페이지/ 건의 사항 삭제 요청
		if(uri.startsWith(context + "/suggest/detail") || uri.startsWith(context + "/suggest/delete")) {

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
			return deny(request, response, "게시글 작성자와 관리자만 이용 가능한 서비스입니다.", HttpServletResponse.SC_FORBIDDEN);

		} // end check suggestion detail&delete
		
		
		// 댓글 작성 요청 ajax
		if (uri.matches(context + "/comment/\\d+/addComment")) {
		    String base = context + "/comment/";
		    int start = base.length();
		    int end = uri.indexOf("/addComment");
		    int sugNo = Integer.parseInt(uri.substring(start, end));
		    
		    BoardVO suggestion = ss.getDetail(sugNo);
		    String userId = suggestion.getS_userid();
		    
		    if(loginId.equals(userId)) {
		    	// 로그인 아이디와 건의 사항 작성자 아이디가 같은 경우 true
		    	return true;
		    }
		    
		    return deny(request, response, "게시글 작성자와 관리자만 이용 가능한 서비스입니다.", HttpServletResponse.SC_FORBIDDEN);
		} // end check addComment
		
		// 댓글 삭제 요청 ajax
		if (uri.startsWith(context + "/comment/removeComment/")){
			
			int rpl_no = Integer.parseInt(uri.substring((context + "/comment/removeComment/").length()));
			String userId = cs.getUserIdByRplNo(rpl_no);
			
			if(loginId.equals(userId)) {
				// 로그인 아이디와 댓글 작성자 아이디가 같은 경우 true
				return true;
			}
		    
		    return deny(request, response, "댓글 작성자와 관리자만 삭제가 가능합니다.", HttpServletResponse.SC_FORBIDDEN);
		} // end check removeComment
		
		return false;
		
	} // end preHandle

	
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
