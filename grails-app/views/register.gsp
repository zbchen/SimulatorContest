<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>用户注册</title>
    <asset:stylesheet href="element-ui.css"/>
    <asset:stylesheet src="login-register.css"/>
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    [v-cloak]{
        display: none;!important;
    }
</style>
</head>

<body class="register">
<div id="register" v-cloak>
    <div class="project_name">
        <h1>程序设计综合实践</h1>
    </div>

    <div class="login-form">
        <div class="login-title">用户注册</div>

        <form role="form" action="/Register/reg" method="post" @submit="on_submit">
            <div class="form-control">
                <input class="input-style" type="text" name="groupname"
                       placeholder="请输入组名" v-model="groupname" @blur="check_groupname">

                <div class="text-error" v-show="error_groupname">{{ error_groupname_message }}</div>
            </div>

            <div class="form-control">
                <input class="input-style" type="password" name="password"
                       placeholder="请输入密码" v-model="password" @blur="check_password">

                <div class="text-error" v-show="error_password">{{ error_password_message }}</div>
            </div>

            <div class="form-control">
                <input class="input-style" type="password" name="password2"
                       placeholder="请确认密码" v-model="password2" @blur="check_password2">

                <div class="text-error" v-show="error_password2">{{ error_password2_message }}</div>
            </div>

            <div class="form-control">
                <input class="input-style" type="text" name="name1"
                       placeholder="请输入组员姓名" v-model="name1" @blur="check_name1">

                <div class="text-error" v-show="error_name1">{{ error_name1_message }}</div>
            </div>

            <div class="form-control">
                <input class="input-style" type="text" name="num1"
                       placeholder="请输入组员学号" v-model="num1" @blur="check_num1">

                <div class="text-error" v-show="error_num1">{{ error_num1_message }}</div>
            </div>
            <button type="submit" class="login-button">注 册</button>
        </form>

        <div class="register-link">
            <span>已有账户 ? <a href="/">登录</a></span>
        </div>
    </div>
</div>
<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const Login = new Vue({
        el: '#register',
        data: {
            groupname: '',
            password: '',
            password2: '',
            name1: '',
            num1: '',
            error_groupname: false,
            error_password: false,
            error_password2: false,
            error_name1: false,
            error_num1: false,
            error_groupname_message: '组名不能为空',
            error_password_message: '密码不能为空',
            error_password2_message: '请再次输入密码',
            error_name1_message: '组员姓名不能为空',
            error_num1_message: '学号不能为空'
        },
        methods: {
            check_groupname() {
                if (this.groupname === '') {
                    this.error_groupname = true
                } else {
                    this.error_groupname = false
                }
            },
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
                } else if (this.password2 !== this.password) {
                    this.error_password2_message = '前后密码不一致'
                    this.error_password2 = true
                } else {
                    this.error_password2 = false
                }
            },
            check_name1() {
                if (this.name1 === '') {
                    this.error_name1 = true
                } else {
                    this.error_name1 = false
                }
            },
            check_num1() {
                if (this.num1 === '') {
                    this.error_num1 = true
                } else {
                    this.error_num1 = false
                }
            },
            on_submit() {
                this.check_groupname()
                this.check_password()
                this.check_password2()
                this.check_name1()
                this.check_num1()
                if (this.error_groupname == true || this.error_password == true
                    || this.error_password1 == true || this.error_name1 == true
                    || this.error_num1 == true) {
                    window.event.returnValue = false
                }
            }

        }
    })
</script>

</body>
</html>