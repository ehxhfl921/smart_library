package net.koreate.user.service;

import java.util.Map;

import net.koreate.common.utils.Criteria;
import net.koreate.user.vo.UserVO;

public interface UserService {

	/**
	 * 회원 가입 - 전달 받은 회원 정보 회원 테이블에 입력
	 * 
	 * @param vo	가입 요청한 회원 정보
	 */
	
	void join(UserVO vo) throws Exception;
	
	/**
	 * 전달 받은 아이디와 비밀번호로 회원 정보 조회 후 로그인 처리
	 * 
	 * @param id	로그인할 사용자 아이디
	 * @param pw	로그인할 사용자 비밀번호
	 * @return		검색된 사용자의 정보를 UserVO 타입 객체에 저장 후 반환
	 */
	UserVO login(String id, String pw) throws Exception;
	
	/**
	 * 아이디 찾기(이메일 검증) - 전달 받은 이름, 이메일과 정보가 일치하는 회원의 이메일 반환
	 * 
	 * @param name	아이디 찾기 요청한 사용자 이름
	 * @param email	전달 받은 아이디 찾기용 이메일(인증 코드 전송할 이메일)
	 * @return		검색된 이메일 반환
	 */
	String checkAndGetEmailForId(String name, String email) throws Exception;
	
	/**
	 * 아이디 찾기 - 이메일 인증이 완료된 사용자의 이메일로 아이디 조회 후 반환
	 *  
	 * @param email	인증된 이메일
	 * @return		이메일이 일치하는 회원의 아이디
	 */
	String getId(String email) throws Exception;
	
	/**
	 * 비밀번호 찾기(이메일 검증) - 전달 받은 아이디, 이메일과 정보가 일치하는 회원의 이메일 반환
	 *  
	 * @param id	비밀번호 찾기 요청한 사용자 아이디
	 * @param email	전달 받은 비밀번호 찾기용 이메일(인증 코드 전송할 이메일)
	 * @return		검색된 이메일 반환
	 */
	String checkAndGetEmailForPw(String id, String email) throws Exception;
	
	/**
	 * 비밀번호 찾기(이메일 인증 완료 후) - 전달 받은 아이디로 회원 조회 후 새로운 비밀번호로 변경
	 * 
	 * @param id	전달 받은 아이디
	 * @param pw	변경할 새로운 비밀번호
	 */
	void resetPassword(String id, String pw) throws Exception;
	
	/**
	 * 관리자 : 회원 관리 - 회원 정보 상세 페이지 - 회원 정보 수정
	 * 사용자 : 마이페이지 - 내 회원 정보 - 회원 정보 수정
	 *  
	 * 전달 받은 회원 정보로 회원 정보 수정 처리
	 * 
	 * @param vo	수정할 회원 정보
	 */
	void modifyInfo(UserVO vo) throws Exception;
	
	/**
	 * 관리자 : 회원 관리 - 회원 정보 상세 페이지 - 회원 삭제
	 * 사용자 : 마이페이지 - 내 회원 정보 - 회원 탈퇴
	 * 
	 * 전달 받은 회원 번호로 회원 탈퇴 처리
	 * 
	 * @param mno	회원 번호
	 */
	void withdraw(int mno) throws Exception;
	
	/**
	 * 관리자 : 회원 관리 페이지
	 * cri에 저장된 페이징 정보를 이용하여 검색한 페이징 처리된 전체 회원 목록,
	 * 페이징 블럭 출력용 PageMaker 객체를 Map에 저장 후 반환
	 * 
	 * @param cri 	페이징 정보
	 * @return		페이징 처리된 회원 목록, PageMaker 객체를 Map에 저장 후 반환
	 */
	Map<String, Object> getMemberList(Criteria cri) throws Exception;
	
	/**
	 * 관리자 : 회원 관리 - 회원 정보 상세 페이지
	 * 전달 받은 회원 번호로 회원 정보 조회 후 반환
	 * 
	 * @param mno	회원 번호
	 * @return		회원 번호로 검색된 회원 정보를 담은 vo 객체
	 */
	UserVO getMemberDetail(int mno) throws Exception;
}
