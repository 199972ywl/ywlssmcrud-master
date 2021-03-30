package com.ssmcrud.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    //状态码 100：成功，200：失败
    private int code;
    //返回信息
    private String Meg;
    //返回用户要保存的数据
    private Map<String,Object> extend = new HashMap<>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMeg("成功");
        return msg;
    }
    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMeg("失败");
        return msg;
    }

    public Msg add(String key,Object obj ){
         this.getExtend().put(key,obj);
         return this;

    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMeg() {
        return Meg;
    }

    public void setMeg(String meg) {
        Meg = meg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
