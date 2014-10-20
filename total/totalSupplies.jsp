<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'searchbByRno.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" >
		<link href="<%=basePath%>lib/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />
		<script src="<%=basePath%>lib/jquery/jquery-1.3.2.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/core/base.js"
			type="text/javascript"></script>
		<script src="lib/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
		<script src="lib/ligerUI/js/plugins/ligerForm.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerGrid.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerButton.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDialog.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTab.js"
			type="text/javascript"></script>
		<script src="lib/jquery-validation/jquery.metadata.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDateEditor.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
		<script type="text/javascript">
      //var arealist = ${requestScope.arealist};
	var grid = null;
	var reportJson = ${requestScope.showlist};
	var CustomersData = {
		Rows : reportJson
	};
	$(function() {
		var departmentlist = ${requestScope.departmentlist};
		//$("#btnOK").ligerButton();
		
		grid = $("#maingrid4").ligerGrid(
						{

							columns : [

									{
										display : '物料编号',
										name : 'mno',
										width : 140
									},

									{
										display : '物料名称',
										name : 'name',
										minWidth : 100
									},
									{
										display : '物料种类',
										name : 'category',
										minWidth : 140
									},
									{
										display : '物料价格',
										name : 'price',
										minWidth : 140
									},
									{
										display : '总用量',
										name : 'total',
										minWidth : 140
									},
									{
										display : '单位用量',
										name : 'totalByDep',
										minWidth : 140
									},

									{
										display : '剩余量',
										name : 'remain'
									}
								    ],

							pageSize : 30,

							data : $.extend(true, {}, CustomersData),

							width : '100%',
							height : '100%'

						});

		$("#pageloading").hide();
		
	         $("#txtDepartment").ligerComboBox({ data: departmentlist, isMultiSelect: false, isShowCheckBox: false });
    

	});

	function f_search()

	{
		self.location.href='total/TotalSuppliesAction.action?&department='+$("#txtDepartment").val();
	}

	
</script>

<style type="text/css">
.l-table-edit-td {
	padding: 4px;
	margin-left: 10px;
	float: left;
}
	.top {
	 	margin-top: 13px;
		margin-left: 7px;
		padding-left: 6px;
		padding-bottom: 2px;
		border-bottom: 1px solid rgb(230, 230, 230);
		font-size: 12px;
	}
	.top span {
		font-weight: bold;
	}
	.l-button {
		display: inline-block;
		height: 23px;
		width: 120px;
	}
	.l-box-select-table {
	font-size: 12px;
	}
	label, .text, .l-button{
		display: inline-block !important;
		float: left !important;
	}
	#maingrid4 {
		clear: both;
	}
	.l-text-wrapper {
		float: left;
	}
	</style>
</head>
<body style="padding: 10px;">
	<div class="top">
			<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif" />
			<span>物料信息汇总</span>
	</div>
	<div class="content">
		<p>
			<label>使用单位：</label>
			<input type="text" class="text" id="txtDepartment" />
			<input id="btnOK" type="button" class="l-button" value="查询" onclick="f_search()" />
		</p>
	</div>
	<div id="maingrid4"></div>

	</body>

</html>
