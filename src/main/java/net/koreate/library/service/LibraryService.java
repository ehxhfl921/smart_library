package net.koreate.library.service;

import net.koreate.library.vo.LibraryVO;

public interface LibraryService {

	/**
	 * 전달 받은 객체에 저장된 도서관 정보(이용 안내)로 수정 처리
	 */
	void modifyLibraryInfo(LibraryVO vo) throws Exception;
}
