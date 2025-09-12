package net.koreate.board.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String mySuggestionList(
				Criteria cri,
				HttpSession session,
				Model model
			) throws Exception{
		UserVO logins = (UserVO)session.getAttribute("logins");
		Map<String, Object> result = ss.getMySuggestionLst(logins.getId(), cri);
				
		model.addAttribute("list", result.get("list"));
		model.addAttribute("pm", result.get("pm"));
				
		return "board/mySuggestionList";
	}
	
	/**
	 * 건의 사항 상세 페이지 보기 요청 처리
	 * 
	 * @param sug_no 상세 보기 요청한 건의사항 게시글 번호
	 */
	@GetMapping("/detail")
	public String suggestionDetail(int sug_no, Model model) throws Exception{
		  BoardVO board = ss.getDetail(sug_no);
	      model.addAttribute("boardVO", board);
	      
	      return "board/SuggestionDetail";
	}

	/**
	 * 건의 사항 등록 요청 처리
	 * @param vo 등록할 건의 사항 게시글 정보
	 */
	@PostMapping("/register")
	public String suggestionRegister(BoardVO vo, Model model) throws Exception{
		System.out.println("param data : " + vo);
	    String result = ss.write(vo);
	    model.addAttribute("msg", result);
	    return "redirect:/";
	}
	
	/**
	 * 건의 사항 수정 폼 페이지 요청
	 * 
	 * @param sug_no	수정할 건의 사항 게시글 번호
	 */
	@GetMapping("/modifyForm")
	public String goToModifyForm(int sug_no, Model model) throws Exception{
		BoardVO board = ss.getDetail(sug_no);
	    model.addAttribute(board);
	    return "board/suggestionUpdate";
	}
	
	/**
	 * 건의 사항 수정 요청 처리
	 * @param vo	수정할 건의 사항 게시글 정보
	 */
	@PostMapping("/modify")
	public String suggestionModify(BoardVO vo, Model model) throws Exception{
		String result = ss.update(vo);
	    model.addAttribute("result", result);
	    return "redirect:/board/suggestionDetail?nno=" + vo.getNno();
	}
	
	/**
	 * 건의 사항 삭제 요청 처리
	 * @param sug_no 삭제 처리할 건의 사항 게시글 번호
	 */
	@GetMapping("/delete")
	public String suggestionDelete(int sug_no, Model model) throws Exception{
		 String result = ss.delete(sug_no);
	     model.addAttribute("result", result);
	     return "redirect:/board/suggestionDetail";
	}
}
