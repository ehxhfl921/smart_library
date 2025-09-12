package net.koreate.room.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.common.utils.Criteria;
import net.koreate.room.vo.RoomVO;

/**
 *  스터디룸 관련 DB 작업 
 */
public interface RoomMapper {

	/**
	 * 	스터디룸 테이블에서 스터디룸 정보 조회
	 *	전달 받은 날짜(예약 희망일), 예약 상태(승인된 예약만)로 예약 테이블에서 스터디룸 예약 정보 조회
	 *	전달 받은 스터디룸 번호와 예약자 아이디, 예약 희망일, 예약 신청일을 예약 테이블에 입력
	 *	스터디룸 예약 테이블에서 로그인 사용자 아이디로 스터디룸 예약 내역 조회: 최근 순으로 정렬(사용자 - 내 서재 스터디룸 이용 내역)
	 *
	 *	스터디룸 예약 내역 전체 목록 조회: 최근 순으로 정렬(관리자 - 스터디룸 예약 관리)
	 *	전달 받은 스터디룸 예약 번호로 예약 승인/거절 처리(관리자 - 스터디룸 예약 관리)
	 *	전달 받은 예약 번호로 조회된 하나의 스터디룸 예약 정보 반환(승인 처리 시 중복 예약 방지 처리용)
	 *	전달 받은 스터디룸 번호, 예약 날짜가 일치하는 예약 신청들 중 예약을 승인할 예약 번호(rno)를 제외한 나머지 예약 신청을 모두 거절 처리(승인 처리 시 중복 예약 방지 처리용)
	 *	전달 받은 스터디룸 예약 번호로 예약 취소 처리(관리자 - 스터디룸 예약 관리, 사용자 - 내 서재 스터디룸 이용 내역)
	 *	
	 *	스터디룸 예약 테이블의 전체 행 개수(관리자 - 스터디룸 예약 관리 페이지 페이징용)
	 *	로그인 사용자의 스터디룸 예약건 전체 개수 조회(사용자 - 내 서재 스터디룸 이용 내역 페이징용)
	 */
	
	/**
	 * studyroom 테이블에서 스터디룸 정보 조회
	 * @return 조회된 스터디룸 정보를 리스트로 반환
	 */
	@Select("SELECT sno, s_name FROM studyroom ORDER BY sno ")
	List<RoomVO> rooms() throws Exception;
	
	/**
	 * 사용자가 예약 희망하는 날짜 정보를 전달 받아서
	 * 예약 승인된(status 컬럼이 'APPROVED'인) 예약건의 스터디룸 번호(sno)를 예약 테이블에서 조회
	 * 해당 날짜에 예약된 스터디룸의 정보를 리스트로 반환
	 * 
	 * @param reserve_date	전달 받은 사용자가 예약하려는 날짜
	 * @return				해당 날짜의 스터디룸 예약 정보 리스트
	 */
	@Select("SELECT * "
			+ "FROM studyroom_reservation "
			+ "WHERE reserve_date = #{reserve_date} AND  status = 'APPROVED' "
			+ "ORDER BY rno DESC")
	List<RoomVO> searchReservationByDate(Date reserve_date) throws Exception;
	
	/**
	 * 전달 받은 스터디룸 예약 정보(sno, user_id, user_name, reserve_date)를 예약 테이블에 입력(예약 신청)
	 * 
	 * @param vo	스터디룸 예약 정보를 담은 RoomVO 타입 객체
	 */
	@Insert("INSERT INTO studyroom_reservation "
			+ "(sno, user_id, user_name, reserve_date)"
			+ "VALUES(#{sno},#{user_id}, #{user_name}, #{reserve_date})")
	void makeReservation(RoomVO vo) throws Exception;
	
