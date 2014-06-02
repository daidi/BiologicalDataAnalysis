package com.isdaidi.bigdata.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import weka.associations.FPGrowth;
import weka.core.Instances;
import weka.core.converters.ArffSaver;
import weka.core.converters.CSVLoader;
import weka.filters.unsupervised.attribute.NominalToBinary;
import weka.filters.unsupervised.attribute.NumericToBinary;

public class AnaServlet extends HttpServlet {

	private final String uploadPath = "C:\\upload\\"; // 用于存放上传文件的目录
	private final File tempPath = new File("C:\\upload\\tmp\\"); // 用于存放临时文件的目录

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		String arg = request.getParameter("args");
		PrintWriter out = response.getWriter();
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(4096);
		factory.setRepository(tempPath);
		String filepath = "fakepath";
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
					if (name.endsWith("csv")) {
						filepath = uploadPath + name;
						File outfile = new File(filepath);
						while (outfile.exists()){
							filepath=filepath.replace(".csv", "_copy.csv");
							outfile = new File(filepath);
						}
						item.write(outfile);
						request.setAttribute("filepath", filepath);
					} else {
						System.out.println("name====" + name
								+ "========不是csv后缀，忽略。");
					}
					System.out.println(uploadPath + name);

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		//清理arff文件
		File f=new File(uploadPath+"output_fp.arff");
		if(f.exists())
			f.delete();
		//执行算法
		CSVLoader loader = new CSVLoader();
		loader.setFile(new File(filepath));
		Instances dataRaw = loader.getDataSet();

		NominalToBinary filter2 = new NominalToBinary();
		try {
			filter2.setInputFormat(dataRaw);
			dataRaw = filter2.useFilter(dataRaw, filter2);

			NumericToBinary filter1 = new NumericToBinary();
			filter1.setInputFormat(dataRaw);
			filter1.setIgnoreClass(true);
			dataRaw = filter1.useFilter(dataRaw, filter1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("=====");
		// save ARFF
		ArffSaver saver = new ArffSaver();
		saver.setInstances(dataRaw);
		saver.setFile(new File(uploadPath + "output_fp.arff"));
		saver.writeBatch();
		FPGrowth fpg = new FPGrowth();
		if (arg == null || "".equals(arg))
			arg = "-P 2 -I -1 -N 1000 -T 1 -C 0.9 -D 0.05 -U 1.0 -M 0.1 -t "
					+ uploadPath + "output_fp.arff";
		else
			arg+="-t "+ uploadPath + "output_fp.arff";
		String[] args = arg.split(" ");// TODO
		for (String s : args)
			System.out.println(s);
		String res = fpg.runAssociator(new FPGrowth(), args);
		System.out.println(res);
		request.setAttribute("result", res);
		request.getRequestDispatcher("/analysisMain.jsp").forward(request,
				response);
	}

}
