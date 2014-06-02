<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>

	<meta charset="utf-8" />
	<title>生物基因数据分析系统</title>

	<meta content="width=device-width, initial-scale=1.0" name="viewport" />

	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="bootstrap/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="bootstrap/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="bootstrap/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link rel="shortcut icon" href="bootstrap/image/favicon.ico" />

</head>


<body class="page-header-fixed">



	<div class="header navbar navbar-inverse navbar-fixed-top">



		<div class="navbar-inner">

			<div class="container-fluid">


				<a class="brand" href="index.html">

				<img src="bootstrap/image/logo.png" alt="logo"/>

				</a>


				<a href="javascript:;" class="btn-navbar collapsed" data-toggle="collapse" data-target=".nav-collapse">

				<img src="bootstrap/image/menu-toggler.png" alt="" />

				</a>          

     

			</div>

		</div>


	</div>



	<div class="page-container">

		<div class="page-sidebar nav-collapse collapse">


			<ul class="page-sidebar-menu">

				<li>


					<div class="sidebar-toggler hidden-phone"></div>


				</li>

				<li>

					<br/><br/>


				</li>

				<li class="">

					<a href="javascript:;">

					<i class="icon-home"></i> 

					<span class="title">首页</span>
					<span class="arrow "></span>

					</a>
					<ul class="sub-menu">
						<li >
							<a href="index.jsp">
							介绍系统主要分为数据查询和数据分析两大模块，下面可以依次进入功能界面。</a>
						</li>

					</ul>
				</li>
								<li class="start active">

					<a href="">

					<i class="icon-search"></i> 

					<span class="title">数据查询</span>

					<span class="arrow"></span>

					<span class="selected"></span>
					</a>

					<ul class="sub-menu">
						<li >
							<a href="query.jsp">
							数据查询是把现有基因按照峰值分析统计结果输出成矩阵，可通过图表形式直观展现。</a>
						</li>

					</ul>

				</li>

				<li class="">

					<a href="">

					<i class="icon-cogs"></i> 

					<span class="title">数据分析</span>

					<span class="arrow "></span>

					</a>

					<ul class="sub-menu">
						<li >
							<a href="analysis.jsp">
							数据分析是对数据查询的结果用关联规则分析算法进行分析，归纳总结出生物数据在同一区域内出现频率类似的细胞类型。</a>
						</li>

					</ul>

				</li>



			</ul>
		</div>


		<div class="page-content">


			<div class="container-fluid">

				<div class="row-fluid">

					<div class="span12">

						<h3 class="page-title">

							数据查询 <small>根据生物信息查询峰值个数，为下一步分析建立fp-tree做准备</small>

						</h3>

						<ul class="breadcrumb">

							<li>

								<i class="icon-home"></i>

								<a href="index.jsp">Home</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li><a href="#">数据查询</a></li>

						</ul>
					</div>

				</div>

				<div id="dashboard">
				<iframe name="myframe" width="100%" height=620 frameborder=0 scrolling=auto src="main.jsp"></iframe>
				</div>

			</div>

		</div>


	</div>


	<div class="footer">

		<div class="footer-inner">

			 &copy; 戴頔  生物大数据分析.

		</div>

		<div class="footer-tools">

			<span class="go-top">

			<i class="icon-angle-up"></i>

			</span>

		</div>

	</div>

	<!-- END FOOTER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->

	<script src="bootstrap/js/jquery-1.10.1.min.js" type="text/javascript"></script>

	<script src="bootstrap/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="bootstrap/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

	<script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

	<!--[if lt IE 9]>
	<script src="bootstrap/js/excanvas.min.js"></script>
	<script src="bootstrap/js/respond.min.js"></script>  
	<![endif]-->   

	<script src="bootstrap/js/app.js" type="text/javascript"></script>
	<script>
		jQuery(document).ready(function() {    
		   App.init();
		});

	</script>

</body>
</html>