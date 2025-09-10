package net.koreate.user.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.common.utils.Criteria;
import net.koreate.user.dao.UserMapper;
import net.koreate.user.vo.UserVO;

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
		Map<String, Object> result = new HashMap<>();
		List<UserVO> list = mapper.memberList(cri);
		int totalCount = mapper.countMembers();

		result.put("list", list);
		result.put("totalCount", totalCount);
		return result;
	}

	@Override
	public UserVO getMemberDetail(int mno) throws Exception {

		return mapper.memberDetail(mno);
	}

}
