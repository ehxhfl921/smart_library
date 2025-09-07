package net.koreate.book.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.book.vo.BookVO;
import net.koreate.common.utils.Criteria;

@Controller
@RequestMapping("/book")
public class BookController {

	@GetMapping("/search")
	public String showSearchPage() {
		return "book/searchBookList"; // 그냥 search로 요청 시 검색창만 있는 jsp 페이지 출력
	}
	
	/**
	 * 전달 받은 키워드로 도서 검색 요청 처리
	 * 
	 * @param keyword	검색할 키워드
	 * @param cri		검색된 도서 목록 페이징 처리 정보
	 * @return	검색된 도서 목록과 페이징 블럭 출력용 pm 객체를 Map에 저장 후 전달
	 */
	@GetMapping("/search/list")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> searchBooks(
			@RequestParam String keyword,
			Criteria cri
			) throws Exception{
		return null;
	}
	
	/**
	 * 내 서재 - 내 도서 대출 내역 페이지 요청 처리
	 * 로그인 사용자 아이디로 도서 대출 테이블에서 검색 후 페이징 처리된 목록, PageMaker 객체
	 * model에 저장
	 * 
	 * @param cri		페이징 정보
	 * @param model		페이징 블럭 출력용 pm 객체와 도서 대출 내역 리스트 저장
	 * @param session	로그인 사용자 아이디 가져오기
	 */
	@GetMapping("/myPage/loans")
	public String myLoanList(
			Criteria cri, Model model, HttpSession session
			) throws Exception{
		return null;
	}
	
	/**
	 * 관리자 전용 - 도서 관리 페이지(페이징 처리된 모든 도서 목록) 요청 처리
	 * model에 검색된 목록과 페이징 블럭 출력용 pm 객체 저장
	 * 
	 * @param cri 페이징 정보
	 */
	@GetMapping("/admin/list")
	public String showAllBooks(Criteria cri, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 관리자 전용 - 도서 상세 페이지 요청 처리
	 * 검색된 하나의 도서 정보와, 해당 도서의 대출 내역(List), PageMaker 객체 model에 저장
	 * 
	 * @param bno 	상세 페이지에서 조회할 도서 번호
	 * @param model 검색된 도서 정보를 담은 BookVO vo 객체,
	 * 				해당 도서 번호로 대출 테이블에서 검색된 대출 내역 리스트,
	 * 				대출 내역 리스트 페이징 블럭 출력을 위한 PageMaker 객체 저장
	 * @param cri	대출 내역 리스트 페이징 정보
	 */
	@GetMapping("/admin/{bno}")
	public String bookDetail(
			@PathVariable("bno") int bno, 
			Model model,
			Criteria cri
			) throws Exception{
		return null;
	}
	
	/**
	 * 관리자 전용 - 도서 신규 등록 폼 페이지 요청 처리
	 */
	@GetMapping("/admin/register")
	public String goToRegisterPage() {
		return null;
	}
	
	/**
	 * 관리자 전용 - 도서 신규 등록 요청 처리
	 * 
	 * @param vo 등록할 신규 도서 정보
	 * @return 등록 후 관리자 전용 도서 관리 페이지로 redirect
	 */
	@PostMapping("/admin/register")
	public String registerBook(BookVO vo, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 관리자 전용 - 도서 정보 수정 폼 페이지 요청 처리
	 */
	@GetMapping("/admin/modify")
	public String goToModifyPage() {
		return null;
	}
	
	/**
	 * 관리자 전용 - 도서 정보 수정 요청 처리
	 * 
	 * @param vo 수정할 도서 정보
	 */
	@PostMapping("/admin/modify")
	public String modifyBook(BookVO vo, Model model) throws Exception{
		return null;
	}
	
	/**
	 * 관리자 전용 - 도서 삭제 요청 처리
	 * 
	 * @param bno 삭제 처리할 도서 번호
	 */
	@GetMapping("/admin/remove/{bno}")
	public String removeBook(
			@PathVariable(name="bno") int bno
			) throws Exception{
		return null;
	}
	
}
