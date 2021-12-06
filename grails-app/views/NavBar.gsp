<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>导航</title>
    <g:include view="template/css.gsp"/>
</head>

<body>
<div id="navbar">
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
    <el-menu class="el-menu-demo top-position" mode="horizontal" @select="handleSelect">
        <el-menu-item index="1">
            <a href="/user">用户</a>
        </el-menu-item>
        <% if (session["group"] /*&& session["group"].grade < 60*/) { %>
        <el-menu-item index="2">
            <a href="/FileUpload">上载</a>
        </el-menu-item>
        <% } %>
        <% if (session["group"] && session["group"].identity == 75) { %>
        <el-menu-item index="3">
            <a href="/bukao">补考</a>
        </el-menu-item>
        <el-menu-item index="4">
            <a href="/admin">测试</a>
        </el-menu-item>
        <el-menu-item index="5">
            <a href="/gadmin">组管理</a>
        </el-menu-item>
        <el-menu-item index="6">
            <a href="/testsuite">测试例</a>
        </el-menu-item>
        <el-menu-item index="7">
            <a href="/clone">查重</a>
        </el-menu-item>
        <el-menu-item index="8">
            <a href="/gradelist">成绩</a>
        </el-menu-item>
        <el-menu-item index="9">
            <a href="/groupcomment">意见</a>
        </el-menu-item>

        <% } %>
        <% if (session["group"] && session["group"].identity != 75) { %>
        <el-menu-item index="10">
            <a href="/viewclone">查重结果</a>
        </el-menu-item>

        <% } %>
        <% if (session["group"]) { %>
        <el-menu-item index="11">
            <a href="/Runner/rank">排名</a>
        </el-menu-item>
        <% } %>
        %{--        <% if (session["group"]) { %>--}%
        %{--        <a href="" onclick="window.showModalDialog('/changepasswd')">密码</a>--}%
        %{--        <% } %>--}%
        %{--        <a href="/Login/logout">注销</a>--}%
        <% if (session["group"]) { %>
        <%
                def comments = simulatorcontest.Comment.findAllByGroup(session["group"])
        %>
        <% if (comments && comments.size() > 0) { %>
        成绩：<%=session["group"].grade%>
        <% } else { %>
        <el-menu-item index="12">
            <a href="/comment" onclick="">提交意见</a>
        </el-menu-item>
        <% } %>
        <el-menu-item index="13" disabled>
            组号：<%=session["group"].id%>
        </el-menu-item>
        <% } %>
    </el-menu>

%{--    <div class="line"></div>--}%

</div>
<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const navbar = new Vue({
        el: '#navbar',
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
<script type="text/javascript">
    //定义window.showModalDialog如果它不存在
    if (window.showModalDialog == undefined) {
        window.showModalDialog = function (url) {
//                                    if(window.hasOpenWindow){
//                                        alert("您已经打开了一个窗口！请先处理它");//避免多次点击会弹出多个窗口
//                                        window.myNewWindow.focus();
//                                    }
//                                    window.hasOpenWindow = true;
            window.myNewWindow = window.open(url);
        }
    }
</script>
</body>
</html>