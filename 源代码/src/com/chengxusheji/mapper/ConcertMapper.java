package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Concert;

public interface ConcertMapper {
	/*添加演唱会信息*/
	public void addConcert(Concert concert) throws Exception;

	/*按照查询条件分页查询演唱会记录*/
	public ArrayList<Concert> queryConcert(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有演唱会记录*/
	public ArrayList<Concert> queryConcertList(@Param("where") String where) throws Exception;

	/*按照查询条件的演唱会记录数*/
	public int queryConcertCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条演唱会记录*/
	public Concert getConcert(int concertId) throws Exception;

	/*更新演唱会记录*/
	public void updateConcert(Concert concert) throws Exception;

	/*删除演唱会记录*/
	public void deleteConcert(int concertId) throws Exception;

}
