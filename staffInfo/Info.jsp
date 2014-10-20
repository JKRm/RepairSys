<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="stcm.repair.model.Staff" %>
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

		<title>My JSP 'Info.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" >
		<link href="<%=basePath%>lib/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />
		
		<link href="<%=basePath%>css/form.css" rel="stylesheet" type="text/css" />
		
		<link href="<%=basePath%>lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet"
			type="text/css" />

		<script src="<%=basePath%>lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/core/base.js" type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerForm.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerSpinner.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTextBox.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTip.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/jquery-validation/jquery.metadata.js"
			type="text/javascript"></script>

		<script type="text/javascript"> 

        var groupicon = "<%=basePath%>lib/ligerUI/skins/icons/communication.gif";
		<%Staff staff = (Staff)request.getAttribute("staffinfo");%>
    </script>
    <style>
    </style>  	
	</head>

	<body style="padding:10px">
	<div class="title">
		<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif">
		<span>基本信息</span>
	</div>
	<div class="content">
	<form>
	<p>
		<label>姓名：</label>
		<input class="text" value="<%=staff.getSname()%>"/>
	</p>
	<p>
		<label>职工号：</label>
		<input class="text" value="<%=staff.getSno()%>"/>
	</p>
	<p>
		<label>单位：</label>
		<input class="text" value="<%=staff.getDno().getDname()%>"/>
	</p>
	<p>
		<label>联系电话：</label>
		<input class="text" value="<%=staff.getPhone()%>"/>
	</p>
	<p>
		<label>常用邮箱：</label>
		<input class="text" value="<%=staff.getEmail()%>"/>
	</p>
	</form>
	</div>

		<form></form>
</html>
