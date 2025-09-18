package net.koreate.book.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.book.dao.UpcomingBookMapper;
import net.koreate.book.vo.UpcomingBookVO;
import net.koreate.common.utils.Criteria;
import net.koreate.common.utils.PageMaker;

@Service
@RequiredArgsConstructor
public class UpcomingBookServiceImpl implements UpcomingBookService {

	@Autowired
	private final UpcomingBookMapper um;
	
	@Override
	public Map<String, Object> getList(Criteria cri) throws Exception {
		
		List<UpcomingBookVO> list = um.getList(cri);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(um.countBooks());
		pm.setDisplayPageNum(10);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pm", pm);
		
		return map;
	}

}
