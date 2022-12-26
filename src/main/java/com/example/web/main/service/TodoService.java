package com.example.web.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.web.main.dto.TodoVO;
import com.example.web.main.mapper.TodoMapper;


@Service
public class TodoService {
	
	@Autowired(required = false)
	private TodoMapper mapper;
	
	public List<TodoVO> getTodoList(String user_id) {
		return mapper.getTodoList(user_id);
	}
	
	// todoList 삽입
	public void insertTodo(TodoVO todo) {
		mapper.insertTodo(todo);
	}
	// todoList 수정
	public void updateTodo(TodoVO todo) {
		mapper.updateTodo(todo);
	}
	// todoList 삭제
	public void deleteTodo(int todo_id) {
		mapper.deleteTodo(todo_id);
	}
	
}
