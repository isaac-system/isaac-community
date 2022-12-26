package com.example.web.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.web.board.dto.HistoryVO;
import com.example.web.board.mapper.HistoryMapper;


@Service
public class HistoryService {
	@Autowired(required = false)
	private HistoryMapper mapper;
	
	public List<HistoryVO> getBoardHistoryList(String user_id) {
		return mapper.getBoardHistoryList(user_id);
	}
	
	public List<HistoryVO> getActivityHistoryList(String user_id) {
		return mapper.getActivityHistoryList(user_id);
	}
	
	// 좋아요 히스토리 추가
	public void insertBoardHistory(HistoryVO history) {
		mapper.insertBoardHistory(history);
	}
	// 좋아요 히스토리 추가
	public void insertLikeActivityHistory(HistoryVO history) {
		mapper.insertLikeActivityHistory(history);
	}
	// 댓글 히스토리 추가
	public void insertCommentActivityHistory(HistoryVO history) {
		mapper.insertCommentActivityHistory(history);
	}
	
}
