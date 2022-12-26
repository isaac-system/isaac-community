package com.example.web.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component
public class DownloadViewer extends AbstractView{

	@Value("${upload}")
	private String path;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String file_name = (String) model.get("downloadFileName");
		
		File file = new File(path + file_name);
		
		response.setContentType("application/download; charset=utf-8");
		
		response.setContentLength((int) file.length());
		
		file_name = URLEncoder.encode(file_name, "utf-8").replaceAll("\\+", "");
		
		response.setHeader("Content-Disposition", "attachment; filename=\""+file_name+"\"");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		FileInputStream fis = new FileInputStream(file);
		
		OutputStream ops = response.getOutputStream();
		
		FileCopyUtils.copy(fis, ops);
		
		ops.flush();
		
	}
	
	
	
}
