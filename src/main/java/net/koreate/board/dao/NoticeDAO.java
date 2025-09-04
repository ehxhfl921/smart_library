package net.koreate.board.dao;

import java.util.List;

import net.koreate.board.vo.BoardVO;

/**
 * 	공지 사항 목록 조회
 *	공지 사항 상세 페이지 조회
 *	작성 요청 시 테이블에 데이터 삽입
 *	수정 요청 시 테이블 데이터 업데이트
 *	삭제 요청 시 n_status 컬럼 'N'으로 업데이트
 */
public interface NoticeDAO {

	/**
	 * 검색 시작 행 번호와 한 페이지에 출력할 행 개수로
	 * notice 테이블에서 페이징 처리된 공지 사항 목록 조회
	 * 
	 * @param startRow 	 검색 시작 행 번호
	 * @param perPageNum 한 페이지에 출력할 행 개수
	 * @return 페이징 처리된 공지 사항 게시글 목록
	 */
	List<BoardVO> noticeList(int startRow, int perPageNum) throws Exception;
	
	/**
	 * 공지 사항 게시글 번호로 notice 테이블에서 하나의 게시글 정보 조회
	 * 
	 * @param nno 공지 사항 게시글 번호
	 * @return 검색된 게시글 정보 반환
	 */
	BoardVO noticeDetail(int nno) throws Exception;
	
	/**
	 * notice 테이블에 n_title, n_author, n_content 데이터 입력
	 * 
	 * @param vo 테이블에 등록할 공지 사항 게시글 정보
	 */
	void writeNotice(BoardVO vo) throws Exception;
	
	/**
	 * 공지 사항 번호로 조회된 공지글의 정보를 요청 받은 정보로 업데이트
	 * 
	 * @param nno 공지 사항 번호
	 * @param vo 수정할 공지 사항 정보
	 */
	void updateNotice(int nno, BoardVO vo) throws Exception;
	
	
}
