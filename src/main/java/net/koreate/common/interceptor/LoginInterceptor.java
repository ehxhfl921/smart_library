package net.koreate.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(
			HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		
		String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String method = request.getMethod();

        // 스터디룸 예약하기 페이지로 이동(GET 방식 /studyroom),
        // 날짜별 스터디룸 예약 가능 여부 조회(GET /studyroom/{날짜}) 는 로그인 체크 제외
        if ("GET".equals(method)) {
        	
            if (uri.equals(contextPath + "/studyroom")) {
                return true;
            }
            
            if (uri.startsWith(contextPath + "/studyroom/") && uri.length() 
            		== (contextPath + "/studyroom/").length() + 10) {
                return true;
            }
        } // 스터디룸 로그인 체크 제외 if

        
        
        // 로그인 체크
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userInfo") == null) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("<script>alert('로그인이 필요한 서비스입니다.'); location.href='"
                    + contextPath + "/user/login';</script>");
            response.getWriter().flush();
            return false;
        }

        return true;
		
	} // end preHandle

	
}
