package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Area;
import com.chengxusheji.po.Huxing;
import com.chengxusheji.po.PriceRange;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.House;

import com.chengxusheji.mapper.HouseMapper;
@Service
public class HouseService {

	@Resource HouseMapper houseMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加房源记录*/
    public void addHouse(House house) throws Exception {
    	houseMapper.addHouse(house);
    }

    /*按照查询条件分页查询房源记录*/
    public ArrayList<House> queryHouse(Area areaObj,String houseName,Huxing huxingObj,PriceRange priceRangeObj,UserInfo userObj,String publishDate,String shenHeState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != areaObj && areaObj.getAreaId()!= null && areaObj.getAreaId()!= 0)  where += " and t_house.areaObj=" + areaObj.getAreaId();
    	if(!houseName.equals("")) where = where + " and t_house.houseName like '%" + houseName + "%'";
    	if(null != huxingObj && huxingObj.getHuxingId()!= null && huxingObj.getHuxingId()!= 0)  where += " and t_house.huxingObj=" + huxingObj.getHuxingId();
    	if(null != priceRangeObj && priceRangeObj.getRangeId()!= null && priceRangeObj.getRangeId()!= 0)  where += " and t_house.priceRangeObj=" + priceRangeObj.getRangeId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_house.userObj='" + userObj.getUser_name() + "'";
    	if(!publishDate.equals("")) where = where + " and t_house.publishDate like '%" + publishDate + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_house.shenHeState like '%" + shenHeState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return houseMapper.queryHouse(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<House> queryHouse(Area areaObj,String houseName,Huxing huxingObj,PriceRange priceRangeObj,UserInfo userObj,String publishDate,String shenHeState) throws Exception  { 
     	String where = "where 1=1";
    	if(null != areaObj && areaObj.getAreaId()!= null && areaObj.getAreaId()!= 0)  where += " and t_house.areaObj=" + areaObj.getAreaId();
    	if(!houseName.equals("")) where = where + " and t_house.houseName like '%" + houseName + "%'";
    	if(null != huxingObj && huxingObj.getHuxingId()!= null && huxingObj.getHuxingId()!= 0)  where += " and t_house.huxingObj=" + huxingObj.getHuxingId();
    	if(null != priceRangeObj && priceRangeObj.getRangeId()!= null && priceRangeObj.getRangeId()!= 0)  where += " and t_house.priceRangeObj=" + priceRangeObj.getRangeId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_house.userObj='" + userObj.getUser_name() + "'";
    	if(!publishDate.equals("")) where = where + " and t_house.publishDate like '%" + publishDate + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_house.shenHeState like '%" + shenHeState + "%'";
    	return houseMapper.queryHouseList(where);
    }

    /*查询所有房源记录*/
    public ArrayList<House> queryAllHouse()  throws Exception {
        return houseMapper.queryHouseList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Area areaObj,String houseName,Huxing huxingObj,PriceRange priceRangeObj,UserInfo userObj,String publishDate,String shenHeState) throws Exception {
     	String where = "where 1=1";
    	if(null != areaObj && areaObj.getAreaId()!= null && areaObj.getAreaId()!= 0)  where += " and t_house.areaObj=" + areaObj.getAreaId();
    	if(!houseName.equals("")) where = where + " and t_house.houseName like '%" + houseName + "%'";
    	if(null != huxingObj && huxingObj.getHuxingId()!= null && huxingObj.getHuxingId()!= 0)  where += " and t_house.huxingObj=" + huxingObj.getHuxingId();
    	if(null != priceRangeObj && priceRangeObj.getRangeId()!= null && priceRangeObj.getRangeId()!= 0)  where += " and t_house.priceRangeObj=" + priceRangeObj.getRangeId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_house.userObj='" + userObj.getUser_name() + "'";
    	if(!publishDate.equals("")) where = where + " and t_house.publishDate like '%" + publishDate + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_house.shenHeState like '%" + shenHeState + "%'";
        recordNumber = houseMapper.queryHouseCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取房源记录*/
    public House getHouse(int houseId) throws Exception  {
        House house = houseMapper.getHouse(houseId);
        return house;
    }

    /*更新房源记录*/
    public void updateHouse(House house) throws Exception {
        houseMapper.updateHouse(house);
    }

    /*删除一条房源记录*/
    public void deleteHouse (int houseId) throws Exception {
        houseMapper.deleteHouse(houseId);
    }

    /*删除多条房源信息*/
    public int deleteHouses (String houseIds) throws Exception {
    	String _houseIds[] = houseIds.split(",");
    	for(String _houseId: _houseIds) {
    		houseMapper.deleteHouse(Integer.parseInt(_houseId));
    	}
    	return _houseIds.length;
    }
}
