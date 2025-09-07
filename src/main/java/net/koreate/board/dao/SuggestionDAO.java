package net.koreate.board.dao;

import java.util.List;

import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;

/**
 * 	건의 사항 관련 DB 작업
 */
public interface SuggestionDAO {
	/**
	 * 검색 시작 행 번호와 출력할 행 개수로
	 * suggestion 테이블에서 페이징 처리된 건의 사항 목록 조회
	 * 
	 * @param cri 페이징 처리 정보
	 * @return 페이징 처리된 건의 사항 게시글 목록
	 */
	List<BoardVO> suggestionList(Criteria cri) throws Exception;

	/**
	 * 건의 사항 게시글 번호로 suggestion 테이블에서 하나의 게시글 정보 조회
	 * 
	 * @param sug_no - 건의 사항 게시글 번호
	 * @return 검색된 게시글 정보 반환
	 */
	BoardVO suggestionDetail(int sug_no) throws Exception;
	
	/**
	 *  suggestion 테이블에 s_title, s_userid, s_author, s_content 데이터 입력
	 *  
	 * @param vo 테이블에 등록할 건의 사항 게시글 정보
	 */
	void suggestionWrite(BoardVO vo) throws Exception;
	
	/**
	 *  건의 사항 게시글 번호로 조회된 건의글의 정보를 요청 받은 정보로 업데이트
	 *  
	 *  @param vo 수정할 건의 사항 게시글 정보
	 */
	void suggsestionUpdate(BoardVO vo) throws Exception;

	/**
	 *  삭제 요청이 들어온 건의 사항 게시글 번호로 검색 후
	 *  s_status 컬럼 'N'으로 변경(삭제 처리)
	 *  
	 * @param sug_no
	 */
	void suggsestionDelete(int sug_no) throws Exception;
	
	
}


