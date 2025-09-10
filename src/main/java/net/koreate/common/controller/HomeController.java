package net.koreate.common.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.RequiredArgsConstructor;
import net.koreate.book.service.BookService;
import net.koreate.book.vo.BookVO;
import net.koreate.library.service.LibraryService;
import net.koreate.library.vo.LibraryVO;

@Controller
@RequiredArgsConstructor
public class HomeController {
	
	private final BookService bs;
	private final LibraryService ls;
	
	/**
	 * 이달의 도서 목록, 도서관 정보 model에 저장
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		try {
			List<BookVO> list = bs.getBomList();
			model.addAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			LibraryVO info = ls.getLibraryInfo();
			model.addAttribute("info", info);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "home";
	}
	
}
