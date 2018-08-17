<section class="content-header">
    <h1>
        <a href="/user">用户</a>
        <%if (session["group"] && session["group"].grade < 60) {%>
        <a href="/FileUpload">上载</a>
        <%}%>
        <%if (session["group"] && session["group"].identity == 75) {%>
        <a href="/bukao">补考</a>
        <a href="/admin">测试</a>
        <a href="/gadmin">组管理</a>
        <a href="/testsuite">测试例</a>
        <a href="/clone">查重</a>
        <a href="/gradelist">成绩</a>
        <a href="/groupcomment">意见</a>
        <%}%>
        <%if (session["group"] && session["group"].identity != 75) {%>
        <a href="/viewclone">查重结果</a>
        <%}%>
        <%if (session["group"]) {%>
        <a href="/Runner/rank">排名</a>
        <%}%>
        <%if (session["group"]) {%>
        <a href="" onclick="window.showModalDialog('/changepasswd')">密码</a>
        <%}%>
        <a href="/Login/logout">注销</a>
        <%if (session["group"]) {%>
            <%
                def comments = simulatorcontest.Comment.findAllByGroup(session["group"])
            %>
            <%if (comments && comments.size() > 0) {%>
                成绩：<%=session["group"].grade%>
            <%} else {%>
                <a href="/comment" onclick="">成绩</a>
            <%}%>
        组号：<%=session["group"].id%>
        <%}%>

    </h1>
    <h1>列表</h1>
</section>