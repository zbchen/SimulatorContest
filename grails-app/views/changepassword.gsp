<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>修改密码</title>
    <asset:stylesheet href="element-ui.css"/>
    <asset:stylesheet src="login-register.css"/>
    <style>
    #changepassword{
        margin: 130px auto;
    }
    [v-cloak]{
        display: none;!important;
    }
</style>
</head>

<body>
<div id="changepassword" v-cloak>
    <div class="login-form">
        <div class="login-title">修改密码</div>

        <form role="form" action="/Register/changePasswd" method="post" @submit="on_submit">
            <div class="form-control">
                <input class="input-style" type="password" name="oldpassword"
                       placeholder="请输入原密码" v-model="password" @blur="check_password">

                <div class="text-error" v-show="error_password">{{ error_password_message }}</div>
            </div>

            <div class="form-control">
                <input class="input-style" type="password" name="newpassword"
                       placeholder="请输入新密码" v-model="password2" @blur="check_password2">

                <div class="text-error" v-show="error_password2">{{ error_password2_message }}</div>
            </div>

            <button type="submit" class="login-button">修 改</button>
        </form>
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
            error_password_message: '密请输入密码',
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
                }else if (this.password2.length < 6) {
                    this.error_password2_message = '密码长度不能小于6位'
                    this.error_password2 = true
                }else {
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

</body>
</html>