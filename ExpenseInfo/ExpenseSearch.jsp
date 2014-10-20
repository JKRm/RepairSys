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
    
    <title>My JSP 'SuppliesSearch.jsp' starting page</title>
    
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
    <script src="<%=basePath%>lib/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
    <script type="text/javascript">
        var grid = null;
        var suppliesJson = ${requestScope.suppliesJson};
        var CustomersData = {
			Rows : suppliesJson
		};
        $(function () {
            grid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '物料编号', name: 'mno', align: 'center', width: 200 },
                { display: '物料名', name: 'mname', width: 200 },
                { display: '种类名', name: 'cname', width: 200,align:'center' }, 
                { display: '剩余数量', name: 'mnum', width: 100 },
                { display: '单价', name: 'mprice', width: 100 }, 
                { display: '备注', name: 'mcontent', width: 400 }
                ],  pageSize:30,where : f_getWhere(),
                data: $.extend(true,{},CustomersData), 
                width: '100%',height:'100%'
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
            if (!grid) return null;
            var clause = function (rowdata, rowindex)
            {
                var key = $("#supplies").val();
                return rowdata.mname.indexOf(key) > -1;
            };
            return clause; 
        }
        
        function reload() {
            grid = $("#maingrid4").ligerGrid({
                columns: [
                { display: '物料编号', name: 'mno', align: 'center', width: 200 },
                { display: '物料名', name: 'mname', width: 200 },
                { display: '种类名', name: 'cname', width: 200,align:'center' }, 
                { display: '剩余数量', name: 'mnum', width: 100 },
                { display: '单价', name: 'mprice', width: 100 }, 
                { display: '备注', name: 'mcontent', width: 400 }
                ],  pageSize:30,where : f_getWhere(),
                data: $.extend(true,{},CustomersData), 
                width: '100%',height:'100%'
            });


            $("#pageloading").hide();
        }
        
        
        function change()
		{
			var cho = $("#category").val();
			if(cho=='0') {
				$("#supplies option").remove();
				$("#supplies").append("<option value='0'>请选择</option>");
			}
			else {
				$.get("expense/JsonAction.action",
						"category="+cho,
						function(data, statusText) {
							var list = data;
							var jsonStr = eval('('+list+')');
							var length = jsonStr.length;
							$("#supplies option").remove();
							$("#supplies").append("<option value='0'>请选择</option>");
							for (var i = 0; i < length; ++i) {
								var addItem = "<option value='"+jsonStr[i]["text"]+"'>"+jsonStr[i]["text"]+"</option>";
								$("#supplies").append(addItem);
							}
					},
			"html");
		}
	}  
    </script>
	<style>
		.l-button {
			display: inline-block;
		}
		#maingrid4 {
			clear: both;
		}
	</style>
  </head>
  
  <body>
<div id="searchbar">
<div class="title">
		<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif">
		<span>查询物料</span>
	</div>
	<div class="content">
	<label>类型：</label>
   	<select name="category" id="category" ltype="select" onchange="change()">
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
	<label>名称：</label>
	<select name="supplies" id="supplies" ltype="select">
         <option value='0'>请选择</option>
	</select>
    <input id="btnOK" type="button" class="l-button" value="查询" onclick="f_search()" />
    <input type="button" class="l-button" value="返回" onclick="reload()" />
</div>
    <div id="maingrid4" style="margin:0; padding:0"></div>
	</div>
</body>
</html>
