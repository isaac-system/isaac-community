package com.example.web.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.web.main.dto.TodoVO;


@Mapper
public interface TodoMapper {
	
	// todoList 호출
	public List<TodoVO> getTodoList(String user_id);
	// todoList 삽입
	public void insertTodo(TodoVO todo);
	// todoList 수정
	public void updateTodo(TodoVO todo);
	// todoList 삭제
	public void deleteTodo(int todo_id);

}
