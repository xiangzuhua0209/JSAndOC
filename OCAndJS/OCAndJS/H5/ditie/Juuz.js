String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g,"");
}

var Juuz = {
    code: {
        ajaxSuccess: 200,
        ajaxError: 300,
        ajaxNotLogin: 301
    },

    noop: function(){},

    randNum: function(n){
        var rand = "";
        for(var i=0; i<n; i++){
            rand += Math.floor(Math.random() * 10);
        }
        return rand;
    },

    //获取设备系统
    getDeviceSystem: function(){
        var str = '';
        var browser = {
            versions: function () {
                var u = navigator.userAgent;

                return {
                    mobile: !!u.match(/AppleWebKit.*Mobile/) || !!u.match(/Windows Phone/) || !!u.match(/Android/) || !!u.match(/MQQBrowser/),
                    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),                //ios终端
                    android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1,  //android终端或者uc浏览器
                    winPhone: u.indexOf('Windows Phone') > -1,                      //winPhone终端
                    iPhone: u.indexOf('iPhone') > -1 || u.indexOf('iPod') > -1,     //是否为iPhone或者iPod
                    iPad: u.indexOf('iPad') > -1,                                   //是否iPad
                    weixin: u.indexOf('MicroMessenger') > -1,                       //是否微信访问
                    qq: u.match(/\sQQ/i) == " qq"                                   //是否QQ
                };
            }(),
            language: (navigator.browserLanguage || navigator.language).toLowerCase()
        }

        if(browser.versions.ios){
            str = 'ios';
        }else if(browser.versions.android){
            str = 'android';
        }else if(browser.versions.winPhone){
            str = 'winPhone';
        }else{
            str = 'other';
        }

        return str;
    },

    //获取url参数
    getQueryString: function(name){
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return unescape(r[2]); return null;
    },

    uiInit: function(box){
    	var $p = $(box || document);
        $('input', $p).each(function(){
            $(this).attr('autocomplete', 'off');
        });
    }
}

$(function(){
    Juuz.uiInit();
});