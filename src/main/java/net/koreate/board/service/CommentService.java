package net.koreate.board.service;

import java.util.Map;

import net.koreate.board.vo.CommentVO;
import net.koreate.common.utils.Criteria;

public interface CommentService {

	
	/**
	 *  댓글 등록 요청 처리
	 */
	void writeComment(CommentVO vo) throws Exception;
	
	/**
	 *  댓글 수정 처리
	 */
	void updateComment(CommentVO vo) throws Exception;

	/**
	 *  댓글 번호로 검색된 댓글의 상태 컬럼을 삭제됨('N')으로 업데이트
	 */
	void deleteComment(int rpl_no) throws Exception;
	
	/**
	 *  검색할 건의 사항 게시글 번호, cri에 저장된 페이징 정보를 이용하여
	 *  검색된 댓글 목록 리스트와 페이징 블럭 출력에 필요한 PageMaker 객체를 
	 *  Map에 저장하여 반환
	 */
	Map<String, Object> commentList(int sug_no, Criteria cri) throws Exception;
}
