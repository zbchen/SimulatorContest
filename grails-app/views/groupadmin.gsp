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
    <title>组管理</title>
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
<div class="body_con" id="groupadmin" v-cloak>
    <div class="body_top">
        <h3>程序设计综合实践</h3>

        <div class="user-panel">
            <el-dropdown>
                <span class="el-dropdown-link">
                    用户操作<i class="el-icon-arrow-down el-icon--right"></i>
                </span>
                <el-dropdown-menu slot="dropdown">
                    <a href="" onclick="window.showModalDialog('/changepasswd')">
                        <el-dropdown-item>修改密码</el-dropdown-item>
                    </a>
                    <a href="/Login/logout">
                        <el-dropdown-item>注销 </el-dropdown-item>
                    </a>
                </el-dropdown-menu>
            </el-dropdown>
        </div>
    </div>

    <div class="body_left">
        <ul class="body_left_list">
            <li>
                <label>
                    <span>组号：<%=session["group"].id%></span>
                    <a href="javascript:;"></a>
                </label>
            </li>
            <li>
                <label>
                    <span>测试</span>
                    <a href="javascript:;"></a>
                </label>
                <ul>
                    <% if (session["group"] /*&& session["group"].grade < 60*/) { %>
                    <li>
                        <label>
                            <span>上载</span>
                            <a href="/FileUpload"></a>
                        </label>
                    </li>
                    <% } %>
                    <% if (session["group"] && session["group"].identity == 75) { %>
                    <li>
                        <label>
                            <span>组管理</span>
                            <a href="/gadmin"></a>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span>测试列表</span>
                            <a href="/admin"></a>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span>测试例</span>
                            <a href="/testsuite"></a>
                        </label>
                    </li>
                    <% } %>
                </ul>
            </li>
            <li>
                <label>
                    <span>成绩</span>
                    <a href="javascript:;"></a>
                </label>
                <ul>
                    <% if (session["group"] && session["group"].identity == 75) { %>
                    <li>
                        <label>
                            <span>成绩列表</span>
                            <a href="/gradelist"></a>
                        </label>
                    </li>
                    <% } %>
                    <li>
                        <label>
                            <span>排名</span>
                            <a href="" target="_blank" onclick="window.showModalDialog('/Runner/rank')"></a>
                        </label>
                    </li>
                    <% if (session["group"] && session["group"].identity == 75) { %>
                    <li>
                        <label>
                            <span>查重</span>
                            <a href="/clone"></a>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span>查重结果</span>
                            <a href="/viewclone"></a>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span>补考</span>
                            <a href="/bukao"></a>
                        </label>
                    </li>
                    <% } %>
                </ul>
            </li>
            <li>
                <label>
                    <span>意见</span>
                    <a href="javascript:;"></a>
                </label>
                <ul>
                    <li>
                        <label>
                            <span>提交意见</span>
                            <a href="/comment" onclick=""></a>
                        </label>
                    </li>
                    <% if (session["group"] && session["group"].identity == 75) { %>
                    <li>
                        <label>
                            <span>意见列表</span>
                            <a href="/groupcomment"></a>
                        </label>
                    </li>
                    <% } %>
                </ul>
            </li>
            <li>
                <label>
                    <span>用户</span>
                    <a href="javascript:;"></a>
                </label>
                <ul>
                    <li>
                        <label>
                            <span>用户信息</span>
                            <a href="/user"></a>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span>修改密码</span>
                            <a href="/changepasswd"></a>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span>注销</span>
                            <a href="/Login/logout"></a>
                        </label>
                    </li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="body_right">
        <section class="content">
            <div class="row">
                %{--            <div class="col-xs-8">--}%
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">组管理</h3>
                    </div>
                    <%
                        def glist = simulatorcontest.ContestGroup.findAll([sort: "identity", order: "asc"])
                    %>
                    <!-- /.box-header -->
                    <div class="bootstrap-data-table-panel">
                        <div class="box-body">
                            <table id="bootstrap-data-table-export" class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>组号</th>
                                    <th>组名</th>
                                    <th>学生</th>
                                    <th>学号</th>
                                    <th>成绩</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${glist}" var="g">
                                    <%
                                        /// only list the latest file of each group
                                    %>
                                    <tr>
                                        <th>${g.id}</th>
                                        <th>${g.name}</th>
                                        <th>${g.students[0].name}</th>
                                        <th>${g.students[0].identity}</th>
                                        <th>${g.grade}</th>
                                        <th>
                                            %{--                                        <a href="#"--}%
                                            %{--                                           onclick="window.showModalDialog('/updategrade?gid=${g.id}')">--}%
                                            %{--                                            <el-button type="primary" plain size="small">成绩</el-button>--}%
                                            %{--                                        </a>--}%
                                            %{--                                            <el-button type="primary" plain size="small" onclick="showGrade(${g.id})">成绩</el-button>--}%
                                            <el-button type="primary" plain size="small" data-toggle="modal"
                                                       data-target="#myModal-grade-${g.id}">修改成绩
                                            </el-button>

                                            <div class="modal fade" id="myModal-grade-${g.id}" tabindex="-1"
                                                 role="dialog"
                                                 aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title" id="myModalLabel">修改成绩</h4>
                                                        </div>

                                                        <div class="modal-body">
                                                            <form id="update-grade">
                                                                <div class="form-group row">
                                                                    <label class="col-lg-4 col-form-label"
                                                                           for="grade">成绩：<span
                                                                            class="text-danger">*</span></label>

                                                                    <div class="col-lg-8">
                                                                        <input type="text" class="form-control"
                                                                               id="grade" name="grade">
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>

                                                        <div class="modal-footer">
                                                            <el-button type="info" plain size="small"
                                                                       data-dismiss="modal">关闭</el-button>
                                                            <el-button type="primary" plain
                                                                       size="small"
                                                                       onclick="updateGrade(${g.id})">修改成绩</el-button>

                                                        </div>
                                                    </div><!-- /.modal-content -->
                                                </div><!-- /.modal-dialog -->
                                            </div><!-- /.modal -->

                                            <a href="/muserfile?gid=${g.id}">
                                                <el-button type="primary" plain size="small">文件列表</el-button>
                                            </a>
                                            %{--                                            <a href="/groupAdmin/remove?gid=${g.id}">--}%
                                            %{--                                                <el-button type="danger" plain size="small">删除</el-button>--}%
                                            %{--                                            </a>--}%
                                            <a href="#">
                                                <el-button type="danger" plain size="small"
                                                           onclick="deleteItem(${g.id})">删除</el-button>
                                            </a>
                                        </th>
                                    </tr>
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
            %{--        </div>--}%
        </section>
    </div>
