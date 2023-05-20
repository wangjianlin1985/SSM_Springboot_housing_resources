package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Huxing;

import com.chengxusheji.mapper.HuxingMapper;
@Service
public class HuxingService {

	@Resource HuxingMapper huxingMapper;
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

    /*添加户型记录*/
    public void addHuxing(Huxing huxing) throws Exception {
    	huxingMapper.addHuxing(huxing);
    }

    /*按照查询条件分页查询户型记录*/
    public ArrayList<Huxing> queryHuxing(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return huxingMapper.queryHuxing(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Huxing> queryHuxing() throws Exception  { 
     	String where = "where 1=1";
    	return huxingMapper.queryHuxingList(where);
    }

    /*查询所有户型记录*/
    public ArrayList<Huxing> queryAllHuxing()  throws Exception {
        return huxingMapper.queryHuxingList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = huxingMapper.queryHuxingCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取户型记录*/
    public Huxing getHuxing(int huxingId) throws Exception  {
        Huxing huxing = huxingMapper.getHuxing(huxingId);
        return huxing;
    }

    /*更新户型记录*/
    public void updateHuxing(Huxing huxing) throws Exception {
        huxingMapper.updateHuxing(huxing);
    }

    /*删除一条户型记录*/
    public void deleteHuxing (int huxingId) throws Exception {
        huxingMapper.deleteHuxing(huxingId);
    }

    /*删除多条户型信息*/
    public int deleteHuxings (String huxingIds) throws Exception {
    	String _huxingIds[] = huxingIds.split(",");
    	for(String _huxingId: _huxingIds) {
    		huxingMapper.deleteHuxing(Integer.parseInt(_huxingId));
    	}
    	return _huxingIds.length;
    }
}
