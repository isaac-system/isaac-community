package com.example.web.main.controller;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.web.board.dto.BoardPagingVO;
import com.example.web.board.service.BoardService;

@Controller
public class MainController {
	
	@Autowired(required = false)
	private BoardService noticeService;
	
	
	// http://localhost:6080
	@RequestMapping("/")
	public String mainPage (Model d, BoardPagingVO boardPage) {
		
		d.addAttribute("tagList", noticeService.getTagCount());
		d.addAttribute("topUserList", noticeService.getTopWriterCount());
		
		boardPage.setPageSize(5);
		boardPage.setStart(0);
		boardPage.setSort("best");
		boardPage.setBoard_type_id(4);
		d.addAttribute("bestStudyList", noticeService.getBoardList(boardPage));
		
		boardPage.setBoard_type_id(2);
		d.addAttribute("bestQnAList", noticeService.getBoardList(boardPage));
		
		boardPage.setBoard_type_id(3);
		d.addAttribute("bestKnowledgeList", noticeService.getBoardList(boardPage));
		
		
		boardPage.setBoard_type_id(0);
		d.addAttribute("bestWeeklyList", noticeService.getBoardList(boardPage));
		
		return "main";
	}
}
