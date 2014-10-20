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

		<title>My JSP 'ModifyPassword.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" >
		<link href="<%=basePath%>lib/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet"
			type="text/css" />
		<script src="<%=basePath%>lib/jquery/jquery-1.3.2.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/core/base.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerForm.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerButton.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDialog.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTextBox.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTip.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>js/modifypsw.js" type="text/javascript"></script>
	</head>
<style type="text/css">
body {
	font-size: 12px;
}

.l-table-edit {
	
}

.l-table-edit-td {
	padding: 4px;
}

.l-button-submit,.l-button-test {
	width: 80px;
	float: left;
	margin-left: 10px;
	padding-bottom: 2px;
}

.l-verify-tip {
	left: 230px;
	top: 120px;
}
.title {
	margin-top: 13px;
	margin-left: 7px;
	padding-left: 6px;
	padding-bottom: 2px;
	border-bottom: 1px solid rgb(230, 230, 230);
}
.title span {
	font-weight: bold;
	margin-left: 5px;
}
.form {
	margin-top: 13px;
	margin-left: 7px;
	line-height: 30px;
}
.form label {
	display: inline-block;
	text-align: right;
	width: 80px;
	margin-right: 10px;
}
.form .text {
	width: 168px;
	height: 23px;
	color: green;
	border: 1px solid rgb(220, 220, 220);
}
</style>
	<body style="padding: 10px">
		<form name="form1" method="post" action="" id="form1">
		<div class="title">
		<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif">
		<span>修改密码</span>
		</div>
		<div class="form">
		<p>
			<label>原密码：</label>
			<input name="prepsw" type="password" id="prepsw" class="text" />
		</p>
		<p>
			<label>新密码：</label>
			<input name="newpsw" type="password" id="newpsw" class="text"/>
		</p>
		<p>
			<label>请确认：</label>
			<input name="conpsw" type="password" id="conpsw" class="text" />
		</p>
		<input type="button" value="提交" id="buttons"
				class="l-button l-button-submit" />
		<input type="reset" value="重置" class="l-button l-button-test" />
		</form>
		</div>
	</body>
</html>