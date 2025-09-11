package net.koreate.board.service;

import java.util.Map;

import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;

public interface NoticeService {
	
	/**
	 * 전달 받은 공지글 정보를 notice 테이블에 입력
	 * 
	 * @param vo 등록할 공지 사항 정보
	 */
	String write(BoardVO vo) throws Exception;
	
	/**
	 * 전달 받은 공지글 번호로 공지글 검색 후 수정할 정보로 업데이트
	 * 
	 * @param vo 수정할 공지글 정보가 저장된 BoardVO 객체
	 * @return 
	 */
	void update(BoardVO vo) throws Exception;
	
	/**
	 * 전달 받은 공지글 번호로 공지글 검색 후 n_status 컬럼 'N'으로 업데이트
	 * 
	 * @param nno 삭제 처리할 공지글 번호
	 */
	String delete(int nno) throws Exception;
	
	/**
	 * 전달 받은 공지글 번호로 공지글 검색 후 정보 반환
	 * 
	 * @param nno 검색할 공지글 번호
	 * @return 검색된 하나의 공지글 정보
	 */
	BoardVO getDetail(int nno) throws Exception;
	
	/**
	 * @param pageNum 요청 페이지 번호
	 * @return cri에 저장된 페이징 정보를 이용하여 검색된 공지 사항 목록 리스트와 
	 * 		   페이징 블럭 출력을 위한 PageMaker 객체를 Map에 저장 후 반환
	 */
	Map<String, Object> list(Criteria cri) throws Exception;

}
