
<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册</title>

    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="logreg/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="logreg/css/form-elements.css">
    <link rel="stylesheet" href="logreg/css/style.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Favicon and touch icons -->
    <link rel="shortcut icon" href="logreg/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="logreg/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="logreg/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="logreg/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="logreg/ico/apple-touch-icon-57-precomposed.png">

</head>

<body>

<!-- Top content -->
<div class="top-content">

    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text">
                    <h1><strong>程序设计课程设计</strong></h1>
                    <div class="description">
                       <!-- <br>
                        ***</br>
                        
                        </p>-->
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top">
                        <div class="form-top-left">
                            <h3>新组注册</h3>
                            <p>请输入相关信息：</p>
                        </div>
                        <div class="form-top-right" style="font-size: 28">
                            <a href="/">直接登录</a>
                        </div>

                    </div>
                    <div class="form-bottom">
                        <form role="form" action="/Register/reg" method="post" class="login-form">
                            <div class="form-group">
                                <label class="sr-only" for="form-groupname">组名</label>
                                <input type="text" name="groupname" placeholder="组名" class="form-username form-control" id="form-username">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-gpnum">组号</label>
                                <input type="text" name="groupnum" placeholder="组号" class="form-username form-control" id="form-gpnum">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password">密码</label>
                                <input type="password" name="password" placeholder="密码" class="form-password form-control" id="form-password">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password2">确认密码</label>
                                <input type="password" name="password2" placeholder="确认密码" class="form-password form-control" id="form-password2">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-name1">组员一姓名</label>
                                <input type="text" name="name1" placeholder="组员一姓名" class="form-username form-control" id="form-name1">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-num1">组员一学号</label>
                                <input type="text" name="num1" placeholder="组员一学号" class="form-username form-control" id="form-num1">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-name2">组员二姓名</label>
                                <input type="text" name="name2" placeholder="组员二姓名" class="form-username form-control" id="form-name2">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-num2">组员二学号</label>
                                <input type="text" name="num2" placeholder="组员二学号" class="form-username form-control" id="form-num2">
                            </div>

                            <input type="hidden" value="go" name="dest">
                            <div id="form-alert" class="alert alert-info">
                                
                            </div>

                            <button type="submit" class="btn">点我注册</button>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>


<!-- Javascript -->
<script src="plugins/jQuery-2.2.3/jquery-2.2.3.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="plugins/jQuery-backstretch/jquery.backstretch.min.js"></script>
<script src="logreg/js/scripts2.js"></script>

<!--[if lt IE 10]>
<script src="logreg/js/placeholder.js"></script>
<![endif]-->

</body>

</html>