package com.example.web.board.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.web.board.dto.BoardPagingVO;
import com.example.web.board.dto.BoardVO;
import com.example.web.board.dto.CommentVO;
import com.example.web.board.dto.LikeVO;
import com.example.web.board.dto.TagVO;
import com.example.web.board.mapper.BoardMapper;
import com.example.web.comm.dto.FileVO;
import com.example.web.comm.dto.Users;

@Service
public class BoardService {
	
	@Autowired(required = false)
	private BoardMapper mapper;
	
	public List<BoardVO> getBoardList (BoardPagingVO sch) {
		
		sch.setCount(mapper.getBoardTotalCnt(sch));
		
		if(sch.getPageSize()==0) {
			sch.setPageSize(10);
		}
		
		sch.setPageCount( (int) Math.ceil( sch.getCount()/(double) sch.getPageSize() ));
		
		if(sch.getPageCount() == 0) {
			sch.setPageCount(1);
		}
		
		if(sch.getCurPage() == 0) {
			sch.setCurPage(1);
		}
		
		sch.setStart( (sch.getCurPage() - 1) * sch.getPageSize() );
		
		sch.setBlockSize(10);
		
		int blocknum = (int) (Math.ceil(sch.getCurPage()/(double)sch.getBlockSize()));
		
		int endBlock = blocknum*sch.getBlockSize();
		if(endBlock > sch.getPageCount()) {
			endBlock = sch.getPageCount();
		}
		sch.setEndBlock(endBlock);
		sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
		
		return mapper.getBoardList(sch);
	}
	
	public BoardVO getBoard (int no) {
		mapper.noticeViewsUp(no);
		return mapper.getBoard(no);
	}
	
	public List<String> getTagList(String tags) {
		return mapper.getTagList(tags);
	}
	
	
	// 파일 업로드 및 게시판 작성
	@Value("${upload}")
	private String path;
	
	public void insertBoard(BoardVO board) {
		
		mapper.insertBoard(board);
		
		List<MultipartFile> mpfList = board.getFileList();
		
		for (MultipartFile mpf : mpfList) {
			
			if (!mpf.isEmpty()) {
			
				String originalFileName = mpf.getOriginalFilename();	//오리지날 파일명
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
				
				String fileName = UUID.randomUUID() + extension;
				
				File file = new File(path + fileName);
				
				try {
					mpf.transferTo(file);
				} catch (IllegalStateException e) {
				    // TODO Auto-generated catch block
				    e.printStackTrace();
				} catch (IOException e) {
				    // TODO Auto-generated catch block
					    e.printStackTrace();
				}
					
				mapper.insertFile(new FileVO( path, fileName , originalFileName ));
				
			};
			
		}
		
	}
	
	public void updateBoard(BoardVO board) {
		
		mapper.updateBoard(board);
		
		mapper.deleteFile(board.getBoard_no());
		
		List<MultipartFile> mpfList = board.getFileList();
		
		for (MultipartFile mpf : mpfList) {
			
			if (!mpf.isEmpty()) {
			
				String originalFileName = mpf.getOriginalFilename();	//오리지날 파일명
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
				
				String fileName = UUID.randomUUID() + extension;
				
				File file = new File(path + fileName);
				
				try {
					mpf.transferTo(file);
				} catch (IllegalStateException e) {
				    // TODO Auto-generated catch block
				    e.printStackTrace();
				} catch (IOException e) {
				    // TODO Auto-generated catch block
					    e.printStackTrace();
				}
					
				mapper.insertFile(new FileVO( path, fileName , originalFileName ));
				
			};
			
		}
		
		
	}
	
	public void deleteBoard(int board_no) {
		List<FileVO> fileList = mapper.getFileList(board_no);
		
		for (FileVO fileVO : fileList) {
			
			File file = new File(fileVO.getFile_path()+fileVO.getFile_name());
			
			if(file.exists()) {
				if(file.delete()) {
					System.out.println("파일 삭제 성공");
				} else {
					System.out.println("파일 삭제 실패");
				}
			} else {
				System.out.println("파일이 존재하지 않습니다.");
			}
		}
		
		mapper.deleteBoard(board_no);
	}
	
	public void insertFile(FileVO file) {
		mapper.insertFile(file);
	}
	
	// 좋아요 수
	public int getLikeCount(LikeVO like) {
		return mapper.getLikeCount(like);
	}
	// 좋아요 체크
	public int likeCheck(LikeVO like) {
		return mapper.likeCheck(like);
	}
	// 좋아요 삭제
	public void deleteLike(LikeVO like) {
		mapper.deleteLike(like);
	}
	// 좋아요 & 싫어요
	public void likeUp(LikeVO like) {
		mapper.likeUp(like);
	}
	public void likeDown(LikeVO like) {
		mapper.likeDown(like);
	}
	
	/*============================= 댓글 기능 ============================ */
	// 댓글 수
	public int countComment(int notice_no) {
		return mapper.countComment(notice_no);
	}
	// 댓글 리스트
	public List<CommentVO> getCommentList(int notice_no){
		return mapper.getCommentList(notice_no);
	}
	// 대댓글 리스트
	public List<CommentVO> getReCommentList(CommentVO comment) {
		return mapper.getReCommentList(comment);
	}
	// 댓글 쓰기
	public void insertComment(CommentVO comment) {
		mapper.insertComment(comment);
	}
	// 댓글 수정
	public void updateComment(CommentVO comment) {
		mapper.updateComment(comment);
	}
	// 댓글 삭제
	public void deleteComment(CommentVO comment) {
		mapper.deleteComment(comment);
	}
	
	// 대댓글 쓰기
	public void insertReComment(CommentVO comment) {
		mapper.insertReComment(comment);
	}
	
	public List<TagVO> getTagCount() {
		return mapper.getTagCount();
	}
	
	public List<Users> getTopWriterCount() {
		return mapper.getTopWriterCount();
	}
	
	
}
