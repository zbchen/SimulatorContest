<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>修改成绩</title>
    <asset:stylesheet href="element-ui.css"/>
    <asset:stylesheet src="login-register.css"/>
    <style>
    #updateGrade {
        margin: 130px auto;
    }

    [v-cloak] {
        display: none;
    !important;
    }
    </style>
</head>

<body>
<div id="updateGrade" v-cloak>
    <div class="login-form">
        <div class="login-title">修改成绩</div>
        <form role="form" action="/GroupAdmin/grade" method="post" @submit="on_submit">
            <div class="form-control">
                <input class="input-style" type="text" name="grade"
                       placeholder="成绩" v-model="grade" @blur="check_grade">

                <div class="text-error" v-show="error_grade">{{ error_grade_message }}</div>
            </div>
            <input type="hidden" name="gid" value="${params["gid"]}">
            <button type="submit" class="login-button">修 改</button>
%{--        </g:uploadForm>--}%
        </form>
    </div>
</div>
<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const Login = new Vue({
        el: '#updateGrade',
        data: {
            grade: '',
            error_grade: false,
            error_grade_message: '请输入成绩',
        },
        methods: {
            check_grade() {
                if (this.grade === '') {
                    this.error_grade = true
                } else {
                    this.error_grade = false
                }
            },
            on_submit() {
                this.check_grade()
                if (this.error_grade == true) {
                    window.event.returnValue = false
                }
            }
        }
    })
</script>

</body>
</html>