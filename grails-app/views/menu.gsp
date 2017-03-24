<section class="content-header">
    <h1>
        <a href="/user">用户</a>
        <a href="/FileUpload">上载</a>
        <%if (session["group"] && session["group"].identity == 75) {%>
        <a href="/admin">测试</a>
        <a href="/gadmin">组管理</a>
        <a href="/testsuite">测试例</a>
        <a href="/clone">查重</a>
        <%}%>
        <%if (session["group"] && session["group"].identity != 75) {%>
        <a href="/viewclone">查重结果</a>
        <%}%>
        <%if (session["group"]) {%>
        <a href="/Runner/rank">排名</a>
        <%}%>
        <a href="/Login/logout">注销</a>
    </h1>
    <h1>列表</h1>
</section>