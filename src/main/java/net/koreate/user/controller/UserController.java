package net.koreate.user.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import net.koreate.common.utils.Criteria;
import net.koreate.user.service.UserService;
import net.koreate.user.vo.UserVO;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
	
	private final JavaMailSender mailSender;
	private final UserService userService;
	
	/**
	 * 회원 가입 페이지로 이동 요청 처리
	 */
	@GetMapping("/join")
	public String goToJoinForm() throws Exception{
		return "user/join";
	}
	
	/**
	 * 회원 가입 요청 처리 : 회원 테이블에 전달 받은 정보 입력
	 * 회원 가입 완료 후 메인 페이지로 이동
	 * 
	 * @param vo	가입할 회원 정보
	 */
	@PostMapping("/join")
	public String join(UserVO vo, RedirectAttributes rttr) throws Exception {
	    try {
	        userService.join(vo);
	        
	        rttr.addFlashAttribute("msg", "회원 가입이 완료되었습니다.");
	       
	        return "redirect:/user/goToLogin";
	    } catch (Exception e) {
	    	
	        e.printStackTrace();
	        rttr.addFlashAttribute("msg", "회원 가입 실패하였습니다.");
	        
	        return "redirect:/user/join";
	    }
	}
	
	/**
	 * 로그인 페이지로 이동 요청 처리
	 */
	@GetMapping("/goToLogin")
	public String loginPage() throws Exception{
		return "user/login";
	}
	
	/**
	 * 로그인 요청 처리 - 세션에 로그인 사용자 정보 저장 (자동 로그인 체크 시 쿠키에 저장)
	 * 로그인 후 메인 페이지로 이동
	 * 
	 * @param id	로그인할 아이디
	 * @param pw	로그인할 비밀번호
	 */
	@PostMapping("/login")
	public String login(
	        String id,
	        String pw,
	        String autoLogin,   
	        HttpSession session,
	        HttpServletResponse response
	) throws Exception {

	    UserVO user = userService.login(id, pw);

	    if (user != null) {

	        session.setAttribute("userInfo", user);

	        if ("Y".equals(autoLogin)) {
	        	Cookie cookie = new Cookie("userInfo", user.getId());
	            cookie.setPath("/");
	            cookie.setMaxAge(60 * 60 * 3);
	            response.addCookie(cookie);
	        }
	        return "redirect:/";
	    }

	    return "user/login";
	}
	/**
	 * 로그아웃 요청 처리 - 세션에 로그인 사용자 정보 삭제 (쿠키에 자동 로그인 정보 있으면 쿠키도 삭제)
	 * 로그아웃 후 메인 페이지로 이동
	 */
	@GetMapping("/logout")
	public String logout(HttpSession session, HttpServletResponse response ) throws Exception{
		session.invalidate();
		
		 Cookie cookie = new Cookie("userInfo", null); 
		    cookie.setMaxAge(0); 
		    cookie.setPath("/"); 
		    response.addCookie(cookie);
		    
		return "redirect:/";
	}
	
	/**
	 * 로그인 사용자 - 마이 페이지로 이동 요청 처리
	 */
	@GetMapping("/myPage")
	public String goToMyPage(HttpSession session) throws Exception{
		
		return "user/myPage";
	}
	
	/**
	 * 로그인 사용자 - 마이 페이지에서 회원 정보 수정 폼 페이지로 이동 요청 처리
	 */
	@GetMapping("/myPage/modifyInfo")
	public String goToUpdateMyInfo() throws Exception{
		
		return "user/updateInfo";
	}
	
	/**
	 * 회원 정보 수정 요청 처리
	 * 
	 * 관리자 	 - 수정 처리 후 해당 회원 정보 상세 페이지로 이동
	 * 로그인 사용자 - 수정 처리 후 마이페이지(내 회원 정보 페이지)로 이동
	 * 
	 * @param vo	수정할 정보가 담긴 UserVO 타입 객체
	 */
	@PostMapping("/admin/modifyInfo")
	public String updateInfo(UserVO vo, HttpSession session) throws Exception {
	  
	    userService.modifyInfo(vo);

	    return "redirect:/admin/memberDetail?mno=" + vo.getMno();
	}
	
	@PostMapping("/modifyInfo")
	public String updateMyInfo(UserVO vo, HttpSession session) throws Exception {
		
		UserVO userInfo = (UserVO) session.getAttribute("userInfo");
		
		
		if (vo.getPw() == null || vo.getPw().isEmpty()) {
			vo.setPw(userInfo.getPw());
		}
		
		
		userService.modifyInfo(vo);
		
		
		if (userInfo != null && userInfo.getMno() == vo.getMno()) {
			session.setAttribute("userInfo", vo);
		}
		
		return "redirect:/user/myPage";
	}
	
	/**
	 * 회원 탈퇴 요청 처리
	 * 
	 * 관리자		 - 탈퇴 처리 후 cri에 저장된 페이지 정보로 기존 회원 목록 페이지로 이동
	 * 로그인 사용자 - 탈퇴 처리 후 세션에 로그인 정보도 삭제, 메인 페이지로 이동
	 * 
	 * @param mno		탈퇴 요청한 사용자 회원 번호
	 * @param cri		관리자가 기존에 보던 회원 목록 페이지 번호
	 * 					(회원 목록 - 상세 페이지 - 회원 삭제 버튼까지 페이지 번호 계속 넘겨주기)
	 * @param session	로그인 사용자 정보 가져와서 관리자가 삭제하는 경우, 사용자가 탈퇴하는 경우 구분,
	 * 					사용자가 탈퇴할 경우에는 세션에 로그인 정보도 삭제
	 * @param cookie	탈퇴 요청한 사용자가 자동 로그인 설정한 상태라면 쿠키에서도 정보 삭제(관리자가 회원 삭제한 경우에도)
	 */
	@PostMapping("/withdraw")
	public String withdraw(
			int mno
			) throws Exception{
		
		userService.withdraw(mno);

	    return "redirect:/user/logout";       
	}
	
	@PostMapping("/admin/delete")
	public String withdraw(
			int mno, Criteria cri
			) throws Exception{
		
		userService.withdraw(mno);


	    return "redirect:/admin/memberList?page=" +cri.getPage();
	}

	
	
	/**
	 * 아이디 찾기 페이지로 이동 요청 처리
	 */
	@GetMapping("/findIdForm")
	public String goToFindId() throws Exception{
		
		return "user/findID";
	}
	
	
	
	/**
	 * 비밀번호 찾기 페이지로 이동 요청 처리
	 */
	@GetMapping("/findPwForm")
	public String goToFindPw() throws Exception{
		
		return "user/findPassword";
	}
	
	/**
	 * 아이디 찾기 - 이름, 이메일 입력 후 인증 코드 요청 버튼 클릭 시
	 * 입력 받은 이름과 이메일로 가입한 사용자가 있는지 검색 후 검색된 이메일 전달
	 * 
	 * @param name	전달 받은 사용자 이름
	 * @param email	전달 받은 사용자 이메일
	 * @return		검증된 이메일
	 */
	@GetMapping("/checkEmailForId")
	@ResponseBody
	public String checkEmailForId(String name, String email) throws Exception{
		
		return userService.checkAndGetEmailForId(name, email);
	}
	
	/**
	 * 비밀번호 찾기 - 아이디, 이메일 입력 후 인증 코드 요청 버튼 클릭 시
	 * 입력 받은 아이디와 이메일로 가입한 사용자가 있는지 검색 후 검색된 이메일 전달
	 * 
	 * @param id	전달 받은 사용자 아이디
	 * @param email	전달 받은 사용자 이메일
	 * @return		검증된 이메일
	 */
	@GetMapping("/checkEmailForPw")
	@ResponseBody
	public String checkEmailForPw(String id, String email) throws Exception{
		
		return userService.checkAndGetEmailForPw(id, email);
	}
	
	/**
	 * 회원 가입 - 이메일 인증 버튼 클릭 시 이메일로 인증 코드 발송
	 * 아이디 찾기, 비밀번호 찾기 - 이메일 검증이 끝난 후에 검증된 이메일로 인증 코드 발송
	 * 
	 * @param email		검증된 이메일
	 */
	@GetMapping("/sendEmail")
	@ResponseBody
	public String sendMail(String email) throws Exception{
		String code = "";
		for(int i = 0; i < 5; i++) {
			code += (int)(Math.random() * 10);
		}
		System.out.println("발신 code : "+code);
		
		// code 메일 발송
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, "UTF-8");
		helper.setFrom("ssunllo9898@gmail.com", "SmartLibrary MASTER");
		helper.setTo(email);	// 인증된 이메일을 수신자로 지정
		helper.setSubject("스마트 도서관 이메일 인증 코드");
		helper.setText("다음 인증 코드를 입력해 주세요.<h3>["+code+"]</h3>", true);
		mailSender.send(message);
		
		System.out.println("이메일 인증 코드 발송 완료");
		
		return code;
	}
	
	/**
	 * 아이디 찾기 - 이메일 인증 코드 입력 후 <인증하기> 버튼 클릭 시 코드가 일치할 경우
	 * 전달 받은 이메일로 가입한 사용자의 아이디 조회 후 반환
	 * 
	 * @param email		인증된 이메일
	 */
	@GetMapping("/findId")
	@ResponseBody
	public String findId(String email) throws Exception{
		
		return userService.getId(email);
	}
	
	/**
	 * 비밀번호 찾기 - 이메일 인증까지 마친 후에 <비밀번호 변경> 버튼 클릭 시
	 * 비밀번호 변경 폼 페이지로 이동 요청 처리
	 * 
	 * @param id	이메일 인증을 마친 사용자 아이디
	 */
	@GetMapping("/resetPwForm")
	public String goToResetPw(String id) throws Exception{
		
		return "user/resetPasswordForm";
	}
	
	/**
	 * 비밀번호 찾기 - 새로운 비밀번호로 변경 요청 처리
	 * 전달 받은 아이디로 검색된 회원의 비밀번호를 새로운 비밀번호로 변경
	 * 
	 * @param id	이메일 인증을 마친 사용자 아이디
	 * @param pw	변경할 새로운 비밀번호
	 */
	@PostMapping("/resetPw")
	public String resetPassword(String id, String pw, String confirmPassword, RedirectAttributes rttr) throws Exception{
		
	    if (!pw.equals(confirmPassword)) {
	        rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 입력하세요.");
	        return "redirect:/user/resetPwForm?id=" + id;
	    }
		
		try {
			userService.resetPassword(id, pw);
			rttr.addFlashAttribute("msg", "비밀번호가 성공적으로 변경되었습니다. 새 비밀번호로 로그인하세요");
			return "redirect:/user/goToLogin";
		}catch(Exception e){
			e.getStackTrace();
			rttr.addFlashAttribute("msg", "비밀번호 변경에 실패하였습니다. 다시 시도해 주세요.");
	        return "redirect:/user/resetPwForm?id=" + id;
		
		}
	}
	
	/**
	 * 관리자 - 회원 관리 페이지 요청 처리 (페이징 처리된 회원 목록)
	 * 
	 * @param cri	페이징 정보
	 * @param model	페이징 처리된 회원 목록과 페이징 블럭 출력용 PageMaker 객체 저장
	 */
	@GetMapping("/admin/memberList")
	public String memberList(Criteria cri, Model model) throws Exception{
		
		model.addAllAttributes(userService.getMemberList(cri));
		return "admin/memberList";
	}
	
	/**
	 * 관리자 - 회원 정보 상세 페이지 요청 처리
	 * 
	 * 관리자가 해당 회원 삭제할 경우 기존에 보던 목록 페이지로 갈 수 있도록
	 * 페이지 정보는 목록에서 넘겨 받아 유지하기 
	 * ex) 회원 목록 url 			: ~ memberList?page=3
	 * 	   회원 정보 상세 페이지 url  : ~ memberDetail?mno=12&page=3
	 * 			-> 삭제 버튼 클릭 시 페이지 정보도 넘겨주기 (삭제 요청 시 page=3 정보도 같이 넘겨주기)
	 * 
	 * @param mno	관리자가 상세 페이지 요청한 회원 번호
	 * @param cri	기존에 보던 목록 페이지 정보
	 */
	@GetMapping("/admin/memberDetail")
	public String memberDetail(int mno, Criteria cri, Model model) throws Exception {
	   
		model.addAttribute("member", userService.getMemberDetail(mno));
	    model.addAttribute("cri", cri);
	    return "admin/memberDetail";

	}
}	
	    
	    
	    
	    
	    
	    
	    