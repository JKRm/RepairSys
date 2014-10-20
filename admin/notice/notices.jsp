<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*,
			stcm.repair.service.impl.NoticeServiceImpl,
			stcm.repair.model.Notice
"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>通知列表</title>
<link href="<%=basePath %>css/manage_notice.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>js/string.js" type="text/javascript"></script>
<script>
	function con(nid) {
		if (confirm("确定删除？")) {
			var form = document.createElement("form");
			location.href = "<%=basePath %>admin/notice/delete.action?nid=" + nid;
			form.submit();
			alert(form.action);
		} else {
		}
	}
</script>
<style>
	.top {
	 	margin-top: 23px;
		margin-left: 9px;
		padding-left: 6px;
		padding-bottom: 2px;
		border-bottom: 1px solid rgb(230, 230, 230);
		font-size: 12px;
	}
	.top span {
		font-weight: bold;
	}
</style>
</head>
<body>
<div class="top">
			<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif" />
			<span>通知列表</span>
</div>
<div id="noticeList">
  <ul>
  <%List<Notice> notices = (List<Notice>) session.getAttribute("notices");
  	for (int i=0; i<notices.size(); ++i) {
  		Notice notice = notices.get(i);
  %>
  <li>
    <a href="<%=basePath %>admin/notice/get.action?nid=<%=notice.getNid() %>"><%=notice.getTitle() %></a>
    <span class="time">[<%=notice.getTime().substring(0, 10) %>]</span>
    <span class="actions">
      <a href="<%=basePath %>admin/notice/edit.action?nid=<%=notice.getNid() %>">编辑</a>
      <a style="cursor:pointer" onclick="con(<%=notice.getNid() %>)">删除</a>
    </span>
  </li>
  <%}%>
  </ul>
</div>
</body>
</html>