<asset:javascript src="jquery-2.2.0.min.js"/>
<asset:javascript src="data-table/datatables.min.js"/>
<asset:javascript src="data-table/dataTables.buttons.min.js"/>
<asset:javascript src="data-table/jquery.dataTables.min.js"/>
<asset:javascript src="data-table/datatables-init.js"/>
<asset:javascript src="sweetalert.min.js"/>
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
<script>
    function openModel(url){
        var x = window.screen.height;
        var y = window.screen.width;
        var h = 650;
        var w = 800;
        var model = "title=word,resizable=yes,scrollbars=yes," +
            "height=" + h + ",width=" + w + "," +
            "status=yes,toolbar=no,menubar=no,location=no," +
            "top=" + (x-h)/2 + "," +
            "left=" + (y-w)/2;
        var oOpen = window.open(url,"adviceDetail",model);
        oOpen.focus();
    }
    function showResult(id){
        const url = "Runner/result?fid="+id
        openModel(url)
    }
    function showGrade(id){
        const url = " updategrade?gid="+id;
        openModel(url)
    }
    function addPara(id){
        const url = "/addpara?sid="+id
        openModel(url)
    }
</script>
<script>
    $(".body_left_list >li >label").on('click',function () {
        $gao = $(this).parent('li').css('max-height');
        if($gao == '1500px'){
            $(this).parent('li').animate({'max-height':'40px'});
            $(this).children('i').css({
                'transform':'rotate(-90deg)'
            })
        }else{
            $(this).parent('li').animate({'max-height':'1500px'});
            $(this).children('i').css({
                'transform':'rotate(0)'
            })
        }
    });
    $(".body_left_list >li >ul >li >ul >li").on({
        mouseover: function () {
            var juli = $(this).offset().top;
            $(this).children('ul').css({
                'padding-top':juli
            })
        },
        mouseout: function () {
            $(".link").hide();
        }
    });
</script>