package net.koreate.book.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import net.koreate.book.vo.BookVO;
import net.koreate.common.utils.Criteria;

/**
 * 	도서 대출 관련 DB 작업
 */
public interface LoanMapper {

	/**
	 *  도서 대출 테이블에서 도서 번호로 해당 도서 대출 내역(목록) 출력(페이징 처리)
	 *  도서 대출 테이블에서 회원 아이디로 로그인 사용자의 도서 대출 내역(목록) 출력(페이징 처리)
	 *  
	 *  도서 대출 테이블에서 회원 아이디가 일치하는 행 개수 조회 (사용자 - 내 서재 도서 대출 내역)
	 *  도서 대출 테이블에서 도서 번호가 일치하는 행 개수 조회 (관리자 - 도서 상세 페이지 해당 도서 대출 내역)
	 */
	
	/**
	 * 도서 번호로 해당 도서의 대출 기록을 대출 테이블에서 검색 후 리스트로 반환 (페이징 처리)
	 * 
	 * @param bno 대출 기록을 확인할 도서 번호
	 */
	@Select("SELECT bl.loan_no, bl.user_id, bl.loan_status, bl.borrow_date, bl.return_date, "
			+ "u.name "
			+ "FROM book_loan bl "
			+ "INNER JOIN member u ON bl.user_id = u.id "
			+ "WHERE bl.bno = #{bno} ORDER BY loan_no DESC "
			+ "OFFSET #{cri.startRow} ROWS FETCH NEXT #{cri.perPageNum} ROWS ONLY")
	List<BookVO> loanListOfBook(@Param("bno") int bno, @Param("cri") Criteria cri) throws Exception;
	
	/**
	 * 로그인 사용자의 아이디를 전달받아 해당 사용자의 도서 대출 내역을 조회 후 리스트로 반환(페이징 처리)
	 * 도서 번호로 도서 테이블에서 제목, 저자도 같이 검색
	 * 
	 * @param user_id 대출 내역을 검색할 사용자 아이디
	 * @return 해당 사용자의 도서 대출 내역(목록)
	 */
	@Select("SELECT bl.loan_no, bl.loan_status, bl.borrow_date, bl.return_date, "
			+ "b.title, b.author "
			+ "FROM book_loan bl "
			+ "INNER JOIN book b ON bl.bno = b.bno "
			+ "WHERE bl.user_id = #{user_id} ORDER BY loan_no DESC "
			+ "OFFSET #{cri.startRow} ROWS FETCH NEXT #{cri.perPageNum} ROWS ONLY")
	List<BookVO> loanListOfUser(@Param("user_id") String user_id, @Param("cri") Criteria cri) throws Exception;
	
	/**
	 * 도서 대출 테이블에서 대출자 아이디가 로그인 사용자의 아이디와 일치하는 행 개수 조회
	 * 
	 * @param user_id 대출 내역을 조회할 사용자 아이디
	 * @return 해당 사용자의 대출 내역의 전체 개수
	 */
	@Select("SELECT count(*) FROM book_loan WHERE user_id = #{user_id}")
	int countUsersLoanList(String user_id) throws Exception;
	
	/**
	 * 도서 대출 테이블에서 도서 번호가 일치하는 행 개수 조회
	 * 
	 * @param bno 대출 내역을 조회할 도서의 번호
	 * @return 해당 도서의 대출 내역의 전체 개수
	 */
	@Select("SELECT count(*) FROM book_loan WHERE bno = #{bno}")
	int countLoanListOfBook(int bno) throws Exception;

}
