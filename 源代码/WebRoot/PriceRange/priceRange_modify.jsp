<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/priceRange.css" />
<div id="priceRange_editDiv">
	<form id="priceRangeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">租金范围id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="priceRange_rangeId_edit" name="priceRange.rangeId" value="<%=request.getParameter("rangeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">租金范围区段:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="priceRange_rangeName_edit" name="priceRange.rangeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="priceRangeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/PriceRange/js/priceRange_modify.js"></script> 
