package com.example.web.restController;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;


@RestController
public class SummerNoteRestController {
	
	
	@Value("${summernoteUpload}")
	private String summernotePath;
	
	@RequestMapping(value="/uploadSummernoteImageFile",method = RequestMethod.POST , produces = "application/json; charset=utf8")
	public Map<String, String> uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		
		Map<String, String> map = new HashMap<>(); 
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));  //파일 확장자
		
		String fileName = UUID.randomUUID() + extension;
		
		File file = new File(summernotePath+fileName);
		
		try {
			multipartFile.transferTo(file);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		map.put("url", "/summernote/"+fileName);
		
		return map;
		
	}
	
	
}
