<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>生物大数据分析</title>
<link rel="stylesheet" href="./bootstrap/css/bootstrap3.min.css">
<link rel="stylesheet" href="./bootstrap/css/bootstrap3-theme.min.css">
<script type='text/javascript' src="./bootstrap/js/jquery-1.10.1.min.js"></script>
<script type="text/javascript" src="./bootstrap/js/bootstrap.min.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript">
	//提交表单，因为有上传控件，必须手动提交表单，否则后台取不到值
	function ok() {
		var timemethod = document.getElementById("timemethod").value;
		if (timemethod == "single" && checksingle()) {
			var starttime = document.getElementById("starttime").value;
			var endtime = document.getElementById("endtime").value;
			var aptratio = document.getElementById("aptratio").value;
			var chromosome = document.getElementById("chromosome").value;
			var param = "servlet/HandleServlet?timemethod=" + timemethod
					+ "&starttime=" + starttime + "&endtime=" + endtime
					+ "&aptratio=" + aptratio + "&chromosome=" + chromosome;
			var arrCheck = document.getElementsByName("select");
			for ( var i = 0; i < arrCheck.length; i++) {
				if (arrCheck[i].checked) {
					param += "&select=" + arrCheck[i].value;
				}
			}
			fileForm.action = param;
			fileForm.submit();
		} else if (timemethod == "file" && checkfile()) {
			var aptratio = document.getElementById("aptratio").value;
			var param = "servlet/HandleServlet?timemethod=" + timemethod
					+ "&aptratio=" + aptratio;
			var arrCheck = document.getElementsByName("select");
			for ( var i = 0; i < arrCheck.length; i++) {
				if (arrCheck[i].checked) {
					param += "&select=" + arrCheck[i].value;
				}
			}
			fileForm.action = param;
			fileForm.submit();
		}
	}
	//控制select的显示与隐藏
	function showpanel(obj) {
		var res = document.getElementById(obj.value);
		if (res.style.display == 'none')
			res.style.display = 'inline';
		else
			res.style.display = 'none';
	}
	// 检查单参数是否错误
	function checksingle() {
		var ma = document.getElementById("my-alert");
		var re = new RegExp(/^\d{1,10}$/);
		if (!re.test(document.getElementById("starttime").value)) {
			ma.style.display = 'block';
			document.getElementById("starttime").focus();
			return false;
		} else if (!re.test(document.getElementById("endtime").value)) {
			ma.style.display = 'block';
			document.getElementById("endtime").focus();
			return false;
		}
		var selectedObj = document.getElementsByName("select");
		var flag = 0;
		for ( var i = 0; i < selectedObj.length; i++) {
			if (selectedObj[i].checked) {
				flag = 1;
				break;
			}
		}
		if (flag == 0) {
			ma.style.display = 'block';
			document.getElementById("inlineCheckbox1").focus();
			return false;
		}
		return true;
	}

	//检查文件参数
	function checkfile() {
		var ma = document.getElementById("my-alert");
		var selectedObj = document.getElementsByName("select");
		var flag = 0;
		for ( var i = 0; i < selectedObj.length; i++) {
			if (selectedObj[i].checked) {
				flag = 1;
				break;
			}
		}
		if (flag == 0) {
			ma.style.display = 'block';
			document.getElementById("inlineCheckbox1").focus();
			return false;
		}
		var filetime = document.getElementById("filetime").value;
		if (filetime.indexOf("txt") == -1) {
			ma.style.display = 'block';
			document.getElementById("filetime").focus();
			return false;
		}
		return true;
	}

	$(document).ready(function() {
		// 获取当前要提交哪个表单
		$('#afile').on('shown.bs.tab', function() {
			document.getElementById("timemethod").value = "file";
		});
		$('#asingle').on('shown.bs.tab', function() {
			document.getElementById("timemethod").value = "single";
		});
		//帮助文本弹出框
		var options = {
			animation : true,
			trigger : 'hover' //触发tooltip的事件
		};
		$('#test').tooltip(options);
	});
</script>
</head>

