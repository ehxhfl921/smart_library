package net.koreate.common.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.RequiredArgsConstructor;
import net.koreate.book.service.BookService;
import net.koreate.book.vo.BookVO;

@Controller
@RequiredArgsConstructor
public class HomeController {
	
	private final BookService bs;
	
	/**
	 * 이달의 도서 목록 model에 저장
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		try {
			List<BookVO> list = bs.getBomList();
			model.addAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "home";
	}
	
}
