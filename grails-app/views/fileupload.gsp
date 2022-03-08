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
<div class="body_con">
    <div class="body_top">程序设计综合实践</div>
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
        <g:uploadForm controller="FileUpload" action="upload">
            <div class="file">
                <div class="file-style">
                    <img src="${resource(dir: 'images', file: 'file.jpeg')}" alt="file" class="img-file">
                    <span class="file-click ">点击此处上传文件</span>
                    <input type="file" name="myFile" class="input-file"/>
                </div>

                <div class="submit">
                    <input id="fileCover" type="text" class="form-control" style="display: none"/>
                    <button class="btn btn-primary btn-outline m-b-10 m-l-5" type="submit">提交</button>
                </div>
                %{--        <input type="submit"/>--}%
            </div>
        </g:uploadForm>
    </div>
</div>


<asset:javascript src="jquery-2.2.0.min.js"/>
<script>
    $('input[type=file]').change(function () {
        $('#fileCover').val($(this).val());
        $('#fileCover').show()
    });
</script>
</body>
</html>
