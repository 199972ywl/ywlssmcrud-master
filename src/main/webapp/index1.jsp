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
<%--员工修改模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <%--            添加表单--%>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empname_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empemail_add_input" class="col-sm-2 control-label">EmpEmail</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="empemail_update_input" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empemail_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empemail_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加模态框-->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
<%--            添加表单--%>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empname_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empname_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empemail_add_input" class="col-sm-2 control-label">EmpEmail</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="empemail_add_input" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empemail_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empemail_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                 
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


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
               <thead>
               <tr>
                   <th>
                       <input type="checkbox" id="check_all">
                   </th>
                   <th>id</th>
                   <th>empName</th>
                   <th>gender</th>
                   <th>email</th>
                   <th>deptName</th>
                   <th>操作</th>
               </tr>
               </thead>
                <tbody>
<%--                <tr>--%>
<%--                    <th>1</th>--%>
<%--                    <th>ywl</th>--%>
<%--                    <th>M</th>--%>
<%--                    <th>ywl@qq.com</th>--%>
<%--                    <th>开发部</th>--%>
<%--                    <th>--%>
<%--                        <button class="btn btn-primary btn-sm">--%>
<%--                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>--%>
<%--                            修改</button>--%>
<%--                        <button class="btn btn-danger btn-sm">--%>
<%--                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>--%>
<%--                            删除</button>--%>
<%--                    </th>--%>
<%--                </tr>--%>
                </tbody>




            </table>
        </div>

    </div>
    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area">
<%--            当前第页 总页 总条记录--%>
        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav_area">
            <%--  分页条--%>

        </div>
    </div>

</div>
<script type="text/javascript">

    var curredpage;//当前页
<%--    1.页面加载完成以后直接发送一个AJAX请求 要到页面数据--%>
    $(function () {
        to_page(1);

    })
