<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>用户登录</title>
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

<body class="login">
<div id="login" v-cloak>
    <div class="project_name">
        <h1>程序设计综合实践</h1>
    </div>

    <div class="login-form">
        <div class="login-title">用户登录</div>
        <form role="form" action="/Login/log" method="post" @submit="on_submit">
            <div class="form-control">
                <input class="input-style" type="text" name="username"
                       placeholder="请输入用户名" v-model="username" @blur="check_username">
                <div class="text-error" v-show="error_username">{{ error_username_message }}</div>
            </div>

            <div class="form-control">
                <input class="input-style" type="password" name="password"
                       placeholder="请输入密码" v-model="password" @blur="check_password">
                <div class="text-error" v-show="error_password">{{ error_password_message }}</div>
            </div>
            <button type="submit" class="login-button">登  录</button>
        </form>
        <div class="register-link">
            <span>还没有账户 ? <a href="register"> 点击此处</a></span>
        </div>
    </div>
</div>
<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const Login = new Vue({
        el: '#login',
        data:{
            username:'',
            password:'',
            error_username:false,
            error_password:false,
            error_username_message:'请输入用户名',
            error_password_message:'请输入密码'

        },
        methods:{
            check_username(){
                if(this.username === ''){
                    this.error_username = true
                }else{
                    this.error_username = false
                }
            },
            check_password(){
                if(this.password === ''){
                    this.error_password = true
                }else{
                    this.error_password = false
                }
            },
            on_submit(){
                this.check_username()
                this.check_password()
                if(this.error_password == true || this.error_username == true){
                    window.event.returnValue = false
                }
            }
        }
    })
</script>
<g:include view="template/js.gsp"/>
</body>
</html>