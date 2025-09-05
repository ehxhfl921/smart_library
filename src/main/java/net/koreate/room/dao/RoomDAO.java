package net.koreate.room.dao;

import java.util.Date;
import java.util.List;

import net.koreate.common.utils.Criteria;
import net.koreate.room.vo.RoomVO;

/**
 *  스터디룸 관련 DB 작업 
 */
public interface RoomDAO {

	/*
	 	스터디룸 테이블에서 스터디룸 정보 조회
	 	전달 받은 날짜(예약 희망일)로 예약 테이블에서 스터디룸 예약 정보 조회 (해당 날짜의 스터디룸 예약 리스트 반환)
	 	전달 받은 스터디룸 번호와 예약자 아이디, 예약 희망일, 예약 신청일을 예약 테이블에 입력
	 	스터디룸 예약 테이블에서 로그인 사용자 아이디로 스터디룸 예약 내역 조회: 최근 순으로 정렬(사용자 - 내 서재 스터디룸 이용 내역)
	 	스터디룸 예약 내역 전체 목록 조회: 최근 순으로 정렬(관리자 - 스터디룸 예약 관리)
	 	전달 받은 스터디룸 예약 번호로 예약 승인/거절 처리(관리자 - 스터디룸 예약 관리)
	 	전달 받은 스터디룸 예약 번호로 예약 취소 처리(관리자 - 스터디룸 예약 관리, 사용자 - 내 서재 스터디룸 이용 내역)
	 */
	
	/**
	 * studyroom 테이블에서 스터디룸 정보 조회
	 * @return 조회된 스터디룸 정보를 RoomVO 타입 객체에 저장 후 리스트로 반환
	 */
	List<RoomVO> rooms() throws Exception;
	
	/**
	 * 사용자가 예약 희망하는 날짜 정보를 전달 받아서 예약 테이블에서 조회
	 * 조회된 예약들을 리스트로 반환
	 * 
	 * @param reserve_date	전달 받은 사용자가 예약하려는 날짜
	 * @return				해당 날짜의 스터디룸 예약 정보 리스트
	 */
	List<RoomVO> searchReservationByDate(Date reserve_date) throws Exception;
	
	/**
	 * 전달 받은 스터디룸 예약 정보를 예약 테이블에 입력
	 * 
	 * @param vo	스터디룸 예약 정보를 담은 RoomVO 타입 객체
	 */
	void makeReservation(RoomVO vo) throws Exception;
	
	/**
	 * 스터디룸 예약 테이블에서 로그인 사용자 아이디와 예약자 아이디가 일치하는 예약 내역 조회
	 * 최근 순으로 정렬하여 페이징 처리된 리스트로 반환
	 * 
	 * @param user_id	스터디룸 이용 내역을 조회할 사용자 아이디(예약자 아이디)
	 * @param cri		페이징 정보
	 * @return			페이징 처리된 로그인 사용자의 스터디룸 이용(예약) 내역 리스트 반환
	 */
	List<RoomVO> myReservationList(String user_id, Criteria cri) throws Exception;
	
	/*
	 	스터디룸 예약 내역 전체 목록 조회: 최근 순으로 정렬(관리자 - 스터디룸 예약 관리)
	 	전달 받은 스터디룸 예약 번호로 예약 승인/거절 처리(관리자 - 스터디룸 예약 관리)
	 	전달 받은 스터디룸 예약 번호로 예약 취소 처리(관리자 - 스터디룸 예약 관리, 사용자 - 내 서재 스터디룸 이용 내역)
	 */
	/**
	 * 스터디룸 예약 내역 전체 조회 - rno 최근 순으로 정렬
	 * 
	 * @param cri	페이징 정보
	 * @return		페이징 처리된 모든 스터디룸 예약 내역 리스트로 반환
	 */
	List<RoomVO> reservationList(Criteria cri) throws Exception;
	
	/**
	 * 전달 받은 스터디룸 예약 번호로 예약 승인 처리 - status 컬럼 'APPROVE'로 변경
	 * 
	 * @param rno	예약 승인할 스터디룸 예약 번호
	 */
	void acceptReservation(int rno) throws Exception;
	
	
}
