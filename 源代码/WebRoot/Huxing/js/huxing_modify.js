$(function () {
	$.ajax({
		url : "Huxing/" + $("#huxing_huxingId_edit").val() + "/update",
		type : "get",
		data : {
			//huxingId : $("#huxing_huxingId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (huxing, response, status) {
			$.messager.progress("close");
			if (huxing) { 
				$("#huxing_huxingId_edit").val(huxing.huxingId);
				$("#huxing_huxingId_edit").validatebox({
					required : true,
					missingMessage : "请输入户型id",
					editable: false
				});
				$("#huxing_huxingName_edit").val(huxing.huxingName);
				$("#huxing_huxingName_edit").validatebox({
					required : true,
					missingMessage : "请输入户型名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#huxingModifyButton").click(function(){ 
		if ($("#huxingEditForm").form("validate")) {
			$("#huxingEditForm").form({
			    url:"Huxing/" +  $("#huxing_huxingId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#huxingEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#huxingEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
