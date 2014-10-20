<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="stcm.repair.model.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ReportAddition.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <link href="<%=basePath%>lib/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <link href="<%=basePath%>lib/ligerUI/skins/Silvery/css/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>css/form.css" rel="stylesheet" type="text/css" />
    <script src="<%=basePath%>lib/jquery/jquery-1.3.2.min.js" type="text/javascript"></script>
     <script src="<%=basePath%>lib/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerButton.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerRadio.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script> 
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTip.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
    <script src="<%=basePath%>lib/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=basePath%>lib/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script type="text/javascript">
        var eee;
        $(function ()
        {
            $.metadata.setType("attr", "validate");
            var v = $("#form1").validate({
                errorPlacement: function (lable, element)
                {
                    if (element.hasClass("l-textarea"))
                    {
                        element.ligerTip({ content: lable.html(), target: element[0] }); 
                    }
                    else if (element.hasClass("l-text-field"))
                    {
                        element.parent().ligerTip({ content: lable.html(), target: element[0] });
                    }
                    else
                    {
                        lable.appendTo(element.parents("td:first").next("td"));
                    }
                },
                success: function (lable)
                {
                    lable.ligerHideTip();
                    lable.remove();
                }
                
            });

        });
        
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
	
	 function change2()
	{
	
		var cho = $("#BuildingNo").val();
		if(cho=='0') {
			$("#RoomNo option").remove();
			$("#RoomNo").append("<option value='0'>请选择</option>");
		}
		else {
			$.get("report/Json4roomAction.action",
			"BuildingNo="+cho,
			function(data, statusText) {
				var list = data;
				var jsonStr = eval('('+list+')');
				var length = jsonStr.length;
				$("#RoomNo option").remove();
				$("#RoomNo").append("<option value='0'>请选择</option>");
				for (var i = 0; i < length; ++i) {
					var addItem = "<option value='"+jsonStr[i]["value"]+"'>"+jsonStr[i]["text"]+"</option>";
					$("#RoomNo").append(addItem);
				}
			},
			"html");
		}
	}  
	
	function change3()
	{
		var cho = $("#category").val();
		if(cho=='0') {
			$("#supplies option").remove();
			$("#supplies").append("<option value='0'>请选择</option>");
		}
		else {
			$.get("report/Json4categoryAction.action",
			"category="+cho,
			function(data, statusText) {
				var list = data;
				var jsonStr = eval('('+list+')');
				var length = jsonStr.length;
				$("#supplies option").remove();
				$("#supplies").append("<option value='0'>请选择</option>");
				for (var i = 0; i < length; ++i) {
					var addItem = "<option value='"+jsonStr[i]["value"]+"'>"+jsonStr[i]["text"]+"</option>";
					$("#supplies").append(addItem);
				}
			},
			"html");
		}
	}  
	
	function getRadioValue(name){
		var radioes = document.getElementsByName(name);
		for(var i=0;i<radioes.length;i++)
		{
     		if(radioes[i].checked){
      		return radioes[i].value;
     		}
		}
		return false;
	}
	
	function setupdatedata(){
		var roomNo=document.getElementById("RoomNo").value;
		var rtype=getRadioValue("rtype");
		var supplies=document.getElementById("supplies").value;
		var damagenum=document.getElementById("damagenum").value;
		var rdescription=document.getElementById("rdescription").value;
		$.post(
            		"<%=basePath%>report/AddReportAction.action",
            		{'roomNo':roomNo, 'rtype':rtype, 'supplies':supplies, 'damagenum':damagenum, 'rdescription':rdescription},
            		function (data, statusCode) {
            			if (statusCode == 404 || statusCode == 400 || statusCode == 500) {
            				$.ligerDialog.error("未知错误");
            			} else if(data == "success"){
            				$.ligerDialog.success("新增报修成功");
            			} else if (data == "error") {
            				$.ligerDialog.error("新增报修失败");
            			}
            			
            		}
            		);
	}
	
    </script>
    <style type="text/css">
    label {
    	width: 120px !important;
    }
    textarea {
    	width: 465px !important;
    	height: 150px;
    	resize: none;
    }
    .l-button {
    	display: inline-block !important;
    }
    .content {
    }
    </style>
	
  </head>
  
  <body style="padding:10px">	
	<div class="title">
		<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif">
		<span>添加报修</span>
	</div>
	<div class="content">
            <%int funcno = (Integer)session.getAttribute("funcno");
            	if(funcno == 1 || funcno == 6){%>	
      <p>	
          <label>所属区域：</label>
          <select name="AreaNo" id="AreaNo" ltype="select"  onchange="change()">
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
          <label>楼号：</label>
          <select name="BuildingNo" id="BuildingNo" ltype="select" onchange="change2()">
                <option value='0'>请选择</option>
				</select>
          <label>房间号：</label>
          <select name="RoomNo" id="RoomNo" ltype="select">
					<option value='0'>请选择</option>
				</select>
           <%}else if(funcno == 2){%>
           <label>楼号：</label>
           <select name="BuildingNo" id="BuildingNo" ltype="select" onchange="change2()">
                <option value='0'>请选择</option>
                 <%
					 List<Building> building = (List<Building>)request.getAttribute("buildingList");
                	 for(int i=0;i<building.size();i++){
                	 	String buildingName = building.get(i).getBname();
                	 	int buildingNo = building.get(i).getBno();
                 %>
					<option value="<%=buildingNo %>"><%=buildingName %></option>
					<%} %>
				</select>
          	<label>房间号：</label>
                <select name="RoomNo" id="RoomNo" ltype="select">
					<option value='0'>请选择</option>
				</select>
           <%}else{%>
        	<label>房间号：</label>
                <select name="RoomNo" id="RoomNo" ltype="select">
					<option value='0'>请选择</option>
					<%
					 List<Location> room = (List<Location>)request.getAttribute("roomList");
                	 for(int i=0;i<room.size();i++){
                	 	String roomName = room.get(i).getRoom();
                	 	int roomNo = room.get(i).getLno();
                 %>
					<option value="<%=roomNo %>"><%=roomName %></option>
					<%} %>
				</select>
           <% }%>
           </p>
           <p>
           <label>报修类型：</label>
                    <input id="rtype1" type="radio" name="rtype" value="水"/>&nbsp;水&nbsp;&nbsp;
                    <input id="rtype2" type="radio" name="rtype" value="电" />&nbsp;电&nbsp;&nbsp;
                    <input id="rtype3" type="radio" name="rtype" value="木" />&nbsp;木&nbsp;&nbsp;
                    <input id="rtype4" type="radio" name="rtype" value="其它" />&nbsp;其他&nbsp;&nbsp;
           </p>
           <p>     
           <label>损坏物品种类：</label>
                <select name="category" id="category" ltype="select" onchange="change3()">
                <option value="0">请选择</option>
					<%
					 List<Category> category = new ArrayList<Category>();
					 category = (List<Category>)request.getAttribute("categoryList");
                	 for(int i=0;i<category.size();i++){
                	 	String categoryName = category.get(i).getCname();
                	 	int cno = category.get(i).getCno();
                 %>
					<option value="<%=cno %>"><%=categoryName %></option>
					<%} %>
				</select>
			 </p>
			 <p>
			 <label>损坏物品名称：</label>
                <select name="supplies" id="supplies" ltype="select">
                <option value='0'>请选择</option>
				</select>
			  </p>
			  <p>
				<label>损坏数量：</label>
                    <input name="damagenum" type="text" id="damagenum" ltype='spinner' ligerui="{type:'int'}" value="1" class="required" validate="{digits:true,min:1,max:100}" />
    		  </p>
			  <p>
    		<label>损坏描述：</label>
                <textarea name="rdescription"class="l-textarea" id="rdescription" style="width:400px" validate="{required:true}" ></textarea>
			</p>
			<p style="margin-top: 10px;margin-left: 300px;">
				<input type="button" value="提交" id="Button1" class="l-button l-button-submit" onclick="setupdatedata();"/> 
				<input type="reset" value="重置" class="l-button l-button-test"/>
		    </p>
	</div>
</body>
</html>
