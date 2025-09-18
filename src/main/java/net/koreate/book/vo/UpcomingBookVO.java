package net.koreate.book.vo;

import java.util.Date;

import lombok.Data;

@Data
public class UpcomingBookVO {

	private int rnum;				// 행 번호
	private int num;				// 출간 예정 도서 번호
    private String title;			// 제목
    private String author;			// 저자
    private String publisher;		// 발행 기관
    private Date p_date;			// 발행일
    private String book_type;		// 도서 유형
    private String img_src;			// 이미지 url
    private String link;			// 도서 상세 정보 url
}
