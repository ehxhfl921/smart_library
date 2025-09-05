package net.koreate.board.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;

public class SuggestionController {

	
	/**
	 * 페이징 처리된 건의 사항 게시글 목록 페이지 요청 처리
	 * @param cri
	 * @param model 건의사항 리스트, PageMaker 객체
	 */
	@GetMapping("/list")
	public String suggestionList(Criteria cri, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 건의 사항 상세 페이지 보기 요청 처리
	 * 
	 * @param sug_no 상세 보기 요청한 건의사항 게시글 번호
	 * @param model	 
	 * @return
	 * @throws Exception
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
	public String suggestionRegister(BoardVO vo) throws Exception{
		return null;
	}
	
	/**
	 * 건의 사항 수정 요청 처리
	 * @param vo 수정할 건의 사항 게시글 정보
	 */
	@PostMapping("/modify")
	public String suggestionModify(BoardVO vo) throws Exception{
		return null;
	}
	
	/**
	 * 건의 사항 삭제 요청 처리
	 * @param nno 삭제 처리할 건의 사항 게시글 번호
	 */
	@GetMapping("/delete")
	public String suggestionDelete(int sug_no) throws Exception{
		return null;
	}
}
