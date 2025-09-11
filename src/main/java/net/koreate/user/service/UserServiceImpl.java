package net.koreate.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.common.utils.Criteria;
import net.koreate.common.utils.PageMaker;
import net.koreate.user.dao.UserMapper;
import net.koreate.user.vo.UserVO;

/**
 * @since 20250912
 */
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	private final UserMapper mapper;
	
	@Override
	public void join(UserVO vo) throws Exception {
		
		mapper.join(vo);

	}

	@Override
	public UserVO login(String id, String pw) throws Exception {
		
		return mapper.login(id, pw);
	}

	@Override
	public String checkAndGetEmailForId(String name, String email) throws Exception {
		
		return mapper.getEmailForId(name, email);
	}

	@Override
	public String getId(String email) throws Exception {

		return mapper.findId(email);
	}

	@Override
	public String checkAndGetEmailForPw(String id, String email) throws Exception {

		return mapper.getEmailForPw(id, email);
	}

	@Override
	public void resetPassword(String id, String pw) throws Exception {
		
		mapper.resetPassword(id, pw);

	}

	@Override
	public void modifyInfo(UserVO vo) throws Exception {

		mapper.modifyInfo(vo);
	}

	@Override
	public void withdraw(int mno) throws Exception {

		mapper.withdraw(mno);
	}

	@Override
	public Map<String, Object> getMemberList(Criteria cri) throws Exception {
		PageMaker pm = new PageMaker();
		
		int totalCount = mapper.countMembers();
		
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		pm.setDisplayPageNum(10);
		
		List<UserVO> list = mapper.memberList(cri);		
		
		Map<String, Object> map = new HashMap<>();		
		map.put("list", list);
		map.put("pm", pm);
		
		return map;
	}

	@Override
	public UserVO getMemberDetail(int mno) throws Exception {

		return mapper.memberDetail(mno);
	}

}
