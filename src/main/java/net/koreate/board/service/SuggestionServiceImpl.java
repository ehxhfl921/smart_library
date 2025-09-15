package net.koreate.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.board.dao.SuggestionMapper;
import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;
import net.koreate.common.utils.PageMaker;
import net.koreate.user.vo.UserVO;

@Service
@RequiredArgsConstructor
public class SuggestionServiceImpl implements SuggestionService {

    private final SuggestionMapper sug;

    @Override
    public String write(BoardVO vo) throws Exception {
        int result = sug.suggestionWrite(vo);
        return (result != 0) ? "건의사항 등록 성공" : "건의사항 등록 실패";
    }

    @Override
    public String update(BoardVO vo) throws Exception {
        int result = sug.suggsestionUpdate(vo);
        return (result == 1) ? "건의사항 수정 성공" : "건의사항 수정 실패";
    }

    @Override
    public String delete(int sug_no) throws Exception {
        int result = sug.suggsestionDelete(sug_no);
        return (result == 1) ? "건의사항 삭제 성공" : "건의사항 삭제 실패";
    }

    @Override
    public BoardVO getDetail(int sug_no) throws Exception {
        return sug.suggestionDetail(sug_no);
    }

    @Override
    public Map<String, Object> list(Criteria cri) throws Exception {
        List<BoardVO> lists = sug.suggestionList(cri);
        int totalCount = sug.countSuggestion();

        PageMaker pm = new PageMaker();
        pm.setCri(cri);
        pm.setTotalCount(totalCount);
        pm.setDisplayPageNum(10);

        Map<String, Object> map = new HashMap<>();
        map.put("list", lists);
        map.put("pm", pm);

        return map;
    }

    @Override
    public Map<String, Object> getMySuggestionLst(String user_id, Criteria cri) throws Exception {
        List<BoardVO> suggestionList = sug.mySuggestion(user_id, cri);
        int totalCount = sug.countMySuggestion(user_id); // 로그인 사용자 건의사항 수

        PageMaker pm = new PageMaker();
        pm.setCri(cri);
        pm.setTotalCount(totalCount);
        pm.setDisplayPageNum(10);

        Map<String, Object> map = new HashMap<>();
        map.put("list", suggestionList);
        map.put("pm", pm);

        return map;
    }

    @Override
    public UserVO logins(UserVO user) throws Exception {
        return sug.login(user); // Mapper에서 로그인 처리
    }
}
