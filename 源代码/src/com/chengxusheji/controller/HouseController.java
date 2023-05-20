package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.HouseService;
import com.chengxusheji.po.House;
import com.chengxusheji.service.AreaService;
import com.chengxusheji.po.Area;
import com.chengxusheji.service.HuxingService;
import com.chengxusheji.po.Huxing;
import com.chengxusheji.service.PriceRangeService;
import com.chengxusheji.po.PriceRange;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//House管理控制层
@Controller
@RequestMapping("/House")
public class HouseController extends BaseController {

    /*业务层对象*/
    @Resource HouseService houseService;

    @Resource AreaService areaService;
    @Resource HuxingService huxingService;
    @Resource PriceRangeService priceRangeService;
    @Resource UserInfoService userInfoService;
	@InitBinder("areaObj")
	public void initBinderareaObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("areaObj.");
	}
	@InitBinder("huxingObj")
	public void initBinderhuxingObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("huxingObj.");
	}
	@InitBinder("priceRangeObj")
	public void initBinderpriceRangeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("priceRangeObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("house")
	public void initBinderHouse(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("house.");
	}
	/*跳转到添加House视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new House());
		/*查询所有的Area信息*/
		List<Area> areaList = areaService.queryAllArea();
		request.setAttribute("areaList", areaList);
		/*查询所有的Huxing信息*/
		List<Huxing> huxingList = huxingService.queryAllHuxing();
		request.setAttribute("huxingList", huxingList);
		/*查询所有的PriceRange信息*/
		List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
		request.setAttribute("priceRangeList", priceRangeList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "House_add";
	}
	
	
	

	/*客户端ajax方式提交添加房源信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated House house, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			house.setHousePhoto(this.handlePhotoUpload(request, "housePhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        houseService.addHouse(house);
        message = "房源添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	/*客户端ajax方式提交添加房源信息*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(House house, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			house.setHousePhoto(this.handlePhotoUpload(request, "housePhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		house.setPublishDate(sdf.format(new java.util.Date()));
		
		String user_name = (String) session.getAttribute("user_name");
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(user_name);
		house.setUserObj(userObj);
		
        houseService.addHouse(house);
        message = "房源添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	
	/*ajax方式按照查询条件分页查询房源信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("areaObj") Area areaObj,String houseName,@ModelAttribute("huxingObj") Huxing huxingObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj,@ModelAttribute("userObj") UserInfo userObj,String publishDate,String shenHeState,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (houseName == null) houseName = "";
		if (publishDate == null) publishDate = "";
		if (shenHeState == null) shenHeState = "";
		if(rows != 0)houseService.setRows(rows);
		List<House> houseList = houseService.queryHouse(areaObj, houseName, huxingObj, priceRangeObj, userObj, publishDate, shenHeState, page);
	    /*计算总的页数和总的记录数*/
	    houseService.queryTotalPageAndRecordNumber(areaObj, houseName, huxingObj, priceRangeObj, userObj, publishDate, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = houseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = houseService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(House house:houseList) {
			JSONObject jsonHouse = house.getJsonObject();
			jsonArray.put(jsonHouse);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询房源信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<House> houseList = houseService.queryAllHouse();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(House house:houseList) {
			JSONObject jsonHouse = new JSONObject();
			jsonHouse.accumulate("houseId", house.getHouseId());
			jsonHouse.accumulate("houseName", house.getHouseName());
			jsonArray.put(jsonHouse);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询房源信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("areaObj") Area areaObj,String houseName,@ModelAttribute("huxingObj") Huxing huxingObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj,@ModelAttribute("userObj") UserInfo userObj,String publishDate,String shenHeState,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (houseName == null) houseName = "";
		if (publishDate == null) publishDate = "";
		if (shenHeState == null) shenHeState = "";
		
		shenHeState = "已审核";
		
		List<House> houseList = houseService.queryHouse(areaObj, houseName, huxingObj, priceRangeObj, userObj, publishDate, shenHeState, currentPage);
	    /*计算总的页数和总的记录数*/
	    houseService.queryTotalPageAndRecordNumber(areaObj, houseName, huxingObj, priceRangeObj, userObj, publishDate, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = houseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = houseService.getRecordNumber();
	    request.setAttribute("houseList",  houseList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("areaObj", areaObj);
	    request.setAttribute("houseName", houseName);
	    request.setAttribute("huxingObj", huxingObj);
	    request.setAttribute("priceRangeObj", priceRangeObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("publishDate", publishDate);
	    request.setAttribute("shenHeState", shenHeState);
	    List<Area> areaList = areaService.queryAllArea();
	    request.setAttribute("areaList", areaList);
	    List<Huxing> huxingList = huxingService.queryAllHuxing();
	    request.setAttribute("huxingList", huxingList);
	    List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
	    request.setAttribute("priceRangeList", priceRangeList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "House/house_frontquery_result"; 
	}
	
	
	/*前台按照查询条件分页查询房源信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("areaObj") Area areaObj,String houseName,@ModelAttribute("huxingObj") Huxing huxingObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj,@ModelAttribute("userObj") UserInfo userObj,String publishDate,String shenHeState,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (houseName == null) houseName = "";
		if (publishDate == null) publishDate = "";
		if (shenHeState == null) shenHeState = ""; 
		
		userObj = new UserInfo();
		userObj.setUser_name((String)session.getAttribute("user_name"));
		
		List<House> houseList = houseService.queryHouse(areaObj, houseName, huxingObj, priceRangeObj, userObj, publishDate, shenHeState, currentPage);
	    /*计算总的页数和总的记录数*/
	    houseService.queryTotalPageAndRecordNumber(areaObj, houseName, huxingObj, priceRangeObj, userObj, publishDate, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = houseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = houseService.getRecordNumber();
	    request.setAttribute("houseList",  houseList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("areaObj", areaObj);
	    request.setAttribute("houseName", houseName);
	    request.setAttribute("huxingObj", huxingObj);
	    request.setAttribute("priceRangeObj", priceRangeObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("publishDate", publishDate);
	    request.setAttribute("shenHeState", shenHeState);
	    List<Area> areaList = areaService.queryAllArea();
	    request.setAttribute("areaList", areaList);
	    List<Huxing> huxingList = huxingService.queryAllHuxing();
	    request.setAttribute("huxingList", huxingList);
	    List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
	    request.setAttribute("priceRangeList", priceRangeList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "House/house_userFrontquery_result"; 
	}
	
	

     /*前台查询House信息*/
	@RequestMapping(value="/{houseId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer houseId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键houseId获取House对象*/
        House house = houseService.getHouse(houseId);

        List<Area> areaList = areaService.queryAllArea();
        request.setAttribute("areaList", areaList);
        List<Huxing> huxingList = huxingService.queryAllHuxing();
        request.setAttribute("huxingList", huxingList);
        List<PriceRange> priceRangeList = priceRangeService.queryAllPriceRange();
        request.setAttribute("priceRangeList", priceRangeList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("house",  house);
        return "House/house_frontshow";
	}

	/*ajax方式显示房源修改jsp视图页*/
	@RequestMapping(value="/{houseId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer houseId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键houseId获取House对象*/
        House house = houseService.getHouse(houseId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonHouse = house.getJsonObject();
		out.println(jsonHouse.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新房源信息*/
	@RequestMapping(value = "/{houseId}/update", method = RequestMethod.POST)
	public void update(@Validated House house, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String housePhotoFileName = this.handlePhotoUpload(request, "housePhotoFile");
		if(!housePhotoFileName.equals("upload/NoImage.jpg"))house.setHousePhoto(housePhotoFileName); 


		try {
			houseService.updateHouse(house);
			message = "房源更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "房源更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除房源信息*/
	@RequestMapping(value="/{houseId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer houseId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  houseService.deleteHouse(houseId);
	            request.setAttribute("message", "房源删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "房源删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条房源记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String houseIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = houseService.deleteHouses(houseIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出房源信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("areaObj") Area areaObj,String houseName,@ModelAttribute("huxingObj") Huxing huxingObj,@ModelAttribute("priceRangeObj") PriceRange priceRangeObj,@ModelAttribute("userObj") UserInfo userObj,String publishDate,String shenHeState, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(houseName == null) houseName = "";
        if(publishDate == null) publishDate = "";
        if(shenHeState == null) shenHeState = "";
        List<House> houseList = houseService.queryHouse(areaObj,houseName,huxingObj,priceRangeObj,userObj,publishDate,shenHeState);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "House信息记录"; 
        String[] headers = { "所在区域","房源名称","房源照片","面积","所在楼层","户型","租金范围","租金价格","朝向","联系人","联系电话","发布人","发布时间","审核状态"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<houseList.size();i++) {
        	House house = houseList.get(i); 
        	dataset.add(new String[]{house.getAreaObj().getAreaName(),house.getHouseName(),house.getHousePhoto(),house.getMj() + "",house.getFloor(),house.getHuxingObj().getHuxingName(),house.getPriceRangeObj().getRangeName(),house.getPrice() + "",house.getChaoxiang(),house.getLxr(),house.getTelephone(),house.getUserObj().getName(),house.getPublishDate(),house.getShenHeState()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"House.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
