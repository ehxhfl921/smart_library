package net.koreate.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;

/**
 * 	공지 사항 관련 DB 작업
 */
public interface NoticeMapper {

	/**
	 * 검색 시작 행 번호와 한 페이지에 출력할 행 개수로
	 * notice 테이블에서 페이징 처리된 공지 사항 목록 조회
	 * 
	 * @param cri 페이징 처리 정보
	 * @return 페이징 처리된 공지 사항 게시글 목록
	 */
	@Select("SELECT * FROM notice " +
	        "WHERE n_status = 'Y' " +
	        "ORDER BY nno DESC " +
	        "OFFSET #{startRow} ROWS FETCH NEXT #{perPageNum} ROWS ONLY")
	List<BoardVO> noticeList(Criteria cri) throws Exception;
	
	/**
	 * 공지 사항 게시글 번호로 notice 테이블에서 하나의 게시글 정보 조회
	 * 
	 * @param nno 공지 사항 게시글 번호
	 * @return 검색된 게시글 정보 반환
	 */
	@Select("SELECT * FROM notice WHERE nno = #{nno}")
	BoardVO noticeDetail(int nno) throws Exception;
	
	/**
	 * notice 테이블에 n_title, n_author, n_content 데이터 입력
	 * 
	 * @param vo 테이블에 등록할 공지 사항 게시글 정보
	 */
	@Insert("INSERT INTO notice(n_title, n_author, n_content) "
			+ " VALUES(#{n_title}, #{n_author}, #{n_content})")	
	void writeNotice(BoardVO vo) throws Exception;
	
	/**
	 * 공지 사항 번호로 조회된 공지글의 정보를 요청 받은 정보로 업데이트
	 * 
	 * @param vo 수정할 공지 사항 정보
	 */
	@Update("UPDATE notice SET "
			+ " n_title = #{n_title} , "
			+ " n_content = #{n_content} , "
			+ " WHERE nno = #{nno}")
	void updateNotice(BoardVO vo) throws Exception;

	/**
	 *  삭제 요청한 공지 사항 게시글 번호로 게시글 검색 후
	 *  n_status 컬럼 'N'으로 변경 (삭제 처리)
	 * @param nno
	 * @throws Exception
	 */
	@Update("UPDATE notice SET n_status = 'N' WHERE nno = #{nno}")
	void deleteNotice(int nno) throws Exception;
	
	
}
