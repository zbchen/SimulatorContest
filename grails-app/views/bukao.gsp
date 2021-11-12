<%@ page import="simulatorcontest.UploadFile" %>

<g:if test="${!session["group"] || session["group"].identity != 75}">
    <g:javascript>
        window.location.href = '/';
    </g:javascript>
</g:if>
<div class="wrapper">
    <!-- Main content -->
    <section class="content">
        <div class="row">
            %{--                <div class="col-xs-8">--}%
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">补考</h3>
                </div>
                <!-- /.box-header -->
                <!--a href="/Runner/testAll">全部测试</a-->
                <div class="box-body">
                    <table id="table1" class="table table-bordered table-hover">
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
                                if (g.grade < 60) {
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
                                <th>${f.result && b == true ? "已测试" + (f.isPass() ? "(已通过)" : "(未通过)") : "未测试"}</th>
                                <th>${f.uploadDate}</th>
                                <th><a href="/Runner/test?fid=${f.id}">测试</a>&nbsp;
                                    <a href="/Runner/result?fid=${f.id}">查看结果</a>&nbsp;
                                    <a href="/FileUpload/remove?fid=${f.id}">删除</a>
                                </th>
                            </tr>
                            <%
                                    }
                                }
                            %>
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
