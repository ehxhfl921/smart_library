package net.koreate.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.board.dao.NoticeMapper;
import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;
import net.koreate.common.utils.PageMaker;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

    private final NoticeMapper map;

    @Override
    public String write(BoardVO vo) throws Exception {
        int result = map.writeNotice(vo);
        String message = (result != 0) ? "공지사항 등록 성공" : "공지사항 등록 실패";
		return message;
    }

    @Override
    public void update(BoardVO vo) throws Exception {
        map.updateNotice(vo);
    }

    @Override
    public String delete(int nno) throws Exception {
    	return map.deleteNotice(nno) == 1 ? "공지사항 삭제 성공" : "공지사항 삭제 실패";
    }

    @Override
    public BoardVO getDetail(int nno) throws Exception {
    	return map.noticeDetail(nno);
    }

    @Override
    public Map<String, Object> list(Criteria cri) throws Exception {
    	
    	List<BoardVO> lists = map.noticeList(cri);
    	PageMaker pm = new PageMaker();
    	
    	int totalCount = map.countNotice();
    	
    	pm.setCri(cri);
		pm.setTotalCount(totalCount);
		pm.setDisplayPageNum(10);
		
		Map<String, Object> map = new HashMap<>();
		map.put("lists", lists);
		map.put("pm", pm);
		
		return map;
    }
}
