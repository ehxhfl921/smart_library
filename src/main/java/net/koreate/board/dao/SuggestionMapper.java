package net.koreate.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;

/**
 *    건의 사항 관련 DB 작업
 */
public interface SuggestionMapper {
   /**
    * 검색 시작 행 번호와 출력할 행 개수로
    * suggestion 테이블에서 페이징 처리된 건의 사항 목록 조회
    * 
    * @param cri 페이징 처리 정보
    * @return 페이징 처리된 건의 사항 게시글 목록
    */
   @Select("SELECT * FROM suggestion " +
           "WHERE s_status = 'Y' " +
           "ORDER BY sug_no DESC " +
           "OFFSET #{startRow} ROWS FETCH NEXT #{perPageNum} ROWS ONLY")
   List<BoardVO> suggestionList(Criteria cri) throws Exception;

   /**
    * 건의 사항 게시글 번호로 suggestion 테이블에서 하나의 게시글 정보 조회
    * 
    * @param sug_no - 건의 사항 게시글 번호
    * @return 검색된 게시글 정보 반환
    */
   @Select("SELECT * FROM suggestion WHERE sug_no = #{sug_no}")
   BoardVO suggestionDetail(int sug_no) throws Exception;
   
   /**
    *  suggestion 테이블에 s_title, s_userid, s_author, s_content 데이터 입력
    *  
    * @param vo 테이블에 등록할 건의 사항 게시글 정보
    */
   @Insert("INSERT INTO notice(s_title, s_author, s_content, s_userid) "
         + " VALUES(#{s_title}, #{s_author}, #{s_content}, #{s_userid})")
   void suggestionWrite(BoardVO vo) throws Exception;
   
   /**
    *  건의 사항 게시글 번호로 조회된 건의글의 정보를 요청 받은 정보로 업데이트
    *  
    *  @param vo 수정할 건의 사항 게시글 정보
    */
   @Update("UPDATE suggestion SET "
         + " s_title = #{s_title} , "
         + " s_content = #{s_content} , "
         + " WHERE sug_no = #{sug_no}")
   void suggsestionUpdate(BoardVO vo) throws Exception;

   /**
    *  삭제 요청이 들어온 건의 사항 게시글 번호로 검색 후
    *  s_status 컬럼 'N'으로 변경(삭제 처리)
    *  
    * @param sug_no
    */
   @Update("UPDATE suggestion SET s_status = 'N' WHERE sug_no = #{sug_no}")
   void suggsestionDelete(int sug_no) throws Exception;
   
   /**
    * 전달 받은 사용자 아이디로 로그인 사용자가 작성한 건의 사항 목록 조회(페이징)
    * 
    * @param user_id   작성한 건의 사항 조회할 아이디
    * @param cri      페이징 정보
    */
   @Select("SELECT * FROM suggestions WHERE user_id = #{user_id} ORDER BY created_at DESC"
   		+ "LIMIT #{cri.perPageNum} OFFSET #{(cri.page - 1) * cri.perPageNum}")
   List<BoardVO> mySuggestion(@Param("user_id") String user_id, @Param("cri") Criteria cri) throws Exception;
   
   @Select("SELECT count(*) FROM notice WHERE s_status = 'Y'")
	int countSuggestion() throws Exception;
}


