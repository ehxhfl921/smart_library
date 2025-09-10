package net.koreate.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.RequiredArgsConstructor;
import net.koreate.library.service.LibraryService;
import net.koreate.library.vo.LibraryVO;

@Controller
@RequiredArgsConstructor
public class LibraryController {

	private final LibraryService ls;
	
	/**
	 * 도서관 정보 페이지 요청 처리
	 */
	@GetMapping("/libraryInfo")
	public String LibraryInfo(Model model) {
		try {
			
			LibraryVO vo = ls.getLibraryInfo();
			model.addAttribute("info", vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "libraryInfo";
	}
	
	/**
	 * 도서관 정보 수정 폼 페이지로 이동 요청 처리
	 */
	@GetMapping("/libraryInfo/modify")
	public String goToModifyForm() {
		return "manageInfo";
	}
	
	/**
	 * 도서관 정보 수정 요청 처리
	 * 
	 * @param vo 수정할 도서관 정보를 담은 LibraryVO 타입 객체
	 * @return 수정 완료 후 도서관 정보 페이지로 이동
	 */
	@PostMapping("/libraryInfo/modify")
	public String modifyLibraryInfo(
				LibraryVO vo, Model model
			) throws Exception{
		
		try {
			
			ls.modifyLibraryInfo(vo);
			LibraryVO info = ls.getLibraryInfo();
			model.addAttribute("info", info);
			model.addAttribute("msg", "도서관 정보 수정이 완료되었습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "도서관 정보 수정에 실패하였습니다.");
		}
		
		return "libraryInfo";
	}
	
}
