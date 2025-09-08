package net.koreate.book.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.koreate.book.dto.BookDTO;
import net.koreate.common.utils.Criteria;

@Controller
@RequestMapping("/book")
public class BookController {

	/**
	 * 도서 검색 페이지로 이동 요청 처리
	 * 	-> 키워드가 넘어오지 않은 경우 검색창만 있는 기본 도서 검색 페이지로 이동 -> 원하는 키워드로 검색 시 ajax 목록 호출,
	 * 메인 페이지 검색창에서 바로 검색한 경우 키워드랑 페이지 정보 받아서 도서 검색 페이지로 이동
	 * 	-> 키워드가 넘어온 경우 도서 검색 페이지로 이동 후 바로 ajax로 검색한 도서 목록 호출 : 도서 검색 페이지에서 검색한 것과 같은 결과 출력
	 * 
	 * @param keyword	메인 페이지에서 바로 검색한 경우 : 검색 키워드	/ 일반 도서 검색 페이지로 이동 요청 : ""
	 * @param cri		메인 페이지에서 바로 검색한 경우 : 페이지=1
	 * @param model		메인 페이지에서 바로 검색한 경우 : 페이징 처리된 검색 목록, 페이징 블럭 출력용 pm 객체
	 */
	@GetMapping("/search")
	public String showSearchPage(
			@RequestParam(required = false) String keyword,
			Criteria cri,
			Model model
			) {
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
	 * 파일 업로드 함수 호출해서 표지 이미지 업로드 후에 파일 이름 반환 받아서 
	 * "/images/파일이름"으로 vo cover 필드에 경로 저장
	 * 
	 * 서비스.registerBook(vo) 호출해서 테이블에 도서 정보 등록
	 * 
	 * @param dto 등록할 신규 도서 정보
	 * @return 등록 후 관리자 전용 도서 관리 페이지로 redirect
	 */
	@PostMapping("/admin/register")
	public String registerBook(BookDTO dto, Model model) throws Exception{
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
	 * 표지 이미지 MultipartFile 새로 등록하지 않은 경우 기존 경로 그대로 유지
	 * 새로 등록하는 경우 해당 이미지 업로드, 새로운 경로 vo에 set
	 * 
	 * 도서 번호로 기존 도서 정보 담은 vo 객체 생성 => 새 표지 이미지 파일 등록 여부 먼저 확인 후 있으면 업로드 후 vo에 set
	 * => 나머지 바뀌거나 바뀌지 않은 모든 정보 vo에 set => 서비스.modifyBook(vo) 호출해서 수정
	 * 
	 * @param vo 수정할 도서 정보
	 */
	@PostMapping("/admin/modify")
	public String modifyBook(BookDTO dto, Model model) throws Exception{
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
	
	/**
	 * 파일 업로드 후 저장된 파일 이름 반환 메서드
	 */
	public String uploadFile(MultipartFile file) throws IOException{
		String fileName = "";
		
		UUID uid = UUID.randomUUID();
		String origin = file.getOriginalFilename();
		String random = uid.toString().replace("-", "");	// - 특수 문자 제거, 32개 무작위 문자
		
		fileName = random + "_" + origin;
		
		// 파일 업로드
		File f = new File("C:\\Temp\\upload", fileName);
		// copy(업로드할 파일 데이터, 업로드 파일 위치 밎 이름);
		FileCopyUtils.copy(file.getBytes(), f);
		
		// 파일 실제 경로에 저장
		String realDir = "C:/Users/KTE/Desktop/SmartLibrary/cover";
		File r = new File(realDir, fileName);
		FileCopyUtils.copy(file.getBytes(), r);
		
		return fileName;
	}
}
