package com.ssmcrud.service;

import com.ssmcrud.bean.Department;
import com.ssmcrud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptService {

        @Autowired
        private DepartmentMapper departmentMapper;

        public List<Department> getDepts(){
            List<Department> departments = departmentMapper.selectByExample(null);
            return departments;

        }
}
