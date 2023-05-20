<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.House" %>
<%@ page import="com.chengxusheji.po.Area" %>
<%@ page import="com.chengxusheji.po.Huxing" %>
<%@ page import="com.chengxusheji.po.PriceRange" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<House> houseList = (List<House>)request.getAttribute("houseList");
    //获取所有的areaObj信息
    List<Area> areaList = (List<Area>)request.getAttribute("areaList");
    //获取所有的huxingObj信息
    List<Huxing> huxingList = (List<Huxing>)request.getAttribute("huxingList");
    //获取所有的priceRangeObj信息
    List<PriceRange> priceRangeList = (List<PriceRange>)request.getAttribute("priceRangeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Area areaObj = (Area)request.getAttribute("areaObj");
    String houseName = (String)request.getAttribute("houseName"); //房源名称查询关键字
    Huxing huxingObj = (Huxing)request.getAttribute("huxingObj");
    PriceRange priceRangeObj = (PriceRange)request.getAttribute("priceRangeObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String publishDate = (String)request.getAttribute("publishDate"); //发布时间查询关键字
    String shenHeState = (String)request.getAttribute("shenHeState"); //审核状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>房源查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>House/frontlist">房源信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>House/house_frontAdd.jsp" style="display:none;">添加房源</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<houseList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		House house = houseList.get(i); //获取到房源对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>House/<%=house.getHouseId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=house.getHousePhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		所在区域:<%=house.getAreaObj().getAreaName() %>
			     	</div>
			     	<div class="field">
	            		房源名称:<%=house.getHouseName() %>
			     	</div>
			     	<div class="field">
	            		面积:<%=house.getMj() %>平米
			     	</div>
			     	<div class="field">
	            		所在楼层:<%=house.getFloor() %>
			     	</div>
			     	<div class="field">
	            		户型:<%=house.getHuxingObj().getHuxingName() %>
			     	</div>
			     	<div class="field" style="display:none;">
	            		租金范围:<%=house.getPriceRangeObj().getRangeName() %>
			     	</div>
			     	<div class="field">
	            		租金价格:<%=house.getPrice() %>元/月
			     	</div>
			     	<div class="field">
	            		朝向:<%=house.getChaoxiang() %>
			     	</div>
			     	<div class="field" style="display:none;">
	            		联系人:<%=house.getLxr() %>
			     	</div>
			     	<div class="field" style="display:none;">
	            		联系电话:<%=house.getTelephone() %>
			     	</div>
			     	<div class="field" style="display:none;">
	            		发布人:<%=house.getUserObj().getName() %>
			     	</div>
			     	<div class="field" style="display:none;">
	            		发布时间:<%=house.getPublishDate() %>
			     	</div>
			     	<div class="field" style="display:none;">
	            		审核状态:<%=house.getShenHeState() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>House/<%=house.getHouseId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="houseEdit('<%=house.getHouseId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="houseDelete('<%=house.getHouseId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>房源查询</h1>
		</div>
		<form name="houseQueryForm" id="houseQueryForm" action="<%=basePath %>House/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="areaObj_areaId">所在区域：</label>
                <select id="areaObj_areaId" name="areaObj.areaId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Area areaTemp:areaList) {
	 					String selected = "";
 					if(areaObj!=null && areaObj.getAreaId()!=null && areaObj.getAreaId().intValue()==areaTemp.getAreaId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=areaTemp.getAreaId() %>" <%=selected %>><%=areaTemp.getAreaName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="houseName">房源名称:</label>
				<input type="text" id="houseName" name="houseName" value="<%=houseName %>" class="form-control" placeholder="请输入房源名称">
			</div>
            <div class="form-group">
            	<label for="huxingObj_huxingId">户型：</label>
                <select id="huxingObj_huxingId" name="huxingObj.huxingId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Huxing huxingTemp:huxingList) {
	 					String selected = "";
 					if(huxingObj!=null && huxingObj.getHuxingId()!=null && huxingObj.getHuxingId().intValue()==huxingTemp.getHuxingId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=huxingTemp.getHuxingId() %>" <%=selected %>><%=huxingTemp.getHuxingName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="priceRangeObj_rangeId">租金范围：</label>
                <select id="priceRangeObj_rangeId" name="priceRangeObj.rangeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(PriceRange priceRangeTemp:priceRangeList) {
	 					String selected = "";
 					if(priceRangeObj!=null && priceRangeObj.getRangeId()!=null && priceRangeObj.getRangeId().intValue()==priceRangeTemp.getRangeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=priceRangeTemp.getRangeId() %>" <%=selected %>><%=priceRangeTemp.getRangeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group" style="display:none;">
            	<label for="userObj_user_name">发布人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="publishDate">发布时间:</label>
				<input type="text" id="publishDate" name="publishDate" class="form-control"  placeholder="请选择发布时间" value="<%=publishDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group" style="display:none;">
				<label for="shenHeState">审核状态:</label>
				<input type="text" id="shenHeState" name="shenHeState" value="<%=shenHeState %>" class="form-control" placeholder="请输入审核状态">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="houseEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;房源信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="houseEditForm" id="houseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="house_houseId_edit" class="col-md-3 text-right">房源id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="house_houseId_edit" name="house.houseId" class="form-control" placeholder="请输入房源id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="house_areaObj_areaId_edit" class="col-md-3 text-right">所在区域:</label>
		  	 <div class="col-md-9">
			    <select id="house_areaObj_areaId_edit" name="house.areaObj.areaId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_houseName_edit" class="col-md-3 text-right">房源名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="house_houseName_edit" name="house.houseName" class="form-control" placeholder="请输入房源名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_housePhoto_edit" class="col-md-3 text-right">房源照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="house_housePhotoImg" border="0px"/><br/>
			    <input type="hidden" id="house_housePhoto" name="house.housePhoto"/>
			    <input id="housePhotoFile" name="housePhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_mj_edit" class="col-md-3 text-right">面积:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="house_mj_edit" name="house.mj" class="form-control" placeholder="请输入面积">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_floor_edit" class="col-md-3 text-right">所在楼层:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="house_floor_edit" name="house.floor" class="form-control" placeholder="请输入所在楼层">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_huxingObj_huxingId_edit" class="col-md-3 text-right">户型:</label>
		  	 <div class="col-md-9">
			    <select id="house_huxingObj_huxingId_edit" name="house.huxingObj.huxingId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_priceRangeObj_rangeId_edit" class="col-md-3 text-right">租金范围:</label>
		  	 <div class="col-md-9">
			    <select id="house_priceRangeObj_rangeId_edit" name="house.priceRangeObj.rangeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_price_edit" class="col-md-3 text-right">租金价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="house_price_edit" name="house.price" class="form-control" placeholder="请输入租金价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_chaoxiang_edit" class="col-md-3 text-right">朝向:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="house_chaoxiang_edit" name="house.chaoxiang" class="form-control" placeholder="请输入朝向">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_address_edit" class="col-md-3 text-right">小区地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="house_address_edit" name="house.address" class="form-control" placeholder="请输入小区地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_lxr_edit" class="col-md-3 text-right">联系人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="house_lxr_edit" name="house.lxr" class="form-control" placeholder="请输入联系人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="house_telephone_edit" name="house.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_houseDesc_edit" class="col-md-3 text-right">房源详情:</label>
		  	 <div class="col-md-9">
			 	<textarea name="house.houseDesc" id="house_houseDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_userObj_user_name_edit" class="col-md-3 text-right">发布人:</label>
		  	 <div class="col-md-9">
			    <select id="house_userObj_user_name_edit" name="house.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_publishDate_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date house_publishDate_edit col-md-12" data-link-field="house_publishDate_edit">
                    <input class="form-control" id="house_publishDate_edit" name="house.publishDate" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="house_shenHeState_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="house_shenHeState_edit" name="house.shenHeState" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
		</form> 
	    <style>#houseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxHouseModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var house_houseDesc_edit = UE.getEditor('house_houseDesc_edit'); //房源详情编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.houseQueryForm.currentPage.value = currentPage;
    document.houseQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.houseQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.houseQueryForm.currentPage.value = pageValue;
    documenthouseQueryForm.submit();
}

/*弹出修改房源界面并初始化数据*/
function houseEdit(houseId) {
	$.ajax({
		url :  basePath + "House/" + houseId + "/update",
		type : "get",
		dataType: "json",
		success : function (house, response, status) {
			if (house) {
				$("#house_houseId_edit").val(house.houseId);
				$.ajax({
					url: basePath + "Area/listAll",
					type: "get",
					success: function(areas,response,status) { 
						$("#house_areaObj_areaId_edit").empty();
						var html="";
		        		$(areas).each(function(i,area){
		        			html += "<option value='" + area.areaId + "'>" + area.areaName + "</option>";
		        		});
		        		$("#house_areaObj_areaId_edit").html(html);
		        		$("#house_areaObj_areaId_edit").val(house.areaObjPri);
					}
				});
				$("#house_houseName_edit").val(house.houseName);
				$("#house_housePhoto").val(house.housePhoto);
				$("#house_housePhotoImg").attr("src", basePath +　house.housePhoto);
				$("#house_mj_edit").val(house.mj);
				$("#house_floor_edit").val(house.floor);
				$.ajax({
					url: basePath + "Huxing/listAll",
					type: "get",
					success: function(huxings,response,status) { 
						$("#house_huxingObj_huxingId_edit").empty();
						var html="";
		        		$(huxings).each(function(i,huxing){
		        			html += "<option value='" + huxing.huxingId + "'>" + huxing.huxingName + "</option>";
		        		});
		        		$("#house_huxingObj_huxingId_edit").html(html);
		        		$("#house_huxingObj_huxingId_edit").val(house.huxingObjPri);
					}
				});
				$.ajax({
					url: basePath + "PriceRange/listAll",
					type: "get",
					success: function(priceRanges,response,status) { 
						$("#house_priceRangeObj_rangeId_edit").empty();
						var html="";
		        		$(priceRanges).each(function(i,priceRange){
		        			html += "<option value='" + priceRange.rangeId + "'>" + priceRange.rangeName + "</option>";
		        		});
		        		$("#house_priceRangeObj_rangeId_edit").html(html);
		        		$("#house_priceRangeObj_rangeId_edit").val(house.priceRangeObjPri);
					}
				});
				$("#house_price_edit").val(house.price);
				$("#house_chaoxiang_edit").val(house.chaoxiang);
				$("#house_address_edit").val(house.address);
				$("#house_lxr_edit").val(house.lxr);
				$("#house_telephone_edit").val(house.telephone);
				house_houseDesc_edit.setContent(house.houseDesc, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#house_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#house_userObj_user_name_edit").html(html);
		        		$("#house_userObj_user_name_edit").val(house.userObjPri);
					}
				});
				$("#house_publishDate_edit").val(house.publishDate);
				$("#house_shenHeState_edit").val(house.shenHeState);
				$('#houseEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除房源信息*/
function houseDelete(houseId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "House/deletes",
			data : {
				houseIds : houseId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#houseQueryForm").submit();
					//location.href= basePath + "House/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交房源信息表单给服务器端修改*/
function ajaxHouseModify() {
	$.ajax({
		url :  basePath + "House/" + $("#house_houseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#houseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#houseQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*发布时间组件*/
    $('.house_publishDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

