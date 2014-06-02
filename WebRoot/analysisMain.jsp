<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>生物大数据分析</title>
<link rel="stylesheet" href="/hello/bootstrap/css/bootstrap3.min.css">
<link rel="stylesheet"
	href="/hello/bootstrap/css/bootstrap3-theme.min.css">
<script type='text/javascript'
	src="/hello/bootstrap/js/jquery-1.10.1.min.js"></script>
<script type="text/javascript"
	src="/hello/bootstrap/js/bootstrap.min.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript">
	//提交表单，因为有上传控件，必须手动提交表单，否则后台取不到值
	function ok() {
		var args = document.getElementById("args").value;
		var param = "/hello/servlet/AnaServlet?args=" + args;
		fileForm.action = param;
		fileForm.submit();
	}
</script>
</head>

<body>
	<form name="fileForm" id="fileForm" method="post"
		enctype="multipart/form-data" role="form">
		<div class="form-group">
			<label for="args">分析的参数</label> <input type="text" name="args"
				class="form-control" id="args">
		</div>
		<div class="form-group">
			<label for="txtfile">分析的文件</label> <input type="file" name="txtfile"
				class="form-control" id="txtfile">
		</div>
		<div class="form-group">
			<label for="result">分析结果</label>
			<textarea rows="15" class="form-control" id="result">
								<%
									String res = (String) request.getAttribute("result");
									if (res != null)
										out.print(res);
									else
										out.print("请先提交需要分析的csv文件");
								%>
				</textarea>
		</div>

		<button type="button" class="btn btn-primary"
			data-loading-text="正在加载..." onclick="ok()">开始分析</button>


		<input type="button" name="Submit" data-loading-text="正在加载..."
			class="btn btn-primary" value="返回查询界面" class="btn btn-primary"
			onclick="top.location.href='/hello/query.jsp'" /> <input
			type="button" name="Submit" data-loading-text="正在加载..."
			class="btn btn-primary" value="返回主界面" class="btn btn-primary"
			onclick="top.location.href='/hello/index.jsp'" />
	</form>

</body>
</html>







