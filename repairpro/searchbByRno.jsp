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
			
<script type="text/javascript">
	
	var grid = null;
	var reportJson = ${requestScope.reportJson};
	var CustomersData = {
		Rows : reportJson
	};
	$(function() {

	//var tab = $(window.parent.document).find("#framecenter");
	
	
	//var framec = parent.document.getElementById("framecenter").ligerGetTabManager();
	//var tab = framec.ligerGetTabManager();
		//$("#btnOK").ligerButton();
		grid = $("#maingrid4").ligerGrid({

			columns : [

			{
				display : '报修单编号',
				name : 'rno',
				align : 'left',
				width : 120
			},

			{
				display : '姓名',
				name : 'sname',
				width : 90
			}, {
				display : '单位',
				name : 'dname',
				minWidth : 140
			}, {
				display : '报修地点',
				name : 'location',
				minWidth : 140
			}, {
				display : '用料',
				name : 'supplies',
				minWidth : 140
			}, {
				display : '损坏数量',
				name : 'damagenum',
				width : 60
			},

			{
				display : '损坏类型',
				name : 'type',
				width : 60
			}, {
				display : '报修单状态',
				name : 'state',
				width : 80
			}, {
				display : '费用',
				name : 'price',
				width : 60
			}, {
				display : '报修时间',
				name : 'time'
			}, {
				display : '详细描述',
				name : 'description'
			} ,{ display: '操作', isSort: false, width: 90, render: function (rowdata, rowindex, value)
                {
                var h = "";
                if (!rowdata._editing)
                {
                    h += "<a href='javascript:beginEdit(" + rowindex + ")'>查看</a> ";
                    if(rowdata.state == "尚未审批" || rowdata.state == "未通过" || rowdata.state == "已完成")
                    	h += "<a href='javascript:deleteRow(" + rowindex + ")'>删除</a> "; 
                }
                else
                {
                    h += "<a href='javascript:endEdit(" + rowindex + ")'>提交</a> ";
                    h += "<a href='javascript:cancelEdit(" + rowindex + ")'>取消</a> "; 
                }
                return h;
            }
            }
            ],
            
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
		
		if($("#btnBack").val() == undefined){
			$("#btnOK").after("<input id='btnBack' class='l-btn' style='width:100px;' type='button' value='返回' onclick='f_back()' />");
		}

	}

	function f_back()
	{
		grid.options.data = $.extend(true, {}, CustomersData);

		grid.loadData(f_getWhereback());
		
		$("#btnBack").remove();
	}
	
	function f_getWhere()

	{

		if (!grid)
			return null;

		var clause = function(rowdata, rowindex)

		{

			var key = $("#txtKey").val();

			return rowdata.rno.indexOf(key) > -1;

		};

		return clause;

	}
	
	function f_getWhereback()

	{

		if (!grid)
			return null;

		var clause = function(rowdata, rowindex)

		{
			return true;

		};

		return clause;

	}
	
	
	function beginEdit(rowid) { 
		var row = grid.getSelectedRow();
	    $.ligerDialog.open({
			title : '报修详细信息',
			url : 'repair/ReportSingleAction.action?rno='+ JSON.stringify(row.rno),
			height : 650,
			width : 500,
			isDrag : false
		});
	}
	function cancelEdit(rowid) { 
		grid.cancelEdit(rowid);
    }
    function endEdit(rowid)
    {
    	grid.endEdit(rowid);
    }

    function deleteRow(rowid)
    {
    	var row = grid.getSelectedRow();
        if (confirm('确定删除?'))
        {
            $.get("repair/DeleteAction.action?rno="+ JSON.stringify(row.rno),
					function(data, statusText) {
				if (data == "success") {
					$.ligerDialog.success('删除成功');
		        	grid.deleteRow(rowid);
				} else {
					$.ligerDialog.error('删除失败');
				}
			}, "html");
        }
    }
    
</script>

		<style type="text/css">
.l-table-edit-td {
	padding: 4px;
	margin-left: 10px;
	float: left;
}

#btnOK.l-btn { /*	width: 80px;*/
	margin-left: 10px;
	float: left;
}

#maingrid4 {
	clear: both;
	margin-top: 10px;
}
.l-text-wrapper {
	float: left;
}
#searchbar div {
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
</style>
</head>
<body style="padding: 10px;">
<div class="top">
			<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif" />
			<span>报修编号查询</span>
</div>
		<div id="searchbar">
		<div>
		<div class="l-text-wrapper">&nbsp;&nbsp;报修单编号：&nbsp;</div>
			<input id="txtKey" type="text" class=".l-table-edit-td" />
		</div>
		<input id="btnOK" type="button" class="l-button" value="查询" onclick="f_search()" />
		</div>

		<div id="maingrid4"></div>

		<div style="display: none;">
		</div>
		
	</body>

</html>
