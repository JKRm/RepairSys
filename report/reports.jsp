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

		<title>报修管理</title>

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
	var reportJson = ${requestScope.reportJson};
	var stateData = [{state:'已完成',text:'已完成'},{state:'未确认',text:'未确认'},{state:'正在维修',text:'正在维修'},{state:'未缴费',text:'未缴费'},{state:'未通过',text:'未通过'},{state:'尚未审批',text:'尚未审批'}];
	var CustomersData = {
		Rows : reportJson
	};
	$(function() {

		//$("#btnOK").ligerButton();
		grid = $("#maingrid4").ligerGrid({

			columns : [

			{
				display : '报修单编号',
				name : 'rno',
				align : 'left',
				width : 120,
				frozen : true
			},

			{
				display : '姓名',
				name : 'sname',
				minWidth : 60,
				frozen : true
			}, {
				display : '单位',
				name : 'dname',
				minWidth : 160,
				frozen : true
			}, {
				display : '报修地点',
				name : 'location',
				minWidth : 150,
				frozen : true
			}, {
				display : '用料',
				name : 'supplies',
				minWidth : 140,
				frozen : true
			}, {
				display : '损坏数量',
				name : 'damagenum',
				minWidth : 80,
				frozen : true
			},

			{
				display : '损坏类型',
				name : 'type',
				frozen : true
			}, {
				display : '报修单状态',
				name : 'state',
				editor : {type : 'select', data : stateData, valueColumnName : 'state'},
				frozen : true
			}, {
				display : '费用',
				name : 'price',
				frozen : true
			}, {
				display : '报修时间',
				name : 'time',
				type : 'date',
				format : 'yyyy-MM-dd',
				width : 100,
				frozen : true
			}, {
				display : '详细描述',
				name : 'description',
				width : 300,
				frozen : true
			} ],
			onSelectRow : function(rowdata, rowindex)
			{
				$("#txtrowindex").val(rowindex);

			},
			enabledEdit: true,
			clickToEdit: true,
			checkbox:true,
			rownumbers:true,
			pageSize : 30,
			where : f_getWhere(),

			data : $.extend(true, {}, CustomersData),

			width : '100%',
			height : '100%'

		});

		$("#pageloading").hide();

	});
	
	function deleteRow()
    {
        var newRow = grid.get('data').Rows.slice(0);
		var toDel = grid.getCheckedRows();
    //	var datadel = grid.getDeleted(); 
        var dele=eval(JSON.stringify(toDel));
        var delmno = new Array();
        for(var i=0;i<dele.length;i++){
        	delmno[i]=dele[i].rno;
        	for(var j=0;j<newRow.length;j++) {
        		if (delmno[i] == newRow[j].rno) {
        			newRow.splice(j,1);
        			j = j-1;
        		}
        	}
        }
        
        
  // var param = {'rno':delmno};
       $.post(
       		"<%=basePath%>report/DeleteAction.action",
       		"rno="+delmno,
       		function (data, statusCode) {
       			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
       				$.ligerDialog.error("未知错误");
       			} else if(data == "success"){
       				$.ligerDialog.success("删除成功");
       				grid.deleteSelectedRow();
       				CustomersData = {
       						Rows : newRow
       				};
       				showAll('');
       			} else if (data == "error") {
       				$.ligerDialog.error("删除失败");
       			}
       			
       		}
       		);
   
    }
	
	function saveUpdate()
	 {
		var newRow = grid.get('data').Rows.slice(0);
    	var data = grid.getUpdated();
        var myobj=eval(JSON.stringify(data));
        var state = new Array();
        var rno = new Array();
        
        for(var i=0;i<myobj.length;i++){
        	state[i]=myobj[i].state;  
        	rno[i]=myobj[i].rno;  
        	for(var j=0;j<newRow.length;j++) {
        		if (rno[i] == newRow[j].rno) {
        			newRow[j].state = state[i];
        		}
        	}
		} 
        $.post(
        		"<%=basePath%>report/UpdateAction.action",
        		"state="+state+"&rno="+rno,
        		function (data, statusCode) {
        			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
        				$.ligerDialog.error("未知错误");
        			} else if(data == "success"){
        				$.ligerDialog.success("修改成功");
        				CustomersData = {
           						Rows : newRow
           				};
        				showAll('');
        			} else if (data == "error") {
        				$.ligerDialog.error("修改失败");
        			}
        		}
        		);
        
    }
	
	function showAll(key)
	{
		grid.options.data = $.extend(true, {}, CustomersData);

		grid.loadData(f_getWhere(key));
	}

	function f_search(key)
	{

		grid.options.data = $.extend(true, {}, CustomersData);

		grid.loadData(f_getWhere(key));

	}

	function f_getWhere(key)
	{

		if (!grid)
			return null;

		var clause = function(rowdata, rowindex)
		{

			return rowdata.state.indexOf(key) > -1;

		};

		return clause;

	}
</script>

<style type="text/css">
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
			<span>报修信息维护</span>
		</div>
		<div class="content">
			<div>
	   			<input type="button" class="l-button" onclick="f_search('已完成');" value="查找已完成报修单"/>
	   			<input type="button" class="l-button" onclick="deleteRow();" value="删除选中行"/>
				<input type="button" class="l-button" onclick="saveUpdate();" value="保存修改"/>
				<input type="button" class="l-button" onclick="showAll('');" value="显示全部"/>  
			</div>
			<div id="maingrid4"></div>
		</div>
</body>

</html>
