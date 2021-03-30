package com.ssmcrud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssmcrud.bean.Employee;
import com.ssmcrud.bean.Msg;
import com.ssmcrud.service.EmployeeService;
import com.sun.media.jfxmediaimpl.HostUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    //查询所有员工信息
    @ResponseBody//返回一个josn
    @RequestMapping("/emps")
    public Msg getAllempsWithJosn(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
         /*分页
        int pageNum：从第几页开始查
        int pageSize：一页查几个
        startPage方法下紧跟的查询就会分页

         */
        PageHelper.startPage(pn,5);
        List<Employee> allemps = employeeService.getAllemps();
        //包装分页信息，navigatePages:连续显示几页
        PageInfo<Employee> pempinfo = new PageInfo<>(allemps,5);
//        model.addAttribute("pageinfo",pempinfo);
        return Msg.success().add("pageinfo",pempinfo) ;
    }
    //保存新增的员工信息
    @ResponseBody
    @RequestMapping(value = "/emps",method = RequestMethod.POST)
    public Msg addEmp(@Valid Employee employee, BindingResult bindingResult){

        if(bindingResult.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();

            for (FieldError Error : fieldErrors) {
                System.out.println("错误的字段名："+Error.getField());
                System.out.println("错误信息："+Error.getDefaultMessage());
                map.put(Error.getField(),Error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.addEmp(employee);
            return Msg.success();
        }


    }
    //校验员工名是否可用
    @RequestMapping("/check")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName")String empName){

        String empNameText="(^[\\u2E80-\\u9FFF]{2,5})|(^[A-Za-z0-9_-]{3,16}$)";
//                          (^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5});
        if(!empName.matches(empNameText)){
            return Msg.fail().add("Msg_key","用户名允许中文2-5位或者英文数字结合3-16位(后端校验)");
        }

        boolean b = employeeService.chenckUser(empName);
        if (b==true){
            return Msg.success();
        }else {
            return Msg.fail().add("Msg_key","用户名不可用");
        }


    }
    //获取单个员工信息
    @RequestMapping(value = "/emps/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){
        Employee emp = employeeService.getEmp(id);

        return Msg.success().add("emp",emp);
    }
    //保存修改的员工信息
    @ResponseBody
    @RequestMapping(value = "/emps/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        System.out.println("方法调用");
        System.out.println(employee);
        employeeService.saveEmp(employee);
        return Msg.success();
    }
    //删除单个或多个员工（二合一）
    @ResponseBody
    @RequestMapping(value = "/emps/{ids}",method = RequestMethod.DELETE)
    public Msg deleEmp(@PathVariable("ids") String ids){
        System.out.println("方法调用");
        if(ids.contains("-")){
            System.out.println(ids);
            //删除多个
            //组装Stirng[]数组
            String[] strs = ids.split("-");
            //组装ids集合
            List<Integer> list = new ArrayList<>();
            for (String id: strs) {
                int i = Integer.parseInt(id);
                list.add(i);

            }
            employeeService.deleteBatch(list);
            return Msg.success();

        }else {
            //删除单个
            int id = Integer.parseInt(ids);
            employeeService.deleEmp(id);
            return  Msg.success();
        }


    }


//    @RequestMapping("/emps")
//    public String getALLemps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,Model model){
//
//        /*分页
//        int pageNum：从第几页开始查
//        int pageSize：一页查几个
//        startPage方法下紧跟的查询就会分页
//
//         */
//        PageHelper.startPage(pn,5);
//        List<Employee> allemps = employeeService.getAllemps();
//        //包装分页信息，navigatePages:连续显示几页
//        PageInfo<Employee> pempinfo = new PageInfo<>(allemps,5);
//        model.addAttribute("pageinfo",pempinfo);
//        return "list";
//    }
}
