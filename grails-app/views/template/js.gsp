<asset:javascript src="jquery-2.2.0.min.js"/>
<asset:javascript src="data-table/datatables.min.js"/>
<asset:javascript src="data-table/dataTables.buttons.min.js"/>
<asset:javascript src="data-table/jquery.dataTables.min.js"/>
<asset:javascript src="data-table/datatables-init.js"/>
<script type="text/javascript">
    //定义window.showModalDialog如果它不存在
    if (window.showModalDialog == undefined) {
        window.showModalDialog = function (url) {
//                                    if(window.hasOpenWindow){
//                                        alert("您已经打开了一个窗口！请先处理它");//避免多次点击会弹出多个窗口
//                                        window.myNewWindow.focus();
//                                    }
//                                    window.hasOpenWindow = true;
            window.myNewWindow = window.open(url);
        }
    }
</script>