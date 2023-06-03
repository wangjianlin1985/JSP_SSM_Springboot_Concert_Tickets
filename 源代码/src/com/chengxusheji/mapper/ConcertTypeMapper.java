package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ConcertType;

public interface ConcertTypeMapper {
	/*添加演唱会分类信息*/
	public void addConcertType(ConcertType concertType) throws Exception;

	/*按照查询条件分页查询演唱会分类记录*/
	public ArrayList<ConcertType> queryConcertType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有演唱会分类记录*/
	public ArrayList<ConcertType> queryConcertTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的演唱会分类记录数*/
	public int queryConcertTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条演唱会分类记录*/
	public ConcertType getConcertType(int typeId) throws Exception;

	/*更新演唱会分类记录*/
	public void updateConcertType(ConcertType concertType) throws Exception;

	/*删除演唱会分类记录*/
	public void deleteConcertType(int typeId) throws Exception;

}
