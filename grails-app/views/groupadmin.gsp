<%@ page import="simulatorcontest.UploadFile" %>
<g:if test="${!session["group"] || session["group"].identity != 75}">
    <g:javascript>
        window.location.href = '/';
    </g:javascript>
</g:if>
<!-- Content Wrapper. Contains page content -->
<div class="wrapper">
    <!-- Content Header (Page header) -->
    %{--    <g:include view="/menu"/>--}%

    <!-- Main content -->
    <section class="content">
        <div class="row" id="groupadmin">
            %{--            <div class="col-xs-8">--}%
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">组管理</h3>
                </div>
                <%
                    def glist = simulatorcontest.ContestGroup.findAll([sort: "identity", order: "asc"])
                %>
                <!-- /.box-header -->
                <div class="box-body">
                    <table id="table1" class="table table-bordered table-hover">
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
                                    <a href="/groupAdmin/remove?gid=${g.id}">删除</a>
                                    <a href="#" onclick="window.showModalDialog('/updategrade?gid=${g.id}')">成绩</a>
                                    <a href="/muserfile?gid=${g.id}">文件列表</a>
                                </th>
                            </tr>
                        </g:each>
                        </tbody>

                    </table>

                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
            %{--            </div>--}%
            <!-- /.col -->
        </div>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->