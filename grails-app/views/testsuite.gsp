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
    <title>测试集管理</title>
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
    <g:include view="template/css.gsp"/>
</head>

<body>
<div class="body_con" id="testsuite" v-cloak>
    <div class="body_top">
        <h3>程序设计综合实践</h3>
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
    </div>
    <div class="body_left">
        <ul class="body_left_list">
            <li>
                <label>
                    <span> 组号：<%=session["group"].id%></span>
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
                            <a href="/Runner/rank"></a>
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
                %{--                <div class="col-xs-8">--}%
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">测试例</h3>
                    </div>
                    <!-- /.box-header -->
                    <el-row class="ele-button">
                        <el-button type="primary" round onclick="window.showModalDialog('/addcase')">
                            添加
                        </el-button>
                    </el-row>

                    <div class="bootstrap-data-table-panel">
                        <div class="box-body">
                            <table id="bootstrap-data-table-export" class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>测试集名称</th>
                                    <th>超时配置</th>
                                    <th>调用参数</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    def suitelist = simulatorcontest.TestCase.findAll()
                                %>
                                <g:each in="${suitelist}" var="s">
                                    <tr>
                                        <th>${s.id}</th>
                                        <th>${s.suite}</th>
                                        <th>${s.timeout}</th>
                                        <th>${s.getParamsString()}</th>
                                        <th>
                                            %{--                                            <a href="#" onclick="window.showModalDialog('/addpara?sid=${s.id}')">--}%
                                            %{--                                                <el-button type="primary" plain size="small">添加参数</el-button>--}%
                                            %{--                                            </a>--}%
                                            <el-button type="primary" plain size="small" onclick="addPara(${s.id})">添加参数</el-button>
                                            <a href="/TestSuite/remove?sid=${s.id}">
                                                <el-button type="danger" plain size="small">删除</el-button>
                                            </a>
                                            %{--                                            <a href="#">--}%
                                            %{--                                                <el-button type="danger" plain size="small"--}%
                                            %{--                                                           onclick="deleteItem(${s.id})">删除</el-button>--}%
                                            %{--                                            </a>--}%

                                            %{--                                            </a>--}%

                                            %{--                                            <div class="button-list">--}%
                                            %{--                                                <button type="button" class="btn btn-sm btn-primary btn-rounded m-b-10 m-l-5">--}%
                                            %{--                                                    <a href="#"--}%
                                            %{--                                                       onclick="window.showModalDialog('/addpara?sid=${s.id}')">添加参数</a>--}%
                                            %{--                                                </button>--}%
                                            %{--                                                <button type="button" class="btn btn-sm btn-danger btn-rounded m-b-10 m-l-5">--}%
                                            %{--                                                    <a href="/TestSuite/remove?sid=${s.id}">删除</a>--}%
                                            %{--                                                </button>--}%
                                            %{--                                            </div>--}%

                                        </th>
                                    </tr>
                                </g:each>
                                </tbody>

                            </table>
                            %{--                          <button type="submit" onclick="window.showModalDialog('/addcase')">添加</button>--}%
                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col -->
            %{--            </div>--}%
        </section>
    </div>
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
%{--            "lengthChange": false,--}%
%{--            "searching": false,--}%
%{--            "ordering": false,--}%
%{--            "info": true,--}%
%{--            "autoWidth": false--}%
%{--        });--}%
%{--    });--}%
%{--</script>--}%
<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const TestSuite = new Vue({
        el: "#testsuite",
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
%{--<script type="text/javascript">--}%
%{--    //定义window.showModalDialog如果它不存在--}%
%{--    if (window.showModalDialog == undefined) {--}%
%{--        window.showModalDialog = function (url) {--}%
%{--//                                    if(window.hasOpenWindow){--}%
%{--//                                        alert("您已经打开了一个窗口！请先处理它");//避免多次点击会弹出多个窗口--}%
%{--//                                        window.myNewWindow.focus();--}%
%{--//                                    }--}%
%{--//                                    window.hasOpenWindow = true;--}%
%{--            window.myNewWindow = window.open(url);--}%
%{--        }--}%
%{--    }--}%
%{--</script>--}%
%{--<script>--}%
%{--    function deleteItem(sid) {--}%
%{--        console.log(sid);--}%
%{--        removeProject(sid)--}%
%{--        function removeProject(sid) {--}%
%{--            var result = confirm("确定要删除所选项目？")--}%
%{--            if (result) {--}%
%{--                $.ajax({--}%
%{--                    type: "POST",--}%
%{--                    async: true,--}%
%{--                    cache: false,--}%
%{--                    url: "TestSuite/remove",--}%
%{--                    data: {sid: sid},--}%
%{--                    success: function (data) {--}%
%{--                        if (data === "1") {--}%
%{--                            var result = confirm("是否跳转至测试例列表？")--}%
%{--                            if (result) {--}%
%{--                                window.location.reload()--}%
%{--                            }--}%
%{--                        }--}%
%{--                    },--}%
%{--                    error: function (xmlhttp, state, msg) {--}%
%{--                        alert(state + ":" + msg);--}%
%{--                    }--}%
%{--                });--}%
%{--            }--}%
%{--        }--}%
%{--    }--}%
%{--</script>--}%
</body>
</html>
