/**
 * Created by Flyme on 2017/1/12.
 */

jQuery(document).ready(function() {

	var alertdiv = $("#form-alert");
	var text = $.trim(alertdiv.text());
	if(text == ""){
		alertdiv.hide();
	}else{
		alertdiv.show();
	}
	


	/*
	 Fullscreen background
	 */
	$.backstretch("logreg/img/backgrounds/1.jpg");

	/*
	 Form validation
	 */
	$('.login-form input[type="text"], .login-form input[type="password"], .login-form textarea').on('focus', function() {
		$(this).removeClass('input-error');
	});

	$('.login-form').on('submit', function(e) {

		var bblank = false;
		var bhasspace = false;
		$(this).find('input[type="text"], input[type="password"], textarea').each(function(){
			if( $(this).val() == "" ) {
				e.preventDefault();
				$(this).addClass('input-error');
				bblank = true;
			}else if($(this).val().indexOf(" ") != -1){
				e.preventDefault();
				$(this).addClass('input-error');
				bhasspace = true;
			}
			else {
				$(this).removeClass('input-error');
			}
		});

		if(bblank){
			alertdiv.show();
			alertdiv.text("请填写缺失的信息");
			return;
		}

		if(bhasspace){
			alertdiv.show();
			alertdiv.text("用户名或密码不能包含空格");
			return;
		}

		var password1 = $("#form-password").val();
		if(password1.length <= 5){
			e.preventDefault();
			alertdiv.show();
			alertdiv.text("密码长度至少为6");
		}else{
			$("#form-password").val($.md5(password1));
			alertdiv.hide();
		}

	});


});

