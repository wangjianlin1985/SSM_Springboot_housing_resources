package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Huxing {
    /*户型id*/
    private Integer huxingId;
    public Integer getHuxingId(){
        return huxingId;
    }
    public void setHuxingId(Integer huxingId){
        this.huxingId = huxingId;
    }

    /*户型名称*/
    @NotEmpty(message="户型名称不能为空")
    private String huxingName;
    public String getHuxingName() {
        return huxingName;
    }
    public void setHuxingName(String huxingName) {
        this.huxingName = huxingName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonHuxing=new JSONObject(); 
		jsonHuxing.accumulate("huxingId", this.getHuxingId());
		jsonHuxing.accumulate("huxingName", this.getHuxingName());
		return jsonHuxing;
    }}