<!doctype html>

<g:if test="${!session["group"]}">
    <g:javascript>
        window.location.href = '/';
    </g:javascript>
</g:if>

<html>
<body>
    <g:uploadForm controller="FileUpload" action="upload">
        <input type="file" name="myFile" />
        <input type="submit" />
    </g:uploadForm>
</body>
</html>
