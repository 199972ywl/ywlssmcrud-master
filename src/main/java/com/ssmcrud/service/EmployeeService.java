package com.ssmcrud.service;

import com.ssmcrud.bean.Employee;
import com.ssmcrud.bean.EmployeeExample;
import com.ssmcrud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    //获取所员工信息
    public List<Employee> getAllemps() {
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        return employees;
    }

    //保存新增的员工信息
    public void addEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    //校验员工名是否可用
    public boolean chenckUser(String empName) {

        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);

        long count = employeeMapper.countByExample(example);
        return count == 0 ? true : false;

    }

    //获取单个员工信息
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;

    }

    //保存修改的员工信息
    public void saveEmp(Employee employee) {
        int i = employeeMapper.updateByPrimaryKeySelective(employee);
    }
    //删除单个员工
    public void deleEmp(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }
    //删除多个
    public void deleteBatch(List<Integer> ids){
        System.out.println(ids);
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
       employeeMapper.deleteByExample(example);
//        System.out.println("影响行数"+i);

    }
}
