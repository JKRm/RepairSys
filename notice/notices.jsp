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
<link href="<%=basePath %>css/notice.css" rel="stylesheet" type="text/css" />
<link href="<%=basePath%>css/form.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="noticeList">
  <ul>
  <%List<Notice> notices = (List<Notice>) session.getAttribute("notices");
  	for (int i=0; i<notices.size(); ++i) {
  		Notice notice = notices.get(i);
  %>
  <li>
    <a href="<%=basePath %>admin/notice/read.action?nid=<%=notice.getNid() %>"><%=notice.getTitle() %></a>
    <span class="time">[<%=notice.getTime().substring(0, 10) %>]</span>
  </li>
  <%}%>
  </ul>
</div>
</body>
</html>