package net.koreate.board.vo;

import java.util.Date;

import lombok.Data;

/**
 * 	공지 사항 및 건의 사항 테이블 행 정보 저장용 클래스
 */
@Data
public class BoardVO {

	private int rnum;			// 목록 출력 시 행 번호 저장
	
	private int nno; 			// 공지 사항 게시글 번호
	private String n_title;		// 공지 사항 제목
	private String n_author;	// 공지 사항 작성자
	private String n_content;	// 공지 사항 내용
	private Date n_create_date;	// 공지 사항 작성 시간
	private String n_status;	// 공지 사항 삭제 여부
	
	private int sug_no;			// 건의 사항 게시글 번호
	private String s_title;		// 건의 사항 제목
	private String s_userid;	// 건의 사항 작성자 아이디
	private String s_author;	// 건의 사항 작성자 이름
	private String s_content;	// 건의 사항 내용
	private Date s_create_date;	// 건의 사항 작성 시간
	private Date s_update_date;	// 건의 사항 작성 시간
	private String s_status;	// 건의 사항 삭제 여부
	
}
