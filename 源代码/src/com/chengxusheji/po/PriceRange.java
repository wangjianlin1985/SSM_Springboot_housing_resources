package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class PriceRange {
    /*租金范围id*/
    private Integer rangeId;
    public Integer getRangeId(){
        return rangeId;
    }
    public void setRangeId(Integer rangeId){
        this.rangeId = rangeId;
    }

    /*租金范围区段*/
    @NotEmpty(message="租金范围区段不能为空")
    private String rangeName;
    public String getRangeName() {
        return rangeName;
    }
    public void setRangeName(String rangeName) {
        this.rangeName = rangeName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPriceRange=new JSONObject(); 
		jsonPriceRange.accumulate("rangeId", this.getRangeId());
		jsonPriceRange.accumulate("rangeName", this.getRangeName());
		return jsonPriceRange;
    }}