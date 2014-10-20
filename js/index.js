/**
 * 
 */
var tab = null;

var accordion = null;

var tree = null;

var eee;
// 页面布局
$(function()

{
	// 布局
	$("#layout1").ligerLayout({
		leftWidth : 200,
		height : '100%',
		heightDiff : -34,
		space : 4,
		onHeightChanged : f_heightChanged
	});
	var height = $(".l-layout-center").height();
	// Tab
	$("#framecenter").ligerTab({
		height : height
	});

	// 面板
	$("#accordion1").ligerAccordion({
		height : height - 24,
		speed : null
	});
	$(".l-link").hover(function() {
		$(this).addClass("l-link-over");

	}, function() {
		$(this).removeClass("l-link-over");
	});
	// 树
	$("#tree1").ligerTree({
		data : indexdata1,
		checkbox : false,
		slide : false,
		nodeWidth : 120,
		attribute : [ 'nodename', 'url' ],
		onSelect : function(node) {
			if (!node.data.url)
				return;
			var tabid = $(node.target).attr("tabid");
			if (!tabid) {
				tabid = new Date().getTime();
				$(node.target).attr("tabid", tabid)
			}
			f_addTab(tabid, node.data.text, node.data.url);
		}
	});
	// 树
	$("#tree2").ligerTree({
		data : indexdata2,
		checkbox : false,
		slide : false,
		nodeWidth : 120,
		attribute : [ 'nodename', 'url' ],
		onSelect : function(node) {
			if (!node.data.url)
				return;
			var tabid = $(node.target).attr("tabid");
			if (!tabid) {
				tabid = new Date().getTime();
				$(node.target).attr("tabid", tabid)
			}
			f_addTab(tabid, node.data.text, node.data.url);
		}
	});

	// 树
	$("#tree3").ligerTree({
		data : indexdata3,
		checkbox : false,
		slide : false,
		nodeWidth : 120,
		attribute : [ 'nodename', 'url' ],
		onSelect : function(node) {
			if (!node.data.url)
				return;
			var tabid = $(node.target).attr("tabid");
			if (!tabid) {
				tabid = new Date().getTime();
				$(node.target).attr("tabid", tabid)
			}
			f_addTab(tabid, node.data.text, node.data.url);
		}
	});
	tab = $("#framecenter").ligerGetTabManager();
	accordion = $("#accordion1").ligerGetAccordionManager();
	tree = $("#tree1").ligerGetTreeManager();
	$("#pageloading").hide();
});


function f_heightChanged(options) {
	if (tab)
		tab.addHeight(options.diff);
	if (accordion && options.middleHeight - 24 > 0)
		accordion.setHeight(options.middleHeight - 24);
}
function f_addTab(tabid, text, url) {
	tab.addTabItem({
		tabid : tabid,
		text : text,
		url : url
	});
}


$(function() {
	$.metadata.setType("attr", "validate");
	var v = $("#form1")
			.validate(
					{
						debug : false,
						errorPlacement : function(lable, element) {

							if (element.hasClass("l-textarea")) {
								element.addClass("l-textarea-invalid");
							} else if (element.hasClass("l-text-field")) {
								element.parent().addClass("l-text-invalid");
							}

							var nextCell = element.parents("td:first").next(
									"td");
							nextCell.find("div.l-exclamation").remove();
							$(
									'<div class="l-exclamation" title="'
											+ lable.html() + '"></div>')
									.appendTo(nextCell).ligerTip();
						},
						success : function(lable) {
							var element = $("#" + lable.attr("for"));
							var nextCell = element.parents("td:first").next(
									"td");
							if (element.hasClass("l-textarea")) {
								element.removeClass("l-textarea-invalid");
							} else if (element.hasClass("l-text-field")) {
								element.parent().removeClass("l-text-invalid");
							}
							nextCell.find("div.l-exclamation").remove();
						}
					/*
					 * submitHandler : function() { alert("Submitted!"); }
					 */
					});
	$("#form1").ligerForm();
	// $(".l-button-test").click(function () {
	// alert(v.element($("#txtName")));
	// });
	$("#Button").click(function() {
		$.get("login/LoginAjaxAction.action",
				$("#form1").serializeArray(),
				function(data, statusText) {
			if (data == "success") {
				$("#form1").submit();
			} else {
				$.ligerDialog.error('用户名或密码错误请重新输入');
			}
		}, "html");
	});
});
