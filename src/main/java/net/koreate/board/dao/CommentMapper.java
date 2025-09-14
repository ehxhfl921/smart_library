package net.koreate.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.board.vo.CommentVO;
import net.koreate.common.utils.Criteria;

/**
 * 	건의 사항 댓글 관련 DB 작업
 */
public interface CommentMapper {

	/**
	 * 건의 사항 게시글 번호, 페이징 정보로 해당 건의 사항에 작성된 댓글 목록 조회
	 * @param sug_no 건의 사항 게시글 번호
	 * @return 해당 건의 사항에 작성된 댓글 목록
	 */
	@Select("SELECT * FROM suggestion_reply WHERE sug_no = #{sug_no} AND rpl_status = 'Y' "
			+ "ORDER BY rpl_no "
			+ "OFFSET #{cri.startRow} ROWS FETCH NEXT #{cri.perPageNum} ROWS ONLY")
	List<CommentVO> commentList(@Param("sug_no") int sug_no, @Param("cri") Criteria cri) throws Exception;
	
	/**
	 * suggestion_reply 테이블에 sug_no, user_id, content 데이터 입력
	 * @param vo 테이블에 등록할 댓글 정보를 담은 객체
	 */
	@Insert("INSERT INTO suggestion_reply(sug_no, user_id, content) "
			+ "VALUES(#{sug_no}, #{user_id}, #{content})")
	void writeComment(CommentVO vo) throws Exception;
	
	/**
	 * 댓글 번호로 suggestion_reply 테이블에서 댓글 조회 후 content 데이터 업데이트,
	 * rpl_update_date 컬럼에 수정 시간 삽입
	 * @param vo 수정할 댓글 정보를 담은 객체
	 */
	@Update("UPDATE suggestion_reply SET content = #{content}, rpl_update_date = SYSTIMESTAMP "
			+ "WHERE rpl_no = #{rpl_no}")
	void updateComment(CommentVO vo) throws Exception; 
	
	/**
	 * 댓글 번호로 suggestion_reply 테이블에서 댓글 조회 후
	 * rpl_status 컬럼 'N'으로 업데이트
	 * @param rpl_no 삭제 상태로 변경할 댓글 번호
	 */
	@Update("UPDATE suggestion_reply SET rpl_status = 'N' WHERE rpl_no = #{rpl_no}")
	void deleteComment(int rpl_no) throws Exception;
	
	/**
	 * 해당 건의 사항 게시글에 등록된 전체 댓글 개수
	 * @param sug_no 검색할 게시글 번호
	 * @return 등록된 전체 댓글 개수
	 */
	@Select("SELECT count(*) FROM suggestion_reply WHERE sug_no = #{sug_no} AND rpl_status = 'Y'")
	int totalCount(int sug_no) throws Exception;
}
