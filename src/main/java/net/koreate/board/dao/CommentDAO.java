package net.koreate.board.dao;

import java.util.List;

import net.koreate.board.vo.CommentVO;
import net.koreate.common.utils.Criteria;

/**
 * 	건의 사항 댓글 관련 DB 작업
 */
public interface CommentDAO {

	/**
	 * 건의 사항 게시글 번호로 해당 건의 사항에 작성된 댓글 목록 조회
	 * @param sug_no 건의 사항 게시글 번호
	 * @return 해당 건의 사항에 작성된 댓글 목록
	 */
	List<CommentVO> commentList(int sug_no, Criteria cri) throws Exception;
	
	/**
	 * suggestion_reply 테이블에 sug_no, user_id, content 데이터 입력
	 * @param vo 테이블에 등록할 댓글 정보를 담은 객체
	 */
	void writeComment(CommentVO vo) throws Exception;
	
	/**
	 * 댓글 번호로 suggestion_reply 테이블에서 댓글 조회 후 수정된 content 데이터 업데이트,
	 * rpl_update_date 컬럼에 수정 시간 삽입
	 * 
	 * @param rpl_no 업데이트 할 댓글 번호
	 * @param content 테이블에 업데이트 할 수정된 댓글 내용
	 */
	void updateComment(int rpl_no, String content) throws Exception; 
	
	/**
	 * 댓글 번호로 suggestion_reply 테이블에서 댓글 조회 후
	 * rpl_status 컬럼 'N'으로 업데이트
	 * @param rpl_no 삭제 상태로 변경할 댓글 번호
	 */
	void deleteComment(int rpl_no) throws Exception;
}
