package net.koreate.book.dao;

import java.util.List;

import net.koreate.book.vo.BookVO;
import net.koreate.common.utils.Criteria;

/**
 * 	도서, 이달의 도서 관련 DB 작업 
 */
public interface BookDAO {

	/**
	 *  키워드로 도서 검색/목록 출력(페이징)
	 *  전체 도서 목록 출력(페이징 처리)
	 *  도서 번호로 도서 상세 정보 출력
	 *  도서 등록/수정/삭제
	 *  이달의 도서로 등록/삭제
	 *  
	 *  도서 테이블 전체 행 개수 조회 (관리자 - 도서 관리 페이지 도서 목록)
	 *  도서 테이블에서 특정 키워드가 포함된 행의 개수 조회(사용자 - 도서 검색 후 도서 목록 페이지)
	 */
	
	/**
	 * 사용자가 입력한 키워드가 제목이나 작가에 포함된 도서 목록 조회 (페이징 처리)
	 * 
	 * @param keyword 검색할 키워드
	 * @param cri 페이징 정보
	 * @return 키워드가 제목 혹은 작가에 포함된 도서 목록
	 */
	List<BookVO> serchBookList(Criteria cri, String keyword) throws Exception;
	
	/**
	 * 페이징 처리된 전체 도서 목록 조회
	 * 
	 * @param cri 페이징 정보
	 * @return 전체 도서 목록
	 */
	List<BookVO> allBookList(Criteria cri) throws Exception;
	
	/**
	 * 도서 번호로 도서 상세 정보 조회
	 * 
	 * @param bno 검색할 도서 번호
	 * @return 검색된 도서 정보를 담은 BookVO 객체
	 */
	BookVO bookDetail(int bno) throws Exception;
	
	/**
	 * 전달 받은 도서 정보를 도서 테이블에 등록
	 * @param vo 새로 등록할 도서 정보를 담은 BookVO 객체
	 */
	void addBook(BookVO vo) throws Exception;
	
	/**
	 * 도서 번호로 검색 후 전달 받은 도서 정보로 업데이트(수정)
	 * 
	 * @param vo 수정할 도서 정보가 담긴 객체
	 */
	void updateBook(BookVO vo) throws Exception;
	
	/**
	 * 도서 번호로 검색 후 해당 도서 상태 컬럼(b_status) 'N'으로 업데이트(삭제 처리)
	 * 
	 * @param vo 삭제
	 */
	void deleteBook(int bno) throws Exception;
	
	/**
	 * 전달 받은 도서 정보를 이달의 도서 테이블에 등록
	 * 
	 * @param vo 이달의 도서로 등록할 도서의 정보를 담은 객체
	 */
	void regieterBOM(BookVO vo) throws Exception;
	
	/**
	 * 이달의 도서 테이블에서 도서 번호로 검색 후
	 * 해당 도서의 bom_status를 'N'으로 변경(이달의 도서에서 제거 처리)
	 * @param bno
	 * @throws Exeption
	 */
	void removeFromBOM(int bno) throws Exception;
	
	/**
	 * 도서 테이블의 전체 행 개수 조회(N 상태인 도서 제외하고 카운트)
	 * 
	 * @return 전체 도서 개수
	 */
	int countAllBooks() throws Exception;
	
	/**
	 * 제목이나 저자에 검색 키워드가 포함된 행 개수 조회
	 * @return 검색 키워드가 포함된 행의 전체 개수
	 */
	int countSearchBook(String keyword) throws Exception;
}
