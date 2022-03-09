<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>意见与建议</title>
    <asset:stylesheet href="element-ui.css"/>
    <g:include view="template/css.gsp"/>
    <asset:stylesheet href="login-register.css"/>

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="body_con" id="comment" v-cloak>
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
                    <span>组号：<%=session["group"].id%></span>
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
                            <a href="" onclick="window.showModalDialog('/changepasswd')"></a>
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
        <div id="register">
            <div class="comment-name">
                意见与建议
            </div>

            <div class="comment-form">
                <div class="comment-title">填写意见</div>

                <form role="form" action="/Login/comment" method="post" @submit="on_submit">
%{--                    <div class="form-control">--}%
                        <textarea class="textarea-style" name="comment" placeholder="意见与建议" id="form-comment"
                                  rows="6"></textarea>
%{--                    </div>--}%
                    <button type="submit" class="comment-button">提 交</button>
                </form>
            </div>
        </div>
    </div>
</div>
<g:include view="template/js.gsp"/>
<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const comment = new Vue({
        el:'#comment'
    })
</script>
</body>
</html>