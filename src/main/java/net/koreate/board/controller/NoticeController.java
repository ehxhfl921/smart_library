package net.koreate.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	/**
	 * 페이징 처리된 공지 사항 게시글 목록 페이지 요청 처리
	 * @param cri
	 * @param model 공지사항 리스트, PageMaker 객체
	 */
	@GetMapping("/list")
	public String noticeList(Criteria cri, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 공지 사항 상세 페이지 보기 요청 처리
	 * @param nno 전달 받은 공지 사항 번호
	 * @param model 공지 사항 게시글 정보
	 */
	@GetMapping("/detail")
	public String noticeDetail(int nno, Model model) throws Exception{
		return null;
	}

	/**
	 * 공지 사항 등록 요청 처리
	 * @param vo 등록할 공지 사항 게시글 정보
	 */
	@PostMapping("/register")
	public String noticeRegister(BoardVO vo, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 공지 사항 수정 요청 처리
	 * @param vo 수정할 공지 사항 게시글 정보
	 */
	@PostMapping("/modify")
	public String noticeModify(BoardVO vo, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 공지 사항 삭제 요청 처리
	 * @param nno 삭제 처리할 공지 사항 게시글 번호
	 */
	@GetMapping("/delete")
	public String noticeDelete(int nno, Model model) throws Exception{
		return null;
	}
	
	
}
