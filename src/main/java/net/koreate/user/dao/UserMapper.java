package net.koreate.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.common.utils.Criteria;
import net.koreate.user.vo.UserVO;

/**
 *  회원 관련 DB 작업
 */
@Mapper
public interface UserMapper {

	/**
	 *  회원 가입 - 회원 테이블에 정보 저장
	 *  아이디 중복 체크
	 *  로그인 - 아이디, 비밀번호로 조회된 회원 정보
	 *  아이디 찾기 - 전달 받은 이름, 이메일과 정보가 일치하는 회원의 이메일
	 *  		   이메일로 조회된 회원의 아이디
	 *  비밀번호 찾기 - 전달 받은 아이디, 이메일과 정보가 일치하는 회원의 이메일
	 *  			아이디로 조회된 회원의 비밀번호 변경
	 *  vo 객체에 저장된 회원 정보로 수정 처리(사용자 - 마이 페이지 내 정보 수정, 관리자 - 회원 관리 회원 정보 수정)
	 *  회원 번호로 검색된 회원 탈퇴 처리(사용자 - 회원 탈퇴, 관리자 - 회원 삭제)
	 *  
	 *  전체 회원 목록 조회(페이징 처리)
	 *  회원 번호로 한 명의 회원 정보 조회
	 *  전체 회원 수 조회
	 */
	
	/**
	 * 전달 받은 회원 정보를 테이블에 입력(회원 가입)
	 * 
	 * @param vo	회원 정보
	 */
	@Insert("INSERT INTO member(id, pw, name, phone, email, addr, addr_detail, addr_post, info) " +
            " VALUES(#{id}, #{pw}, #{name}, #{phone}, #{email}, #{addr}, #{addr_detail}, #{addr_post}, #{info})")
	void join(UserVO vo) throws Exception;
	
	@Select("SELECT id FROM member WHERE id = #{id}")
	String checkId(String id) throws Exception;
	
	/**
	 * 전달 받은 아이디, 비밀번호로 회원 정보 조회
	 * 
	 * @param id	로그인할 아이디
	 * @param pw	로그인할 비밀번호
	 * @return		아이디, 비밀번호로 조회된 회원 정보
	 */
	@Select("SELECT * FROM member WHERE id=#{id} AND pw=#{pw} AND status='Y'") 
	UserVO login(@Param("id") String id, @Param("pw") String pw) throws Exception;
	
	/**
	 * 전달 받은 이름, 이메일과 정보가 일치하는 회원의 이메일 조회
	 * 
	 * @param name		아이디 찾기 할 회원 이름
	 * @param email		아이디 찾기 할 회원 이메일
	 * @return			이름과 이메일이 일치하는 회원의 이메일
	 */
	@Select("SELECT email FROM member WHERE name=#{name} AND email=#{email} AND status='Y' AND ROWNUM = 1")
	String getEmailForId(@Param("name")String name, @Param("email")String email) throws Exception;
	
	/**
	 * 인증된 이메일과 이메일이 일치하는 회원의 아이디 조회
	 * 
	 * @param email		전달 받은 이메일
	 * @return			이메일로 검색된 회원의 아이디 목록
	 */
	@Select("SELECT id FROM member WHERE email = #{email} AND status='Y'")
	List<String> findId(@Param("email")String email) throws Exception;
	
	/**
	 * 전달 받은 아이디, 이메일과 정보가 일치하는 회원의 이메일 조회
	 * 
	 * @param id		비밀번호 찾기 할 회원 아이디
	 * @param email		비밀번호 찾기 할 회원 이메일
	 * @return			아이디와 이메일이 일치하는 회원의 이메일
	 */
	@Select("SELECT email FROM member WHERE id=#{id} AND email=#{email} AND status='Y'")
	String getEmailForPw(@Param("id")String id, @Param("email")String email) throws Exception;
	
	/**
	 * 전달 받은 아이디로 회원 조회 후 새로 설정할 비밀번호로 업데이트
	 *  
	 * @param id	비밀번호 변경할 회원 아이디
	 * @param pw	새로운 비밀번호
	 */
	@Update("UPDATE member SET pw=#{pw} WHERE id=#{id} AND status='Y'")
	void resetPassword(@Param("id")String id, @Param("pw")String pw) throws Exception;
	
	/**
	 * 전달 받은 정보로 회원 정보 수정 처리
	 * 
	 * @param vo	수정할 회원 정보
	 */
	@Update("UPDATE member SET pw=#{pw}, name=#{name}, phone=#{phone}, addr=#{addr}, addr_detail=#{addr_detail}, addr_post=#{addr_post} WHERE mno=#{mno} ")
	void modifyInfo(UserVO vo) throws Exception;
	
	/**
	 * 전달 받은 회원 번호로 검색된 회원 탈퇴 처리(status 컬럼 'N'으로 업데이트)
	 * 
	 * @param mno	회원 번호
	 */
	@Update("UPDATE member SET status='N', delete_date = SYSTIMESTAMP WHERE mno=#{mno}")
	void withdraw(int mno) throws Exception;
	
	/**
	 * 전달 받은 페이징 정보를 이용해 페이징 처리된 전체 회원 목록 조회
	 * 
	 * @param cri	페이징 정보
	 * @return		페이징 처리된 회원 목록
	 */
	@Select("SELECT ROWNUM AS rnum, u.* FROM "
			+ "(SELECT * FROM member WHERE status='Y' AND id != 'admin' ORDER BY mno DESC) "
			+ "u ORDER BY rnum ASC "
			+ "OFFSET #{startRow} ROWS FETCH NEXT #{perPageNum} ROWS ONLY")
	List<UserVO> memberList(Criteria cri) throws Exception;
	
	/**
	 * 전달 받은 회원 번호로 한 명의 회원 정보 조회
	 * 
	 * @param mno	회원 번호
	 * @return		회원 번호가 일치하는 회원의 정보
	 */
	@Select("SELECT * FROM member WHERE mno = #{mno}")
	UserVO memberDetail(int mno) throws Exception;
	
	/**
	 * 전체 회원 수 조회
	 */
	@Select("SELECT COUNT (*) FROM member WHERE status='Y' AND id != 'admin'" )
	int countMembers() throws Exception;
}
