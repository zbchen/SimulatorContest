<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>导航栏</title>
    <asset:stylesheet href="element-ui.css"/>
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="data-table/dataTables.bootstrap.min.css"/>
    <asset:stylesheet src="data-table/buttons.bootstrap.min.css"/>
    <asset:stylesheet src="data-table/dataTables-init.css"/>
    <style>
    a:hover {
        text-decoration: none;
    }

    .box {
        width: 80%;
        display: block;
        margin: 0 auto;
        text-align: center;
    }

    thead {
        background: #84beff;
    }

    .user-panel {
        position: fixed;
        right: 10px;
        top: 10px;
    }

    .el-dropdown-link {
        cursor: pointer;
        color: #409EFF;
    }

    .el-icon-arrow-down {
        font-size: 12px;
    }
    </style>
</head>

<body>
<div id="navbar">
    <template class="navbar-title">
        <el-tabs type="card" v-model="activeName" @tab-click="handleClick">
            <el-tab-pane label="用户" name="first">
                <g:include view="userfile1.gsp"/>
            </el-tab-pane>
            <% if (session["group"] && session["group"].identity == 75) { %>
            <el-tab-pane label="补考" name="second">
                <g:include view="bukao.gsp"/>
            </el-tab-pane>
            <el-tab-pane label="测试" name="third">
                <g:include view="manager.gsp"/>
            </el-tab-pane>
            <el-tab-pane label="组管理" name="fourth">
                <g:include view="groupadmin.gsp"/>
            </el-tab-pane>
            <el-tab-pane label="测试例" name="fifth">
                <g:include view="testsuite1.gsp"/>
            </el-tab-pane>
            <el-tab-pane label="查重" name="sixth">
                <g:include view="clone.gsp"/>
            </el-tab-pane>
            <el-tab-pane label="成绩" name="seventh">
                <g:include view="gradelist.gsp"/>
            </el-tab-pane>
            <el-tab-pane label="意见" name="eighth">
                <g:include view="groupcomment.gsp"/>
            </el-tab-pane>
            <% } %>
            <% if (session["group"] && session["group"].identity != 75) { %>
            <el-tab-pane label="查重结果" name="second">
                <g:include view="viewclone.gsp"/>
            </el-tab-pane>
            <% } %>
            <% if (session["group"]) { %>
            <el-tab-pane label="排名" name="ninth">
                <a href="/Runner/rank">排名</a>
            </el-tab-pane>
            <% } %>
            <% if (session["group"]) { %>
            <%
                    def comments = simulatorcontest.Comment.findAllByGroup(session["group"])
            %>
            <% if (comments && comments.size() > 0) { %>
            <%=session["group"].grade%>
            <% } else { %>
            %{--            <el-tab-pane label="成绩" name="twelfth">--}%
            %{--                <a href="/comment" onclick="">成绩</a>--}%
            %{--            </el-tab-pane>--}%
            <% } %>
            <el-tab-pane label="组号：<%=session["group"].id%>" disabled="true" name="thirteenth"></el-tab-pane>
            <% } %>
        </el-tabs>
        <div class="user-panel">
            <el-dropdown>
                <span class="el-dropdown-link">
                    用户操作<i class="el-icon-arrow-down el-icon--right"></i>
                </span>
                <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item>
                        <a href="" onclick="window.showModalDialog('/changepasswd')">修改密码</a>
                    </el-dropdown-item>
                    <el-dropdown-item>
                        <a href="/Login/logout">注销</a>
                    </el-dropdown-item>
                </el-dropdown-menu>
            </el-dropdown>
        </div>
    </template>
</div>
%{--<asset:javascript src="jquery-2.2.0.min.js"/>--}%
%{--<asset:javascript src="bootstrap.js"/>--}%
%{--<asset:javascript src="data-table/datatables.min.js"/>--}%
%{--<asset:javascript src="data-table/jquery.dataTables.min.js"/>--}%
%{--<asset:javascript src="data-table/datatables-init.js"/>--}%
<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const NavBar = new Vue({
        el: "#navbar",
        data() {
            return {
                activeName: 'first'
            };
        },
        methods: {
            handleClick(tab, event) {
                console.log(tab, event);
            },
            logout() {
                console.log("logout");
            }
        }
    })
</script>
%{--<script src="plugins/jQuery-2.2.3/jquery-2.2.3.min.js"></script>--}%
%{--<!-- Bootstrap 3.3.6 -->--}%
%{--<script src="bootstrap/js/bootstrap.min.js"></script>--}%
%{--<!-- FastClick -->--}%
%{--<script src="plugins/fastclick/fastclick.js"></script>--}%
%{--<!-- AdminLTE App -->--}%
%{--<script src="adminlte/js/app.min.js"></script>--}%
%{--<!-- AdminLTE for demo purposes -->--}%
%{--<script src="adminlte/js/demo.js"></script>--}%
%{--<!-- DataTables -->--}%
%{--<script src="plugins/datatables/jquery.dataTables.min.js"></script>--}%
%{--<script src="plugins/datatables/dataTables.bootstrap.min.js"></script>--}%

%{--<script src="plugins/jquery-form/jquery.form.js"></script>--}%
%{--<!-- Slimscroll -->--}%
%{--<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>--}%
<script type="text/javascript">
    //定义window.showModalDialog如果它不存在
    if (window.showModalDialog == undefined) {
        window.showModalDialog = function (url) {
//                                    if(window.hasOpenWindow){
//                                        alert("您已经打开了一个窗口！请先处理它");//避免多次点击会弹出多个窗口
//                                        window.myNewWindow.focus();
//                                    }
//                                    window.hasOpenWindow = true;
            window.myNewWindow = window.open(url);
        }
    }
</script>
</body>
</html>