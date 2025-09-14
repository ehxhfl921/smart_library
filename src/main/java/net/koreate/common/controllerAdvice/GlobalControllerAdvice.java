package net.koreate.common.controllerAdvice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import net.koreate.library.service.LibraryService;
import net.koreate.library.vo.LibraryVO;

@ControllerAdvice
public class GlobalControllerAdvice {

	@Autowired
	private LibraryService ls;
	
	@ModelAttribute("info")
    public LibraryVO setLibraryInfo(){
		
		LibraryVO info = null;
		
		try {
			info = ls.getLibraryInfo();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
        return info;
    }
}
