package com.example.web.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.web.board.dto.HistoryVO;


@Mapper
public interface HistoryMapper {
	
	// 유저 아이디에 따른 활동 리스트
	public List<HistoryVO> getBoardHistoryList(String user_id);
	
	public List<HistoryVO> getActivityHistoryList(String user_id);
	
	// 게시판 쓸때 마다 추가 되는 히스토리
	public void insertBoardHistory(HistoryVO ins);
	// 좋아요 히스토리 추가
	public void insertLikeActivityHistory(HistoryVO ins);
	// 댓글 히스토리 추가
	public void insertCommentActivityHistory(HistoryVO ins);
}
