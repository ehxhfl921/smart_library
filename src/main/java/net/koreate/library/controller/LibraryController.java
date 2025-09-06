package net.koreate.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import net.koreate.library.vo.LibraryVO;

@Controller
public class LibraryController {

	/**
	 * 도서관 정보 페이지 요청 처리
	 */
	@GetMapping("/libraryInfo")
	public String LibraryInfo(Model model) {
		return null;
	}
	
	/**
	 * 도서관 정보 수정 폼 페이지로 이동 요청 처리
	 */
	@GetMapping("/libraryInfo/modify")
	public String goToModifyForm() {
		return null;
	}
	
	/**
	 * 도서관 정보 수정 요청 처리
	 * 
	 * @param vo 수정할 도서관 정보를 담은 LibraryVO 타입 객체
	 * @return 수정 완료 후 도서관 정보 페이지로 이동
	 */
	@PostMapping("/libraryInfo/modify")
	public String modifyLibraryInfo(LibraryVO vo, Model model) throws Exception{
		return null;
	}
}
