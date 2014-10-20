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

		<title>维修信息维护</title>

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
	
	var oldTime = null;
	var grid = null;
	var maintenances = ${requestScope.maintenances};
	var CustomersData = {
		Rows : maintenances
	};
	$(function() {

		//$("#btnOK").ligerButton();
		grid = $("#maingrid4").ligerGrid({

			columns : [
			{
				display : '维修编号',
				name : 'mtno',
				align : 'left',
				width : 100,
				frozen : true
			},
			{
				display : '维修位置',
				name : 'location',
				width : 160,
				frozen : true
			},
			{
				display : '维修人',
				name : 'mter',
				Width : 100,
				editor : {type : 'text'}
			}, 
			{
				display : '维修起始时间',
				name : 'time',
				type : 'date',
				format : 'yyyy-MM-dd',
				width : 105,
				editor : {type : 'date'}
			},
			{
				display : '保质期限',
				name : 'period',
				minWidth : 143,
				editor : {type : 'text'}
			},
			{
				display : '价格',
				name : 'price',
				width : 80,
				editor : {type : 'float'}
			},
			{
				display : '维修详细',
				name : 'content',
				minWidth : 349,
				align : 'left',
				editor : {type : 'text'}
			},
			{
				display : '操作',
				isSort : false,
				width : 80,
				render : function (rowdata, rowindex, value)
				{
					 var h = "";
	                    if (!rowdata._editing)
	                    {
	                        h += "<a href='javascript:beginEdit(" + rowindex + ")'>修改</a> ";
	                    }
	                    else
	                    {
	                        h += "<a href='javascript:endEdit(" + rowindex + ")'>提交</a> ";
	                        h += "<a href='javascript:cancelEdit(" + rowindex + ")'>取消</a> "; 
	                    }
	                    return h;
				}
			}],
			onSelectRow : function(rowdata, rowindex)

			{
				$("#txtrowindex").val(rowindex);

			},
			enabledEdit: true,
			clickToEdit: false,
			resizable : true,//版本暂不支持
			pageSize : 30,
			where : f_getWhere(),
			data : $.extend(true, {}, CustomersData),

			width : '100%',
			height : '100%'

		});

		$("#pageloading").hide();

	});
	
	function beginEdit(rowid) { 
    	operant = "modify";
    	var row = grid.getSelectedRow();
    	oldTime = row.time;
    	grid.beginEdit(rowid);
    }
    function cancelEdit(rowid) {
    	operant = "no";
    	grid.cancelEdit(rowid);
    }
    function endEdit(rowid)
    {
    	grid.endEdit(rowid);
    	
    	var row = grid.getSelectedRow();
    	if (!row) { alert('请选择行'); return; }
    	
    	var comment = JSON.stringify(row);
    	comment = JSON.parse(comment);
    	var id = comment.id;//执行updateRow后更改了notice.id
		
    	if ((comment.time == null || comment.time == "") && oldTime != null && oldTime != "") { //可能是个bug，不对日期框做更改时，日期框的旧值会丢失。
    		comment.time = oldTime;
    		grid.updateRow(comment, grid.getSelectedRowObj());//将日期的旧值显示。
    		
    	} else if (comment.time != null && comment.time != ""){
    		var t = comment.time.split('-');
    		var tt = t[0]+"/"+t[1]+"/"+t[2].substring(0,2);
    		var dd = new Date(tt); 
         	var tmp = dd.valueOf(); 
    		tmp = tmp+1*24*60*60*1000;
    		var d = new Date(tmp);
    		var mm = d.getMonth()+1;
    		comment.time = d.getFullYear() + "-" + mm + "-" + d.getDate();
    	}
    	
    	comment.id = id;
    	var newRow = CustomersData.Rows.slice(0);
    	for (var j = 0; j < newRow.length; ++j) {
    		
    	}
    	
    	var url = "<%=basePath%>maintenance/UpdateAction.action?id="+comment.id+"&mtno="+comment.mtno+
			"&lno="+comment.lno;
    	if (comment.mter != undefined) url += "&mter="+encodeURI(encodeURI(comment.mter)); 
    	if (comment.time != undefined) url += "&mttime="+comment.time; 
    	if (comment.period != undefined) url += "&mtperiod="+encodeURI(encodeURI(comment.period)); 
    	if (comment.price != undefined) url += "&mtprice="+encodeURI(encodeURI(comment.price)); 
    	if (comment.content != undefined) url += "&mtcontent="+encodeURI(encodeURI(comment.content)); 
    	
   		$.get(
 				url,
 				function(data, statuscode){
 					if (data == "success") {
    						$.ligerDialog.success('操作成功');
    					} else if (data == "error") {
    						$.ligerDialog.error('操作失败');
    						grid.cancelEdit(rowid);
    					} else {
    						$.ligerDialog.error(data);
    						grid.cancelEdit(rowid);
    					}
 				},
 				"html");
   	}
    
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
			var key = $("#key").val();

			return rowdata.mtno.indexOf(key) > -1;

		};

		return clause;
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
}
</style>
	</head>
	<body style="padding: 10px;">
	<div class="title">
		<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif">
		<span>维修信息维护</span>
	</div>
	<div class="content">
		<div id="searchbar">
			<label>维修编号：</label>
			<input id="key" type="text" class=".l-table-edit-td text" />
			<input id="btnOK" type="button" class="l-button" value="查询" onclick="f_search()" />
		</div>

		<div id="maingrid4"></div>

		<div style="display: none;">
		</div>
		
	</div>
	</body>
</html>
