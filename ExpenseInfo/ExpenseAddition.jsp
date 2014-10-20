<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ExpenseAddition.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <link href="<%=basePath%>lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>css/form.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>   
    <script src="<%=basePath%>lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script type="text/javascript"> 
        var rno;
        var hlocation;
        var price;
        var state;
        var time;
        var locationValue;
        var priceValue;
        var stateValue;
        var timeValue;
        $(function ()
        {
            $("#btnSet").bind('click', function ()
            {
				var cho = $("#rno").val();
				$.get("expense/confirmAction.action",
				"rno="+cho,
				function(data, statusText) {
					var list = data;
					var jsonStr = eval('('+list+')');
					var length = jsonStr.length;
					locationValue=jsonStr[0]["value"];
					priceValue=jsonStr[1]["value"];
					stateValue=jsonStr[2]["value"];
					timeValue=jsonStr[3]["value"];
					document.getElementById("hiddenRno").value=cho;
					document.getElementById("location").value=locationValue;
					document.getElementById("price").value=priceValue;
					document.getElementById("state").value=stateValue;
					document.getElementById("time").value=timeValue;
					if(stateValue!="未缴费"){
						document.getElementById("btnSub").disabled=true;
					}
					
				},
				"html");
				
		}  );
        }); 
        
        function setdel(){
        var delno=document.getElementById("rno").value;
        $.post(
           		"<%=basePath%>expense/updateAction.action",
           		{'hiddenRno':delno},
           		function (data, statusCode) {
           			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
           				$.ligerDialog.error("未知错误！");
           			} else if(data == "success"){
           				$.ligerDialog.success("缴费成功");
           			} else if (data == "error") {
           				$.ligerDialog.error("缴费失败");
           			}
           			
           		}
           		);
        
        
        }
    </script>
    <style>
    .l-button {
    	display: inline-block;
    }
    </style>
  </head>
  
  <body style="padding:10px">
  	<div class="title">
		<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif">
		<span>添加缴费</span>
	</div>
	<div class="content">
  		<p>
  			<label>报修单号：</label>
  			<input type="text" id="rno" class="text" ligerui="width:150" />
  		</p>
		<p>
			<label>报修位置：</label>
			<input readonly type="text" id="location" class="text readonly" ligerui="width:150" />
		</p>
		<p>
			<label>应付金额：</label>
			<input readonly type="text" id="price" class="text readonly" ligerui="width:150" />
		</p>
		<p>
			<label>报修状态：</label>
			<input readonly type="text" id="state" class="text readonly" ligerui="width:150" />
		</p>
		<p>
			<label>报修时间：</label>
			<input readonly type="text" id="time" class="text readonly" ligerui="width:150" />
		</p>
		<input type="hidden" id="hiddenRno" name="hiddenRno">
		<p style="margin-left: 110px;">
			<input type="button" class="l-button" id="btnSet" value="查询" />
			<input type="button" id="btnSub" class="l-button" value="缴费" onclick="setdel()" />
		</p>
	</div>
	</body>
</html>
