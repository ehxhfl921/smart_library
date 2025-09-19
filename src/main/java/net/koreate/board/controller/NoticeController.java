package net.koreate.board.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import net.koreate.board.service.NoticeService;
import net.koreate.board.vo.BoardVO;
import net.koreate.common.utils.Criteria;
import net.koreate.user.vo.UserVO;

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
   public String noticeDetail(
		   @RequestParam("nno") int nno,
		   @RequestParam("rnum") int rnum,
		   Model model) throws Exception {
	    BoardVO board = ns.getDetail(nno);
	    board.setRnum(rnum);
	    model.addAttribute("boardVO", board);
	    return "notice/noticeDetail";
	}
   
   /**
    * 공지 사항 수정 폼 페이지 요청
    * 
    * @param nno   수정할 공지 사항 게시글 번호
    */
   @GetMapping("/modifyForm")
   public String noticeModify(
		   @RequestParam("nno") int nno, 
		   @RequestParam("rnum") int rnum, 
		   Model model) throws Exception {
	   
       BoardVO board = ns.getDetail(nno);
       board.setRnum(rnum);
       
       model.addAttribute("boardVO", board);
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
   public String noticeRegister(BoardVO vo,
		   RedirectAttributes rttr,
		   HttpSession session
		   ) throws Exception{
      
      UserVO login = (UserVO)session.getAttribute("userInfo");
      
      if(login != null) {
    	  vo.setN_author(login.getName());
      }
      
      try {
		String result = ns.write(vo);
	    rttr.addFlashAttribute("msg", result);
	} catch (Exception e) {
		rttr.addFlashAttribute("msg", "공지 사항 등록에 실패하였습니다.");
		e.printStackTrace();
	}
      
      return "redirect:/notice/list";
   }
 
   /**
    * 공지 사항 수정 요청 처리
    * @param vo 수정할 공지 사항 게시글 정보
    */
   @PostMapping("/modify")
   public String noticeModifyPost(BoardVO boardVO, RedirectAttributes rttr) throws Exception {
	   
	   String result = ns.update(boardVO); // 서비스에서 수정 처리
	   rttr.addFlashAttribute("msg", result);
	   
	   return "redirect:/notice/detail?nno=" + boardVO.getNno() + "&rnum=" + boardVO.getRnum(); // 수정 완료 후 detail 이동
   }
   
   /**
    * 공지 사항 삭제 요청 처리
    * @param nno 삭제 처리할 공지 사항 게시글 번호
    */
	@PostMapping("/delete")
	   public String deleteNotice(@RequestParam("nno") int nno, RedirectAttributes redirectAttr) throws Exception {
	       ns.delete(nno); // 논리 삭제 처리
	       redirectAttr.addFlashAttribute("msg", "공지사항이 삭제되었습니다.");
	       return "redirect:/notice/list";
	   }

   }

   