package net.koreate.room.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import net.koreate.common.utils.Criteria;
import net.koreate.room.service.RoomService;
import net.koreate.room.vo.RoomVO;
import net.koreate.user.vo.UserVO;

@Controller
@RequestMapping("/studyroom")
@RequiredArgsConstructor
public class RoomController {

	private final RoomService rs;
	
	/**
	 * 스터디룸 예약 페이지로 이동 요청 처리
	 */
	@GetMapping("")
	public String goToStudyroomPage() {
		return "room/roomReservation";
	}
	
	/**
	 * 사용자가 스터디룸 예약 희망하는 날짜 선택 시
	 * 해당 날짜의 스터디룸 예약 목록, 스터디룸 정보 테이블에서 조회한 스터디룸 목록 요청 처리
	 *  
	 * @param reserve_date	예약 희망일
	 */
	@GetMapping("/{reserve_date}")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getRoomsByDate(
				@PathVariable("reserve_date") @DateTimeFormat(pattern = "yyyy-MM-dd") Date reserve_date
			) throws Exception{
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> result = null;
		
		try {
			
			result = rs.getRoomsByDate(reserve_date);
			entity = new ResponseEntity<>(result, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		

		return entity;
	}
	
	/**
	 * 스터디룸 예약 요청 처리
	 * 
	 * @param sno			예약할 스터디룸 번호
	 * @param reserve_date	예약 희망일
	 */
	@PostMapping(value="", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> makeReservation(
			@RequestBody Map<String, Object> data,
			HttpSession session
			) throws Exception{
		
		String snoStr = (String) data.get("sno");
		int sno = Integer.parseInt(snoStr);
		
	    String dateStr = (String) data.get("date");
	    Date reserve_date = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
	    
		ResponseEntity<String> entity = null;
		
		RoomVO vo = new RoomVO();
		
		UserVO user = (UserVO)session.getAttribute("userInfo");
		
		// 인터셉터 만든 뒤 삭제
		if(user == null) {
		    return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
		}
		
		
		if(user != null) {
			String user_id = user.getId();
			String user_name = user.getName();
			vo.setUser_id(user_id);
			vo.setUser_name(user_name);
		}
		
		vo.setSno(sno);
		vo.setReserve_date(reserve_date);
		
		try {
			
			rs.makeReservation(vo);
			String msg = "스터디룸 예약 신청을 완료했습니다. 관리자 승인 후 이용 가능합니다.";
			entity = new ResponseEntity<>(msg, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			String msg = "스터디룸 예약 신청을 완료하지 못했습니다.";
			entity = new ResponseEntity<>(msg, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/**
	 * 내 서재 - 스터디룸 이용 내역 페이지 요청 처리
	 * (페이징 처리된 로그인 사용자의 스터디룸 예약 목록 페이지) 
	 * 
	 * @param cri
	 */
	@GetMapping("/myReservationList")
	public String goToMyReservationList(
			Criteria cri,
			HttpSession session,
			Model model
			) throws Exception{
		
		UserVO user = (UserVO)session.getAttribute("userInfo");
		String user_id = null;
		
		if(user != null) {
			user_id = user.getId();
			try {
				Map<String, Object> result = rs.getMyReservation(user_id, cri);
				model.addAllAttributes(result);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "room/reservationList";
	}
	
	/**
	 * 관리자 전용 - 스터디룸 예약 관리 페이지 요청 처리
	 * (페이징 처리된 스터디룸 예약 목록 페이지)
	 * 
	 * @param cri
	 */
	@GetMapping("/admin/reservationList")
	public String goToManageReservation(
			Criteria cri, Model model
			) throws Exception{
		
		try {
			Map<String, Object> result = rs.getReservationList(cri);
	        model.addAttribute("list", result.get("list"));
	        model.addAttribute("pm", result.get("pm"));
		}catch(Exception e){  
	        e.printStackTrace();
		}	
			return "admin/manageReservation";
	}
	
	/**
	 * 관리자 전용 - 스터디룸 예약 승인 요청 처리
	 * 
	 * @param rno	예약 승인할 스터디룸 예약 번호
	 */
	@PatchMapping(value="/approve/{rno}", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String approveReservation(
			@PathVariable("rno") int rno) throws Exception{
		
		String msg = "";
		
		try {
			rs.approveReservation(rno);
			msg = "예약을 승인하였습니다.";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "예약 승인에 실패하였습니다.";
		}
		
		return msg;
	}
	
	/**
	 * 관리자 전용 - 스터디룸 예약 거절 요청 처리
	 * 
	 * @param rno	예약 거절할 스터디룸 예약 번호
	 */
	@PatchMapping(value="/reject/{rno}", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public  String rejectReservation(
			@PathVariable("rno") int rno
			) throws Exception{
		
		String msg = "";
		
		try {
			rs.rejectReservation(rno);
			msg = "예약을 거절하였습니다.";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "예약 거절에 실패하였습니다.";
		}
		
		
		return msg;
	}
	
	/**
	 * 관리자 or 예약한 사용자 본인 - 스터디룸 예약 취소 처리
	 * 
	 * @param rno	예약 취소할 스터디룸 예약 번호
	 */
	@PatchMapping(value="/cancel/{rno}", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String cancelReservation(
			@PathVariable("rno") int rno
			) throws Exception{
		
		String msg = "";
		
		try {
			rs.cancelReservation(rno);
			msg = "예약을 취소하였습니다.";
		}catch(Exception e) {
			e.printStackTrace();
			msg = "예약 취소에 실패하였습니다.";
		}
		
		return msg;
	}
	
}
