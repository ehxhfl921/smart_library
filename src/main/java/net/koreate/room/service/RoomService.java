package net.koreate.room.service;

import java.util.Date;
import java.util.Map;

import net.koreate.common.utils.Criteria;
import net.koreate.room.vo.RoomVO;

public interface RoomService {

	/**
	 * 사용자가 예약 희망하는 날짜 선택 시 해당 날짜로 예약된(예약 테이블에 존재하고 상태가 'APPROVED'인) 스터디룸 예약 리스트,
	 * 스터디룸(studyroom 테이블) 정보(sno, s_name) 리스트를 Map에 저장 후 반환
	 * 
	 * ※ 스터디룸 정보 리스트 	: 스터디룸 목록 출력용
	 * ※ 스터디룸 예약 정보 리스트 : 스터디룸 예약 가능/불가 여부 구분용 
	 * ※ 뷰 페이지에서 두 리스트의 스터디룸 번호(sno)를 비교 -> 예약 리스트에 sno가 존재하는 스터디룸은 예약 불가 표시,
	 * 											   예약 리스트에 sno가 없는(해당 날짜에 예약이 없는) 스터디룸은 예약 가능 표시
	 * 
	 * @param reserve_date 	사용자가 스터디룸을 예약하고자 하는 날짜
	 * @return 선택 날짜에 예약된 스터디룸들의 리스트, 스터디룸 정보 리스트를 Map에 저장 후 반환
	 */
	Map<String, Object> getRoomsByDate(Date reserve_date) throws Exception;
	
	/**
	 * 전달 받은 예약 정보를 스터디룸 예약 테이블에 입력
	 * 
	 * @param vo	스터디룸 예약 정보를 담은 RoomVO 타입 객체 
	 */
	void makeReservation(RoomVO vo) throws Exception;
	
	/**
	 * 전달 받은 예약 번호로 검색된 스터디룸 예약 신청 승인 처리 (status 컬럼 'APPROVED'로 업데이트) 후
	 * 같은 날, 같은 스터디룸에 대한 다른 예약 신청은 모두 거절 처리 (status 컬럼 'REJECTED'로 업데이트)
	 * 
	 * ※ 예약 승인 처리 -> 예약 번호(rno)로 하나의 예약 정보 검색 후 RoomVO 타입 객체에 저장 
	 * 	  -> vo에 저장된 sno, reserve_date와 예약 번호(rno)를 이용해 나머지 예약 거절 처리
	 * 
	 * @param rno	예약 신청을 승인할 스터디룸 예약 번호
	 */
	void approveReservation(int rno) throws Exception;
	
	/**
	 * 전달 받은 예약 번호로 검색된 스터디룸 예약 신청 거절 처리
	 * (status 컬럼 'APPROVED'로 업데이트)
	 * 
	 * @param rno	예약 신청을 승인할 스터디룸 예약 번호
	 */
	void rejectReservation(int rno) throws Exception;
	
	/**
	 * 전달 받은 예약 번호로 검색된 스터디룸 예약 취소 처리
	 * (status 컬럼 'CANCELED'로 업데이트)
	 * 
	 * @param rno 	예약 취소할 스터디룸 예약 번호 
	 */
	void cancelReservation(int rno) throws Exception;
	
	/**
	 * 관리자 전용 스터디룸 예약 관리 페이지
	 * cri에 저장된 페이징 정보로 페이징 처리된 스터디룸 예약 목록 List<RoomVO> 객체,
	 * 페이징 블럭 출력용 PageMaker 객체를 Map에 저장 후 반환
	 * 
	 * @param cri	페이징 정보
	 * @return		페이징 처리된 스터디룸 예약 목록, PageMaker 객체를 Map에 저장 후 반환
	 */
	Map<String, Object> getReservationList(Criteria cri) throws Exception;

	/**
	 * 내 서재 - 스터디룸 이용 내역
	 * cri에 저장된 페이징 정보, 전달 받은 사용자 아이디로 스터디룸 예약 테이블에서 예약 내역 조회
	 * 검색된 처리된 사용자의 스터디룸 예약 내역 List<RoomVO> 객체, 페이징 블럭 출력용 PageMaker 객체를 Map에 저장 후 반환 
	 * 
	 * @param user_id	스터디룸 이용 내역을 조회할 사용자 아이디
	 * @param cri		페이징 정보
	 * @return			페이징 처리된 사용자의 스터디룸 예약 목록, PageMaker 객체를 Map에 저장 후 반환			
	 */
	Map<String, Object> getMyReservation(String user_id, Criteria cri) throws Exception;

}
