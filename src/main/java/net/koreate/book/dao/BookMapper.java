package net.koreate.book.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.book.vo.BookVO;
import net.koreate.common.utils.Criteria;

/**
 * 	도서, 이달의 도서 관련 DB 작업 
 */
public interface BookMapper {

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
	@Select("SELECT * FROM book WHERE title LIKE '%' || #{keyword} || '%' OR "
			+ "author LIKE '%' || #{keyword} || '%' AND b_status = 'Y' "
			+ "ORDER BY bno DESC "
			+ "OFFSET #{cri.startRow} ROWS FETCH NEXT #{cri.perPageNum} ROWS ONLY")
	List<BookVO> serchBookList(Criteria cri, String keyword) throws Exception;
	
	/**
	 * 페이징 처리된 전체 도서 목록 조회
	 * 
	 * @param cri 페이징 정보
	 * @return 전체 도서 목록
	 */
	@Select("SELECT * FROM book WHERE b_status = 'Y' ORDER BY bno DESC "
			+ "OFFSET #{cri.startRow} ROWS FETCH NEXT #{cri.perPageNum} ROWS ONLY")
	List<BookVO> allBookList(Criteria cri) throws Exception;
	
	/**
	 * 도서 번호로 도서 상세 정보 조회
	 * 
	 * @param bno 검색할 도서 번호
	 * @return 검색된 도서 정보를 담은 BookVO 객체
	 */
	@Select("SELECT * FROM book WHERE bno = #{bno}")
	BookVO bookDetail(int bno) throws Exception;
	
	/**
	 * 전달 받은 도서 정보를 도서 테이블에 등록
	 * @param vo 새로 등록할 도서 정보를 담은 BookVO 객체
	 */
	@Insert("INSERT INTO book(title, author, publisher, p_date, cover) "
			+ "VALUES(#{title}, #{author}, #{publisher}, #{p_date}, #{cover}")
	void addBook(BookVO vo) throws Exception;
	
	/**
	 * 도서 번호로 검색 후 전달 받은 도서 정보로 업데이트(수정)
	 * 
	 * @param vo 수정할 도서 정보가 담긴 객체
	 */
	@Update("UPDATE book SET "
			+ "title = #{title}, author = #{author}, publisher = #{publisher}, "
			+ "p_date = #{p_date}, cover = #{cover} "
			+ "WHERE bno = #{bno}")
	void updateBook(BookVO vo) throws Exception;
	
	/**
	 * 도서 번호로 검색 후 해당 도서 상태 컬럼(b_status) 'N'으로 업데이트(삭제 처리)
	 * 
	 * @param bno 삭제할 도서 번호
	 */
	@Update("UPDATE book SET b_status = 'N' WHERE bno = #{bno}")
	void deleteBook(int bno) throws Exception;
	
	/**
	 * 전달 받은 도서 정보를 이달의 도서 테이블에 등록
	 * 
	 * @param vo 이달의 도서로 등록할 도서의 정보를 담은 객체
	 */
	@Update("INSERT INTO book_of_the_month(bno, title, author, publisher, p_date, cover) "
			+ "VALUES(#{bno}, #{title}, #{author}, #{publisher}, #{p_date}, #{cover})")
	void regieterBOM(BookVO vo) throws Exception;
	
	/**
	 * 이달의 도서 테이블에서 도서 번호로 검색 후
	 * 해당 도서의 bom_status를 'N'으로 변경(이달의 도서에서 제거 처리)
	 * @param bno
	 */
	@Update("UPDATE book_of_the_month SET bom_status = 'N' WHERE bno = #{bno}")
	void removeFromBOM(int bno) throws Exception;
	
	/**
	 * 이달의 도서 전체 목록 조회
	 * @return 리스트로 반환
	 */
	@Select("SELECT * FROM book_of_the_month ORDER BY bom_no DESC WHERE bom_status = 'Y'")
	List<BookVO> bookOfTheMonthList() throws Exception;
	
	/**
	 * 도서 테이블의 전체 행 개수 조회(N 상태인 도서 제외하고 카운트)
	 * 
	 * @return 전체 도서 개수
	 */
	@Select("SELECT count(*) FROM book WHERE b_status = 'Y'")
	int countAllBooks() throws Exception;
	
	/**
	 * 제목이나 저자에 검색 키워드가 포함된 행 개수 조회
	 * @return 검색 키워드가 포함된 행의 전체 개수
	 */
	@Select("SELECT count(*) FROM book WHERE title LIKE '%' || #{keyword} || '%' OR "
			+ "author LIKE '%' || #{keyword} || '%' AND b_status = 'Y'")
	int countSearchBook(String keyword) throws Exception;
}
