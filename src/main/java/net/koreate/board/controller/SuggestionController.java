package net.koreate.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;

@Controller
@RequestMapping("/suggest")
public class SuggestionController {

	
	/**
	 * 페이징 처리된 건의 사항 게시글 목록 페이지 요청 처리
	 * 
	 * @param cri
	 * @param model 건의사항 리스트, PageMaker 객체
	 */
	@GetMapping("/list")
	public String suggestionList(Criteria cri, Model model) throws Exception{
		return null;
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
		return null;
	}
	
	/**
	 * 건의 사항 상세 페이지 보기 요청 처리
	 * 
	 * @param sug_no 상세 보기 요청한 건의사항 게시글 번호
	 */
	@GetMapping("/detail")
	public String suggestionDetail(int sug_no, Model model) throws Exception{
		return null;
	}

	/**
	 * 건의 사항 등록 요청 처리
	 * @param vo 등록할 건의 사항 게시글 정보
	 */
	@PostMapping("/register")
	public String suggestionRegister(BoardVO vo, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 건의 사항 수정 폼 페이지 요청
	 * 
	 * @param sug_no	수정할 건의 사항 게시글 번호
	 */
	@GetMapping("/modifyForm")
	public String goToModifyForm(int sug_no, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 건의 사항 수정 요청 처리
	 * @param vo	수정할 건의 사항 게시글 정보
	 */
	@PostMapping("/modify")
	public String suggestionModify(BoardVO vo, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 건의 사항 삭제 요청 처리
	 * @param sug_no 삭제 처리할 건의 사항 게시글 번호
	 */
	@GetMapping("/delete")
	public String suggestionDelete(int sug_no, Model model) throws Exception{
		return null;
	}
}
