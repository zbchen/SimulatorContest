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

<body>
<div id="register" v-cloak>
    <div class="project_name">
        <h1>意见与建议</h1>
    </div>

    <div class="login-form">
        <div class="login-title">填写意见</div>

        <form role="form" action="/Login/comment" method="post" @submit="on_submit">
            <div class="form-control">
                <textarea class="textarea-style" name="comment" placeholder="意见与建议" id="form-comment"
                          rows="6"></textarea>

            </div>
            <button type="submit" class="login-button">提 交</button>
        </form>
    </div>
</div>
<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>

</body>
</html>