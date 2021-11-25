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
<div class="wrapper">

    <!-- Content Wrapper. Contains page content -->
    <div class="wrapper">
        <!-- Content Header (Page header) -->
        <g:include view="/NavBar.gsp"/>

        <!-- Main content -->
        <section class="content">
            <div class="row">
%{--                <div class="col-xs-8">--}%
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">意见</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="bootstrap-data-table-panel">
                            <div class="box-body">
                                <table id="bootstrap-data-table-export" class="table table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th>组号</th>
                                        <th>学生1</th>
                                        <th>学生2</th>
                                        <th>成绩</th>
                                        <th>意见</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        def glist = simulatorcontest.ContestGroup.findAll([id: "identity", order: "asc"])
                                    %>
                                    <g:each in="${glist}" var="g">
                                        <%
                                            /// only list the latest file of each group
                                            def clist = simulatorcontest.Comment.findAllByGroup(g)
                                        %>
                                        <tr>
                                            <th>${g.id}</th>
                                            <th>${g.students[0].name}</th>
                                            <th></th>
                                            <th>${g.grade}</th>
                                            <th>
                                                <% if (clist.size() > 0) { %>
                                                <textarea
                                                        style="width:400px;height:150px;overflow:scroll;resize:none;">${
                                                        clist.get(0).comment}</textarea>
                                                <% } else { %>
                                                未提交
                                                <% } %>
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
%{--            "lengthChange": false,--}%
%{--            "searching": true,--}%
%{--            "ordering": true,--}%
%{--            "info": true,--}%
%{--            "autoWidth": false--}%
%{--        });--}%
%{--    });--}%
%{--</script>--}%
<g:include view="template/js.gsp"/>
</body>
</html>
