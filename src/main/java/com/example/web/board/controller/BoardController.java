package com.example.web.board.controller;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.web.board.dto.BoardPagingVO;
import com.example.web.board.dto.BoardVO;
import com.example.web.board.dto.HistoryVO;
import com.example.web.board.service.BoardService;
import com.example.web.board.service.HistoryService;

@Controller
public class BoardController {
	
	@Autowired(required = false)
	private BoardService service;
	
	@Autowired(required = false)
	private HistoryService historyService;
	
	/*============================ BOARD PAGES ==============================*/
	
	@RequestMapping("/notice")
	public String notice (Model d, BoardPagingVO sch) {
		sch.setBoard_type_id(1);
		d.addAttribute("boardTitle", "NOTICE");
		d.addAttribute("boardType", 1);
		d.addAttribute("boardList", service.getBoardList(sch));
		d.addAttribute("tagList", service.getTagCount());
		d.addAttribute("topUserList", service.getTopWriterCount());
		
		return "board";
	}
	@RequestMapping("/questions")
	public String questions (Model d, BoardPagingVO sch) {
		sch.setBoard_type_id(2);
		d.addAttribute("boardTitle", "Q & A");
		d.addAttribute("boardType", 2);
		d.addAttribute("boardList", service.getBoardList(sch));
		d.addAttribute("tagList", service.getTagCount());
		d.addAttribute("topUserList", service.getTopWriterCount());
		
		return "board";
	}
	
	@RequestMapping("/knowledge")
	public String knowledge (Model d, BoardPagingVO sch) {
		sch.setBoard_type_id(3);
		d.addAttribute("boardTitle", "KNOWLEDGE");
		d.addAttribute("boardType", 3);
		d.addAttribute("boardList",  service.getBoardList(sch));
		d.addAttribute("tagList", service.getTagCount());
		d.addAttribute("topUserList", service.getTopWriterCount());
		
		return "board";
	}
	
	@RequestMapping("/studyGroup")
	public String events (Model d, BoardPagingVO sch) {
		sch.setBoard_type_id(4);
		d.addAttribute("boardTitle", "STUDY GROUP");
		d.addAttribute("boardType", 4);
		d.addAttribute("boardList",  service.getBoardList(sch));
		d.addAttribute("tagList", service.getTagCount());
		d.addAttribute("topUserList", service.getTopWriterCount());
		
		return "board";
	}
	
	// http://localhost:6080/tagged
	@GetMapping("/tagged")
	public String tagged (Model d, BoardPagingVO sch) {
		d.addAttribute("boardTitle", sch.getTags().toUpperCase());
		d.addAttribute("boardList",  service.getBoardList(sch));
		d.addAttribute("tagList", service.getTagCount());
		d.addAttribute("topUserList", service.getTopWriterCount());
		
		return "board";
	}
	
	/*============================ BOARD PAGES END ==============================*/
	
	@GetMapping("/board_write")
	public String notice_write_Form(Model d) {
		return "board_write";
	}
	
	@PostMapping("/board_write")
	public String notice_write (BoardVO board, HistoryVO history) {
		board.setTags(board.getTags().replaceAll(",$", ""));
		
		service.insertBoard(board);
		
		history.setAction_id(1);
		historyService.insertBoardHistory(history);
		return "redirect:/";
	}
	
	@GetMapping("/notice_detail")
	public String notice_detail (@RequestParam(value = "board_no", defaultValue = "0") int board_no, Model d) {
		d.addAttribute("board", service.getBoard(board_no));
		return "board_detail";
	}
	// http://localhost:6080/notice_download?file_name=10.png
	@RequestMapping("/board_download")
	public String download(@RequestParam("file_name") String file_name, Model d) {
		d.addAttribute("downloadFileName", file_name);
		return "downloadViewer";
	}
	
	@GetMapping("/board_update")
	public String notice_update (@RequestParam(value = "board_no", defaultValue = "0") int board_no, Model d) {
		d.addAttribute("board", service.getBoard(board_no));
		return "board_update";
	}
	
	@RequestMapping("/updateBoard")
	public String updateBoard (BoardVO board) {
		service.updateBoard(board);
		return "redirect:/";
	}
	
	@RequestMapping("/deleteBoard")
	public String deleteBoard (@RequestParam(value = "board_no", defaultValue = "0") int board_no) {
		
		service.deleteBoard(board_no);
		
		return "redirect:/";
	}
	
}
