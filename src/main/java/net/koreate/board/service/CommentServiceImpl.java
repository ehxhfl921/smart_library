package net.koreate.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.board.dao.CommentMapper;
import net.koreate.board.vo.CommentVO;
import net.koreate.common.utils.Criteria;
import net.koreate.common.utils.PageMaker;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

	private final CommentMapper cm;
	
	@Override
	public void writeComment(CommentVO vo) throws Exception {
		cm.writeComment(vo);
	}

	@Override
	public void updateComment(CommentVO vo) throws Exception {
		cm.updateComment(vo);
	}

	@Override
	public void deleteComment(int rpl_no) throws Exception {
		cm.deleteComment(rpl_no);
	}

	@Override
	public Map<String, Object> commentList(int sug_no, Criteria cri) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		
		List<CommentVO> list = cm.commentList(sug_no, cri);
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(cm.totalCount(sug_no));
		pm.setDisplayPageNum(5);
		
		map.put("list", list);
		map.put("pm", pm);
		
		return map;
	}

}
