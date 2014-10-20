<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="stcm.repair.util.Excel" %>
<%@ page import="stcm.repair.model.Report" %>
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
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDateEditor.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>
		<script type="text/javascript">
      //var arealist = ${requestScope.arealist};
	var grid = null;
	var reportJson = ${requestScope.showlist};
	var CustomersData = {
		Rows : reportJson
	};
	$(function() {
		var arealist = ${requestScope.arealist};
		var buildinglist = ${requestScope.buildinglist};
		var roomlist = ${requestScope.roomlist};
		var departmentlist = ${requestScope.departmentlist};
		var myDate = new Date();

		$("#txt1").ligerDateEditor({
			label : '',
			labelWidth : 100,
			labelAlign : 'right',
			initValue : dateToStr(myDate)
		});

		
		$("#txt2").ligerDateEditor({
			format: "yyyy-MM-dd",
			label : '',
			labelWidth : 67,
			labelAlign : 'right',
			initValue : dateToStr(myDate)
		});
		
	//	$("#btnOK").ligerButton();
		
		grid = $("#maingrid4").ligerGrid(
						{

							columns : [

									{
										display : '维修编号',
										name : 'rno',
										align : 'left',
										width : 120
									},

									{
										display : '报修单位',
										name : 'dname',
										minWidth : 60
									},
									{
										display : '报修地点',
										name : 'location',
										minWidth : 140
									},
									{
										display : '保修种类',
										name : 'type'
									},
									{
										display : '维修价格',
										name : 'price'
									},
									{
										display : '详细描述',
										name : 'description',
										width : 280
									}
								    ],

							pageSize : 30,

							data : $.extend(true, {}, CustomersData),

							width : '100%',
							height : '100%'

						});

		$("#pageloading").hide();
		
		$("#txtArea").ligerComboBox({ data: arealist, isMultiSelect: false,
            onSelected: function (newvalue)
            {
                var newData = new Array();
                for (i = 0; i < buildinglist.length; i++)
                {
                    if (buildinglist[i].pid == newvalue)
                    {
                        newData.push(buildinglist[i]);
                    }
                }
                $("#txtBuilding").ligerGetComboBoxManager().setData(newData);
            }
        });
        $("#txtBuilding").ligerComboBox({ data: null, isMultiSelect: false,
        	onSelected: function (newvalue)
            {
                var newData1 = new Array();
                for (i = 0; i < roomlist.length; i++)
                {
                    if (roomlist[i].pid == newvalue)
                    {
                        newData1.push(roomlist[i]);
                    }
                }
                $("#txtRoom").ligerGetComboBoxManager().clearContent();
                $("#txtRoom").ligerGetComboBoxManager().setData(newData1);
            }	
        });
        $("#txtRoom").ligerComboBox({ data: null, isMultiSelect: false});
	    $("#txtDepartment").ligerComboBox({ data: departmentlist, isMultiSelect: false, isShowCheckBox: false });
    

	});

	function f_search()

	{
		self.location.href='total/TotalRepairAction.action?dname='+$("#txtDepartment").val()+'&area='+$("#txtArea").val()+'&building='+$("#txtBuilding").val()+'&room='+$("#txtRoom").val()+'&start='+$("#txt1").val()+'&end='+$("#txt2").val();
	}

	function dateToStr(datetime){

		var year = datetime.getFullYear();
		var month = datetime.getMonth()+1;//js从0开始取 
		var date = datetime.getDate(); 
		
		if(month<10){
		 month = "0" + month;
		}
		if(date<10){
		 date = "0" + date;
		}


		var time = year+"-"+month+"-"+date; 

		return time;
		}
</script>

<style type="text/css">

#maingrid4 {
	clear: both;
	margin-top: 10px;
}
.l-text-wrapper {
	float: left  !important;
	display: inline-block  !important;
}
.l-box-select-table {
	font-size: 12px;
}
.l-text-label {
	width: 80px !important;
	margin-right: 10px;
}

</style>

</head>
<body>
	<div class="title">
		<img src="<%=basePath %>lib/ligerUI/skins/icons/communication.gif">
		<span>费用汇总</span>
	</div>
	<div class="content">
		<p>
			<label>选择区域：</label>
			<input type="text" id="txtArea" />
			<label>选择楼群：</label>
			<input type="text" id="txtBuilding" />
			<label>选择房间：</label>
			<input type="text" id="txtRoom" />
		</p>
		<p>
			<label>使用单位：</label>
			<input type="text" id="txtDepartment" />
			<label>开始时间：</label>
			<input type="text" id="txt1" />
			<label>结束时间：</label>
			<input type="text" id="txt2" />
			<input id="btnOK" type="button" class="l-button" value="查询" onclick="f_search()" />
		</p>
	</div>
		<div id="maingrid4"></div>
</div>
	</body>

</html>
