<%@ page import="simulatorcontest.UploadFile" %>
<g:if test="${!session["group"]}">
    <g:javascript>
        window.location.href = '/';
    </g:javascript>
</g:if>
<div class="wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="row">
%{--            <div class="col-xs-8">--}%
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">用户</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table id="table1" class="table table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>编号</th>
                                <th>组名</th>
                                <th>文件名</th>
                                <th>状态</th>
                                <th>提交时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                def flist = simulatorcontest.UploadFile.findAllByGroup(session["group"], [sort: "id", order: "desc"])
                                def i = 1
                            %>
                            <g:each in="${flist}" var="f">
                                <tr>
                                    <th>${i++}</th>
                                    <th>${f.group.name}</th>
                                    <th><!--a href="/FileUpload/download?fid=${f.id}"-->${f.name}<!--/a--></th>
                                    <th>${f.result ? "已测试" + ((f.isPass() && application["testsuite"] != "003") ? "(已通过)" : "(未通过)") : "未测试"}</th>
                                    <th>${f.uploadDate}</th>
                                    <th>
                                        <% if (session["group"].grade < 60) { %>
                                        <!--a href="/Runner/test?fid=${f.id}">测试</a-->&nbsp;
                                        <% } %>
                                        <a href="/Runner/result?fid=${f.id}">查看结果</a>
                                        <% if (session["group"].grade < 60) { %>
                                        <!--a href="/Runner/fl?fid=${f.id}">缺陷定位</a-->
                                        <% } %>
                                        <!--a href="/FileUpload/remove?fid=${f.id}">删除</a-->
                                    </th>
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
%{--        </div>--}%
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->