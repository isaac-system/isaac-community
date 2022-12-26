package com.example.web.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.web.board.dto.BoardPagingVO;
import com.example.web.board.dto.BoardVO;
import com.example.web.board.dto.CommentVO;
import com.example.web.board.dto.LikeVO;
import com.example.web.board.dto.TagVO;
import com.example.web.comm.dto.FileVO;
import com.example.web.comm.dto.Users;


@Mapper
public interface BoardMapper {
	
	/*============================= 게시판 기능 ============================ */
	// 총 게시판 건수
	public int getBoardTotalCnt(BoardPagingVO sch);  
	// 게시판 리스트
	public List<BoardVO> getBoardList(BoardPagingVO sch);
	// 게시판 디테일 
	public BoardVO getBoard(int no);
	// 게시판 증가
	public void noticeViewsUp(int no); 
	
	// 게시판 등록
	public void insertBoard(BoardVO notice);
	// 게시판 삭제
	public void deleteBoard (int no);
	// 게시판 수정
	public void updateBoard (BoardVO notice);
	/*============================= 파일 첨부 기능 ============================ */
	// 파일 정보 가져오기
	public List<FileVO> getFileList(int board_no);
	// 파일 첨부
	public void insertFile(FileVO file);
	// 파일 삭제
	public void deleteFile(int board_not);
	
	/*============================= 좋아요 기능 ============================ */
	// 좋아요 수
	public int getLikeCount(LikeVO like);
	// 좋아요 체크
	public int likeCheck(LikeVO like);
	// 좋아요 싫어요 삭제
	public void deleteLike(LikeVO like);
	// 좋아요 & 싫어요
	public void likeUp(LikeVO like);
	public void likeDown(LikeVO like);
	/*============================= 댓글 기능 ============================ */
	// 댓글 수
	public int countComment(int board_no);
	// 댓글 리스트
	public List<CommentVO> getCommentList(int board_no);
	// 대댓글 리스트
	public List<CommentVO> getReCommentList(CommentVO comment);
	// 댓글 쓰기
	public void insertComment(CommentVO comment);
	// 댓글 수정
	public void updateComment(CommentVO comment);
	// 댓글 삭제
	public void deleteComment(CommentVO comment);
	// 대댓글 쓰기
	public void insertReComment(CommentVO comment);
	/*============================= 태그 기능 ============================ */
	// 자동완성 태그 리스트
	public List<String> getTagList(String tags); 
	// 인기 태그 리스트
	public List<TagVO> getTagCount();
	
	/*============================= 유저의 게시물 수 기능 ============================ */
	// 유저의 게시물 수 가 큰 1~5 표시
	public List<Users> getTopWriterCount();
}