<body>
	<div class="alert alert-danger fade in" style="display:none"
		id="my-alert">
		<button type="button" class="close" data-dismiss="alert"
			aria-hidden="true">×</button>
		<h4>遇到一个错误!</h4>
		<p>
			检测到参数错误，您可能没有填入参数或者填入的参数可能不符合规范，请检查并修改参数.<br />出错的元素已经被<b>高亮</b>标注。
		</p>
	</div>
	<div class="container">



		<div class="span2">


			<div class="well">
				<form name="geneForm" id="geneForm" onsubmit="return check();"
					method="get" class="form-horizontal" role="form">

					<fieldset disabled>
						<div class="form-group">
							<label for="option1" class="col-sm-2 control-label">Organism</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="option1"
									value=" human">
							</div>
						</div>
					</fieldset>
					<div class="form-group">
						<label class="col-sm-2 control-label"><b>*</b>cell type</label>

						<div class="col-sm-10">

							<label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox1" value="GM" name="select"
								onclick="showpanel(this);" />GM
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox2" value="H1" name="select"
								onclick="showpanel(this);" />H1
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox3" value="K562" name="select"
								onclick="showpanel(this);" />K562
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox4" value="A549" name="select"
								onclick="showpanel(this);" />A549
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox5" value="CD20" name="select"
								onclick="showpanel(this);" />CD20
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox6" value="HeLa-S3" name="select"
								onclick="showpanel(this);" />HeLa-S3
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox7" value="HepG2" name="select"
								onclick="showpanel(this);" />HepG2
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox8" value="HUVEC" name="select"
								onclick="showpanel(this);" />HUVEC
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox9" value="CD14" name="select"
								onclick="showpanel(this);" />CD14
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox10" value="Dnd41" name="select"
								onclick="showpanel(this);" />Dnd41
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox11" value="HMEC" name="select"
								onclick="showpanel(this);" />HMEC
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox12" value="HSMM" name="select"
								onclick="showpanel(this);" />HSMM
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox13" value="HSMMtube" name="select"
								onclick="showpanel(this);" />HSMMtube
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox14" value="NH-A" name="select"
								onclick="showpanel(this);" />NH-A
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox15" value="NHDF-Ad" name="select"
								onclick="showpanel(this);" />NHDF-Ad
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox16" value="NHEK" name="select"
								onclick="showpanel(this);" />NHEK
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox17" value="NHLF" name="select"
								onclick="showpanel(this);" />NHLF
							</label> <label class="checkbox-inline"> <input type="checkbox"
								id="inlineCheckbox18" value="Osteobl" name="select"
								onclick="showpanel(this);" />Osteobl


							</label>

						</div>
					</div>

					<div class="form-group" id="GM" style="display:none">
						<label class="col-sm-2 control-label">GM</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>GM12878CTCFPk</option>
								<option>GM12878EZH2Pk</option>
								<option>GM12878H3K4m2Pk</option>
								<option>GM12878H3K9acPk</option>
								<option>GM12878H3K9m3Pk</option>
								<option>GM12878H3K27acPk</option>
								<option>GM12878H3K36m3Pk</option>
								<option>GM12878H3K79m2Pk</option>
								<option>GM12878EZH2Pk</option>
							</select> <br />

						</div>
					</div>


					<div class="form-group" id="H1" style="display:none">
						<label class="col-sm-2 control-label">H1</label>
						<div class="col-sm-10">
							<select multiple class="form-control" size="5">
								<option id="H1">H1-hESCCHD1</option>
								<option value="H1-hESCCHD7">H1-hESCCHD7</option>
								<option value="H1-hESCCTCF">H1-hESCCTCF</option>
								<option value=[selected]>H1-hESCEZH2</option>
								<option value=[selected]>H1-hESCH2A.Z</option>
								<option value=[selected]>H1-hESCH3K4m1</option>
								<option value=[selected]>H1-hESCH3K4m2</option>
								<option value=[selected]>H1-hESCH3K4m3</option>
								<option value=[selected]>H1-hESCH3K9ac</option>
								<option value=[selected]>H1-hESCH3K9m3</option>
								<option value=[selected]>H1-hESCH3K27ac</option>
								<option value=[selected]>H1-hESCH3K27m3</option>
								<option value=[selected]>H1-hESCH3K36m3</option>
								<option value=[selected]>H1-hESCH3K79m2</option>
								<option value=[selected]>H1-hESCH4K20m1</option>
								<option value=[selected]>H1-hESCHDAC2</option>
								<option value=[selected]>H1-hESCHDAC6</option>
								<option value=[selected]>H1-hESCJARID1A</option>
								<option value=[selected]>H1-hESCJMJD2A</option>
								<option value=[selected]>H1-hESCP300</option>
								<option value=[selected]>H1-hESCPHF8</option>
								<option value=[selected]>H1-hESCPLU1</option>
								<option value=[selected]>H1-hESCRBBP5</option>
								<option value=[selected]>H1-hESCSAP30</option>
								<option value=[selected]>H1-hESCSIRT6</option>
								<option value="H1-hESCSUZ12">H1-hESCSUZ12</option>

							</select> <br />
						</div>
					</div>


					<div class="form-group" id="K562" style="display:none">
						<label class="col-sm-2 control-label">K562</label>
						<div class="col-sm-10">
							<select multiple class="form-control" size="5">
								<option value=[selected]>K562CBP</option>
								<option value=[selected]>K562CBX2</option>
								<option value=[selected]>K562CBX3</option>
								<option value=[selected]>K562CBX8</option>
								<option value=[selected]>K562CHD1</option>
								<option value=[selected]>K562CHD4Mi2</option>
								<option value=[selected]>K562CHD7</option>
								<option value=[selected]>K562CTCF</option>
								<option value=[selected]>K562EZH2</option>
								<option value=[selected]>K562H2A.Z</option>
								<option value=[selected]>K562H3K4m1</option>
								<option value=[selected]>K562H3K4m2</option>
								<option value=[selected]>K562H3K4m3</option>
								<option value=[selected]>K562H3K9ac</option>
								<option value=[selected]>K562H3K9m3</option>
								<option value=[selected]>K562H3K9m1</option>
								<option value=[selected]>K562H3K27ac</option>
								<option value=[selected]>K562H3K27m3</option>
								<option value=[selected]>K562H3K36m3</option>
								<option value=[selected]>K562H3K79m2</option>
								<option value=[selected]>K562H4K20m1</option>
								<option value=[selected]>K562HDAC1</option>
								<option value=[selected]>K562HDAC2</option>
								<option value=[selected]>K562HDAC6</option>
								<option value=[selected]>K562LSD1</option>
								<option value=[selected]>K562NCoR</option>
								<option value=[selected]>K562NSD2</option>
								<option value=[selected]>K562P300</option>
								<option value=[selected]>K562PCAF</option>
								<option value=[selected]>K562PHF8</option>
								<option value=[selected]>K562PLU1</option>
								<option value=[selected]>K562Pol2</option>
								<option value=[selected]>K562RBBP5</option>
								<option value=[selected]>K562REST</option>
								<option value=[selected]>K562RNF2</option>
								<option value=[selected]>K562SAP30</option>
								<option value=[selected]>K562SETDB1</option>
								<option value=[selected]>K562SIRT6</option>
								<option value=[selected]>K562SUZ12</option>
							</select> <br />
						</div>
					</div>

					<div class="form-group" id="A549" style="display:none">
						<div align="center">
							<label class="col-sm-2 control-label">A549</label>
						</div>
						<div class="col-sm-10">
							<div align="center">
								<select multiple class="form-control" size="5">
									<option>A549DEXCTCF</option>
									<option>A549DEXH2A.Z</option>
									<option>A549DEXH3K27ac</option>
									<option>A549DEXH3K36m3</option>
									<option>A549DEXH3K4m1</option>
									<option>A549DEXH3K4m2</option>
									<option>A549DEXH3K4m3</option>
									<option>A549DEXH3K79m2</option>
									<option>A549EtOHCTCF</option>
									<option>A549EtOHH2A.Z</option>
									<option>A549EtOHH3K20m1</option>
									<option>A549EtOHH3K27ac</option>
									<option>A549EtOHH3K27m3</option>
									<option>A549EtOHH3K36m3</option>
									<option>A549EtOHH3K4m1</option>
									<option>A549EtOHH3K4m2</option>
									<option>A549EtOHH3K4m3</option>
									<option>A549EtOHH3K79m2</option>
									<option>A549EtOHH3K9ac</option>
									<option>A549EtOHH3K9m3</option>

								</select> <br />
							</div>
						</div>
					</div>

					<div class="form-group" id="CD20" style="display:none">
						<label class="col-sm-2 control-label">CD20</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>CD20CTCF</option>
								<option>CD20EZH2</option>
								<option>CD20H2A.Z</option>
								<option>CD20H3K27ac</option>
								<option>CD20H3K4m2</option>
								<option>CD20H4K20m1</option>

							</select> <br />

						</div>
					</div>



					<div class="form-group" id="HeLa-S3" style="display:none">
						<label class="col-sm-2 control-label">HeLa-S3</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>HeLa-S3CTCF</option>
								<option>HeLa-S3EZH2</option>
								<option>HeLa-S3H2A.Z</option>
								<option>HeLa-S3H3K27ac</option>
								<option>HeLa-S3H3K27m3</option>
								<option>HeLa-S3H3K36m3</option>
								<option>HeLa-S3H3K4m1</option>
								<option>HeLa-S3H3K4m2</option>
								<option>HeLa-S3H3K4m3</option>
								<option>HeLa-S3H3K79m2</option>
								<option>HeLa-S3H3K9ac</option>
								<option>HeLa-S3H3K9m3</option>
								<option>HeLa-S3H4K20m1</option>
								<option>HeLa-S3Pol2</option>

							</select> <br />

						</div>
					</div>

					<div class="form-group" id="HepG2" style="display:none">
						<label class="col-sm-2 control-label">HepG2</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>HepG2CTCF</option>
								<option>HepG2EZH2</option>
								<option>HepG2H2A.Z</option>
								<option>HepG2H3K27ac</option>
								<option>HepG2H3K27m3</option>
								<option>HepG2H3K36m3</option>
								<option>HepG2H3K4m1</option>
								<option>HepG2H3K4m2</option>
								<option>HepG2H3K4m3</option>
								<option>HepG2H3K79m2</option>
								<option>HepG2H3K9m3</option>
								<option>HepG2H4K20m1</option>


							</select> <br />

						</div>
					</div>

					<div class="form-group" id="HUVEC" style="display:none">
						<label class="col-sm-2 control-label">HUVEC</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">

								<option>HUVECCTCF</option>
								<option>HUVECEZH2</option>
								<option>HUVECH2A.Z</option>
								<option>HUVECH3K27ac</option>
								<option>HUVECH3K27m3</option>
								<option>HUVECH3K36m3</option>
								<option>HUVECH3K4m1</option>
								<option>HUVECH3K4m2</option>
								<option>HUVECH3K4m3</option>
								<option>HUVECH3K79m2</option>
								<option>HUVECH3K9ac</option>
								<option>HUVECH3K9m1</option>
								<option>HUVECH3K9m3</option>
								<option>HUVECH4K20m1</option>
								<option>HUVECPol2</option>

							</select> <br />

						</div>
					</div>

					<div class="form-group" id="CD14" style="display:none">
						<label class="col-sm-2 control-label">CD14</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>CD14+CTCF</option>
								<option>CD14+H2A.Z</option>
								<option>CD14+H3K27ac</option>
								<option>CD14+H3K27m3</option>
								<option>CD14+H3K36m3</option>
								<option>CD14+H3K4m1</option>
								<option>CD14+H3K4m2</option>
								<option>CD14+H3K4m3</option>
								<option>CD14+H3K79m2</option>
								<option>CD14+H3K9ac</option>
								<option>CD14+H3K9m3</option>
								<option>CD14+H4K20m1</option>


							</select> <br />

						</div>
					</div>

					<div class="form-group" id="Dnd41" style="display:none">
						<label class="col-sm-2 control-label">Dnd41</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>Dnd41CTCF</option>
								<option>Dnd41EZH2</option>
								<option>Dnd41H2A.Z</option>
								<option>Dnd41H3K27ac</option>
								<option>Dnd41H3K27m3</option>
								<option>Dnd41H3K36m3</option>
								<option>Dnd41H3K4m1</option>
								<option>Dnd41H3K4m2</option>
								<option>Dnd41H3K4m3</option>
								<option>Dnd41H3K79m2</option>
								<option>Dnd41H3K9ac</option>
								<option>Dnd41H3K9m3</option>
								<option>Dnd41H4K20m1</option>


							</select> <br />

						</div>
					</div>

					<div class="form-group" id="HMEC" style="display:none">
						<label class="col-sm-2 control-label">HMEC</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>HMECCTCF</option>
								<option>HMECEZH2</option>
								<option>HMECH2A.Z</option>
								<option>HMECH3K27ac</option>
								<option>HMECH3K27m3</option>
								<option>HMECH3K36m3</option>
								<option>HMECH3K4m1</option>
								<option>HMECH3K4m2</option>
								<option>HMECH3K4m3</option>
								<option>HMECH3K79m2</option>
								<option>HMECH3K9ac</option>
								<option>HMECH3K9m3</option>
								<option>HMECH4K20m1</option>


							</select> <br />
						</div>
					</div>

					<div class="form-group" id="HSMM" style="display:none">
						<label class="col-sm-2 control-label">HSMM</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>HSMMCTCF</option>
								<option>HSMMEZH2</option>
								<option>HSMMH2A.Z</option>
								<option>HSMMH3K27ac</option>
								<option>HSMMH3K27m3</option>
								<option>HSMMH3K36m3</option>
								<option>HSMMH3K4m1</option>
								<option>HSMMH3K4m2</option>
								<option>HSMMH3K4m3</option>
								<option>HSMMH3K79m2</option>
								<option>HSMMH3K9ac</option>
								<option>HSMMH3K9m3</option>
								<option>HSMMH4K20m1</option>


							</select> <br />

						</div>
					</div>

					<div class="form-group" id="HSMMtube" style="display:none">
						<label class="col-sm-2 control-label">HSMMtube</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>HSMMtubeCTCF</option>
								<option>HSMMtubeEZH2</option>
								<option>HSMMtubeH2A.Z</option>
								<option>HSMMtubeH3K27ac</option>
								<option>HSMMtubeH3K27m3</option>
								<option>HSMMtubeH3K36m3</option>
								<option>HSMMtubeH3K4m1</option>
								<option>HSMMtubeH3K4m2</option>
								<option>HSMMtubeH3K4m3</option>
								<option>HSMMtubeH3K79m2</option>
								<option>HSMMtubeH3K9ac</option>
								<option>HSMMtubeH3K9m3</option>
								<option>HSMMtubeH4K20m1</option>


							</select> <br />

						</div>
					</div>

					<div class="form-group" id="NH-A" style="display:none">
						<label class="col-sm-2 control-label">NH-A</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>NH-ACTCF</option>
								<option>NH-AEZH2</option>
								<option>NH-AH2A.Z</option>
								<option>NH-AH3K27ac</option>
								<option>NH-AH3K27m3</option>
								<option>NH-AH3K36m3</option>
								<option>NH-AH3K4m1</option>
								<option>NH-AH3K4m2</option>
								<option>NH-AH3K4m3</option>
								<option>NH-AH3K79m2</option>
								<option>NH-AH3K9ac</option>
								<option>NH-AH3K9m3</option>
								<option>NH-AH4K20m1</option>


							</select> <br />

						</div>
					</div>

					<div class="form-group" id="NHDF-Ad" style="display:none">
						<label class="col-sm-2 control-label">NHDF-Ad</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>NHDF-Ad</option>
								<option>NHDF-AdEZH2</option>
								<option>NHDF-AdH3K27ac</option>
								<option>NHDF-AdH3K27m3</option>
								<option>NHDF-AdH3K36m3</option>
								<option>NHDF-AdH3K4m1</option>
								<option>NHDF-AdH3K4m2</option>
								<option>NHDF-AdH3K4m3</option>
								<option>NHDF-AdH3K79m2</option>
								<option>NHDF-AdH3K9ac</option>
								<option>NHDF-AdH3K9m3</option>
								<option>NHDF-AdH4K20m1</option>


							</select> <br />

						</div>
					</div>

					<div class="form-group" id="NHEK" style="display:none">
						<label class="col-sm-2 control-label">NHEK</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>NHEKCTCF</option>
								<option>NHEKEZH2</option>
								<option>NHEKH2A.Z</option>
								<option>NHEKH3K27ac</option>
								<option>NHEKH3K27m3</option>
								<option>NHEKH3K36m3</option>
								<option>NHEKH3K4m1</option>
								<option>NHEKH3K4m2</option>
								<option>NHEKH3K4m3</option>
								<option>NHEKH3K79m2</option>
								<option>NHEKH3K9ac</option>
								<option>NHEKH3K9m1</option>
								<option>NHEKH3K9m3</option>
								<option>NHEKH4K20m1</option>
								<option>NHEKPol2</option>


							</select> <br />

						</div>
					</div>


					<div class="form-group" id="NHLF" style="display:none">
						<label class="col-sm-2 control-label">NHLF</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>NHLFCTCF</option>
								<option>NHLFEZH2</option>
								<option>NHLFH2A.Z</option>
								<option>NHLFH3K27ac</option>
								<option>NHLFH3K27m3</option>
								<option>NHLFH3K36m3</option>
								<option>NHLFH3K4m1</option>
								<option>NHLFH3K4m2</option>
								<option>NHLFH3K4m3</option>
								<option>NHLFH3K79m2</option>
								<option>NHLFH3K9ac</option>
								<option>NHLFH3K9m3</option>
								<option>NHLFH4K20m1</option>


							</select> <br />

						</div>
					</div>

					<div class="form-group" id="Osteobl" style="display:none">
						<label class="col-sm-2 control-label">Osteobl</label>
						<div class="col-sm-10">


							<select multiple class="form-control" size="5">
								<option>OsteoblCTCF</option>
								<option>OsteoblH2A.Z</option>
								<option>OsteoblH3K27ac</option>
								<option>OsteoblH3K27m3</option>
								<option>OsteoblH3K36m3</option>
								<option>OsteoblH3K4m1</option>
								<option>OsteoblH3K4m2</option>
								<option>OsteoblH3K4m3</option>
								<option>OsteoblH3K79m2</option>
								<option>OsteoblH3K9m3</option>
								<option>OsteoblH4K20m1</option>
								<option>OsteoblP300</option>


							</select> <br />


						</div>
					</div>




					<br />
					<div class="form-group">
						<label class="col-sm-2 control-label">overlap ratio</label>
						<div class="col-sm-10">
							<select class="form-control" name="aptratio" id="aptratio">
								<option value="1">100%</option>
								<option value="0.5">50%</option>
								<option value="0.25">25%</option>
							</select>

						</div>
					</div>


				</form>
				<form name="fileForm" id="fileForm" onsubmit="return check();"
					method="post" class="form-horizontal" enctype="multipart/form-data"
					role="form">

					<div>
						<div class="form-group">
							<label class="col-sm-2 control-label">*Region</label>
							<div class="col-sm-10">
								<ul class="nav nav-tabs">
									<li class="active"><a href="#single" data-toggle="tab"
										id="asingle">单个位置</a></li>
									<li><a href="#file" data-toggle="tab" id="afile">文件批处理</a></li>
								</ul>
								<div id="myTabContent" class="tab-content">
									<div class="tab-pane fade in active" id="single">
										<br />

										<div class="form-group">
											<label class="col-sm-2 control-label">*Chromosome</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" name="chromosome"
													id="chromosome">
											</div>
										</div>

										<div class=" form-group">
											<label class="col-sm-2 control-label">*Region start</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" name="starttime"
													id="starttime">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">*Region end</label>
											<div class="col-sm-10">
												<input type="text" class="form-control" name="endtime"
													id="endtime">
											</div>
										</div>
									</div>
									<div class="tab-pane fade" id="file">
										<br />
										<div class=" form-group">
											<label class="col-sm-2 control-label">*Regtime file</label>
											<div class="col-sm-10">
												<input type="file" class="form-control" name="filetime"
													id="filetime"> <span class="help-block">上传的文件必须是txt格式的，文件名不能包含中文，且应该是<a
													href="#" data-toggle="tooltip" title=""
													data-placement="bottom"
													data-original-title="形如： 0,99999;2,8888;，逗号分割开始时间与结束时间，分号分割每组时间。"
													id="test">符合格式</a>的。
												</span>
											</div>
										</div>
									</div>
									<input type='hidden' value='single' id="timemethod"
										name='timemethod' value="single">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="button" name="Submit" data-loading-text="正在加载..."
									class="btn btn-primary" onclick="ok()">run</button>


								<button type="button" class="btn btn-primary">reset</button>
							</div>
						</div>
					</div>
				</form>

			</div>
		</div>
	</div>
</body>
</html>







