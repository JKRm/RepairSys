<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>新增通知</title>
<link href="<%=basePath %>css/manage_notice.css" rel="stylesheet" type="text/css" />
<script src="<%=basePath %>js/string.js" type="text/javascript"></script>
<script>
	function addNewImgLine() {
		var area = document.getElementById("imgInputArea");
		area.innerHTML += "<p><label class=\"level2\">附件名称</label><input type=\"text\" name=\"atitle\"/></p><p><label class=\"level2\">选择附件</label><input type=\"file\" name=\"upload\"/></p>";
	}
	function addNoticeCheck() {
		var title = document.getElementById("title").value;
		var detail = document.getElementById("detail").value;
		title = Trim(title);
		detail = Trim(detail);
		if (title != "" && detail != "") {
			return true;
		} 
		if (title == "") {
			document.getElementById("title_prompt").innerHTML = "标题不能为空";
			document.getElementById("title_prompt").style.visibility = "visible";
		} else {
			document.getElementById("title_prompt").innerHTML = "";
			document.getElementById("title_prompt").style.visibility = "hidden";
		}
		if (detail == "") {
			document.getElementById("detail_prompt").innerHTML = "内容不能为空";
			document.getElementById("detail_prompt").style.visibility = "visible";
		} else {
			document.getElementById("detail_prompt").innerHTML = "";
			document.getElementById("detail_prompt").style.visibility = "hidden";
		}
		return false;
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
			<span>添加通知</span>
</div>
<div id="editDiv">
  <form action="<%=basePath %>admin/notice/AddNotice.action" enctype="multipart/form-data" onsubmit="return addNoticeCheck()" method="post">
	<p>
	  <label class="notnull">标题</label>
	  <input type="text" id="title" name="title"/>
	  <span id="title_prompt" class="prompt"></span>
	</p>
	<p>
	  <label class="notnull">内容</label>
	  <span id="detail_prompt" class="prompt">
	  </span>
	</p>
	<p>
	  <label>&nbsp;</label>
	  <textarea id="detail" name="detail"></textarea>
	</p>
	<div id="attachmentList">
	<p><label>附件列表</label><span id="upload_prompt" class="prompt"></span></p>
	<div id="imgInputArea">
	  <p><label class="level2">附件名称</label><input type="text" name="atitle"/></p>
	  <p><label class="level2">选择附件</label><input type="file" name="upload" /></p>
	  <p><label class="level2">附件名称</label><input type="text" name="atitle"/></p>
	  <p><label class="level2">选择附件</label><input type="file" name="upload" /></p>
	</div>
	<p class="moreButton"><input type="button" onclick="addNewImgLine()" value="点此添加更多附件"/></p>
	</div>
	<p class="submitLine"><input type="submit" value="提交"/></p>
  </form>
</div>
</body>
</html>