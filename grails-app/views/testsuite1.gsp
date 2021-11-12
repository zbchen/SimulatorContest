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
%{--            <div class="col-xs-8">--}%
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">测试例</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <table id="table1" class="table table-bordered table-hover">
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
                                        <a href="/TestSuite/remove?sid=${s.id}">删除</a>
                                        <a href="#" onclick="window.showModalDialog('/addpara?sid=${s.id}')">添加参数</a>
                                    </th>
                                </tr>
                            </g:each>
                            </tbody>

                        </table>
                        <button type="submit" onclick="window.showModalDialog('/addcase')">添加</button>
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
