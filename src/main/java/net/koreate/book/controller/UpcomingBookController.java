package net.koreate.book.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import net.koreate.book.service.UpcomingBookService;
import net.koreate.common.utils.Criteria;

@Controller
@RequiredArgsConstructor
public class UpcomingBookController {

	@Autowired
	private final UpcomingBookService us;
	
	@GetMapping("/upcoming")
	public String upcomingBookList(Criteria cri, Model model) throws Exception{
		
		cri.setPerPageNum(10);
		
		Map<String, Object> map = us.getList(cri);
		
		model.addAllAttributes(map);
		
		return "book/upcomingBooks";
	}
}
