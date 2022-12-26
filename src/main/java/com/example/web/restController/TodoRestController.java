package com.example.web.restController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.web.main.dto.TodoVO;
import com.example.web.main.service.TodoService;

@RestController
public class TodoRestController {
	
	@Autowired(required = false)
	private TodoService service;
	
	// http://localhost:6080/getTodoList
	@RequestMapping("/getTodoList")
	public List<TodoVO> getTodoList (@RequestParam(value = "user_id", defaultValue = "") String user_id) {
		List<TodoVO> todoList;
		
		if (user_id != null) {
			todoList = service.getTodoList(user_id);
		} else {
			todoList = null;
		}
		return todoList;
		
	}
	
	// todoList 삽입
	@PostMapping("/insertTodo")
	public void insertTodo(TodoVO todo) {
		if (todo.getUser_id() != null) {
			service.insertTodo(todo);
		}
	}
	
	// todoList 수정
	@PostMapping("/updateTodo")
	public void updateTodo(TodoVO todo) {
		service.updateTodo(todo);
	}
	
	// todoList 삭제
	@PostMapping("/deleteTodo")
	public void deleteTodo(TodoVO todo) {
		service.deleteTodo(todo.getTodo_id());
	}
	 
	
}
