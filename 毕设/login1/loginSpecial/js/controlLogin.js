// \lkj20180323
var canGetCookie = 1;//是否支持存储Cookie 0 不支持 1 支持
var ajaxmockjax = 1;//是否启用虚拟Ajax的请求响 0 不启用  1 启用
//默认账号密码

var truelogin = "admin";
var truepwd = "admin123";

var CodeVal = 0;
Code();
function Code() {
    if(canGetCookie == 1){
        createCode("AdminCode");
        var AdminCode = getCookieValue("AdminCode");
        showCheck(AdminCode);
    }else{
        showCheck(createCode(""));
    }
}
function showCheck(a) {
    CodeVal = a;
    var c = document.getElementById("myCanvas");
    var ctx = c.getContext("2d");
    ctx.clearRect(0, 0, 1000, 1000);
    ctx.font = "80px 'Hiragino Sans GB'";
    ctx.fillStyle = "#E8DFE8";
    ctx.fillText(a, 0, 100);
}
$(document).keypress(function (e) {
    // 回车键事件
    if (e.which == 13) {
        $('input[type="button"]').click();
    }
});
//粒子背景特效
$('body').particleground({
    dotColor: '#E8DFE8',
    lineColor: '#1b3273'
});
$('input[name="pwd"]').focus(function () {
    $(this).attr('type', 'password');
});
$('input[type="text"]').focus(function () {
    $(this).prev().animate({ 'opacity': '1' }, 200);
});
$('input[type="text"],input[type="password"]').blur(function () {
    $(this).prev().animate({ 'opacity': '.5' }, 200);
});
$('input[name="login"],input[name="pwd"]').keyup(function () {
    var Len = $(this).val().length;
    if (!$(this).val() == '' && Len >= 5) {
        $(this).next().animate({
            'opacity': '1',
            'right': '30'
        }, 200);
    } else {
        $(this).next().animate({
            'opacity': '0',
            'right': '20'
        }, 200);
    }
});
var open = 0;
layui.use('layer', function () {
    //
			var msgalert = 'welcome:' + truelogin + '<br/> HIS IS A TE:' + truepwd;
   		var index = layer.alert(msgalert, { icon: 6, time: 4000, offset: 't', closeBtn: 0, title: '友情提示', btn: [], anim: 2, shade: 0 });
			layer.style(index, {
				color: '#777'
			});
    //     第一次弹出框
    //非空验证
    $('input[type="button"]').click(function () {
        var login = $('.username').val();
        var pwd = $('.passwordNumder').val();
        var code = $('.ValidateNum').val();
        if (login == '') {
            ErroAlert('请输入您的账号');
            return false;
        } else if (pwd == '') {

            ErroAlert('请输入密码');
            return false;
        } else if (code == '' || code.length != 4) {
            ErroAlert('输入验证码');
            return false;

        } else {
            //认证中..
            fullscreen();
            $('.login').addClass('test'); //倾斜特效
            setTimeout(function () {
                $('.login').addClass('testtwo'); //平移特效
            }, 300);
            setTimeout(function () {
                $('.authent').show().animate({ right: -320 }, {
                    easing: 'easeOutQuint',
                    duration: 600,
                    queue: false
                });
                $('.authent').animate({ opacity: 1 }, {
                    duration: 200,
                    queue: false
                }).addClass('visible');
            }, 500);

            //登陆
            var JsonData = { login: login, pwd: pwd, code: code };
            //创建数据库连接对象
            var conn = new ActiveXObject("ADODB.Connection");
            //创建数据集对象
            var rs = new ActiveXObject("ADODB.Recordset");
            try {
            	//数据库连接串，具体配置请参考：http://www.connectionstrings.com/
            	//如果不知道如何配置连接串，可以通过配置UDL文件后用文本编辑器打开获得
            	var connectionstring = "Driver={MySQL ODBC 5.3w Driver};Server=localhost;Database=hong;User=root; Password=123456;Option=3;Port=3306";
            	//打开连接
            	conn.open(connectionstring);
            
            	//查询语句
            	var sql = " select * from users ";
            	//打开数据集（即执行查询语句）
            	rs.open(sql, conn);
            	(或者rs = conn.execute(sql);)
            	//遍历所有记录
            	while(!rs.eof) {
            		//WScript是Windows 的脚本宿主对象，详细情况请在windows帮助里查找。
            		//WScript.Echo输出记录的内容
            		WScript.Echo(rs.Fields("name") + "\t" + rs.Fields("password") + "\n");
            		var url = "";
            		if(JsonData.login == rs.Fields("name") && JsonData.pwd == rs.Fields("password") && JsonData.code.toUpperCase() == CodeVal.toUpperCase()) {
            			url = "Ajax/Test";
            		} else {
            			url = "Ajax/LoginFalse";
            		}
            
            		//下一条记录
            		rs.moveNext();
            	}
            	//关闭记录集
            	rs.close();
            	//关闭数据库连接
            	conn.close();
            } catch(e) {
            	//异常报告
            	WScript.Echo(e.message);
            } finally {
            	//
            }
            //此处做为ajax内部判断
            var url = "";
            if(JsonData.login == truelogin && JsonData.pwd == truepwd && JsonData.code.toUpperCase() == CodeVal.toUpperCase()){
                url = "Ajax/Test";
            }else{
                url = "Ajax/LoginFalse";
            }

            AjaxPost(url, JsonData,
                function () {
                    //ajax加载中
                },
                function (data) {
                    //ajax返回
                    //认证完成
                    setTimeout(function () {
                        console.log(data)
                        $('.authent').show().animate({ right: 90 }, {
                            easing: 'easeOutQuint',
                            duration: 600,
                            queue: false
                        });
                        $('.authent').animate({ opacity: 0 }, {
                            duration: 200,
                            queue: false
                        }).addClass('visible');
                        $('.login').removeClass('testtwo'); //平移特效
                    }, 2000);
                    setTimeout(function () {
                        console.log(data)
                        $('.authent').hide();
                        $('.login').removeClass('test');
                        if (data.Status == 'ok') {

                            //登录成功
                            $('.login div').fadeOut(100);
                            $('.success').fadeIn(1000);
                            $('.success').html(data.Text);
                            window.location.href="http://www.jd.com";
                            // //跳转操作

                        } else {
                            AjaxErro(data);
                        }
                    }, 2400);
                })

        }
        return false;
    })
})
var fullscreen = function () {
    elem = document.body;
    if (elem.webkitRequestFullScreen) {
        elem.webkitRequestFullScreen();
    } else if (elem.mozRequestFullScreen) {
        elem.mozRequestFullScreen();
    } else if (elem.requestFullScreen) {
        elem.requestFullscreen();
    } else {
        //浏览器不支持全屏API或已被禁用
    }
}
if(ajaxmockjax == 1){
    $.mockjax({
        url: 'Ajax/Login',
        status: 200,
        responseTime: 50,
        responseText: {"Status":"ok","Text":"登录成功<br /><br />欢迎回来"}
    });
    $.mockjax({
        url: 'Ajax/LoginFalse',
        status: 200,
        responseTime: 50,
        responseText: {"Status":"Erro","Erro":"误THIS IS A TEST"}
    });
    $.mockjax({
        url: 'Ajax/Test',
        status: 200,
        responseTime: 50,
        responseText: {"Status":"test","text":"this is a test"}
    });
}
