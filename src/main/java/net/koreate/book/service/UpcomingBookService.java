package net.koreate.book.service;

import java.util.Map;

import net.koreate.common.utils.Criteria;

public interface UpcomingBookService {

	/**
	 * 전달 받은 페이징 정보로 페이징 처리된 출간 예정 도서 목록, pm 객체 반환
	 */
	Map<String, Object> getList(Criteria cri) throws Exception;
	
}
