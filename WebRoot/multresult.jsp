<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page
	import="com.isdaidi.bigdata.main.GeneProcess,com.isdaidi.bigdata.util.ResultUtil"%>
<%
	response.setContentType("text/html;charset=utf-8");
response.setCharacterEncoding("UTF-8");
	String aptratio = request.getParameter("aptratio");
	String timemethod = request.getParameter("timemethod");
	String[] arrCheckbox = request.getParameterValues("select");
	String filepath = request.getAttribute("filepath").toString();
	String starttime = "";
	String endtime = "";
	System.out.println("filepath=====" + filepath);
	filepath=filepath.replace('\\', '/');
	System.out.println("filepath=====" + filepath);
	String param="../output.jsp?timemethod=file&starttime=" + starttime
	+ "&endtime=" + endtime + "&aptratio="+ aptratio+ "&filepath="+ filepath;	
	for ( int i = 0; i < arrCheckbox.length; i++) {
	param += "&select=" + arrCheckbox[i];
		}
	GeneProcess p = new GeneProcess();
	TreeSet<String> s=new TreeSet<String>();//有序表名集合
	TreeSet<String> s2=new TreeSet<String>();//有序时间集合
	int[] tablesize=new int[arrCheckbox.length];
	int[] timesize=new int[arrCheckbox.length];
	 for (int i = 0; i < arrCheckbox.length; ++i) {
         LinkedHashMap<ResultUtil, Integer> map = p.countMax(
     		arrCheckbox[i], Double.parseDouble(aptratio), filepath);
     		Iterator iter = map.entrySet().iterator();
     		Map.Entry entry ;
   		ResultUtil key ;
   		Object val ;				        		
     		while (iter.hasNext()) {
     	entry = (Map.Entry) iter.next();
     	key = (ResultUtil) entry.getKey();
     	s.add(key.getTablename());
     	s2.add(key.getTimestart()+"<>"+key.getTimeend());
     		}
     		tablesize[i]=s.size();
     		timesize[i]=s2.size();
	 }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Result</title>
<link rel="stylesheet" href="/hello/bootstrap/css/bootstrap3.min.css">
<link rel="stylesheet"
	href="/hello/bootstrap/css/bootstrap3-theme.min.css">
<link href="/hello/bootstrap/css/bootstrap-responsive.min.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/hello/bootstrap/css/responsive-tables.css">
<script type="text/javascript"
	src="/hello/bootstrap/js/jquery-1.10.1.min.js"></script>
<script type="text/javascript" src="/hello/bootstrap/js/highcharts.js"></script>
<script type="text/javascript"
	src="/hello/bootstrap/js/modules/exporting.js"></script>
<script type="text/javascript">
	//提交表单，因为有上传控件，必须手动提交表单，否则后台取不到值
	function out() {
		var param = '<%=param%>';
		outForm.action = param;
		outForm.submit();
	}

	//图表部分
<%for (int i = 0; i < arrCheckbox.length; ++i) {%>
	var ct<%=i%>;
	$(function() {
		ct<%=i%> = new Highcharts.Chart(
				{
					chart : {
						renderTo : 'chart<%=i%>', //关联页面元素div#id

					},
					title : { //图表标题
						text : '基因统计图'
					},

					xAxis : { //x轴
						categories : [
<%LinkedHashMap<ResultUtil, Integer> map = p.countMax(arrCheckbox[i], Double.parseDouble(aptratio), filepath);
	Iterator iter = map.entrySet().iterator();
	Map.Entry entry;
ResultUtil key;
Object val;		
int t=0;
	while (iter.hasNext()) {
		entry = (Map.Entry) iter.next();
  	key = (ResultUtil) entry.getKey();
		if(t%timesize[i]==0){				          	
out.print("'"+key.getTablename()+"',"); 
		}
			++t;
	}%>
						              ], //X轴类别
						labels : {
							y : 30,
							//rotation : 40
						//调节倾斜角度偏移
						}
					//x轴标签位置：距X轴下方18像素
					},
					yAxis : { //y轴
						title : {
							text : '峰值个数'
						}, //y轴标题
						lineWidth : 2
					//基线宽度
					},
					tooltip : {
						formatter : function() { //格式化鼠标滑向图表数据点时显示的提示框
							var s = '' + this.x + '表--峰值数: ' + this.y + '个';
							return s;
						}
					},
					exporting : {
						enabled : true
					//设置导出按钮不可用
					},
					credits : {
						text : '生物数据分析--点击查看数据来源',
						href : 'http://genome.ucsc.edu/cgi-bin/hgTables'
					},
					series : [ 
					           <%iter = map.entrySet().iterator();				          			
				        		t=0;
				        		
				          			while(t<timesize[i]){				          					          			
				          				entry = (Map.Entry) iter.next();
							          	key = (ResultUtil) entry.getKey();%>
					           { //数据列
									type : 'column',
									name : '<%=key.getTimestart()+"到"+key.getTimeend()%>',
									data : [
									        <%Iterator iter1 = map.entrySet().iterator();
									         		Map.Entry entry1 ;
									       		ResultUtil key1 ;
									       		Object val1 ;
									       		int t1=0;
									         		while (iter1.hasNext()) {
									         			entry1 = (Map.Entry) iter1.next();
											         	val1=entry1.getValue();
									         			if(t1%timesize[i]==t){%>
									         	<%=val1%>,
									         	<%}
									         			++t1;
									         		}%>
									        
									        
									        
									        ]
								},
					           <%++t;
				          			}%>
					           

					{ //数据列
						type : 'spline',
						name : '平均值',
						data : [
<%iter = map.entrySet().iterator();
									         		t=0;
									       		double t1=0;
									         		while (iter.hasNext()) {
									         			entry = (Map.Entry) iter.next();
											         	val=entry.getValue();
											         	t1+=Integer.parseInt(val.toString());
									         			if(t%timesize[i]==timesize[i]-1){
									         			t1/=timesize[i];%>
									         	<%=t1%>,
									         	<%t1=0;}
									         			++t;
									         		}%>

						]

					} ]
				});
	});
<%}%>
	
