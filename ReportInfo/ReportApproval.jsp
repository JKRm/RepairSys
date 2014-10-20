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

        var reportJson = ${requestScope.reportJson};
		var CustomersData = {
			Rows : reportJson
		};
        var stateData = [{ state: '尚未审批', text: '尚未审批' }, { state: '未通过', text: '未通过'}, { state: '未缴费' , text: '未缴费'}, { state: '正在维修', text: '正在维修'}];
        $(f_initGrid);
        var manager, g;
        function f_initGrid()
        { 
           g =  manager = $("#maingrid").ligerGrid({
                columns: [
                { display: '报修单编号', name: 'rno',width : 120, type: 'text',frozen:true },
                { display: '姓名', name: 'sname',minWidth : 60,
                   frozen:true
                },
                { display: '单位',  name: 'dname',type:'text',minWidth : 140,
                    frozen:true
                },
                { display: '报修地点', name: 'location',  type: 'text',minWidth : 140, frozen:true },
                { display: '用料', name: 'supplies', type: 'text', minWidth : 140, frozen:true},
                { display: '损坏数量', name: 'damagenum',  type: 'int',width : 50,frozen:true},
                { display: '损坏类型', name: 'type',type: 'text',width : 50,  frozen:true
                },
                { display: '报修单状态', name: 'state',type: 'text',
                	editor: { type: 'select', data: stateData, valueColumnName: 'state' },
                    	render: function (item)
                    	{
                        if (item.state == '未通过') return '未通过';  
                     	if (item.state == '未缴费') return '未缴费';
                     	if (item.state == '正在维修') return '正在维修';
                      	
                        	return '尚未审批';
                    	}
                },
                 { display: '费用', name: 'price',  type: 'float',width : 60, editor: { type: 'float'} },
                 { display: '报修时间', name: 'time',  type: 'date',frozen:true },
                 { display: '详细描述', name: 'description', type: 'text',frozen:true }
                ],
               
                enabledEdit: true, isScroll: false, checkbox:false,rownumbers:true,
                data:$.extend(true, {}, CustomersData),
                width: '100%'
            });  
            
             
        }
        
       
        function getData()
        { 
            var data = manager.getData();
            alert(JSON.stringify(data));
        }
        function getData()
        {
            var data = manager.getData();
            alert(JSON.stringify(data));
        }
        function getUpdate()
        {
            var data = manager.getUpdated();
            var myobj=eval(JSON.stringify(data));
            var arno = new Array();
            var astate = new Array();
            var aprice = new Array();
            for(var i=0;i<myobj.length;i++){  
   				arno[i]=myobj[i].rno;  
   				astate[i]=myobj[i].state; 
   				aprice[i]= myobj[i].price; 
			}  
            
            $.post(
            		"<%=basePath%>report/ApprovalUpdateAction.action",
            		{'Jsonrno':arno, 'Jsonstate':astate, 'Jsonprice':aprice},
            		function (data, statusCode) {
            			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
            				$.ligerDialog.error("未知错误");
            			} else if(data == "success"){
            				$.ligerDialog.success("审批成功");
            			} else if (data == "error") {
            				$.ligerDialog.error("审批失败");
            			}
            			
            		}
            		);
        }
        function getDelete()
        {
            var data = manager.getDeleted();
            alert(JSON.stringify(data));
        }
        function getAdd()
        {
            var data = manager.getAdded();
            alert(JSON.stringify(data));
        }
    </script>

 <style>
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
	.l-button {
		display: inline-block;
		height: 23px;
		width: 120px;
	}
</style>
</head>
<body style="padding: 10px;">
<div class="top">
			<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif" />
			<span>报修审批</span>
</div>
    <div id="maingrid" style="margin-top:20px; margin-bottom: 10px;clear: both;"></div>
<p style="text-align:center; margin-top: 10px;">
   	<input class="l-button" type="button" onclick="getUpdate()" value="确认审批">
   <input class="l-button" type="button" onclick="f_initGrid()" value="恢复更改"/>  
</p>
</body>
</html>
