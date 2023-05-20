package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.House;

public interface HouseMapper {
	/*添加房源信息*/
	public void addHouse(House house) throws Exception;

	/*按照查询条件分页查询房源记录*/
	public ArrayList<House> queryHouse(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有房源记录*/
	public ArrayList<House> queryHouseList(@Param("where") String where) throws Exception;

	/*按照查询条件的房源记录数*/
	public int queryHouseCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条房源记录*/
	public House getHouse(int houseId) throws Exception;

	/*更新房源记录*/
	public void updateHouse(House house) throws Exception;

	/*删除房源记录*/
	public void deleteHouse(int houseId) throws Exception;

}