</script>
</head>

<body>
	<div class="container">
		<div class="well">
			<div style="text-align:center">
				<h1>基因统计结果</h1>
			</div>
		</div>

		<hr />
		图表展示：
		<hr />
		<%
			for (int i = 0; i < arrCheckbox.length; ++i) {
		%>
		前缀为<%=arrCheckbox[i]%>的表：
		<div id="chart<%=i%>"
			style="min-width: 310px; height: 400px; margin: 0 auto"></div>
		<hr />
		<%
			}
		%>

		总体结果展示：
		<hr />
		<table
			class="table table-striped table-hover table-condensed table-responsive"
			border="2">
			<tr>
				<th>前缀</th>
				<th>表名</th>
				<th>开始</th>
				<th>结束</th>
				<th>峰值</th>
			</tr>


			<%
				for (int i = 0; i < arrCheckbox.length; ++i) {
					LinkedHashMap<ResultUtil, Integer> map = p.countMax(
							arrCheckbox[i], Double.parseDouble(aptratio), filepath);
			%>
			<tr>
				<td><%=arrCheckbox[i]%></td>
				<%
					Iterator iter = map.entrySet().iterator();
						Map.Entry entry = (Map.Entry) iter.next();
						ResultUtil key = (ResultUtil) entry.getKey();
						Object val = entry.getValue();
				%>
				<td><%=key.getTablename()%></td>
				<td><%=key.getTimestart()%></td>
				<td><%=key.getTimeend()%></td>
				<td><%=val%></td>


			</tr>
			<%
				while (iter.hasNext()) {
						entry = (Map.Entry) iter.next();
						key = (ResultUtil) entry.getKey();
						val = entry.getValue();
			%>
			<tr>
				<td><%=arrCheckbox[i]%></td>
				<td><%=key.getTablename()%></td>
				<td><%=key.getTimestart()%></td>
				<td><%=key.getTimeend()%></td>
				<td><%=val%></td>
				<%
					}
					}
				%>

				</td>
			</tr>
		</table>
		<hr />
		矩阵展示：
		<hr />
		<%
			for (int i = 0; i < arrCheckbox.length; ++i) {
		%>
		前缀为<%=arrCheckbox[i]%>的表：
		<div style="width:device-width;overflow:auto;overflow-y:hidden">
		<table
			class="table table-striped table-hover table-condensed table-responsive"
			border="2">
			<tr>
				<td>table</td>

				<%
					LinkedHashMap<ResultUtil, Integer> map = p.countMax(
								arrCheckbox[i], Double.parseDouble(aptratio), filepath);
						Iterator iter = map.entrySet().iterator();
						Map.Entry entry;
						ResultUtil key;
						Object val;
						int t = 0;
						while (iter.hasNext()) {
							entry = (Map.Entry) iter.next();
							key = (ResultUtil) entry.getKey();
							if (t % timesize[i] == 0) {
				%><td><%=key.getTablename()%></td>
				<%
					}
							++t;
						}
				%>
			</tr>
			<%
				for (int j = 0; j < timesize[i]; ++j) {
			%>
			<tr>
				<td>region<%=j + 1%></td>
				<%
					iter = map.entrySet().iterator();
							int t1 = 0;
							while (iter.hasNext()) {
								entry = (Map.Entry) iter.next();
								val = entry.getValue();
								if (t1 % timesize[i] == j) {
				%>
				<td><%=val%></td>
				<%
					}
								++t1;
							}
				%>
			</tr>
			<%
				}
			%>
		</table>
		</div>
		<hr />
		<%
			}
		%>
		<%
			for (int i = 0; i < arrCheckbox.length; ++i) {
				LinkedHashMap<ResultUtil, Integer> map = p.countMax(
						arrCheckbox[i], Double.parseDouble(aptratio), filepath);
				Iterator iter = map.entrySet().iterator();
				Map.Entry entry;
				ResultUtil key;
				Object val;
				while (iter.hasNext()) {
					entry = (Map.Entry) iter.next();
					key = (ResultUtil) entry.getKey();
					s.add(key.getTablename());
					s2.add(key.getTimestart() + "<>" + key.getTimeend());
				}
			}
		%>

		<form id="outForm" method="post"></form>
		<input type="button" class="btn btn-primary"
			data-loading-text="正在加载..." value="输出结果到文档" onclick="out();">
		</button>
			<input type="button" name="Submit1" data-loading-text="正在加载..."
			class="btn btn-primary" value="跳转分析界面" class="btn btn-primary"
			onclick="location.href='/hello/analysisMain.jsp'" />
			</button>
		<input type="button" name="Submit" data-loading-text="正在加载..."
			class="btn btn-primary" value="返回查询界面" class="btn btn-primary"
			onclick="location.href='/hello/main.jsp'" />


	</div>
	</div>

</body>
</html>