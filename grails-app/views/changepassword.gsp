<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>修改密码</title>
    <asset:stylesheet href="element-ui.css"/>
    <g:include view="template/css.gsp"/>
    <asset:stylesheet src="login-register.css"/>
</head>

<body>
<div class="body_con" id="changepassword" v-cloak>
    <div class="body_top">
        <h3>程序设计综合实践</h3>

        <div class="user-panel">
            <el-dropdown>
                <span class="el-dropdown-link">
                    用户操作<i class="el-icon-arrow-down el-icon--right"></i>
                </span>
                <el-dropdown-menu slot="dropdown">
                    <a href="" onclick="window.showModalDialog('/changepasswd')">
                        <el-dropdown-item>修改密码</el-dropdown-item>
                    </a>
                    <a href="/Login/logout">
                        <el-dropdown-item>注销 </el-dropdown-item>
                    </a>
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
                            <a href="" target="_blank" onclick="window.showModalDialog('/Runner/rank')"></a>
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
                            <a href="/changepasswd"></a>
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
        <div class="login-form" style="margin: 130px auto">
            <div class="login-title">修改密码</div>

            <form role="form" action="/Register/changePasswd" method="post" @submit="on_submit">
                %{--                    <div class="form-control">--}%
                <input class="input-style" type="password" name="oldpassword"
                       placeholder="请输入原密码" v-model="password" @blur="check_password">

                <div class="text-error" v-show="error_password">{{ error_password_message }}</div>
                %{--                    </div>--}%

                %{--                    <div class="form-control">--}%
                <input class="input-style" type="password" name="newpassword"
                       placeholder="请输入新密码" v-model="password2" @blur="check_password2">

                <div class="text-error" v-show="error_password2">{{ error_password2_message }}</div>
                %{--                    </div>--}%

                <button type="submit" class="login-button">修 改</button>
            </form>
        </div>
    </div>
</div>


<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const Login = new Vue({
        el: '#changepassword',
        data: {
            password: '',
            password2: '',
            error_password: false,
            error_password2: false,
            error_password_message: '请输入密码',
            error_password2_message: '请输入新密码',
        },
        methods: {
            check_password() {
                if (this.password === '') {
                    this.error_password = true
                } else if (this.password.length < 6) {
                    this.error_password_message = '密码长度不能小于6位'
                    this.error_password = true
                } else {
                    this.error_password = false
                }

            },
            check_password2() {
                if (this.password2 === '') {
                    this.error_password2 = true
                } else if (this.password2.length < 6) {
                    this.error_password2_message = '密码长度不能小于6位'
                    this.error_password2 = true
                } else {
                    this.error_password2 = false
                }
            },
            on_submit() {
                this.check_password()
                this.check_password2()
                if (this.error_password == true || this.error_password2 == true) {
                    window.event.returnValue = false
                }
            }

        }
    })
</script>
<g:include view="template/js.gsp"/>
</body>
</html>