package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ConcertType;
import com.chengxusheji.po.Concert;

import com.chengxusheji.mapper.ConcertMapper;
@Service
public class ConcertService {

	@Resource ConcertMapper concertMapper;
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

    /*添加演唱会记录*/
    public void addConcert(Concert concert) throws Exception {
    	concertMapper.addConcert(concert);
    }

    /*按照查询条件分页查询演唱会记录*/
    public ArrayList<Concert> queryConcert(ConcertType concertTypeObj,String concertName,String concertTime,String concertPlace,String ycry,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != concertTypeObj && concertTypeObj.getTypeId()!= null && concertTypeObj.getTypeId()!= 0)  where += " and t_concert.concertTypeObj=" + concertTypeObj.getTypeId();
    	if(!concertName.equals("")) where = where + " and t_concert.concertName like '%" + concertName + "%'";
    	if(!concertTime.equals("")) where = where + " and t_concert.concertTime like '%" + concertTime + "%'";
    	if(!concertPlace.equals("")) where = where + " and t_concert.concertPlace like '%" + concertPlace + "%'";
    	if(!ycry.equals("")) where = where + " and t_concert.ycry like '%" + ycry + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return concertMapper.queryConcert(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Concert> queryConcert(ConcertType concertTypeObj,String concertName,String concertTime,String concertPlace,String ycry) throws Exception  { 
     	String where = "where 1=1";
    	if(null != concertTypeObj && concertTypeObj.getTypeId()!= null && concertTypeObj.getTypeId()!= 0)  where += " and t_concert.concertTypeObj=" + concertTypeObj.getTypeId();
    	if(!concertName.equals("")) where = where + " and t_concert.concertName like '%" + concertName + "%'";
    	if(!concertTime.equals("")) where = where + " and t_concert.concertTime like '%" + concertTime + "%'";
    	if(!concertPlace.equals("")) where = where + " and t_concert.concertPlace like '%" + concertPlace + "%'";
    	if(!ycry.equals("")) where = where + " and t_concert.ycry like '%" + ycry + "%'";
    	return concertMapper.queryConcertList(where);
    }

    /*查询所有演唱会记录*/
    public ArrayList<Concert> queryAllConcert()  throws Exception {
        return concertMapper.queryConcertList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(ConcertType concertTypeObj,String concertName,String concertTime,String concertPlace,String ycry) throws Exception {
     	String where = "where 1=1";
    	if(null != concertTypeObj && concertTypeObj.getTypeId()!= null && concertTypeObj.getTypeId()!= 0)  where += " and t_concert.concertTypeObj=" + concertTypeObj.getTypeId();
    	if(!concertName.equals("")) where = where + " and t_concert.concertName like '%" + concertName + "%'";
    	if(!concertTime.equals("")) where = where + " and t_concert.concertTime like '%" + concertTime + "%'";
    	if(!concertPlace.equals("")) where = where + " and t_concert.concertPlace like '%" + concertPlace + "%'";
    	if(!ycry.equals("")) where = where + " and t_concert.ycry like '%" + ycry + "%'";
        recordNumber = concertMapper.queryConcertCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取演唱会记录*/
    public Concert getConcert(int concertId) throws Exception  {
        Concert concert = concertMapper.getConcert(concertId);
        return concert;
    }

    /*更新演唱会记录*/
    public void updateConcert(Concert concert) throws Exception {
        concertMapper.updateConcert(concert);
    }

    /*删除一条演唱会记录*/
    public void deleteConcert (int concertId) throws Exception {
        concertMapper.deleteConcert(concertId);
    }

    /*删除多条演唱会信息*/
    public int deleteConcerts (String concertIds) throws Exception {
    	String _concertIds[] = concertIds.split(",");
    	for(String _concertId: _concertIds) {
    		concertMapper.deleteConcert(Integer.parseInt(_concertId));
    	}
    	return _concertIds.length;
    }
}
