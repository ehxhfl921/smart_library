package net.koreate.board.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import net.koreate.board.service.SuggestionService;
import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;
import net.koreate.user.vo.UserVO;

@Controller
@RequestMapping("/suggest")
@RequiredArgsConstructor
public class SuggestionController {
	
	private final SuggestionService ss;

	
	/**
	 * 페이징 처리된 건의 사항 게시글 목록 페이지 요청 처리
	 * 
	 * @param cri
	 * @param model 건의사항 리스트, PageMaker 객체
	 */
	@GetMapping("/list")
	public String suggestionList(Criteria cri, Model model) throws Exception{
		System.out.println("건의사항 목록 suggestionList 요청");
		
	       // 조회된 건의사항 게시글 목록
	       Map<String, Object> map = ss.list(cri);
	       model.addAllAttributes(map);
	       return "board/suggestionList";
	}
	
	/**
	 * 내 서재 - 작성한 건의 사항 페이지로 이동 요청 처리
	 * 페이징 처리된 로그인 사용자가 작성한 건의 사항 목록 페이지
	 * 
	 * 세션에 저장된 로그인 사용자 정보에서 아이디 가져와서 
	 * 해당 사용자가 작성한 건의 사항 목록, 페이징 블럭 출력용 PageMaker 객체를 model에 저장
	 * 
	 * @param cri
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	 @GetMapping("/mySuggestion")
    public String mySuggestionList(Criteria cri, HttpSession session, Model model) throws Exception {
        UserVO logins = (UserVO) session.getAttribute("userInfo");
        if (logins == null) {
            return "redirect:/user/goToLogin";
        }
        Map<String, Object> map = ss.getMySuggestionLst(logins.getId(), cri);
        model.addAttribute("list", map.get("list"));
        model.addAttribute("pm", map.get("pm"));
        return "board/mySuggestionList";
	}
	
	/**
	 * 건의 사항 상세 페이지 보기 요청 처리
	 * 
	 * @param sug_no 상세 보기 요청한 건의사항 게시글 번호
	 */
	 @GetMapping("/detail")
	 public String suggestionDetail(@RequestParam(value="sug_no", required=false) Integer sug_no, Model model) throws Exception {
	     if(sug_no == null) {
	         // 값이 없거나 잘못된 경우 목록 페이지로 리다이렉트
	         return "redirect:/suggest/list";
	     }
	     BoardVO detail = ss.getDetail(sug_no);
	     model.addAttribute("suggestion", detail);
	     return "board/suggestionDetail";
	 }



	/**
	 * 건의 사항 등록 요청 처리
	 * @param vo 등록할 건의 사항 게시글 정보
	 */
	@PostMapping("/register")
    public String suggestionRegister(BoardVO vo, HttpSession session, RedirectAttributes rttr) {
        UserVO logins = (UserVO) session.getAttribute("userInfo");
       
        vo.setS_userid(logins.getId());
        vo.setS_author(logins.getName());

        try {
            ss.write(vo);
            rttr.addFlashAttribute("msg", "건의 사항을 등록했습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("msg", "건의 사항 등록 중 오류가 발생했습니다.");
        }

        return "redirect:/suggest/list";
    }



	
	/**
	 * 건의 사항 작성 폼 페이지로 이동 요청 처리
	 */
	 @GetMapping("/register")
	   public String suggestionRegisterForm() throws Exception{

	    return "board/suggestionWrite";
	}
	
	/**
	 * 건의 사항 수정 요청 처리
	 * @param vo	수정할 건의 사항 게시글 정보
	 */
	 @PostMapping("/modify")
	 public String modifySuggestion(BoardVO vo, HttpSession session, RedirectAttributes rttr) {
	     UserVO logins = (UserVO) session.getAttribute("userInfo");
	     vo.setS_userid(logins.getId());
	        vo.setS_author(logins.getName());

	        try {
	            ss.update(vo);
	            rttr.addFlashAttribute("msg", "건의 사항을 수정했습니다.");
	        } catch (Exception e) {
	            e.printStackTrace();
	            rttr.addFlashAttribute("msg", "수정 사항 등록 중 오류가 발생했습니다.");
	        }

	        return "redirect:/suggest/list";
	 }
	 
	 /**
	    * 건의 사항 수정 폼 페이지 요청
	    * 
	    * @param nno   수정할 건의 사항 게시글 번호
	    */
	   @GetMapping("/modifyForm")
	   public String suggestionModify(@RequestParam("sug_no") int sug_no, Model model) throws Exception {
		   BoardVO vo  = ss.getDetail(sug_no);
	       model.addAttribute("suggestion", vo);
	       return "board/suggestionUpdate";
	   }

	/**
	 * 건의 사항 삭제 요청 처리
	 * @param sug_no 삭제 처리할 건의 사항 게시글 번호
	 */
	 @PostMapping("/delete")
	    public String deleteSuggestion(@RequestParam("sug_no") int sug_no, RedirectAttributes rttr) {
	        try {
	            ss.delete(sug_no);
	            rttr.addFlashAttribute("msg", "건의 사항이 삭제되었습니다.");
	        } catch (Exception e) {
	            e.printStackTrace();
	            rttr.addFlashAttribute("msg", "건의 사항 삭제 중 오류가 발생했습니다.");
	        }
	        return "redirect:/suggest/list";
	    }
	}
