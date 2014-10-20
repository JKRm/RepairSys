var eee;
$(function() {
	$("#buttons").click(function() {
		
		$.get("staffinfo/ModifyPswAction.action",
				$("#form1").serializeArray(),
				function(data, statusText) {
			if (data == "success") {
				var massage = $.ligerDialog.success('密码修改成功');
			} else if(data == "error"){
				$.ligerDialog.error('密码错误请重新输入');
			} else if(data == "sosmall"){
				$.ligerDialog.error('新密码不能小于6位');
			} else{
				$.ligerDialog.error('新密码两次输入的不一致');
			}
			
			
		}, "html");
		
	});
	
});