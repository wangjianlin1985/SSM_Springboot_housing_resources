<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/priceRange.css" />
<div id="priceRangeAddDiv">
	<form id="priceRangeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">租金范围区段:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="priceRange_rangeName" name="priceRange.rangeName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="priceRangeAddButton" class="easyui-linkbutton">添加</a>
			<a id="priceRangeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/PriceRange/js/priceRange_add.js"></script> 
