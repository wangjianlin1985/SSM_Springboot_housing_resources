<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/huxing.css" />
<div id="huxing_editDiv">
	<form id="huxingEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">户型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="huxing_huxingId_edit" name="huxing.huxingId" value="<%=request.getParameter("huxingId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">户型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="huxing_huxingName_edit" name="huxing.huxingName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="huxingModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Huxing/js/huxing_modify.js"></script> 
