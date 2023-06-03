package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ConcertType;

import com.chengxusheji.mapper.ConcertTypeMapper;
@Service
public class ConcertTypeService {

	@Resource ConcertTypeMapper concertTypeMapper;
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

    /*添加演唱会分类记录*/
    public void addConcertType(ConcertType concertType) throws Exception {
    	concertTypeMapper.addConcertType(concertType);
    }

    /*按照查询条件分页查询演唱会分类记录*/
    public ArrayList<ConcertType> queryConcertType(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return concertTypeMapper.queryConcertType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ConcertType> queryConcertType() throws Exception  { 
     	String where = "where 1=1";
    	return concertTypeMapper.queryConcertTypeList(where);
    }

    /*查询所有演唱会分类记录*/
    public ArrayList<ConcertType> queryAllConcertType()  throws Exception {
        return concertTypeMapper.queryConcertTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = concertTypeMapper.queryConcertTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取演唱会分类记录*/
    public ConcertType getConcertType(int typeId) throws Exception  {
        ConcertType concertType = concertTypeMapper.getConcertType(typeId);
        return concertType;
    }

    /*更新演唱会分类记录*/
    public void updateConcertType(ConcertType concertType) throws Exception {
        concertTypeMapper.updateConcertType(concertType);
    }

    /*删除一条演唱会分类记录*/
    public void deleteConcertType (int typeId) throws Exception {
        concertTypeMapper.deleteConcertType(typeId);
    }

    /*删除多条演唱会分类信息*/
    public int deleteConcertTypes (String typeIds) throws Exception {
    	String _typeIds[] = typeIds.split(",");
    	for(String _typeId: _typeIds) {
    		concertTypeMapper.deleteConcertType(Integer.parseInt(_typeId));
    	}
    	return _typeIds.length;
    }
}
