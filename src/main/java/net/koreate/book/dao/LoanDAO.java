package net.koreate.book.dao;

import java.util.List;

import net.koreate.book.vo.BookVO;

/**
 * 	도서 대출 관련 DB 작업
 */
public interface LoanDAO {

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
	 * @throws Exception
	 */
	List<BookVO> loanListOfBook(int bno) throws Exception;
	
	/**
	 * 로그인 사용자의 아이디를 전달받아 해당 사용자의 도서 대출 내역을 조회 후 리스트로 반환(페이징 처리)
	 * 
	 * @param user_id 대출 내역을 검색할 사용자 아이디
	 * @return 해당 사용자의 도서 대출 내역(목록)
	 */
	List<BookVO> loanListOfUser(String user_id) throws Exception;
	
	/**
	 * 도서 대출 테이블에서 대출자 아이디가 로그인 사용자의 아이디와 일치하는 행 개수 조회
	 * 
	 * @param user_id 대출 내역을 조회할 사용자 아이디
	 * @return 해당 사용자의 대출 내역의 전체 개수
	 */
	int countUsersLoanList(String user_id) throws Exception;
	
	/**
	 * 도서 대출 테이블에서 도서 번호가 일치하는 행 개수 조회
	 * 
	 * @param bno 대출 내역을 조회할 도서의 번호
	 * @return 해당 도서의 대출 내역의 전체 개수
	 */
	int countLoanListOfBook(int bno) throws Exception;

}
