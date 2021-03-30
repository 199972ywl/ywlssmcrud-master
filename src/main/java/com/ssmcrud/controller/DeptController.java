package com.ssmcrud.controller;

import com.ssmcrud.bean.Department;
import com.ssmcrud.bean.Msg;
import com.ssmcrud.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    DeptService deptService;

    @ResponseBody
    @RequestMapping("/depts")
    public Msg getAlldepts(){

        List<Department> depts = deptService.getDepts();

        return Msg.success().add("depts",depts);
    }

}
