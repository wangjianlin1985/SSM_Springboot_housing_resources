package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Huxing;

public interface HuxingMapper {
	/*添加户型信息*/
	public void addHuxing(Huxing huxing) throws Exception;

	/*按照查询条件分页查询户型记录*/
	public ArrayList<Huxing> queryHuxing(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有户型记录*/
	public ArrayList<Huxing> queryHuxingList(@Param("where") String where) throws Exception;

	/*按照查询条件的户型记录数*/
	public int queryHuxingCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条户型记录*/
	public Huxing getHuxing(int huxingId) throws Exception;

	/*更新户型记录*/
	public void updateHuxing(Huxing huxing) throws Exception;

	/*删除户型记录*/
	public void deleteHuxing(int huxingId) throws Exception;

}
