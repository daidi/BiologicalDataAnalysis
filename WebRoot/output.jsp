<%@ page language="java" import="java.util.*,java.io.OutputStream"
	pageEncoding="UTF-8"%>
<%@page
	import="com.isdaidi.bigdata.main.*,com.isdaidi.bigdata.util.ResultUtil"%>
<!DOCTYPE html>
<head>
<meta charset="utf-8" />
<title>结果输出</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
</head>
<body>
	<%
		String timemethod = request.getParameter("timemethod");
		String starttime = request.getParameter("starttime");
		String endtime = request.getParameter("endtime");
		String aptratio = request.getParameter("aptratio");
		String[] arrCheckbox = request.getParameterValues("select");
		String chromosome = request.getParameter("chromosome");
		
		//String s = "该文档属于识别文档，格式才用JSON/类JSON展示，如果你需要进行后续操作，请不要修改文档的基本格式，否则解析可能会出现问题。\r\n\r\n";//输出到文本的内容
		String s="";
		String table_head="table";
		int region_count=0;
		request.setCharacterEncoding("UTF-8");
		System.out.println("调用方法=====" + timemethod);
		// 多文件处理
		if ("file".equals(timemethod)) {
			String filepath = request.getParameter("filepath");
			System.out.println("filepath=====" + filepath);
			filepath=filepath.replace('/', '\\');
			System.out.println("filepath=====" + filepath);
			GeneProcess p = new GeneProcess();
			for (int i = 0; i < arrCheckbox.length; ++i) {
				LinkedHashMap<ResultUtil, Integer> map = p.countMax(
						arrCheckbox[i], Double.parseDouble(aptratio),
						filepath);
				Iterator iter = map.entrySet().iterator();
				Map.Entry entry;
				ResultUtil key;
				Object val;
				long j=0;
				String tablename="";
				String lasttable="";
				//s += "{";
				while (iter.hasNext()) {
					region_count++;
					entry = (Map.Entry) iter.next();
					key = (ResultUtil) entry.getKey();
					tablename=key.getTablename();
					if(lasttable!=tablename){
						lasttable=tablename;
						s+="\r"+key.toString();
						region_count=0;
					}
					val=entry.getValue();
					s+=","+entry.getValue().toString();
					j++;
					/* entry = (Map.Entry) iter.next();
					key = (ResultUtil) entry.getKey();
					val=entry.getValue();
					s += key.toString()+" = "+val.toString()+" , "; */
				}
				
				
					/* s=s.substring(0, s.lastIndexOf(","));
					s+=" }\r\n\r\n"; */
			}
			for(int k=0;k<region_count+1;k++){
				table_head+=","+"r"+(k+1);
			}
			s=table_head+s;
		} else {
			String key1="";
			String tablename="";
			String lasttable="";
			
			for (int i = 0; i < arrCheckbox.length; ++i) {
				GeneProcess p = new GeneProcess();
				LinkedHashMap<String, Integer> map = p.countMax(
						arrCheckbox[i], Double.parseDouble(starttime),
						Double.parseDouble(endtime),
						Double.parseDouble(aptratio), chromosome);
				long j=0;
				
				for(Map.Entry entry:map.entrySet()){
					region_count++;
					key1=entry.getKey().toString();
					tablename=key1;
					if(lasttable!=tablename){
						s+="\r"+key1;
						region_count=0;
					}
					s+=","+entry.getValue().toString();
					j++;
				}
				
				/* s += map.toString();
				s+="\r\n\r\n"; */
			}
			for(int k=0;k<region_count+1;k++){
				table_head+=","+"r"+(k+1);
			}
			s=table_head+s;
		}

		String fileName = "output.csv";
		response.setContentType("text/plain");
		response.setHeader("Location", fileName);
		response.setHeader("Content-Disposition", "attachment; filename="
				+ fileName);
		OutputStream outputStream = response.getOutputStream();

		byte[] buffer = new byte[1024];
		outputStream.write(s.getBytes());
		outputStream.flush();
		outputStream.close();
		out.clear();
		out = pageContext.pushBody();
	%>
	
</body>

</html>