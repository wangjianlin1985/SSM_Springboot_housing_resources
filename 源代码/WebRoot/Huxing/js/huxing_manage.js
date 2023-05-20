var huxing_manage_tool = null; 
$(function () { 
	initHuxingManageTool(); //建立Huxing管理对象
	huxing_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#huxing_manage").datagrid({
		url : 'Huxing/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "huxingId",
		sortOrder : "desc",
		toolbar : "#huxing_manage_tool",
		columns : [[
			{
				field : "huxingId",
				title : "户型id",
				width : 70,
			},
			{
				field : "huxingName",
				title : "户型名称",
				width : 140,
			},
		]],
	});

	$("#huxingEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#huxingEditForm").form("validate")) {
					//验证表单 
					if(!$("#huxingEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#huxingEditForm").form({
						    url:"Huxing/" + $("#huxing_huxingId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#huxingEditDiv").dialog("close");
			                        huxing_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#huxingEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#huxingEditDiv").dialog("close");
				$("#huxingEditForm").form("reset"); 
			},
		}],
	});
});

function initHuxingManageTool() {
	huxing_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#huxing_manage").datagrid("reload");
		},
		redo : function () {
			$("#huxing_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#huxing_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#huxingQueryForm").form({
			    url:"Huxing/OutToExcel",
			});
			//提交表单
			$("#huxingQueryForm").submit();
		},
		remove : function () {
			var rows = $("#huxing_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var huxingIds = [];
						for (var i = 0; i < rows.length; i ++) {
							huxingIds.push(rows[i].huxingId);
						}
						$.ajax({
							type : "POST",
							url : "Huxing/deletes",
							data : {
								huxingIds : huxingIds.join(","),
							},
							beforeSend : function () {
								$("#huxing_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#huxing_manage").datagrid("loaded");
									$("#huxing_manage").datagrid("load");
									$("#huxing_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#huxing_manage").datagrid("loaded");
									$("#huxing_manage").datagrid("load");
									$("#huxing_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#huxing_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Huxing/" + rows[0].huxingId +  "/update",
					type : "get",
					data : {
						//huxingId : rows[0].huxingId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (huxing, response, status) {
						$.messager.progress("close");
						if (huxing) { 
							$("#huxingEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
