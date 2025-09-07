package net.koreate.library.dao;

import net.koreate.library.vo.LibraryVO;

/**
 *  도서관 이용 안내(정보) 관련 DB 작업
 */
public interface LibraryMapper {

	/**
	 * 전달 받은 정보로 도서관 정보 업데이트
	 * 
	 * @param vo 수정할 정보를 담은 LibraryVO 타입 객체
	 */
	void libraryInfoUpdate(LibraryVO vo) throws Exception;
	
	/**
	 * 도서관 정보 조회
	 */
	LibraryVO libraryInfo() throws Exception;
	
}
