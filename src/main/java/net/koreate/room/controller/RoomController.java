package net.koreate.room.controller;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import net.koreate.common.utils.Criteria;
import net.koreate.room.service.RoomService;

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
				@PathVariable("reserve_date") Date reserve_date
			) throws Exception{
		return null;
	}
	
	/**
	 * 스터디룸 예약 요청 처리
	 * 
	 * @param sno			예약할 스터디룸 번호
	 * @param reserve_date	예약 희망일
	 */
	@PostMapping("")
	@ResponseBody
	public ResponseEntity<String> makeReservation(
			@RequestBody int sno,
			@RequestBody Date reserve_date,
			HttpSession session
			) throws Exception{
		return null;
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
			HttpSession session
			) throws Exception{
		return null;
	}
	
	/**
	 * 관리자 전용 - 스터디룸 예약 관리 페이지 요청 처리
	 * (페이징 처리된 스터디룸 예약 목록 페이지)
	 * 
	 * @param cri
	 */
	@GetMapping("/admin/reservationList")
	public String goToManageReservation(
			Criteria cri,Model model
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
	@PatchMapping("/approve/{rno}")
	@ResponseBody
	public String approveReservation(
			@PathVariable("rno") int rno,
			Criteria cri,
			RedirectAttributes rttr
			) throws Exception{
		rs.approveReservation(rno);
		rttr.addFlashAttribute("msg","예약 승인되었습니다.");
		return "redirect:/studyroom/admin/reservationList?page=" + cri.getPage();
	}
	
	/**
	 * 관리자 전용 - 스터디룸 예약 거절 요청 처리
	 * 
	 * @param rno	예약 거절할 스터디룸 예약 번호
	 */
	@PatchMapping("/reject/{rno}")
	@ResponseBody
	public  String rejectReservation(
			@PathVariable("rno") int rno,
			Criteria cri,
			RedirectAttributes rttr
			) throws Exception{
		rs.rejectReservation(rno);
		rttr.addFlashAttribute("msg", "예약 거절되었습니다.");
		return "redirect:/studyroom/admin/reservationList?page=" + cri.getPage();
	}
	
	/**
	 * 관리자 or 예약한 사용자 본인 - 스터디룸 예약 취소 처리
	 * 
	 * @param rno	예약 취소할 스터디룸 예약 번호
	 */
	@PatchMapping("/cancel/{rno}")
	@ResponseBody
	public String cancelReservation(
			@PathVariable("rno") int rno, 
			Criteria cri,
			RedirectAttributes rttr
			) throws Exception{
		try {
			rs.cancelReservation(rno);
			rttr.addFlashAttribute("msg", "예약 취소되었습니다.");
		}catch(Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "취소 처리 중 오류가 발생했습니다. ");
			
		}
		return "redirect:/studyroom/admin/reservationList?page=" + cri.getPage();
	}
	
}
