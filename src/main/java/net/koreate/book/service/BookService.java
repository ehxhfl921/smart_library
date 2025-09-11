package net.koreate.book.service;

import java.util.List;
import java.util.Map;

import net.koreate.book.vo.BookVO;
import net.koreate.common.utils.Criteria;

public interface BookService {

	/**
	 * cri에 저장된 페이징 정보, 사용자가 검색한 키워드를 이용하여 검색한 도서 목록과
	 * 페이징 블럭 출력을 위한 PageMaker 객체를 Map에 저장 후 반환
	 * 
	 * @param cri 		페이징 정보
	 * @param keyword	검색 키워드
	 * @return			페이징 처리된 키워드 포함 도서 목록, 페이징 블럭 출력용 PageMaker 객체가 저장된 Map 객체
	 */
    Map<String, Object> getSerchBookList(Criteria cri, String keyword) throws Exception;
	
	/**
	 * cri에 저장된 페이징 정보를 이용하여 검색한 모든 도서 목록과
	 * 페이징 블럭 출력을 위한 PageMaker 객체를 Map에 저장 후 반환
	 * 
	 * @param cri 		페이징 정보
	 * @return			페이징 처리된 전체 도서 목록, PageMaker 객체가 저장된 Map 객체
	 */
    Map<String, Object> getAllBookList(Criteria cri) throws Exception;
	
	/**
	 * 전달 받은 도서 번호로 도서 정보 검색 후 BookVO 객체에 저장 후 반환
	 * 
	 * @param bno 상세 페이지 요청 받은 도서 번호
	 * @return 도서 번호가 일치하는 하나의 도서 정보가 저장된 BookVO 객체
	 */
	BookVO getBookDetail(int bno) throws Exception;

	/**
	 * 전달 받은 도서 정보를 도서 테이블에 등록
	 * 
	 * @param vo 새로 등록할 도서 정보
	 */
	void registerBook(BookVO vo) throws Exception;
	
	/**
	 * 전달 받은 도서 정보로 업데이트
	 * 
	 * @param vo 수정할 도서 정보
	 */
	void modifyBook(BookVO vo) throws Exception;
	
	/**
	 * 삭제 요청된 도서 번호와 일치하는 도서의 b_status 컬럼 'N'으로 업데이트(삭제 처리)
	 * 
	 * @param bno 삭제 처리할 도서 번호
	 */
	void removeBook(int bno) throws Exception;
	
	/**
	 * 전달 받은 도서 정보를 이달의 도서 테이블에 입력
	 * 
	 * @param vo 이달의 도서로 등록할 도서의 정보
	 */
	void regieterBOM(BookVO vo) throws Exception;
	
	/**
	 * 전달 받은 도서 번호로 이달의 도서 테이블에서 삭제 처리할 도서 검색 후
	 * bom_status 컬럼 'N'으로 업데이트(삭제 처리)
	 * 
	 * @param bno 이달의 도서에서 제외할 도서 번호
	 */
	void removeFromBOM(int bno) throws Exception;
	
	/**
	 * 전달 받은 도서 번호로 해당 도서가 이달의 도서로 등록된 상태인지 문자열로 반환
	 * 
	 * @param bno
	 */
	String getBomStatus(int bno) throws Exception;
	
	/**
	 * 이달의 도서 전체 목록 조회
	 */
	List<BookVO> getBomList() throws Exception;
	
	/**
	 * 전달 받은 도서 번호, cri에 저장된 페이징 정보로 도서 대출 테이블에서 대출 내역 검색 후
	 * 페이징 처리된 해당 도서의 대출 내역 리스트, 페이징 블럭 출력용 PageMaker 객체 반환
	 *  
	 * @param bno	도서 대출 내역 조회할 도서 번호
	 * @param cri	페이징 정보
	 * @return		페이징 처리된 대출 내역 리스트와 pm 객체를 Map에 저장 후 반환
	 */
	Map<String, Object> getLoanListOfBook(int bno, Criteria cri) throws Exception;
	
	/**
	 * 로그인 사용자의 아이디, cri에 저장된 페이징 정보로 도서 대출 테이블에서 대출 내역 검색 후
	 * 페이징 처리된 로그인 사용자의 도서 대출 내역 리스트, 페이징 블럭 출력용 PageMaker 객체 반환
	 * 
	 * @param user_id	도서 대출 내역 조회할 사용자 아이디
	 * @param cri		페이징 정보
	 * @return			페이징 처리된 사용자의 대출 내역 리스트와 pm 객체를 Map에 저장 후 반환 
	 */
	Map<String, Object> getLoanListOfUser(String user_id, Criteria cri) throws Exception;
}
