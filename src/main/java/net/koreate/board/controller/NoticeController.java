package net.koreate.board.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import net.koreate.board.service.NoticeService;
import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;

@Controller
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {
   
   private final NoticeService ns;
   

   /**
    * 페이징 처리된 공지 사항 게시글 목록 페이지 요청 처리
    * @param cri
    * @param model 공지사항 리스트, PageMaker 객체
    */
   @GetMapping("/list")
   public String noticeList(Criteria cri, Model model) throws Exception{
      System.out.println("공지사항 목록 noticeList 요청");
       
       // 조회된 공지사항 게시글 목록
       Map<String, Object> map = ns.list(cri);
       model.addAllAttributes(map);
       return "notice/noticeList";
   }
   
   /**
    * 공지 사항 상세 페이지 보기 요청 처리
    * @param nno 전달 받은 공지 사항 번호
    * @param model 공지 사항 게시글 정보
    */
   @GetMapping("/detail")
   public String noticeDetail(int nno, Model model) throws Exception{
      BoardVO board = ns.getDetail(nno);
      model.addAttribute("boardVO", board);
      
      return "notice/noticeDetail";
   }
   
   /**
    * 공지 사항 수정 폼 페이지 요청
    * 
    * @param nno   수정할 공지 사항 게시글 번호
    */
   @GetMapping("/modifyForm")
   public String goToModifyForm(int nno, Model model) throws Exception{
      BoardVO board = ns.getDetail(nno);
      model.addAttribute(board);
      return "notice/noticeUpdate";
   }

   
   /**
    * 공지 사항 작성 폼 페이지로 이동 요청 처리
    */
   @GetMapping("/register")
   public String noticeRegisterForm() throws Exception{
	   
	   return "notice/noticeWrite";
   }
   
   
   /**
    * 공지 사항 등록 요청 처리
    * @param vo 등록할 공지 사항 게시글 정보
    */
   @PostMapping("/register")
   public String noticeRegister(BoardVO vo, Model model) throws Exception{
      System.out.println("param data : " + vo);
      String result = ns.write (vo);
      model.addAttribute("msg", result);
      return "notice/noticeList";
   }
   
   /**
    * 공지 사항 수정 요청 처리
    * @param vo 수정할 공지 사항 게시글 정보
    */
   @PostMapping("/modify")
   public String noticeModify(BoardVO vo, Model model) throws Exception{
      String result = ns.update(vo);
      model.addAttribute("result", result);
      return "redirect:/notice/noticeDetail?nno=" + vo.getNno();
   }
   
   /**
    * 공지 사항 삭제 요청 처리
    * @param nno 삭제 처리할 공지 사항 게시글 번호
    */
   @GetMapping("/delete")
   public String noticeDelete(int nno, Model model) throws Exception{
      String result = ns.delete(nno);
      model.addAttribute("result", result);
      return "redirect:/notice/noticeDetail";
   }
   
}