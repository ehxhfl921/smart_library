package net.koreate.room.vo;

import java.util.Date;

import lombok.Data;

/**
 * 스터디룸 & 스터디룸 예약 테이블 정보 저장용 클래스 
 */
@Data
public class RoomVO {
	private int sno;		// 스터디룸 번호
	private String s_name;	// 스터디룸 이름

	private int rno;			// 스터디룸 예약 번호
	private String user_id; 	// 예약자 아이디
	private String user_name;	// 예약자 이름
	private Date reserve_date;	// 예약 희망일
	private Date apply_date;	// 예약 신청일
	private String status;		// 스터디룸 예약 상태
}
