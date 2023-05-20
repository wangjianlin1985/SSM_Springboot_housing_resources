<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/huxing.css" />
<div id="huxingAddDiv">
	<form id="huxingAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">户型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="huxing_huxingName" name="huxing.huxingName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="huxingAddButton" class="easyui-linkbutton">添加</a>
			<a id="huxingClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Huxing/js/huxing_add.js"></script> 