</div>
<!-- /.content-wrapper -->
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
    const groupadmin = new Vue({
        el: '#groupadmin',
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
<script>
    function deleteItem(gid) {
        console.log(gid);
        removeProject(gid)

        function removeProject(gid) {
            swal({
                title: "",
                text: "确定要删除所选项目？",
                icon: "info",
                buttons: {
                    cancel: "取消",
                    confirm: "确定"
                }
            }).then((confirm) => {
                if (confirm) {
                    $.ajax({
                        type: "POST",
                        async: true,
                        cache: false,
                        url: "groupAdmin/remove",
                        data: {gid: gid},
                        success: function (data) {
                            if (data === "1") {
                                swal({
                                    title: '成功',
                                    text: '是否跳转到组管理列表？',
                                    icon: 'success',
                                    button: '确定'
                                }).then(() => {
                                    window.location.href = '/gadmin'
                                })
                            }
                        },
                        error: function (xmlhttp, state, msg) {
                            alert(state + ":" + msg);
                        }
                    });
                }
            })
        }
    }

    function updateGrade(gid) {
        console.log(gid)
        Update(gid)
        function Update(gid) {
            console.log('sdw')
            $.ajax({
                type: "POST",
                async: true,
                cache: false,
                url: "groupAdmin/grade",
                data: {gid: gid,grade:$("#grade").val()},
                success: function (data) {
                    if (data === "1") {
                        swal({
                            title: '成绩修改成功',
                            text: '是否跳转到组管理列表？',
                            icon: 'success',
                            button: '确定'
                        }).then(() => {
                            window.location.href = '/gadmin'
                        })
                    }
                    if (data === "2") {
                        swal({
                            title: '成绩修改失败',
                            text: '是否跳转到组管理列表？',
                            icon: 'warning',
                            button: '确定'
                        }).then(() => {
                            window.location.href = '/gadmin'
                        })
                    }
                },
                error: function (xmlhttp, state, msg) {
                    alert(state + ":" + msg);
                }
            });
        }
    }

</script>
</body>
</html>
