package net.koreate.book.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import net.koreate.book.vo.UpcomingBookVO;
import net.koreate.common.utils.Criteria;

public interface UpcomingBookMapper {

	@Select("SELECT ROWNUM AS rnum, b.* FROM "
			+ "(SELECT * FROM upcoming_books ORDER BY p_date ASC) b ORDER BY rnum ASC "
			+ "OFFSET #{startRow} ROWS FETCH NEXT #{perPageNum} ROWS ONLY")
	List<UpcomingBookVO> getList(Criteria cri) throws Exception;
	
	@Select("SELECT count(*) FROM upcoming_books")
	int countBooks() throws Exception;
}
