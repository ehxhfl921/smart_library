package net.koreate.user.vo;

import lombok.Data;

@Data
public class UserVO {

	private int mno;         // 회원 번호
	private String id;       // 아이디
	private String pw;       // 비밀번호
	private String name;     // 이름
	private String phone;    // 전화번호
	private String email;    // 이메일
	private String addr;     // 주소
	private String info;	 // 개인 정보 이용 동의 여부
	private String status;   // 계정 활성화 여부
}
