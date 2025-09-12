package net.koreate.room.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.common.utils.Criteria;
import net.koreate.common.utils.PageMaker;
import net.koreate.room.dao.RoomMapper;
import net.koreate.room.vo.RoomVO;

@Service
@RequiredArgsConstructor
public class RoomServiceImpl implements RoomService {

	private final RoomMapper mapper;
	
	@Override
	public Map<String, Object> getRoomsByDate(Date reserve_date) throws Exception {
		

		Map<String, Object> map = new HashMap<>();
		
		List<RoomVO> rooms = mapper.rooms();
		
		List<RoomVO> reserved = mapper.searchReservationByDate(reserve_date);
		
		map.put("rooms", rooms);
		map.put("reserved", reserved);
		return map;
	}

	@Override
	public void makeReservation(RoomVO vo) throws Exception {

		mapper.makeReservation(vo);
	}

	@Override
	public void approveReservation(int rno) throws Exception {

		RoomVO vo = mapper.reservationInfo(rno);
		if(vo != null) {
			mapper.approve(rno);
			
			mapper.rejectOthers(rno, vo.getSno(), vo.getReserve_date());
		}
	}

	@Override
	public void rejectReservation(int rno) throws Exception {
		mapper.reject(rno);

	}

	@Override
	public void cancelReservation(int rno) throws Exception {
		mapper.cancel(rno);

	}

	@Override
	public Map<String, Object> getReservationList(Criteria cri) throws Exception {

		Map<String, Object> map = new HashMap<>();

		List<RoomVO> list = mapper.reservationList(cri);
		int totalCount = mapper.countAllReservation();

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(totalCount);

		map.put("list", list);
		map.put("pm", pm);
		return map;
	}

	@Override
	public Map<String, Object> getMyReservation(String user_id, Criteria cri) throws Exception {

		Map<String, Object> map = new HashMap<>();

		List<RoomVO> list = mapper.myReservationList(user_id, cri);
		int totalCount = mapper.countMyReservation(user_id);

		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(totalCount);

		map.put("list", list);
		map.put("pm", pm);
		
		return map;
	}

}
