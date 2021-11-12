<%@ page import="simulatorcontest.UploadFile" %>

<g:if test="${!session["group"] || session["group"].identity != 75}">
    <g:javascript>
        window.location.href = '/';
    </g:javascript>
</g:if>

%{--<html>--}%
%{--<head>--}%
%{--    <meta charset="utf-8">--}%
%{--    <meta http-equiv="X-UA-Compatible" content="IE=edge">--}%
%{--    <title>学生成绩</title>--}%
%{--    <!-- Tell the browser to be responsive to screen width -->--}%
%{--    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">--}%


%{--    <!-- Bootstrap 3.3.6 -->--}%
%{--    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">--}%
%{--    <!-- Theme style -->--}%
%{--    <link rel="stylesheet" href="adminlte/css/AdminLTE.min.css">--}%
%{--    <!-- AdminLTE Skins. Choose a skin from the css/skins--}%
%{--         folder instead of downloading all of them to reduce the load. -->--}%
%{--    <link rel="stylesheet" href="adminlte/css/skins/_all-skins.min.css">--}%
%{--        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->--}%
%{--        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->--}%
%{--        <!--[if lt IE 9]>--}%
%{--        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>--}%
%{--        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>--}%
%{--        <![endif]-->--}%
%{--</head>--}%

%{--<body class="hold-transition sidebar-mini">--}%
%{--<div class="wrapper">--}%

    <!-- Content Wrapper. Contains page content -->
    <div class="wrapper">
        <!-- Content Header (Page header) -->
%{--        <g:include view="/menu" />--}%

        <!-- Main content -->
        <section class="content">
            <div class="row">
%{--                <div class="col-xs-8">--}%
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">成绩</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="table1" class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>姓名</th>
                                    <th>学号</th>
                                    <th>成绩</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <%
                                        def slist = simulatorcontest.Student.findAll([sort:"identity", order:"asc"])
                                    %>
                                <g:each in="${slist}" var="s">
                                        <tr>
                                            <th>${s.name}</th>
                                            <th>${s.identity}</th>
                                            <th>${s.group.grade}</th>
                                        </tr>
                                </g:each>
                                </tbody>

                            </table>
                            
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

%{--</div>--}%
%{--<!-- ./wrapper -->--}%
%{--<!-- jQuery 2.2.3 -->--}%
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

%{--</body>--}%
%{--</html>--}%
