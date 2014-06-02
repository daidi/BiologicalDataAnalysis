package com.isdaidi.bigdata.servlet;

import org.apache.commons.fileupload.*;
import java.util.*;
import java.util.regex.*;
import java.io.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HandleServlet extends HttpServlet {
	private final String uploadPath = "C:\\upload\\"; // 用于存放上传文件的目录
	private final File tempPath = new File("C:\\upload\\tmp\\"); // 用于存放临时文件的目录

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		String timemethod = request.getParameter("timemethod");
		String starttime = request.getParameter("starttime");
		String endtime = request.getParameter("endtime");
		String aptratio = request.getParameter("aptratio");
		String[] arrCheckbox = request.getParameterValues("select");
		
		request.setCharacterEncoding("UTF-8");
		System.out.println("调用方法=====" + timemethod);
		// 多文件处理
		if ("file".equals(timemethod)) {			
			PrintWriter out = response.getWriter();
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(4096);
			factory.setRepository(tempPath);

			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setHeaderEncoding("UTF-8");
			upload.setSizeMax(1000000);
			try {
				List fileItems = upload.parseRequest(request);
				Iterator iter = fileItems.iterator();
				while (iter.hasNext()) {
					FileItem item = (FileItem) iter.next();
					// 忽略其他不是文件域的所有表单信息
					if (!item.isFormField()) {
						String name = item.getName();
						String value = item.getString("utf-8");
						long size = item.getSize();
						if ((name == null || name.equals("")) && size == 0) {
							continue;
						}
						name = name.substring(name.lastIndexOf("\\") + 1,
								name.length());
						if (name.endsWith("txt")) {
							item.write(new File(uploadPath + name));
							request.setAttribute("filepath", uploadPath + name);
						} else {
							System.out.println("name====" + name
									+ "========不是txt后缀，忽略。");
						}
						System.out.println(uploadPath + name);

					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("====" + request.getCharacterEncoding() + "===="
					+ request.getContentType() + "===="
					+ response.getCharacterEncoding() + "===="
					+ response.getContentType() + "====");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=utf-8");
			request.setCharacterEncoding("UTF-8");
			System.out.println("====" + request.getCharacterEncoding() + "===="
					+ request.getContentType() + "===="
					+ response.getCharacterEncoding() + "===="
					+ response.getContentType() + "====");
			request.getRequestDispatcher("/multresult.jsp").forward(request,
					response);
		}
		// 单文件处理
		else {
			if (arrCheckbox == null || starttime == "" || endtime == ""
					|| aptratio == "") {
				request.getRequestDispatcher("/error.jsp").forward(request,
						response);
			} else {
				request.getRequestDispatcher("/result.jsp").forward(request,
						response);
			}
			
				
		}

	}

}
