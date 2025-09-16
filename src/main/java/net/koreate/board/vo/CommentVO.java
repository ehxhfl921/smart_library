package net.koreate.board.vo;

import lombok.Data;

/**
 * 	건의 사항 댓글 테이블 행 정보 저장용 클래스
 */
@Data
public class CommentVO {

	
	private int rpl_no;					// 댓글 번호			 
	private int sug_no;					// 댓글이 작성된 건의 사항 게시글 번호
	private String user_id;				// 댓글 작성자 아이디
	private String content;				// 댓글 내용
	private String rpl_create_date;		// 댓글 작성 시간
	private String rpl_update_date;		// 댓글 수정 시간
	private String rpl_status;			// 댓글 삭제 여부
	
}
