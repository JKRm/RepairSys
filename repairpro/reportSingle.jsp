<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="stcm.repair.model.Report"%>
<%@ page import="stcm.repair.model.Maintenance"%>
<%@ page import="stcm.repair.model.Comment"%>
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

		<title>My JSP 'reportSingle.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" >
		<link href="<%=basePath%>lib/ligerUI/skins/Aqua/css/ligerui-all.css"
			rel="stylesheet" type="text/css" />

		<link href="<%=basePath%>lib/ligerUI/skins/Gray/css/all.css"
			rel="stylesheet" type="text/css" />

		<script src="<%=basePath%>js/json2.js" type="text/javascript"></script>
		<script src="<%=basePath%>lib/jquery/jquery-1.3.2.min.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/core/base.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerForm.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerSpinner.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTextBox.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerComboBox.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerResizable.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerTip.js"
			type="text/javascript"></script>

		<script src="<%=basePath%>lib/jquery-validation/jquery.metadata.js"
			type="text/javascript"></script>
		<script src="<%=basePath%>lib/ligerUI/js/plugins/ligerDialog.js"
			type="text/javascript"></script>
		<style type="text/css">
.l-button-submit,.l-button-test {
	width: 80px;
	float: left;
	margin-left: 10px;
	padding-bottom: 2px;
}
</style>
		<script type="text/javascript"> 

        var groupicon = "<%=basePath%>lib/ligerUI/skins/icons/communication.gif";
//        var arealist = ${requestScope.arealist};
  //      var buildinglist = ${requestScope.buildinglist};
    //    var roomlist = ${requestScope.roomlist};
       var funcno = ${sessionScope.funcno};
        $(function ()

        {
            $.metadata.setType("attr", "validate");

            //创建表单结构

            var mainform = $("#form1");

            mainform.ligerForm({

                inputWidth: 170, labelWidth: 90, space: 40,

                fields: [
<%Report report = (Report) request.getAttribute("report");
			Maintenance maintenance = (Maintenance) request
					.getAttribute("maintenance");
			Comment comment = (Comment) session.getAttribute("commented");%>
                { display: "姓名",name:"sname",type:"text", group: "报修信息表", groupicon: groupicon,options:{value:"<%=report.getSno().getSname() == null ? "" : report.getSno()
					.getSname()%>" ,disabled:true}}, 

                { display: "单位", name:"dno",type:"text", options:{value:"<%=report.getDno().getDname() == null ? "" : report.getDno()
					.getDname()%>" ,disabled:true}}, 

                { display: "报修单编号", name:"rno",type:"text", options:{value:"<%=report.getRno() == null ? "" : report.getRno()%>" ,disabled:true}}, 

                { display: "报修位置", name:"location",type:"text", options:{value:"<%=report.getLno().getBno().getAno().getAname() + "  "
					+ report.getLno().getBno().getBname() + "  "
					+ report.getLno().getRoom()%>" ,disabled:true}},

				{ display: "所用物料", name:"supplies",type:"text", options:{value:"<%=report.getMno().getMname() == null ? "" : report.getMno()
					.getMname()%>" ,disabled:true}},
                
                { display: "损坏数量", name:"dragnum",type:"text", options:{value:"<%=report.getDamagenum()%>" ,disabled:true}},
                
                { display: "报修类型", name:"type",type:"text", options:{value:"<%=report.getRtype() == null ? "" : report.getRtype()%>" ,disabled:true}},
                
                { display: "报修状态", name:"state",type:"text", options:{value:"<%=report.getRstate() == null ? "" : report.getRstate()%>" ,disabled:true}},
                
                { display: "所用费用", name:"price",type:"text", options:{value:"<%=report.getRprice()%>" ,disabled:true}},
                
                { display: "保修时间", name:"time",type:"text", options:{value:"<%=report.getRtype() == null ? "" : report.getRtype()
					.toString()%>" ,disabled:true}},
                
                { display: "详细描述", name:"description",type:"text", options:{value:"<%=report.getRdescription() == null ? "" : report
					.getRdescription()%>" ,disabled:true}},
                
                { display: "维修人",name:"wname",type:"text", group: "维修信息表", groupicon: groupicon,options:{value:"<%=maintenance.getMter() == null ? "" : maintenance
					.getMter()%>" ,disabled:true}}, 

                { display: "维修时间", name:"wtime",type:"text", options:{value:"<%=maintenance.getMttime() == null ? "" : maintenance
					.getMttime().toString()%>" ,disabled:true}},

                { display: "保质期限", name:"wperiod",type:"text", options:{value:"<%=maintenance.getMtperiod() == null ? "" : maintenance
					.getMtperiod()%>" ,disabled:true}},

                { display: "实用费用", name:"wprice",type:"text", options:{value:"<%=maintenance.getMtprice()%>" ,disabled:true}},

                { display: "维修评价",name:"content",type:"text", group: "维修评价表", groupicon: groupicon,options:{value:"<%=comment.getCcontent() == null ? "" : comment
					.getCcontent()%>" ,disabled:true}}

                ]

            });
        	if($("#content").val() == ""&&funcno != 1&&funcno != 6)
        		{
        			$("#form1").after("<br /><br /><input id='comment_buttons' type='button' value='添加评论' class='l-button l-button-test' onclick='addcomment()'/>");
        		}
        	/*$("#txtArea").ligerComboBox({ data: arealist, isMultiSelect: false,
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
            $("#txtRoom").ligerComboBox({ data: null, isMultiSelect: false});*/
        });  
     
	function addcomment()
	{
		
		$("#content").attr({readonly:false});
		if($("#Buttons").val() == undefined)
			$("#comment_buttons").after("<input id='Buttons' type='button' value='提交' class='l-button l-button-test'/>");
		
		$("#comment_buttons").remove();
		//if($("#goback_buttons") != undefined)
		
	   	$("#Buttons").click(function() {
			$.get("repair/ContentAction.action",
					$("#content").serializeArray(),
					function(data, statusText) {
				if (data == "success") {
					$.ligerDialog.success('评论成功');
				} else {
					$.ligerDialog.error('评论失败');
				}
			}, "html");
		});
	}
	
    </script>


	</head>

	<body style="padding: 10px">
		<div>
			<form id="form1"></form>
			<%--<div>
				<%Integer funcno = (Integer)session.getAttribute("funcno");
				if(funcno == 1 || funcno== 6){%>
				<input type="text" id="txtArea" />
				<input type="text" id="txtBuilding" />
				<input type="text" id="txtRoom" />
				<%}else if(funcno == 2){%>
				<input type="text" id="txtBuilding" />
				<input type="text" id="txtRoom" />
				<%}else{%>
				<input type="text" id="txtRoom" />
				<%}%>
			</div>
			--%>
		</div>
</html>
