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
		<link href="<%=basePath%>css/form.css" rel="stylesheet" type="text/css" />
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
			
<script type="text/javascript">
	
	var grid = null;
	var commentsJson = ${requestScope.comments};
	var CustomersData = {
		Rows : commentsJson
	};
	$(function() {

		//$("#btnOK").ligerButton();
		grid = $("#maingrid4").ligerGrid({

			columns : [
			{
				display : '职员编号',
				name : 'cmno',
				width : 150
			},
			{
				display : '报修单编号',
				name : 'rno',
				width : 150
			},
			{
				display : '等级',
				name : 'level',
				minWidth : 60
			}, 
			{
				display : '评价内容',
				name : 'content',
				minWidth : 552
			},
			{
				display : '操作',
				isSort : false,
				width : 90,
				render : function (rowdata, rowindex, value)
				{
					var h = "<a href='javascript:deleteRow("+rowindex+")'>屏蔽</a>";
					return h;
				}
			}],
			onSelectRow : function(rowdata, rowindex)

			{
				$("#txtrowindex").val(rowindex);

			},

			pageSize : 30,
			where : f_getWhere(),
			data : $.extend(true, {}, CustomersData),

			width : '100%',
			height : '100%'

		});

		$("#pageloading").hide();

	});

	function f_search()

	{

		grid.options.data = $.extend(true, {}, CustomersData);

		grid.loadData(f_getWhere());

	}

	function f_getWhere()
	{

		if (!grid)
			return null;

		var clause = function(rowdata, rowindex)
		{
			var key = $("#rnoKey").val();

			if (key == "") {
				key = $("#levelKey").val();
				return rowdata.level.indexOf(key) > -1;
			}

			return rowdata.rno.indexOf(key) > -1;

		};

		return clause;
	}
	
	function f_getAnyWhere()
	{

		if (!grid)
			return null;

		var clause = function(rowdata, rowindex)
		{
			var key = '';
			return rowdata.rno.indexOf(key) > -1;

		};
		return clause;
	}
	
	function deleteRow(rowid)
	{
		var newRow = grid.get('data').Rows.slice(0);
		$.ligerDialog.confirm('确认屏蔽', function (yes) { 
    		if (yes) {
            	var row = grid.getSelectedRow();
            	if (!row) { alert('请选择行'); return; }
            	var comment = JSON.stringify(row);
            	comment = JSON.parse(comment);
            	comment.level = "";
            	comment.content = "该评论已被屏蔽";
            	for(var j=0;j<newRow.length;j++) {
            		if (comment.rno == newRow[j].rno) {
            			newRow[j].level = comment.level;
            			newRow[j].content = comment.content;
            		}
            	}
            	
            	if (comment.rno != "") {
	            	$.post(
	        				"<%=basePath%>comment/DeleteCommentAction.action?",
	        				{'id':comment.id,'rno':comment.rno,'cmno':comment.cmno,'clevel':comment.level,'ccontent':comment.content},
	        				function(data){
	        					if (data == "success") {
		       						$.ligerDialog.success('操作成功');
		       						CustomersData = {
		               						Rows : newRow
		               				};
		       						grid.options.data = $.extend(true, {}, CustomersData);
		       						grid.loadData(f_getAnyWhere());
		       					} else if (data == "error") {
		       						$.ligerDialog.error('操作失败');
		       					} else {
		       						$.ligerDialog.error(data);
		       					}
	        				},
	        			"html");
            	}
            	
    		}
    	});
	}
</script>

		<style type="text/css">
.l-table-edit-td {
	padding: 4px;
	margin-left: 10px;
	float: left;
}

#maingrid4 {
	margin-top: 10px;
	clear: both;
}
.l-button {
	width: 150px;
	height: 22px;
	display: inline-block;
}
</style>
	</head>
	<body>
		<div class="title">
			<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif">
			<span>评价信息维护</span>
		</div>
		<div class="content">
		<div id="searchbar">
			<label>报修单编号：</label>
			<input id="rnoKey" type="text" class="text .l-table-edit-td" />
			<label>等级编号：</label>
			<input id="levelKey" type="text" class="text .l-table-edit-td" />
			<input id="btnOK" type="button" class="l-button" value="查询" onclick="f_search()" />
		</div>

		<div id="maingrid4"></div>

		</div>
		
	</body>

</html>
