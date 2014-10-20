<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="stcm.repair.model.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Area.jsp' starting page</title>
    
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
        var bno;
        var sno;
        $(function ()
        {
            $("#btnSet").bind('click', function ()
            {
				var cho = $("#BuildingNo").val();
				$.get("locationinfo/buildingAction.action",
				"bno="+cho,
				function(data, statusText) {
					var list = data;
					var jsonStr = eval('('+list+')');
					var length = jsonStr.length;
					snoValue=jsonStr[0]["value"];
					document.getElementById("sno").value=snoValue;	
				},
				"html");
				
		}  );
        }); 
        
        function updateSno(){
        var newsno=document.getElementById("new").value;
        var bbno=document.getElementById("BuildingNo").value;
        $.post(
           		"<%=basePath%>locationinfo/SetNewbAction.action",
           		{'bno':bbno,'newSno':newsno},
           		function (data, statusCode) {
           			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
           				$.ligerDialog.error("未知错误！");
           			} else if(data == "success"){
           				$.ligerDialog.success("负责人修改成功");
           			} else if (data == "error") {
           				$.ligerDialog.error("负责人修改失败");
           			}
           			
           		}
           		);
        
        
        }
        
        function change()
	{
		var cho = $("#AreaNo").val();
		if(cho=='0') {
			$("#BuildingNo option").remove();
			$("#BuildingNo").append("<option value='0'>请选择</option>");
		}
		else {
			$.get("report/JsonAction.action",
			"AreaNo="+cho,
			function(data, statusText) {
				var list = data;
				var jsonStr = eval('('+list+')');
				var length = jsonStr.length;
				$("#BuildingNo option").remove();
				$("#BuildingNo").append("<option value='0'>请选择</option>");
				for (var i = 0; i < length; ++i) {
					var addItem = "<option value='"+jsonStr[i]["value"]+"'>"+jsonStr[i]["text"]+"</option>";
					$("#BuildingNo").append(addItem);
				}
			},
			"html");
		}
	}  
    </script>

  </head>
  
  <body style="padding:10px">
  <div class="title">
		<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif">
		<span>楼群负责人查询及修改</span>
		</div>
		<div class="content">
  		<p>
  		<label>区域：</label>
  		<select name="AreaNo" id="AreaNo" ltype="select" onchange="change()">
                <option value="0">请选择</option>
                <%
					 List<Area> area = new ArrayList<Area>();
					 
					 area = (List<Area>)request.getAttribute("areaList");
                
                	 for(int i=0;i<area.size();i++){
                	 	
                	 	String areaName = area.get(i).getAname();
                	 	
                	 	int AreaNo = area.get(i).getAno();
                	 	
                 %>
					<option value="<%=AreaNo %>"><%=areaName %></option>
					<%} %>
					
		</select>
		</p>
		<p>
			<label>楼栋： </label>
			<select name="BuildingNo" id="BuildingNo" ltype="select" >
                <option value='0'>请选择</option>
        	</select>
		<input type="button" class="l-button" id="btnSet" value="查询" />
		</p>
		<p>
			<label>原负责人：</label>
			<input readonly type="text" id="sno" class="text readonly" ligerui="width:150"/>
		<p>
			<label>新负责人：</label><input type="text" id="new" class="text" ligerui="width:150" />
			<input type="button" class="l-button" id="motify" value="修改" onclick="updateSno()" />
		</p>
		</div>
	</body>
</html>
