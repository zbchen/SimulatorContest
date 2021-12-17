<%@ page import="simulatorcontest.UploadFile" %>

<g:if test="${!session["group"] || session["group"].identity != 75}">
    <g:javascript>
        window.location.href = '/';
    </g:javascript>
</g:if>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>提交列表</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">


    <!-- Bootstrap 3.3.6 -->
    %{--    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">--}%
    %{--    <!-- Theme style -->--}%
    %{--    <link rel="stylesheet" href="adminlte/css/AdminLTE.min.css">--}%
    %{--    <!-- AdminLTE Skins. Choose a skin from the css/skins--}%
    %{--         folder instead of downloading all of them to reduce the load. -->--}%
    %{--    <link rel="stylesheet" href="adminlte/css/skins/_all-skins.min.css">--}%
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    <g:include view="/template/css.gsp"/>
</head>

<body class="hold-transition sidebar-mini">
<div class="wrapper" id="manager" v-cloak>

    <!-- Content Wrapper. Contains page content -->
    <div class="wrapper">
        <!-- Content Header (Page header) -->
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
        <el-menu class="el-menu-demo top-position" mode="horizontal" @select="handleSelect">
            <el-menu-item index="1">
                <a href="/user">用户</a>
            </el-menu-item>
            <% if (session["group"] /*&& session["group"].grade < 60*/) { %>
            <el-menu-item index="2">
                <a href="/FileUpload">上载</a>
            </el-menu-item>
            <% } %>
            <% if (session["group"] && session["group"].identity == 75) { %>
            <el-menu-item index="3">
                <a href="/bukao">补考</a>
            </el-menu-item>
            <el-menu-item index="4">
                <a href="/admin">测试</a>
            </el-menu-item>
            <el-menu-item index="5">
                <a href="/gadmin">组管理</a>
            </el-menu-item>
            <el-menu-item index="6">
                <a href="/testsuite">测试例</a>
            </el-menu-item>
            <el-menu-item index="7">
                <a href="/clone">查重</a>
            </el-menu-item>
            <el-menu-item index="8">
                <a href="/gradelist">成绩</a>
            </el-menu-item>
            <el-menu-item index="9">
                <a href="/groupcomment">意见</a>
            </el-menu-item>

            <% } %>
            <% if (session["group"] && session["group"].identity != 75) { %>
            <el-menu-item index="10">
                <a href="/viewclone">查重结果</a>
            </el-menu-item>

            <% } %>
            <% if (session["group"]) { %>
            <el-menu-item index="11">
                <a href="/Runner/rank">排名</a>
            </el-menu-item>
            <% } %>
            %{--        <% if (session["group"]) { %>--}%
            %{--        <a href="" onclick="window.showModalDialog('/changepasswd')">密码</a>--}%
            %{--        <% } %>--}%
            %{--        <a href="/Login/logout">注销</a>--}%
            <% if (session["group"]) { %>
            <%
                    def comments = simulatorcontest.Comment.findAllByGroup(session["group"])
            %>
            <% if (comments && comments.size() > 0) { %>
            成绩：<%=session["group"].grade%>
            <% } else { %>
            <el-menu-item index="12">
                <a href="/comment" onclick="">提交意见</a>
            </el-menu-item>
            <% } %>
            <el-menu-item index="13" disabled>
                组号：<%=session["group"].id%>
            </el-menu-item>
            <% } %>
        </el-menu>
        <!-- Main content -->
        <section class="content">
            <div class="row">
                %{--                <div class="col-xs-8">--}%
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">测试</h3>
                    </div>
                    <!-- /.box-header -->
                    <el-row class="ele-button">
                        <el-button type="primary" round>
                            <a style="color:#fff" href="/Runner/testAll">全部测试</a>
                        </el-button>
                    </el-row>

                    <div class="bootstrap-data-table-panel">
                        <div class="box-body">
                            <table id="bootstrap-data-table-export" class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>组号</th>
                                    <th>组名</th>
                                    <th>姓名</th>
                                    <th>学号</th>
                                    <th>文件名</th>
                                    <th>状态</th>
                                    <th>提交时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    def glist = simulatorcontest.ContestGroup.findAll([sort: "identity", order: "asc"])
                                    def i = 1
                                %>
                                <g:each in="${glist}" var="g">
                                    <%
                                        /// only list the latest file of each group
                                        if (g.files.size() > 0) {
                                            //def fileList = simulatorcontest.UploadFile.findAllByGroup(g, [sort:"id", order:"desc"])
                                            def f = g.files[0]
                                            boolean b = false
                                            f.results.each { it ->
                                                //println it.testcase.suite
                                                //println request.servletContext["testsuite"]
                                                if (it.testcase.suite.equals(request.servletContext["testsuite"])) {
                                                    b = true
                                                }
                                            }
                                    %>
                                    <tr>
                                        <th>${g.id}</th>
                                        <th>${g.name}</th>
                                        <th>${g.students[0].name}</th>
                                        <th>${g.students[0].identity}</th>
                                        <th><a href="/FileUpload/download?fid=${f.id}">${f.name}</a></th>
                                        <th>${
                                                f.result && b == true ? "已测试" + (f.isPass() ? "(已通过)" : "(未通过)") : "未测试"}</th>
                                        <th>${f.uploadDate}</th>
                                        <th>
                                            <a href="/Runner/test?fid=${f.id}">
                                                <el-button type="primary" plain size="small">测试</el-button>
                                            </a>
                                            <a href="/Runner/result?fid=${f.id}">
                                                <el-button type="primary" plain size="small">查看结果</el-button>
                                            </a>
                                            <a href="/FileUpload/remove?fid=${f.id}">
                                                <el-button type="danger" plain size="small">删除</el-button>
                                            </a>
                                        </th>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col -->
            %{--            </div>--}%
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

</div>
<!-- ./wrapper -->
<!-- jQuery 2.2.3 -->
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


%{--<!-- page script -->--}%
%{--<script>--}%
%{--    $(function () {--}%
%{--        $('#table1').DataTable({--}%
%{--            "paging": true,--}%
%{--            "lengthChange": true,--}%
%{--            "searching": true,--}%
%{--            "ordering": true,--}%
%{--            "info": true,--}%
%{--            "autoWidth": true--}%
%{--        });--}%
%{--    });--}%
%{--</script>--}%
<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const Manager = new Vue({
        el: '#manager',
        data() {
            return {
                activeIndex: '1',
                activeIndex2: '1'
            };
        },
        methods: {
            handleSelect(key, keyPath) {
                console.log(key, keyPath);
            }
        }
    })
</script>
<g:include view="template/js.gsp"/>
</body>
</html>
