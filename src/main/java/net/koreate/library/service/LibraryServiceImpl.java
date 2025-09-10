package net.koreate.library.service;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.library.dao.LibraryMapper;
import net.koreate.library.vo.LibraryVO;

@Service
@RequiredArgsConstructor
public class LibraryServiceImpl implements LibraryService {

	private final LibraryMapper lm;
	
	@Override
	public void modifyLibraryInfo(LibraryVO vo) throws Exception {
		lm.libraryInfoUpdate(vo);
	}

	@Override
	public LibraryVO getLibraryInfo() throws Exception {
		return lm.libraryInfo();
	}

}
