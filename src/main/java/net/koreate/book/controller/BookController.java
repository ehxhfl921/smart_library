package net.koreate.book.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import net.koreate.book.dto.BookDTO;
import net.koreate.book.service.BookService;
import net.koreate.book.vo.BookVO;
import net.koreate.common.utils.Criteria;
import net.koreate.common.utils.SearchCriteria;
import net.koreate.user.vo.UserVO;

@Controller
@RequestMapping("/book")
@RequiredArgsConstructor
public class BookController {

	private final BookService bs;
	private String uploadPath = "C:/Users/KTE/Desktop/SmartLibrary/cover";
	
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
		
		if(keyword != null && !keyword.isEmpty()) {
			// 키워드가 null이 아닐 때 (메인 페이지에서 바로 검색한 경우)
			try {
				cri.setPerPageNum(5);
				// 키워드로 검색 후 검색된 도서 목록, pm 객체
				Map<String, Object> searchResult = bs.getSearchBookList(cri, keyword);
				
				// 각각 list, pm으로 모델에 저장
				model.addAttribute("list", searchResult.get("list"));
				model.addAttribute("pm", searchResult.get("pm"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} // end if
		
		return "book/searchBookList"; // 검색창만 있는 jsp 페이지
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
		
		cri.setPerPageNum(5);
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		if(keyword != null && !keyword.isEmpty()) {
			try {
				// 키워드로 검색 후 검색된 도서 목록, pm 객체
				Map<String, Object> searchResult = bs.getSearchBookList(cri, keyword);
				
				entity = new ResponseEntity<Map<String, Object>>(searchResult, HttpStatus.OK);
				
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
			}
		}
		
		return entity;
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
		
		UserVO loginMember = (UserVO)session.getAttribute("userInfo");
		
		// 로그인 사용자 아이디, 페이징 정보로 목록과 pm 객체 조회
		Map<String, Object> result = bs.getLoanListOfUser(loginMember.getId(), cri);
		
		// map에 저장된 목록, pm 객체 model에 저장
		model.addAttribute("list", result.get("list"));
		model.addAttribute("pm", result.get("pm"));
		
		return "book/loanList"; // 내 서재 - 도서 대출 내역 페이지
	}
	
	/**
	 * 관리자 전용 - 도서 관리 페이지(페이징 처리된 모든 도서 목록) 요청 처리
	 * model에 검색된 목록과 페이징 블럭 출력용 pm 객체 저장
	 * 
	 * @param cri 페이징 정보
	 */
	@GetMapping("/admin/list")
	public String showAllBooks(@ModelAttribute SearchCriteria scri, Model model) throws Exception{
		
		Map<String, Object> result = null;
		
		if(scri.getKeyword() == null || scri.getKeyword().isEmpty()) {
			result = bs.getAllBookList(scri);
		}else {
			if((scri.getSearchType().equals("n") && !scri.getKeyword().isEmpty()) || 
			   (scri.getSearchType().equals("ta") && !scri.getKeyword().isEmpty())	) {
				// 검색 카테고리를 선택하지 않고 검색어 입력 후 검색한 경우, 도서 혹은 저자로 키워드 검색한 경우
				result = bs.getSearchBookByTitleNAuthor(scri);
			}
			
			if(scri.getSearchType().equals("t") && !scri.getKeyword().isEmpty()) {
				// 제목으로 검색
				result = bs.getSearchBookByTitle(scri);
			}
			
			if(scri.getSearchType().equals("a") && !scri.getKeyword().isEmpty()) {
				// 저자로 검색
				result = bs.getSearchBookByAuthor(scri);
			}
			
			if(scri.getSearchType().equals("p") && !scri.getKeyword().isEmpty()) {
				// 발행기관으로 검색
				result = bs.getSearchBookByPublisher(scri);
			}
		}
		
		
		model.addAttribute("list", result.get("list"));
		model.addAttribute("pm", result.get("pm"));
		model.addAttribute("keyword", scri.getKeyword());
		
		return "admin/bookList"; // 관리자 전용 - 도서 관리 페이지
	}
	
	/**
	 * 관리자 전용 - 도서 상세 페이지 요청 처리
	 * 검색된 하나의 도서 정보와, 해당 도서의 대출 내역(List), PageMaker 객체 model에 저장
	 * 	+ 해당 도서가 이달의 도서로 등록되어 있는지 검색 후 상태 문자열로 받아서 model에 저장
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
		
		// 상세 페이지에 출력할 도서 정보
		BookVO book = bs.getBookDetail(bno);
		
		cri.setPerPageNum(5);
		
		// 해당 도서의 대출 내역
		Map<String, Object> result = bs.getLoanListOfBook(bno, cri);
		
		// 이달의 도서 등록 여부
		String isBom = bs.getBomStatus(bno);
		
		// 도서 정보, 대출 내역, pm 객체 model에 저장
		model.addAttribute("book", book);
		model.addAttribute("list", result.get("list"));
		model.addAttribute("pm", result.get("pm"));
		model.addAttribute("isBom", isBom);
		
		return "admin/bookDetail";
	}
	
	/**
	 * 관리자 전용 - 도서 신규 등록 폼 페이지 요청 처리
	 */
	@GetMapping("/admin/register")
	public String goToRegisterPage() {
		return "admin/bookRegisterForm";
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
	 * @return 등록 후 관리자 전용 도서 관리 페이지(목록)로
	 */
	@PostMapping("/admin/register")
	public String registerBook(BookDTO dto, RedirectAttributes rttr) throws Exception{
		
		String fileName = null;
		
		if(dto.getCoverFile() != null && !dto.getCoverFile().isEmpty()) {
			// 표지 이미지를 등록한 경우
			fileName = uploadFile(dto.getCoverFile());
		}else {
			// 표지 이미지 없이 도서 등록하는 경우(임시 이미지 출력)
			fileName = "tempImg.png";
		}
		
		BookVO vo = new BookVO();
		
		vo.setTitle(dto.getTitle());
		vo.setAuthor(dto.getAuthor());
		vo.setPublisher(dto.getPublisher());
		vo.setP_date(dto.getP_date());
		// 표지 이미지 경로("images/파일 이름") cover 필드에 저장
		vo.setCover("images/"+fileName);
		
		// vo에 저장된 신규 도서 정보 테이블에 저장
		try {
			bs.registerBook(vo);
			rttr.addFlashAttribute("msg", "신규 도서 등록이 완료되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "신규 도서 등록에 실패하였습니다.");
		}

		
		return "redirect:/book/admin/list";
	}
	
	/**
	 * 관리자 전용 - 도서 정보 수정 폼 페이지 요청 처리
	 */
	@GetMapping("/admin/modify")
	public String goToModifyPage(int bno, Model model) {
		try {
			BookVO vo = bs.getBookDetail(bno);
			model.addAttribute("book", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/bookUpdateForm";
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
	public String modifyBook(
				BookDTO dto,
				RedirectAttributes rttr
			) throws Exception{
		
		// dto에 저장된 도서 번호로 해당 도서 기존 정보 가져오기
		BookVO vo = bs.getBookDetail(dto.getBno());
		
		vo.setTitle(dto.getTitle());
		vo.setAuthor(dto.getAuthor());
		vo.setPublisher(dto.getPublisher());
		vo.setP_date(dto.getP_date());
		
		// 표지 이미지 새로 업로드할 경우 파일 이름 저장할 변수
		String fileName = null;


		if (dto.getCoverFile() != null && !dto.getCoverFile().isEmpty()) {
			// 표지 이미지를 새로 등록한 경우
			// 기존 파일 삭제 (tempImg.png 제외)
	        String oldCover = vo.getCover().replace("images/", "");
	        if (!oldCover.equals("tempImg.png")) {
	            File oldFile = new File(uploadPath, oldCover);
	            if (oldFile.exists()) oldFile.delete();
	        }
	        
			// 새로운 표지 이미지 업로드 후 파일 이름 받아오기
			fileName = uploadFile(dto.getCoverFile());
			// 표지 이미지 경로("images/새로운 파일 이름") cover 필드에 저장
			vo.setCover("images/"+fileName);
			
		} // end if
		
		// vo에 저장된 수정된 도서 정보로 테이블 업데이트
		try {
			bs.modifyBook(vo);
			rttr.addFlashAttribute("msg", "도서 정보 수정이 완료되었습니다.");
		} catch (Exception e) {
			e.getStackTrace();
			e.getMessage();
			rttr.addFlashAttribute("msg", "도서 정보 수정에 실패하였습니다.");
		}
		
		// 리다이렉트로 기존 도서 상세 페이지로 이동할 때 필요한 페이지 번호
		rttr.addAttribute("page", 1);
		
		return "redirect:/book/admin/"+vo.getBno();
	}
	
	/**
	 * 관리자 전용 - 도서 삭제 요청 처리
	 * 
	 * @param bno 삭제 처리할 도서 번호
	 */
	@GetMapping("/admin/remove/{bno}")
	public String removeBook(
			@PathVariable(name="bno") int bno,
			Criteria cri,
			RedirectAttributes rttr
			) throws Exception{
		
		BookVO vo = bs.getBookDetail(bno);
		String coverFileName = vo.getCover().replace("images/", "");
		
		if (!coverFileName.equals("tempImg.png")) {
			File file = new File(uploadPath, coverFileName);
			if (file.exists()) file.delete();
		}
		
		try {
			bs.removeBook(bno);
			rttr.addFlashAttribute("msg", "도서가 삭제되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "도서 삭제에 실패하였습니다.");
		}
		
		rttr.addAttribute("page", cri.getPage());
		
		return "redirect:/book/admin/list";
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
		
		// 임시 업로드
		File f = new File("C:\\Temp\\upload");
		if (!f.exists()) {
        	f.mkdirs();
        }
		File temp = new File(f, fileName);
		FileCopyUtils.copy(file.getBytes(), temp);
		
		// 실제 경로에 업로드
		File realDir = new File(uploadPath);
        if (!realDir.exists()) {
        	realDir.mkdirs();
        }
		File r = new File(realDir, fileName);
		FileCopyUtils.copy(file.getBytes(), r);
		
		return fileName;
	}
	
	/**
	 * 이달의 도서로 등록 요청 처리
	 * 
	 * @param bno	이달의 도서로 등록할 도서 번호
	 */
	@GetMapping("/registerBom")
	@ResponseBody
	public ResponseEntity<Map<String, String>> registerBom(int bno) throws Exception{
		
		ResponseEntity<Map<String, String>> entity = null;
		Map<String, String> result = new HashMap<>();
		
		try {
			// 도서 정보 검색 후
			BookVO vo = bs.getBookDetail(bno);
			// 해당 도서 이달의 도서로 등록
			bs.regieterBOM(vo);
			result.put("msg", "이달의 도서로 등록했습니다.");
			
			entity = new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			result.put("msg", "이달의 도서로 등록하지 못했습니다.");
			entity = new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	
	/**
	 * 이달의 도서에서 삭제 요청 처리
	 * 
	 * @param bno	이달의 도서로 등록할 도서 번호
	 */
	@GetMapping("/removeBom")
	@ResponseBody
	public ResponseEntity<Map<String, String>> reoveBom(int bno) throws Exception{
		
		ResponseEntity<Map<String, String>> entity = null;
		Map<String, String> result = new HashMap<>();
		
		try {
			bs.removeFromBOM(bno);
			result.put("msg", "이달의 도서에서 제거했습니다.");
			entity = new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			result.put("msg", "이달의 도서에서 제거하지 못했습니다.");
			entity = new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
}
