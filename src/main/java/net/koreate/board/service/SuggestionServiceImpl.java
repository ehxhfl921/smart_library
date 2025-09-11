package net.koreate.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.board.dao.SuggestionMapper;
import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;
import net.koreate.common.utils.PageMaker;

@Service
@RequiredArgsConstructor
public class SuggestionServiceImpl implements SuggestionService {
	
	private final SuggestionMapper sug;

	@Override
	public String write(BoardVO vo) throws Exception {
		int result = sug.suggestionWrite(vo);
        String message = (result != 0) ? "건의사항 등록 성공" : "건의사항 등록 실패";
		return message;

	}

	@Override
	public String update(BoardVO vo) throws Exception {
		int result = sug.suggsestionUpdate(vo);
    	return result == 1 ? "건의사항 수정 성공" : "건의사항 수정 실패";

	}

	@Override
	public String delete(int sug_no) throws Exception {
		return sug.suggsestionDelete(sug_no) == 1 ? "공지사항 삭제 성공" : "공지사항 삭제 실패";
	}

	@Override
	public BoardVO getDetail(int sug_no) throws Exception {
		  BoardVO vo = sug.suggestionDetail(sug_no);
	      return vo;
	}

	@Override
	public Map<String, Object> list(Criteria cri) throws Exception {
		  List<BoardVO> lists = sug.suggestionList(cri);
	       PageMaker pm = new PageMaker();
	       
	       int totalCount = sug.countSuggestion();
	       
	       pm.setCri(cri);
	      pm.setTotalCount(totalCount);
	      pm.setDisplayPageNum(10);
	      
	      Map<String, Object> map = new HashMap<>();
	      map.put("lists", lists);
	      map.put("pm", pm);
	      
	      return map;
	}

	@Override
	public Map<String, Object> getMySuggestionLst(String user_id, Criteria cri) throws Exception {
		 
	    List<BoardVO> suggestionList = sug.mySuggestion(user_id, cri);

	    PageMaker pm = new PageMaker();

	    int totalCount = sug.countSuggestion();

	    pm.setCri(cri);
	    pm.setTotalCount(totalCount);
	    pm.setDisplayPageNum(10); // 페이지 번호 수 설정 (예: 1~10)

	    Map<String, Object> map = new HashMap<>();
	    map.put("list", suggestionList);
	    map.put("pm", pm);

	    // 결과 반환
	    return map;
	}

}
