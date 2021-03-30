<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--<jsp:forward page="/emps"></jsp:forward>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建显示页码--%>
 <div class="container">
     <div class="row">
         <div class="col-md-12">
             <h1>SSM_CRUD</h1>
         </div>
     </div>
<%--     按钮--%>
     <div class="row">
         <div class="col-md-4 col-md-offset-8">
             <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
             <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
         </div>
     </div>
<%--     显示表格--%>
     <div class="row">
         <div class="col-md-12">
             <table class="table table-hover" id="emps_table">
                <tr>
                    <th>id</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                 <tr>
                     <th>1</th>
                     <th>ywl</th>
                     <th>M</th>
                     <th>ywl@qq.com</th>
                     <th>开发部</th>
                     <th>
                         <button class="btn btn-primary btn-sm">
                             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                             修改</button>
                         <button class="btn btn-danger btn-sm">
                             <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                             删除</button>
                     </th>
                 </tr>
                 <c:forEach items="${pageinfo.list}" var="emp">
                     <tr>
                         <th>${emp.empId}</th>
                         <th>${emp.empName}</th>
                         <th>${emp.gender=="M"?"男":"女"}</th>
                         <th>${emp.email}</th>
                         <th>${emp.department.deptId==1?"开发部":"测试部"}</th>
                         <th>
                             <button class="btn btn-primary btn-sm">
                                 <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                 修改</button>
                             <button class="btn btn-danger btn-sm">
                                 <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                 删除</button>
                         </th>
                     </tr>

                 </c:forEach>
             </table>
         </div>

     </div>
     <!-- 显示分页信息 -->
         <div class="row">
             <!--分页文字信息  -->
             <div class="col-md-6" id="page_info_area">
                 当前第${pageinfo.pageNum}页 总${pageinfo.pages}页 总${pageinfo.total}条记录
             </div>
             <!-- 分页条信息 -->
             <div class="col-md-6" id="page_nav_area">
                 <%--  分页条--%>
                 <nav aria-label="Page navigation">
                     <ul class="pagination">

                         <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                         <c:if test="${pageinfo.hasPreviousPage}">
                             <li>
                                 <a href="${APP_PATH}/emps?pn=${pageinfo.pageNum-1}" aria-label="Previous">
                                     <span aria-hidden="true">&laquo;</span>
                                 </a>
                             </li>
                         </c:if>

                         <c:forEach items="${pageinfo.navigatepageNums}" var="page_num">
                             <c:if test="${page_num==pageinfo.pageNum}">
                                 <li class="active"><a href="#">${page_num}</a></li>
                             </c:if>
                             <c:if test="${page_num!=pageinfo.pageNum}">
                                 <li><a href="${APP_PATH}/emps?pn=${page_num}" >${page_num}</a></li>
                             </c:if>


                         </c:forEach>
<%--                         <li><a href="#">1</a></li>--%>
<%--                         <li><a href="#">2</a></li>--%>
<%--                         <li><a href="#">3</a></li>--%>
<%--                         <li><a href="#">4</a></li>--%>
<%--                         <li><a href="#">5</a></li>--%>
                         <c:if test="${pageinfo.hasNextPage}">
                             <li>
                                 <a href="${APP_PATH}/emps?pn=${pageinfo.pageNum+1}" aria-label="Next">
                                     <span aria-hidden="true">&raquo;</span>
                                 </a>
                             </li>
                         </c:if>

                         <li><a href="${APP_PATH}/emps?pn=${pageinfo.pages}">末页</a></li>
                     </ul>
                 </nav>
             </div>
         </div>

 </div>
<%--<!-- 搭建显示页面 -->--%>
<%--<div class="container">--%>
<%--    <!-- 标题 -->--%>
<%--    <div class="row">--%>
<%--        <div class="col-md-12">--%>
<%--            <h1>SSM-CRUD BY PL</h1>--%>
<%--        </div>--%>
<%--    </div>--%>
    <!-- 按钮 -->
<%--    <div class="row">--%>
<%--        <div class="col-md-4 col-md-offset-8">--%>
<%--            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>--%>
<%--            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <!-- 显示表格数据 -->--%>
<%--    <div class="row">--%>
<%--        <div class="col-md-12">--%>
<%--            <table class="table table-hover" id="emps_table">--%>
<%--                <thead>--%>
<%--                <tr>--%>
<%--                    <th>--%>
<%--                        <input type="checkbox" id="check_all"/>--%>
<%--                    </th>--%>
<%--                    <th>#</th>--%>
<%--                    <th>empName</th>--%>
<%--                    <th>gender</th>--%>
<%--                    <th>email</th>--%>
<%--                    <th>deptName</th>--%>
<%--                    <th>操作</th>--%>
<%--                </tr>--%>
<%--                </thead>--%>
<%--                <tbody>--%>

<%--                </tbody>--%>
<%--            </table>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- 显示分页信息 -->--%>
<%--    <div class="row">--%>
<%--        <!--分页文字信息  -->--%>
<%--        <div class="col-md-6" id="page_info_area"></div>--%>
<%--        <!-- 分页条信息 -->--%>
<%--        <div class="col-md-6" id="page_nav_area">--%>

<%--        </div>--%>
<%--    </div>--%>

<%--</div>--%>

</body>
</html>
