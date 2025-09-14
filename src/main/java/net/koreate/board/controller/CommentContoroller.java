package net.koreate.board.controller;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import net.koreate.board.service.CommentService;
import net.koreate.board.vo.CommentVO;
import net.koreate.common.utils.Criteria;

@RestController
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentContoroller {

	private final CommentService cs;
	
	/**
	 * 건의 사항에 작성된 페이징 처리된 댓글 목록 요청 처리
	 * 
	 * @param sug_no 건의 사항 게시글 번호
	 * @param cri	 해당 게시글에 달린 댓글 목록 페이징 정보
	 */
	@GetMapping("/{sug_no}/commentList")
	public ResponseEntity<Map<String, Object>> getComments(
			@PathVariable(name="sug_no") int sug_no,
			Criteria cri
			) throws Exception{
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		cri.setPerPageNum(5);
		
		try {
			Map<String, Object> map = cs.commentList(sug_no, cri);
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/**
	 * 댓글 작성 요청 처리
	 * 
	 * @param vo 테이블에 저장될 댓글 정보
	 */
	@PostMapping("/addComment")
	public ResponseEntity<String> addComment(
			@RequestBody CommentVO vo
			) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		String msg = "";
		
		try {
			cs.writeComment(vo);
			msg = "댓글이 등록되었습니다.";
			entity = new ResponseEntity<>(msg, HttpStatus.OK);
			
		} catch (Exception e) {
			entity = new ResponseEntity<>("댓글 등록에 실패하였습니다.", HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	/**
	 * 댓글 수정 요청 처리
	 * 
	 * @param vo 수정할 댓글 정보
	 */
	@PatchMapping("/modifyComment")
	public ResponseEntity<String> modifyComment(
			@RequestBody CommentVO vo
			) throws Exception{
		ResponseEntity<String> entity = null;
		
		String msg = "";
		
		try {
			cs.updateComment(vo);
			msg = "댓글이 수정되었습니다.";
			entity = new ResponseEntity<>(msg, HttpStatus.OK);
			
		} catch (Exception e) {
			entity = new ResponseEntity<>("댓글 수정에 실패하였습니다.", HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	/**
	 * 댓글 삭제 요청 처리
	 * 
	 * @param rpl_no 삭제 처리할 댓글 번호
	 */
	@PatchMapping("/{rpl_no}/removeComment")
	public ResponseEntity<String> removeComment(
			@PathVariable(name="rpl_no") int rpl_no
			) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		String msg = "";
		
		try {
			cs.deleteComment(rpl_no);
			msg = "댓글이 삭제되었습니다.";
			entity = new ResponseEntity<>(msg, HttpStatus.OK);
			
		} catch (Exception e) {
			entity = new ResponseEntity<>("댓글 삭제에 실패하였습니다.", HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	
}
