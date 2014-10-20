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

		<title>山东省食品药品职业学院 网上报修系统</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" >
		<link href="<%=basePath%>lib/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=basePath%>css/index.css" rel="stylesheet" type="text/css" />
		<script src="<%=basePath%>lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/core/base.js" type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
		<script src="<%=basePath%>js/indexdata.js" type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDrag.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDialog.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerComboBox.js"
			type="text/javascript"></script>

		<link href="<%=basePath%>lib/ligerUI/skins/Gray/css/all.css" rel="stylesheet"
			type="text/css" />
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerForm.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerButton.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerSpinner.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTextBox.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTip.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/jquery-validation/jquery.validate.min.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/jquery-validation/jquery.metadata.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/jquery-validation/messages_cn.js"
			type="text/javascript"></script>
		<script type="text/javascript" src="<%=basePath%>js/index.js"
			type="text/javascript"></script>
	</head>

	<body style="padding: 0px; background: #EAEEF5;">
		

		<script type="text/javascript"> 
			if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion .split(";")[1].replace(/[ ]/g,"")=="MSIE6.0")
			{
				alert("系统检测到您使用的浏览器是IE6，系统中某些功能可能无法使用，请更换更高版本的IE浏览器");
			}
		</script> 

		<div id="pageloading"></div>

		<%
			String sno = (String) session.getAttribute("sno");
			if (sno == null) {
		%>
		<script type="text/javascript">
		// 控件样式，登入弹出框样式
		$(function() {
			$("#username").ligerTextBox();
			$("#password").ligerTextBox();
			//$("#Button").ligerButton();
			//$("#Reset").ligerButton();
			$.ligerDialog.open({
				title : '请登入',
				target : $("#target1")
			});
		});
		</script>
		<div id="target1" style="width: 250px; margin: 3px; display: none;">
			<form name="form1" method="post" id="form1"
				action="login/LoginAction.action">
				<table cellpadding="0" cellspacing="0" class="l-table-edit">
					<tr>
						<td align="right" class="l-table-edit-td">
							用户名:
						</td>
						<td align="left" class="l-table-edit-td" style="width: 160px">
							<input name="username" type="text" id="username" ltype="text"
								validate="{required:true,minlength:1,maxlength:20}" />
						</td>
						<td align="left"></td>
					</tr>
					<tr>
						<td align="right" class="l-table-edit-td">
							密&nbsp;&nbsp;&nbsp;码:
						</td>
						<td align="left" class="l-table-edit-td" style="width: 160px">
							<input name="password" type="password" id="password" ltype="text"
								validate="{required:true,minlength:1,maxlength:20}" />
						</td>
						<td align="left"></td>
					</tr>
				</table>
				<br />
				<input type="button" value="提交" id="Button"
					class="l-button l-button-submit" style="width:110px;"/>
				<input type="reset" value="重置" id="Reset"
					class="l-button l-button-test" style="width:110px;" />
			</form>
		</div>
		<%
			}
		%>
		<div id="topmenu" class="l-topmenu">
			<div class="l-topmenu-logo">
				山东省食品药品职业学院 网上报修系统
			</div>
			<div class="l-topmenu-welcome">
				<a href="login/LogoutAction.action" class="l-link2">退出</a>
			</div>
		</div>

		<div id="layout1"
			style="width: 99.2%; margin: 0 auto; margin-top: 4px;">
			<% String sname = (String)session.getAttribute("sname"); %>
			<div position="left" title="欢迎您：<%=(sname==null)?"":sname %>" id="accordion1">
			<%if(sno != null){
				int funcno = (Integer)session.getAttribute("funcno");			
				if(funcno == 1){
			%>
				<div title="功能列表" class="l-scroll">
		        	<ul id="tree3" style="margin-top:3px;">
		        </div>
		        <%}else if(funcno == 6) {%>
		    	<div title="功能列表" class="l-scroll">
		        	<ul id="tree2" style="margin-top:3px;">
		        </div>
		        <%}else {%>
		    	<div title="功能列表" class="l-scroll">
		        	<ul id="tree1" style="margin-top:3px;">
		        </div>
		        <%} 
			}
		        %>
			</div>
			
			<div position="center" id="framecenter">
				<div tabid="home" title="通知公告" style="height: 300px">
					<iframe frameborder="0" name="home" id="home" src="<%=basePath %>admin/notice/getNotices.action"></iframe>
				</div>
			</div>
		</div>

		<div style="height: 32px; line-height: 32px; text-align: center;">
			Copyright © 2011-2019 山东省食品药品职业学院
		</div>
		<div style="display: none"></div>
	</body>
</html>

