package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Concert {
    /*演唱会id*/
    private Integer concertId;
    public Integer getConcertId(){
        return concertId;
    }
    public void setConcertId(Integer concertId){
        this.concertId = concertId;
    }

    /*演唱会分类*/
    private ConcertType concertTypeObj;
    public ConcertType getConcertTypeObj() {
        return concertTypeObj;
    }
    public void setConcertTypeObj(ConcertType concertTypeObj) {
        this.concertTypeObj = concertTypeObj;
    }

    /*演唱会名称*/
    @NotEmpty(message="演唱会名称不能为空")
    private String concertName;
    public String getConcertName() {
        return concertName;
    }
    public void setConcertName(String concertName) {
        this.concertName = concertName;
    }

    /*演唱会图片*/
    private String concertPhoto;
    public String getConcertPhoto() {
        return concertPhoto;
    }
    public void setConcertPhoto(String concertPhoto) {
        this.concertPhoto = concertPhoto;
    }

    /*演唱会时间*/
    @NotEmpty(message="演唱会时间不能为空")
    private String concertTime;
    public String getConcertTime() {
        return concertTime;
    }
    public void setConcertTime(String concertTime) {
        this.concertTime = concertTime;
    }

    /*演唱会地点*/
    @NotEmpty(message="演唱会地点不能为空")
    private String concertPlace;
    public String getConcertPlace() {
        return concertPlace;
    }
    public void setConcertPlace(String concertPlace) {
        this.concertPlace = concertPlace;
    }

    /*演出人员*/
    @NotEmpty(message="演出人员不能为空")
    private String ycry;
    public String getYcry() {
        return ycry;
    }
    public void setYcry(String ycry) {
        this.ycry = ycry;
    }

    /*门票价格*/
    @NotNull(message="必须输入门票价格")
    private Float concertPrice;
    public Float getConcertPrice() {
        return concertPrice;
    }
    public void setConcertPrice(Float concertPrice) {
        this.concertPrice = concertPrice;
    }

    /*详细说明*/
    @NotEmpty(message="详细说明不能为空")
    private String concertDesc;
    public String getConcertDesc() {
        return concertDesc;
    }
    public void setConcertDesc(String concertDesc) {
        this.concertDesc = concertDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonConcert=new JSONObject(); 
		jsonConcert.accumulate("concertId", this.getConcertId());
		jsonConcert.accumulate("concertTypeObj", this.getConcertTypeObj().getTypeName());
		jsonConcert.accumulate("concertTypeObjPri", this.getConcertTypeObj().getTypeId());
		jsonConcert.accumulate("concertName", this.getConcertName());
		jsonConcert.accumulate("concertPhoto", this.getConcertPhoto());
		jsonConcert.accumulate("concertTime", this.getConcertTime().length()>19?this.getConcertTime().substring(0,19):this.getConcertTime());
		jsonConcert.accumulate("concertPlace", this.getConcertPlace());
		jsonConcert.accumulate("ycry", this.getYcry());
		jsonConcert.accumulate("concertPrice", this.getConcertPrice());
		jsonConcert.accumulate("concertDesc", this.getConcertDesc());
		return jsonConcert;
    }}