	/**
	 * 스터디룸 예약 테이블에서 로그인 사용자 아이디와 예약자 아이디가 일치하는 예약 내역 조회
	 * 최근 순으로 정렬하여 페이징 처리된 리스트로 반환
	 * 
	 * @param user_id	스터디룸 이용 내역을 조회할 사용자 아이디(예약자 아이디)
	 * @param cri		페이징 정보
	 * @return			페이징 처리된 로그인 사용자의 스터디룸 이용(예약) 내역 리스트 반환
	 */
	@Select("SELECT * FROM studyroom_reservation "
			+ "WHERE user_id =#{user_id}"
			+ "ORDER BY rno DESC"
			+ "OFFSET#{cri.startRow} ROWS FETCH NEXT #{cri.perPageNum} ROWS ONLY ")
	List<RoomVO> myReservationList(@Param("user_id") String user_id, @Param("cri") Criteria cri) throws Exception;
	
	/**
	 * 스터디룸 예약 내역 전체 조회 - rno 최근 순으로 정렬
	 * 
	 * @param cri	페이징 정보
	 * @return		페이징 처리된 모든 스터디룸 예약 내역 리스트로 반환
	 */
	@Select( "SELECT * FROM studyroom_reservation "
			+ "ORDER BY rno DESC "
			+ "OFFSET #{cri.startRow} ROWS FETCH NEXT #{cri.perPageNum} ROWS ONLY ")
	List<RoomVO> reservationList(Criteria cri) throws Exception;
	
	/**
	 * 전달 받은 예약 번호로 조회된 하나의 스터디룸 예약 정보 반환
	 *  
	 * @param rno	검색할 예약 번호
	 */
	@Select("SELECT rno, sno, user_id, user_name, reserve_date, apply_date, status "
			  + "FROM studyroom_reservation WHERE rno = #{rno}")
	RoomVO reservationInfo(int rno) throws Exception;
	
	/**
	 * 전달 받은 스터디룸 예약 번호로 예약 승인 처리 - status 컬럼 'APPROVED'로 변경
	 * 
	 * @param rno	예약 승인할 스터디룸 예약 번호
	 */
	@Update("UPDATE studyroom_reservation SET status = 'APPROVED' WHERE rno = #{rno} ")
	void approve(int rno) throws Exception;
	
	/**
	 * 전달 받은 스터디룸 번호, 예약 날짜가 일치하는 예약 신청들 중
	 * 예약을 승인할 예약 번호(rno)를 제외한 나머지 예약 신청을 모두 거절 처리
	 * (status 컬럼을 'REJECTED'로 업데이트)
	 *  
	 * @param rno			스터디룸 예약을 승인할 예약 번호
	 * @param sno			스터디룸 번호
	 * @param reserve_date	예약 날짜
	 */
	@Update("UPDATE studyroom_reservation "
			+ "SET status = 'REJECTED' "
			+ "WHERE sno = #{sno} AND reserve_date =#{reserve_date}")
	void rejectOthers(@Param("rno")int rno, @Param("sno")int sno, @Param("reserve_date")Date reserve_date) throws Exception;
	
	/**
	 * 전달 받은 스터디룸 예약 번호로 예약 거절 처리 - status 컬럼 'REJECTED'로 변경
	 * 
	 * @param rno 	예약 거절할 스터디룸 예약 번호
	 */
	@Update("UPDATE studyroom_reservation SET status = 'REJECTED' WHERE rno = #{rno}")
	void reject(int rno) throws Exception;
	
	/**
	 * 전달 받은 스터디룸 예약 번호로 예약 취소 처리 - status 컬럼 'CANCELED'로 변경
	 * 
	 * @param rno 	예약 거절할 스터디룸 예약 번호
	 */
	@Update("UPDATE studyroom_reservation SET status = 'CANCELED' WHERE rno = #{rno} ")
	void cancel(int rno) throws Exception;
	
	/**
	 * 스터디룸 예약 테이블의 전체 행 개수 조회
	 */
	@Select("SELECT count(*) FROM studyroom_reservation")
	int countAllReservation() throws Exception;

	/**
	 * 로그인 사용자의 아이디로 예약한 스터디룸 예약건의 전체 개수 조회
	 * 
	 * @param user_id 로그인 사용자(스터디룸 이용 내역 개수 조회할 아이디)
	 */
	@Select("SELECT count(*) FROM studyroom_reservation WHERE user_id = #{user_id} ")
	int countMyReservation(String user_id) throws Exception;
}
