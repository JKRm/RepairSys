<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ReportApproval.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <link href="<%=basePath%>lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/json2.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <link href="<%=basePath%>css/example.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">

    var grid = null;
    var suppliesJson = ${requestScope.suppliesJson};
    var CustomersData = {
		Rows : suppliesJson
	};
    var categoryJson = ${requestScope.categoryJson};
    var categoryData = {
		Rows : categoryJson
	};
	$(function() {

		//$("#btnOK").ligerButton();
		grid = $("#maingrid4").ligerGrid({

			columns : [

			{
				display : '物料编号',
				name : 'mno',
				width : 120,
				frozen : false
			},

			{
				display : '物料种类',
				name : 'cno',
				minWidth : 60,
				editor: { type: 'select', data: categoryData.Rows, valueColumnName: 'cno',displayColumnName: 'cname' },
                render: function (item)
                {
                    for (var i = 0; i < categoryData.Rows.length; i++)
                    {
                        if (categoryData.Rows[i]['cno'] == item.cno)
                            return categoryData.Rows[i]['cname'];
                    }
                    return item.cname;
                }
					
			}, {
				display : '物料名称',
				name : 'mname',
				minWidth : 190,
				 editor: { type: 'text' }
			}, {
				display : '物料数量',
				name : 'mnum',
				minWidth : 150,
				editor: { type: 'int'}
			}, {
				display : '物料单价',
				name : 'mprice',
				minWidth : 140,
				 editor: { type: 'float'}
			}, {
				display : '备注',
				name : 'mcontent',
				minWidth : 400,
				editor: { type: 'text' }
			}],
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
        
        function addEmpty()
        {
        var row = grid.getSelectedRow();
        grid.addRow(row);
        }
        
        function addNewRow()
        {
            var data = grid.getAdded();
            var myobj=eval(JSON.stringify(data));
            var mno = new Array();
            var cno = new Array();
            var mname = new Array();
            var mnum = new Array();
            var mprice = new Array();
            var mcontent = new Array();
            for(var i=0;i<myobj.length;i++){
            	mno[i]=myobj[i].mno;  
   				cno[i]=myobj[i].cno;
   				mname[i]=myobj[i].mname; 
   				mnum[i]= myobj[i].mnum; 
   				mprice[i]= myobj[i].mprice; 
   				mcontent[i]= myobj[i].mcontent; 
			} 
            $.post(
            		"<%=basePath%>supplies/suppliesAddAction.action",
            		"amno="+mno+"&acno="+cno+"&amname="+mname+"&amnum="+mnum+"&amprice="+mprice+"&amcontent="+mcontent,
            		function (data, statusCode) {
            			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
            				$.ligerDialog.error("未知错误");
            			} else if(data == "success"){
            				$.ligerDialog.success("新增物料成功");
            			} else if (data == "error") {
            				$.ligerDialog.error("新增物料失败");
            			}
            			
            		}
            		);
        } 
        function getData()
        { 
            var data = grid.getData();
        }
        function getData()
        {
            var data = grid.getData();
        }
        function getUpdate()
        {
        	var data = grid.getUpdated();
            var myobj=eval(JSON.stringify(data));
            var mno = new Array();
            var cno = new Array();
            var mname = new Array();
            var mnum = new Array();
            var mprice = new Array();
            var mcontent = new Array();
            for(var i=0;i<myobj.length;i++){
            	mno[i]=myobj[i].mno;  
   				cno[i]=myobj[i].cno;  
   				mname[i]=myobj[i].mname; 
   				mnum[i]= myobj[i].mnum;
   				mprice[i]= myobj[i].mprice; 
   				mcontent[i]= myobj[i].mcontent; 
			} 
            $.post(
            		"<%=basePath%>supplies/suppliesUpdateAction.action",
            		"mno="+mno+"&cno="+cno+"&mname="+mname+"&mnum="+mnum+"&mprice="+mprice+"&mcontent="+mcontent,
            		function (data, statusCode) {
            			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
            				$.ligerDialog.error("未知错误");
            			} else if(data == "success"){
            				$.ligerDialog.success("修改物料信息成功");
            			} else if (data == "error") {
            				$.ligerDialog.error("修改物料信息失败");
            			}
            			
            		}
            		);
            
        }
        function getDelete()
        {
        	var datadel = grid.getCheckedRows(); 
            var dele=eval(JSON.stringify(datadel));
            var delmno = new Array();
            for(var i=0;i<dele.length;i++){
            	delmno[i]=dele[i].mno; 	
            }
       
           $.post(
           		"<%=basePath%>supplies/suppliesDelAction.action",
           		"dmno="+delmno,
           		function (data, statusCode) {
           			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
           				$.ligerDialog.error("未知错误");
           			} else if(data == "success"){
           				$.ligerDialog.success("删除物料成功");
           				grid.deleteSelectedRow();
           			} else if (data == "error") {
           				$.ligerDialog.error("删除物料失败");
           			}
           			
           		}
           		);
           
        }
        
        function deleteRow()
        { 
            grid.deleteSelectedRow();
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
<style>
  .top {
	 	margin-top: 23px;
		margin-left: 19px;
		padding-left: 6px;
		padding-bottom: 2px;
		border-bottom: 1px solid rgb(230, 230, 230);
		font-size: 12px;
	}
	.top span {
		font-weight: bold;
	}
	.content {
		margin: 0 auto;
	}
	.l-button {
		width: 150px;
		display: inline-block;
	}
	#maingrid {
		clear: both;
		margin-bottom: 20px;
	}
	.buttonsLine {
		clear: both;
		width: 650px;
		margin: 0 auto;
		margin-top: 20px;
	}
</style>
</head>
<body style="padding; 10px;">
<div class="top">
			<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif" />
			<span>物料管理</span>
</div>
<div class="content">
 <div class="l-clear"></div>
    <div id="maingrid4" style="margin-top:20px"></div>
  <div class="buttonsLine">
    <input type="button" class="l-button" onclick="getDelete()" value="删除选中行"/>
    <input class="l-button" type="button" class="l-button" onclick="getUpdate()" value="保存修改">  
    <input type="button" class="l-button" onclick="addEmpty()" value="添加数据" />   
    <input class="l-button" type="button" class="l-button" onclick="addNewRow()" value="保存添加">

  </div>
</div>
</body>

</html>
