<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*,
			stcm.repair.model.*,
			stcm.repair.vo.NoticeVo
"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>查看通知</title>
<link href="<%=basePath %>css/notice.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>js/string.js" type="text/javascript"></script>
</head>
<body>
<div id="noticeContent">
  <%NoticeVo noticeVo = (NoticeVo) session.getAttribute("noticeVo");
  	Notice notice = noticeVo.getNotice();
  	List<Attachment> attachments = noticeVo.getAttachments();
  %>
  <p class="title"><%=notice.getTitle()%></p>
  <p class="publish_time">发表时间:<%=notice.getTime().substring(0, 19)%>&nbsp;点击:<%=notice.getVisits() %></p>
  <div id="detail">
  <p><%=notice.getDetail()%></p>
  </div>
  <% if (attachments != null && attachments.size() > 0) { %>
  <div id="fileList">
  <p>附件列表</p>
  <%for (int i=0; i<attachments.size(); ++i) {
  	Attachment attachment = attachments.get(i);
  %>
  <ul>
  <li class="<%=attachment.getUrl().substring(attachment.getUrl().lastIndexOf(".")+1, attachment.getUrl().length()) %>">
  	<a href="<%=basePath %>file/<%=attachment.getUrl() %>"><%=attachment.getAtitle() %></a>
  </li>
  </ul>
  <%} %>
  </div>
  <%} %>
</div>
</body>
</html>