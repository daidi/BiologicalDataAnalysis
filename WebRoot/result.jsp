<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.isdaidi.bigdata.main.*"%>
<%
	String starttime = request.getParameter("starttime");
	String endtime = request.getParameter("endtime");
	String aptratio = request.getParameter("aptratio");
	String chromosome = request.getParameter("chromosome");
	String[] arrCheckbox = request.getParameterValues("select");
String param="../output.jsp?timemethod=single&starttime=" + starttime
+ "&endtime=" + endtime + "&aptratio="+ aptratio + "&chromosome=" + chromosome;
for ( int i = 0; i < arrCheckbox.length; i++) {
		param += "&select=" + arrCheckbox[i];
	}
GeneProcess p = new GeneProcess();
	/*
	for (int i = 0; i < arrCheckbox.length; ++i) {
		GeneProcess p = new GeneProcess();
		LinkedHashMap<String, Integer> map = p.countMax(arrCheckbox[i],
		Double.parseDouble(starttime),
		Double.parseDouble(endtime),
		Double.parseDouble(aptratio), chromosome);
		Iterator iter = map.entrySet().iterator();
		int count = 0;
		while (iter.hasNext()) {
	Map.Entry entry = (Map.Entry) iter.next();
	Object key = entry.getKey();
	Object val = entry.getValue();
	out.println(key + "--->" + val + "<br/>");
	count++;
		}
	} 
	*/
%>

<html>
<head>
<title>基因统计结果</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
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
				<%LinkedHashMap<String, Integer> map = p.countMax(arrCheckbox[i],
					Double.parseDouble(starttime),
					Double.parseDouble(endtime),
					Double.parseDouble(aptratio), chromosome);
					Iterator iter = map.entrySet().iterator();
					while (iter.hasNext()) {
				Map.Entry entry = (Map.Entry) iter.next();
				Object key = entry.getKey();%>
				'<%= key %>',
				<%}%>
				 ], //X轴类别
				labels : {
					y : 30
					//rotation:40//调节倾斜角度偏移
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
					var s= '' + this.x + '表--峰值数: ' + this.y + '个';					
					return s;
				}
			},			
			exporting : {
				enabled : true
			//设置导出按钮不可用
			},
			credits : {
				text : '生物数据分析--点击查看数据来源',
				href:'http://genome.ucsc.edu/cgi-bin/hgTables'
			},
			series : [ { //数据列
				type : 'column',
				name : 'region1',
				data : [ 
<%iter = map.entrySet().iterator();
	while (iter.hasNext()) {
Map.Entry entry = (Map.Entry) iter.next();
Object val = entry.getValue();%>
 <%=val%>,
<%}%>				        
			]			
	            
			},
			{ //数据列
				type : 'spline',
				name : '平均值',
				data : [ 
<%iter = map.entrySet().iterator();
	while (iter.hasNext()) {
Map.Entry entry = (Map.Entry) iter.next();
Object val = entry.getValue();%>
 <%=val%>,
<%}%>				        
			]			
	            
			}]
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
		<table class="table table-striped table-hover table-condensed"
			id="table_conver" border="2">
			<tr>
				<th>前缀名</th>
				<th>基因表</th>
				<th>峰值个数</th>
			</tr>


			<%
				for (int i = 0; i < arrCheckbox.length; ++i) {
					Map<String, Integer> map = p.countMax(arrCheckbox[i],
							Double.parseDouble(starttime),
							Double.parseDouble(endtime),
							Double.parseDouble(aptratio), chromosome);
			%>
			<tr>
				<td><%=arrCheckbox[i]%></td>
				<%
					Iterator iter = map.entrySet().iterator();
						if (iter.hasNext()) {
							Map.Entry entry = (Map.Entry) iter.next();
							Object key = entry.getKey();
							Object val = entry.getValue();
				%>
				<td><%=key%></td>
				<td><%=val%></td>
			</tr>
			<%
				while (iter.hasNext()) {
							entry = (Map.Entry) iter.next();
							key = entry.getKey();
							val = entry.getValue();
			%>
			<tr>
				<td><%=arrCheckbox[i]%></td>
				<td><%=key%></td>
				<td><%=val%></td>
				<%
					}
						} else {
				%>
				<td>没有这个表</td>
				<td>没有这个表</td>
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
				Map<String, Integer> map = p.countMax(arrCheckbox[i],
						Double.parseDouble(starttime),
						Double.parseDouble(endtime),
						Double.parseDouble(aptratio), chromosome);
		%>
		前缀为<%=arrCheckbox[i]%>的表:<br />
		<div style="width:device-width;overflow:auto;overflow-y:hidden">
			<table class="table table-striped table-hover table-condensed"
				border="2">
				<tr>
					<td>table</td>
					<%
						Iterator iter = map.entrySet().iterator();
							while (iter.hasNext()) {
								Map.Entry entry = (Map.Entry) iter.next();
								Object key = entry.getKey();
					%>
					<td><%=key%></td>
					<%
						}
					%>
				</tr>
				<tr>
					<td>region1</td>
					<%
						iter = map.entrySet().iterator();
							while (iter.hasNext()) {
								Map.Entry entry = (Map.Entry) iter.next();
								Object val = entry.getValue();
					%>

					<%
						
					%>
					<td><%=val%></td>
					<%
						}
					%>

				</tr>


			</table>
		</div>
		<br />
		<%
			}
		%>
		<hr />

		<form id="outForm" method="post"></form>
		<input type="button" class="btn btn-primary"
			data-loading-text="正在加载..." value="输出结果到文档" onclick="out();">
		</input>
		<input type="button" name="Submit" data-loading-text="正在加载..."
			class="btn btn-primary" value="返回查询界面" class="btn btn-primary"
			onclick="location.href='/hello/main.jsp'" />



	</div>


</body>
</html>
