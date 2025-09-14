package net.koreate.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import net.koreate.user.vo.UserVO;

public class CheckAdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(
			HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		
        String contextPath = request.getContextPath();
        
		HttpSession session = request.getSession(false);
		UserVO userInfo = new UserVO();
		
		if(session != null) {
			userInfo = (UserVO) session.getAttribute("userInfo");
		}
		
		if (session != null && userInfo != null && !userInfo.getId().equals("admin")) {
			
            response.setContentType("text/html; charset=UTF-8");
            
            response.getWriter().write("<script>alert('관리자만 접근 가능한 서비스입니다.'); location.href='"
                    + contextPath + "/user/login';</script>");
            
            response.getWriter().flush();
            
            return false;
        }
		
		return true;
	}

	
}
