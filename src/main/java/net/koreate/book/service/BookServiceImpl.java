package net.koreate.book.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.book.dao.BookMapper;
import net.koreate.book.dao.LoanMapper;
import net.koreate.book.vo.BookVO;
import net.koreate.common.utils.Criteria;
import net.koreate.common.utils.PageMaker;

@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {

	private final BookMapper book;
	private final LoanMapper loan;
	
	@Override
	public Map<String, Object> getSerchBookList(
			Criteria cri, String keyword
			) throws Exception {
		List<BookVO> bookList = book.serchBookList(cri, keyword);
		PageMaker pm = new PageMaker();
		
		int totalCount = book.countSearchBook(keyword);
		
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		pm.setDisplayPageNum(10);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", bookList);
		map.put("pm", pm);
		
		return map;
	}

	@Override
	public Map<String, Object> getAllBookList(Criteria cri) throws Exception {
		
		List<BookVO> list = book.allBookList(cri);
		PageMaker pm = new PageMaker();
		
		int totalCount = book.countAllBooks();
				
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		pm.setDisplayPageNum(10);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pm", pm);
		
		return map;
	}

	@Override
	public BookVO getBookDetail(int bno) throws Exception {
		BookVO vo = book.bookDetail(bno);
		return vo;
	}

	@Override
	public void registerBook(BookVO vo) throws Exception {
		book.addBook(vo);
	}

	@Override
	public void modifyBook(BookVO vo) throws Exception {
		book.updateBook(vo);
	}

	@Override
	public void removeBook(int bno) throws Exception {
		book.deleteBook(bno);
	}

	@Override
	public void regieterBOM(BookVO vo) throws Exception {
		book.regieterBOM(vo);
	}

	@Override
	public void removeFromBOM(int bno) throws Exception {
		book.removeFromBOM(bno);
	}

	@Override
	public String getBomStatus(int bno) throws Exception {
		String status = book.bomStatus(bno);
		return status;
	}
	
	@Override
	public List<BookVO> getBomList() throws Exception {
		List<BookVO> list = book.bookOfTheMonthList();
		return list;
	}

	@Override
	public Map<String, Object> getLoanListOfBook(int bno, Criteria cri) throws Exception {
		List<BookVO> list = loan.loanListOfBook(bno, cri);
		PageMaker pm = new PageMaker();
		
		int totalCount = loan.countLoanListOfBook(bno);
		
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		pm.setDisplayPageNum(10);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pm", pm);
		
		return map;
	}

	@Override
	public Map<String, Object> getLoanListOfUser(String user_id, Criteria cri) throws Exception {
		List<BookVO> list = loan.loanListOfUser(user_id, cri);
		PageMaker pm = new PageMaker();
		
		int totalCount = loan.countUsersLoanList(user_id);
		
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		pm.setDisplayPageNum(10);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pm", pm);
		
		return map;
	}

}