//抽取一个跳转方法
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                // console.log(result)\
                //1.请求成功后解析员工数据
                build_emps_table(result);
                //2.解析分页条数据
                build_page_nav(result)
                //3.解析分页信息数据
                build_page_info(result)
            }
        })


    }
    //解析员工信息
    function build_emps_table(result) {
        //先清空数据
        $("#emps_table tbody").empty()
        var emp = result.extend.pageinfo.list;
        $.each(emp,function (index,item) {
            var checkerBoxTd = $("<td><input type='checkbox' class='check_item'></td>")
            var empIdTd =$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd=$("<td></td>").append(item.email);
            var deptNameTd=$("<td></td>").append(item.department.deptName);

        // <button class="btn btn-primary btn-sm">
        //         <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
        //     修改</button>
            var editBtn =$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                            .append("<spen></sepn>").addClass("glyphicon glyphicon-pencil").append("修改")
            editBtn.attr("edit-id",item.empId);
            var delBtn =$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append("<spen></sepn>").addClass("glyphicon glyphicon-trash").append("删除")
            delBtn.attr("delete-id",item.empId);
            var butTd = $("<td></td>").append(editBtn).append(" ").append(delBtn)
            $("<tr></tr>").append(checkerBoxTd)
                            .append(empIdTd)
                             .append(empNameTd)
                            .append(genderTd).
                                append(emailTd).append(deptNameTd).append(butTd)
                .appendTo("#emps_table tbody");
            // var emps = result.extend.pageInfo.list;--%>
            <%--        $.each(emps,function(index,item){--%>
            <%--            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");--%>
            <%--            var empIdTd = $("<td></td>").append(item.empId);--%>
            <%--            var empNameTd = $("<td></td>").append(item.empName);--%>
            <%--            var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");--%>
            <%--            var emailTd = $("<td></td>").append(item.email);--%>
            <%--            var deptNameTd = $("<td></td>").append(item.department.deptName);--%>
            // $("<tr></tr>").append(checkBoxTd)--%>
            <%--                .append(empIdTd)--%>
            <%--                .append(empNameTd)--%>
            <%--                .append(genderTd)--%>
            <%--                .append(emailTd)--%>
            <%--                .append(deptNameTd)--%>
            <%--                .append(btnTd)--%>
            <%--                .appendTo("#emps_table tbody");--%>



        })

    }
    //解析分页条
    function build_page_nav(result) {
        //先清空数据
        $("#page_nav_area").empty()
        //创建父类标签
        var ul = $("<ul></ul>").addClass("pagination");
        //首页，前一页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //判断首页和前一页是否能被点击
        if (result.extend.pageinfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            //点击首页跳转到第一页
            firstPageLi.click(function () {
                to_page(1);
            })
            //点击上一页跳转到上一页
            prePageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum-1);
            })
        }


        //末页,后一页
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        //判断末页和下一页能否被点击
        if(result.extend.pageinfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        else {
            //点击末页跳转到最后一页
            lastPageLi.click(function () {
                to_page(9999);
            })
            //点击下一页跳转到下一页
            nextPageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum+1);
            })

        }



        ul.append(firstPageLi).append(prePageLi)
        //遍历页码数
        $.each(result.extend.pageinfo.navigatepageNums,function(index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageinfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            })

            ul.append(numLi);
        })
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area")

    }
    //解析分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第【"+ result.extend.pageinfo.pageNum+"】页  总【"+result.extend. pageinfo.pages+
                            "】页  总【"+result.extend.pageinfo.total+"】条记录")
        curredpage =result.extend.pageinfo.pageNum;

    }
    //表单完整重置
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }
    //点击新增按钮突出模态框
    $("#emp_add_modal_btn").click(function () {
        //1.先发一个ajax请求得到部门信息显示在下拉列表 表单重置
        // $("#empAddModal form")[0].reset();
        reset_form("#empAddModal form");
        getDepts("#dept_add_select");
        //2.显示模态框
        $("#empAddModal").modal({
            backdrop:'static'
        })
    })
    //获取部门信息
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success:function (result) {
                // console.log(result)
                // $("dept_add_select").append(result.extend().depts.deptName)
                $.each(result.extend.depts,function (index,item) {
                    var option = $("<option></option>").append(this.deptName).attr("value",this.deptId)
                    option.appendTo(ele);


                })

            }
        })

    }
    //前端校验信息
    function validate_add_form(){

       var empname = $("#empname_add_input").val();
       var empText = (/^[A-Za-z0-9_-]{3,16}$/)||(/^[\u2E80-\u9FFF]{2,5}/)
        if(!empText.test(empname)){
            show_validate_msg("#empname_add_input","fales","用户名允许中文2-5位或者英文数字结合3-16位")

            //alert("用户名允许中文2-5位或者英文数字结合3-16位")
            // $("#empname_add_input").parant().addClass("has-error");
            // $("#empname_add_input").next("span").text("用户名允许中文2-5位或者英文数字结合3-16位")
            return false;
        }else {
            show_validate_msg("#empname_add_input","success"," ")
            // $("#empname_add_input").parant().addClass("has-success");
            // $("#empname_add_input").next("span").text("");
        }
        var email = $("#empemail_add_input").val();
        var emailText = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if(!emailText.test(email)){
            show_validate_msg("#empemail_add_input","fales","邮箱格式错误")
            // alert("邮箱格式错误")
            // $("#empemail_add_input").parant().addClass("has-error");
            // $("#empemail_add_input").next("span").text("邮箱格式错误")
            return false
        }
        else {
            show_validate_msg("#empemail_add_input","success"," ")
            // $("#empemail_add_input").parant().addClass("has-success");
            // $("#empemail_add_input").next("span").text("")
        }
        return true;

    }
    function show_validate_msg(ele,status,msg){
        //初始化默认状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg)
        }else {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg)
        }
    }

    //校验员工姓名是否可用

    $("#empname_add_input").change(function () {
            var empName=this.value;
            $.ajax({
                url:"${APP_PATH}/check",
                data:"empName="+empName,
                type:"get",
                success:function (result) {
                    if (result.code==100){
                        show_validate_msg("#empname_add_input","success","用户名可用")
                        $("#emp_save_btn").attr("ajax_va","success");

                    }else {
                        show_validate_msg("#empname_add_input","false",result.extend.Msg_key)
                        $("#emp_save_btn").attr("ajax_va","error");
                    }
                }

            })
        })

    //点击保存数据提交
    $("#emp_save_btn").click(function () {


        //提交前先校验数据
           if (!validate_add_form()) {
               return false;
           }
          if ($(this).attr("ajax_va")=="error") {
              return false;
          }

        //校验成功在提交
        $.ajax({
            url:"${APP_PATH}/emps",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                if (result.code ==100){
                    // alert(result.meg)
                    $("#empAddModal").modal("hide");
                    to_page(9999)

                }else {
                    if(undefined!=result.extend.errorFields.email){
                        show_validate_msg("#empemail_add_input","error",result.extend.errorFields.email)


                    }
                    if (undefined!=result.extend.errorFields.empName){
                        show_validate_msg("#empname_add_input","error",result.extend.errorFields.empName)

                    }
                }


            }


        })

    })

    //为修改按钮绑定单机事件
    $(document).on("click",".edit_btn",function () {
        //1.获得员工信息
        getEmp($(this).attr("edit-id"))
        //2.获得部门信息
        getDepts("#dept_update_select");
        //将员工id传递给修改按钮
        $("#empName_update_static").attr("edit-id",$(this).attr("edit-id"))
       //alert( $("#empName_update_static").attr("edit-id"))
        //3.弹出模态框
        $("#empUpdateModal").modal({
            backdrop:'static'
        })


    })
    //获取员工信息方法
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emps/"+id,

            type:"get",
            success:function (reset) {
                // console.log(reset)
                var empDate = reset.extend.emp;
                $("#empName_update_static").text(empDate.empName);
                $("#empemail_update_input").val(empDate.email);
                $("empUpdateModal input[name=gender]").val([empDate.gender]);
                $("#empUpdateModal select").val([empDate.dId])

            }
        })

    }
    //保存员工信息
    //1.为修改绑定单技事件

 $("#emp_update_btn").click(function(){
        //验证邮箱是否合法
        //1、校验邮箱信息
        var email = $("#empemail_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#empemail_update_input", "error", "邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#empemail_update_input", "success", "");
        }
//2、发送ajax请求保存更新的员工数据--%>
        $.ajax({
            url:"${APP_PATH}/emps/"+$("#empName_update_static").attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function(result){
                //alert(result.meg);
                //1、关闭对话框
                $("#empUpdateModal").modal("hide");
                // $("#empUpdateModal").modal("hide");
                // //回到当前页面
                to_page(curredpage);
                // to_page(currentPage);
            }
        });
    });

    //删除单个员工信息
    //1.为删除按键绑定单击事件
    $(document).on('click',".delete_btn",function () {
        //2.点击弹出确认提示框是否删除 （获取当前响应对象的empName）

        if (confirm("是否要删除【"+$(this).parents("tr").find("td:eq(2)").text()+"】吗？")){
            //3.确认删除后发ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emps/"+$(this).attr("delete-id"),
                type:"DELETE",
                success:function () {
                    to_page(curredpage);



                }
            })
        }
    })
   // 多条删除的选中状态
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"));
    })
    $(document).on("click",".check_item",function () {
        //判断选中个数是否与列数相同
        var flag =$(".check_item:checked").length==$(".check_item").length
       $("#check_all").prop("checked",flag);

    })
    //点击多条输出
    $("#emp_delete_all_btn").click(function () {
        var emps="";
        var del_idstr="";
        $.each($(".check_item:checked"),function () {
           emps+= $(this).parents("tr").find("td:eq(2)").text()+",";
           del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";

        })
        emps=emps.substring(0,emps.length-1);
        del_idstr=del_idstr.substring(0,del_idstr.length-1);
       if(confirm("确认删除【"+emps+"】吗?")) {
           $.ajax({
               url:"${APP_PATH}/emps/"+del_idstr,
               type:"DELETE",
               success:function (result) {
                    alert(result.meg)
                   to_page(curredpage);
               }
           })
       }

    })









</script>


</body>
</html>
