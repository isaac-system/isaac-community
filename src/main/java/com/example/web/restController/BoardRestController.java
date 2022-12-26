package com.example.web.restController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.web.board.dto.CommentVO;
import com.example.web.board.dto.HistoryVO;
import com.example.web.board.dto.LikeVO;
import com.example.web.board.service.BoardService;
import com.example.web.board.service.HistoryService;

@RestController
public class BoardRestController {
	
	@Autowired(required = false)
	private BoardService service;
	
	@Autowired(required = false)
	private HistoryService historyService;
	
	// http://localhost:6080/searchTags
	@RequestMapping("/searchTags")
	public List<String> searchTags(@RequestParam String tags) {
		return service.getTagList(tags);
	}
	
	/*======================= 좋아요 REST ==========================*/ 
	// http://localhost:6080/likeCount?board_no=2
	// 좋아요 수
	@RequestMapping("/likeCount")
	public Map<String, Integer> likeCount(LikeVO like) {
		Map<String, Integer> map = new HashMap<>(); 
		if(service.likeCheck(like) == 0) {
			map.put("proc", 0);
		} else if(service.likeCheck(like) == 1) {
			map.put("proc", 1);
		} else if(service.likeCheck(like) == -1) {
			map.put("proc", -1);
		}
		map.put("count",service.getLikeCount(like));
		return map; 
	}
	
	//likeUp
	@RequestMapping("/likeUp")
	public void likeUp (LikeVO like, HistoryVO history,Model d) {
		
		//좋아요를 처음 눌렀을 경우
		if(service.likeCheck(like) == 0) {
			service.likeUp(like);
			history.setAction_id(3);
			historyService.insertLikeActivityHistory(history);
		} else if(service.likeCheck(like) == 1){ 
			//좋아요를 이미 눌렀을 경우 
			service.deleteLike(like);
		}
	}
	
	//likeDown
	@RequestMapping("/likeDown")
	public void likeDown (LikeVO like, HistoryVO history, Model d) {
		//싫어요를 처음 눌렀을 경우
		if(service.likeCheck(like) == 0) {
			service.likeDown(like);
			history.setAction_id(4);
			historyService.insertLikeActivityHistory(history);
		} else if(service.likeCheck(like) == -1){
			//싫어요를 이미 눌렀을 경우 
			service.deleteLike(like);
		} 
	}
	
	/*======================= 댓글 REST ==========================*/
	// 댓글 수
	@RequestMapping("/countComment")
	public int countComment(@RequestParam(value = "board_no", defaultValue = "0") int board_no ) {
		return service.countComment(board_no); 
	}
	// 댓글 리스트
	@RequestMapping("/commentList")
	public List<CommentVO> commentList(@RequestParam(value = "board_no", defaultValue = "0") int board_no ) {
		return service.getCommentList(board_no);
	}
	@RequestMapping("/reCommentList")
	public List<CommentVO> getReCommentList(CommentVO comment) {
		return service.getReCommentList(comment);
	}
	// 댓글 생성
	@RequestMapping("/insertComment")
	public void insertComment (CommentVO comment, HistoryVO history) {
		history.setAction_id(2);
		
		historyService.insertCommentActivityHistory(history);
		
		service.insertComment(comment);
	}
	// 댓글 수정
	@RequestMapping("/updateComment")
	public void updateComment (CommentVO comment) {
		service.updateComment(comment);
	}
	// 댓글 삭제
	@RequestMapping("/deleteComment")
	public void deleteComment (CommentVO comment) {
		service.deleteComment(comment);
	}
	
	
}
