package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class House {
    /*房源id*/
    private Integer houseId;
    public Integer getHouseId(){
        return houseId;
    }
    public void setHouseId(Integer houseId){
        this.houseId = houseId;
    }

    /*所在区域*/
    private Area areaObj;
    public Area getAreaObj() {
        return areaObj;
    }
    public void setAreaObj(Area areaObj) {
        this.areaObj = areaObj;
    }

    /*房源名称*/
    @NotEmpty(message="房源名称不能为空")
    private String houseName;
    public String getHouseName() {
        return houseName;
    }
    public void setHouseName(String houseName) {
        this.houseName = houseName;
    }

    /*房源照片*/
    private String housePhoto;
    public String getHousePhoto() {
        return housePhoto;
    }
    public void setHousePhoto(String housePhoto) {
        this.housePhoto = housePhoto;
    }

    /*面积*/
    @NotNull(message="必须输入面积")
    private Float mj;
    public Float getMj() {
        return mj;
    }
    public void setMj(Float mj) {
        this.mj = mj;
    }

    /*所在楼层*/
    @NotEmpty(message="所在楼层不能为空")
    private String floor;
    public String getFloor() {
        return floor;
    }
    public void setFloor(String floor) {
        this.floor = floor;
    }

    /*户型*/
    private Huxing huxingObj;
    public Huxing getHuxingObj() {
        return huxingObj;
    }
    public void setHuxingObj(Huxing huxingObj) {
        this.huxingObj = huxingObj;
    }

    /*租金范围*/
    private PriceRange priceRangeObj;
    public PriceRange getPriceRangeObj() {
        return priceRangeObj;
    }
    public void setPriceRangeObj(PriceRange priceRangeObj) {
        this.priceRangeObj = priceRangeObj;
    }

    /*租金价格*/
    @NotNull(message="必须输入租金价格")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*朝向*/
    @NotEmpty(message="朝向不能为空")
    private String chaoxiang;
    public String getChaoxiang() {
        return chaoxiang;
    }
    public void setChaoxiang(String chaoxiang) {
        this.chaoxiang = chaoxiang;
    }

    /*小区地址*/
    @NotEmpty(message="小区地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*联系人*/
    @NotEmpty(message="联系人不能为空")
    private String lxr;
    public String getLxr() {
        return lxr;
    }
    public void setLxr(String lxr) {
        this.lxr = lxr;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*房源详情*/
    @NotEmpty(message="房源详情不能为空")
    private String houseDesc;
    public String getHouseDesc() {
        return houseDesc;
    }
    public void setHouseDesc(String houseDesc) {
        this.houseDesc = houseDesc;
    }

    /*发布人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String publishDate;
    public String getPublishDate() {
        return publishDate;
    }
    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shenHeState;
    public String getShenHeState() {
        return shenHeState;
    }
    public void setShenHeState(String shenHeState) {
        this.shenHeState = shenHeState;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonHouse=new JSONObject(); 
		jsonHouse.accumulate("houseId", this.getHouseId());
		jsonHouse.accumulate("areaObj", this.getAreaObj().getAreaName());
		jsonHouse.accumulate("areaObjPri", this.getAreaObj().getAreaId());
		jsonHouse.accumulate("houseName", this.getHouseName());
		jsonHouse.accumulate("housePhoto", this.getHousePhoto());
		jsonHouse.accumulate("mj", this.getMj());
		jsonHouse.accumulate("floor", this.getFloor());
		jsonHouse.accumulate("huxingObj", this.getHuxingObj().getHuxingName());
		jsonHouse.accumulate("huxingObjPri", this.getHuxingObj().getHuxingId());
		jsonHouse.accumulate("priceRangeObj", this.getPriceRangeObj().getRangeName());
		jsonHouse.accumulate("priceRangeObjPri", this.getPriceRangeObj().getRangeId());
		jsonHouse.accumulate("price", this.getPrice());
		jsonHouse.accumulate("chaoxiang", this.getChaoxiang());
		jsonHouse.accumulate("address", this.getAddress());
		jsonHouse.accumulate("lxr", this.getLxr());
		jsonHouse.accumulate("telephone", this.getTelephone());
		jsonHouse.accumulate("houseDesc", this.getHouseDesc());
		jsonHouse.accumulate("userObj", this.getUserObj().getName());
		jsonHouse.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonHouse.accumulate("publishDate", this.getPublishDate().length()>19?this.getPublishDate().substring(0,19):this.getPublishDate());
		jsonHouse.accumulate("shenHeState", this.getShenHeState());
		return jsonHouse;
    }}