<!doctype html>

<g:if test="${!session["group"]}">
    <g:javascript>
        window.location.href = '/';
    </g:javascript>
</g:if>
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
<g:include view="NavBar.gsp"/>
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

<asset:javascript src="jquery-2.2.0.min.js"/>
<script>
    $('input[type=file]').change(function () {
        $('#fileCover').val($(this).val());
        $('#fileCover').show()
    });
</script>
</body>
</html>
