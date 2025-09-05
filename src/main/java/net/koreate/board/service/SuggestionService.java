package net.koreate.board.service;

import java.util.Map;

import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;

public interface SuggestionService {

	/**
	 * 전달 받은 건의 사항 게시글 정보를 suggestion 테이블에 입력
	 * 
	 * @param vo 등록할 건의 사항 정보
	 */
	void write(BoardVO vo) throws Exception;
	
	/**
	 * 건의 사항 게시글 번호로 게시글 검색 후 수정할 정보로 업데이트,
	 * s_update_date 컬럼에 수정 시간 입력
	 * 
	 * @param vo 수정할 건의 사항 게시글 정보가 저장된 BoardVO 객체
	 */
	void update(BoardVO vo) throws Exception;
	
	/**
	 * 전달 받은 건의 사항 게시글 번호로 게시글 검색 후 
	 * s_status 컬럼 'N'으로 업데이트
	 * 
	 * @param nno 삭제 처리할 건의 사항 게시글 번호
	 */
	void delete(int sug_no) throws Exception;
	
	/**
	 * 전달 받은 건의 사항 게시글 번호로 게시글 검색 후 게시글 정보 반환
	 * 
	 * @param sug_no 검색할 건의 사항 게시글 번호
	 * @return 검색된 건의 사항 게시글 정보
	 */
	BoardVO getDetail(int sug_no) throws Exception;
	
	/**
	 * @return cri에 저장된 페이징 정보를 이용하여 검색된 건의 사항 목록 리스트와 
	 * 		   페이징 블럭 출력을 위한 PageMaker 객체를 Map에 저장 후 반환
	 */
	Map<String, Object> list(Criteria cri) throws Exception;
	
}
