<!doctype html>

<g:if test="${!session["group"]}">
    <g:javascript>
        window.location.href = '/';
    </g:javascript>
</g:if>
<head>
    <title>base</title>
    <g:include view="template/css.gsp"/>
</head>
<style>
.file {
    width: 50%;
    margin: 50px auto;
}

.file-style, .input-file {
    width: 300px;
    height: 240px;
    border: 4px dotted #ccc;
    margin: 0 auto;
}

.img-file {
    display: block;
    width: 100px;
    height: 100px;
    margin: 50px auto;
}

.file-click {
    display: block;
    text-align: center;
}

.file-style {
    position: relative;
}

.input-file {
    position: absolute;
    top: -4px;
    left: -5px;
    opacity: 0;

}

.submit {
    width: 300px;
    text-align: center;
    margin: 10px auto;
}

.submit > button {
    margin-top: 10px;
}
</style>
<html>
<body>
<div class="body_con" id="file" v-cloak>
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
        <g:uploadForm controller="FileUpload" action="upload" enctype="multipart/form-data">
            <div class="file">
                <div class="file-style">
                    <img src="${resource(dir: 'images', file: 'file.jpeg')}" alt="file" class="img-file">
                    <span class="file-click ">点击此处上传文件</span>
                    <input type="file" name="myFile" class="input-file" id="input-file"/>
                </div>

                <div class="submit">
                    <input id="fileCover" type="text" class="form-control" style="display: none"/>
                    <button class="btn btn-primary btn-outline m-b-10 m-l-5" type="submit" >提交</button>
%{--                    <input class="btn btn-primary btn-outline m-b-10 m-l-5" type="submit" onclick="submit_file()"/>--}%

                </div>

            </div>
        </g:uploadForm>
    </div>
</div>

<asset:javascript src="vue.js"/>
<asset:javascript src="element-ui.js"/>
<script>
    const file = new Vue({
        el: '#file',
    })
</script>
<g:include view="template/js.gsp"/>
<script>

    $('input[type=file]').change(function () {
        $('#fileCover').val($(this).val());
        $('#fileCover').show()
    });
    // function submit_file(){
    //     // const file = $("#input-file").val()
    //     // if(file === ''){
    //     //     alert("lk;")
    //     //     window.location.href='/fileupload'
    //     // }
    //     // console.log($("#input-file")[0].files[0])
    //     // var filename = file.substring(file.lastIndexOf(".") + 1).toLowerCase()
    //     // if(filename!=='tar'){
    //     //     alert("请选择tar压缩文件")
    //     //     return false
    //     // }
    //     var formData = new FormData()
    //     var type = "file1"
    //
    //     formData.append(type,$("#input-file")[0].files[0])
    //
    //     $.ajax({
    //         type: "POST",
    //         async: false,
    //         cache: false,
    //         url: "fileUpload/upload",
    //         data: formData,
    //         processData:false,
    //         contentType:false,
    //
    //         success: function (data) {
    //             if (data === "1") {
    //                 alert("wsrfhiewhft")
    //                 window.location.href='/user'
    //
    //             }
    //             else if(data==='2'){
    //
    //             }
    //             else if(data==='3'){
    //
    //             }
    //         },
    //         error: function (xmlhttp, state, msg) {
    //             alert(state + ":" + msg);
    //         }
    //     });
    // }
</script>
<script>
    function* foo(x) {
        var y = 2 * (yield (x + 1));
        var z = yield (y / 3);
        return (x + y + z);
    }
    const b = foo(5)
    console.log(b.next())
    console.log(b.next(12))
    console.log(b.next(10))
</script>
</body>
</html>
