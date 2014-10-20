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
	var staffJson = ${requestScope.staffJson};
    var CustomersData = {
		Rows : staffJson
	};
	var funcJson = ${requestScope.funcJson};
    var FuncData = {
		Rows : funcJson
	};
	var depJson = ${requestScope.depJson};
    var DepData = {
		Rows : depJson
	};
	$(function() {

		//$("#btnOK").ligerButton();
		grid = $("#maingrid4").ligerGrid({

			columns : [

			{
				display : '用户编号',
				name : 'sno',
				align : 'center',
				width : 150,
				frozen : true
			},

			{
				display : '用户名',
				name : 'sname',
				minWidth : 80,
				frozen : true
			}, {
				display : '联系电话',
				name : 'phone',
				minWidth : 170,
				editor: { type: 'text' }
			}, {
				display : '邮箱',
				name : 'email',
				minWidth : 210,
				editor: { type: 'text' }
			}, {
				display : '用户类型',
				name : 'funcno',
				minWidth : 150,
				editor: { type: 'select', data: FuncData.Rows, valueColumnName: 'funcno',displayColumnName: 'funcname' },
                render: function (item)
                {
                    for (var i = 0; i < FuncData.Rows.length; i++)
                    {
                        if (FuncData.Rows[i]['funcno'] == item.funcno)
                            return FuncData.Rows[i]['funcname'];
                    }
                    return item.funcname;
                }
			}, {
				display : '所属部门',
				name : 'dno',
				minWidth : 295,
				editor: { type: 'select', data: DepData.Rows, valueColumnName: 'dno',displayColumnName: 'dname' },
                render: function (item)
                {
                    for (var i = 0; i < DepData.Rows.length; i++)
                    {
                        if (DepData.Rows[i]['dno'] == item.dno)
                            return DepData.Rows[i]['dname'];
                    }
                    return item.dname;
                }
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
			height : 400

		});

		$("#pageloading").hide();

	});
	
	function getDelete()
    {
        var data = grid.getCheckedRows();
        var del=eval(JSON.stringify(data));
        var delsno = new Array();
        for(var i=0;i<del.length;i++){
        	delsno[i]=del[i].sno; 
        }
        
       $.post(
       		"<%=basePath %>admin/staff/DeleteAction.action",
       		"dsno="+delsno,
       		function (data, statusCode) {
       			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
       				$.ligerDialog.error("未知错误");
       			} else if(data == "success"){
       				$.ligerDialog.success("删除用户信息成功");
       				grid.deleteSelectedRow();
       			} else if (data == "error") {
       				$.ligerDialog.error("删除用户信息失败");
       			} else{
       				$.ligerDialog.error(data);
       			}
       			
       		},"html"
       		);
    }
	
	function getUpdate()
    {
		//var newRow = grid.get('data').Rows.slice(0);
        var data = grid.getUpdated();
        var myobj=eval(JSON.stringify(data));
        var sno = new Array();
        var sname = new Array();
        var phone = new Array();
        var email = new Array();
        var funcno = new Array();
        var dno = new Array();
        for(var i=0;i<myobj.length;i++){
        		sno[i]=myobj[i].sno;  
				sname[i]=myobj[i].sname;  
				phone[i]=myobj[i].phone; 
				email[i]= myobj[i].email; 
				funcno[i]= myobj[i].funcno; 
				dno[i]= myobj[i].dno; 
		}
        $.post(
        		"<%=basePath %>admin/staff/save.action",
        		"sno="+sno+"&sname="+sname+"&phone="+phone+"&email="+email+"&funcno="+funcno+"&dno="+dno,
        		function (data, statusCode) {
        			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
        				$.ligerDialog.error("未知错误");
        			} else if(data == "success"){
        				$.ligerDialog.success("修改用户信息成功");
        			} else if (data == "error") {
        				$.ligerDialog.error("修改用户信息失败");
        			}
        			
        		},"html"
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
			<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif" />
			<span>用户操作</span>
</div>
 <div class="l-clear"></div>
    
    <div id="maingrid4" style="margin-top:20px"></div> <br /><br />
    <div class="buttonsLine">
	    <input class="l-button" type="button" onclick="getUpdate()" value="保存修改">
   		<!-- <input class="l-button" type="button" onclick="getDelete()" value="删除选中行"> -->
   	</div>
  <div style="display:none;">
  <!-- g data total ttt -->
  </div>
</body>

</html>
