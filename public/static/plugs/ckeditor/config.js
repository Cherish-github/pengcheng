!(function () {
    // 定义编辑器标准配置
    CKEDITOR.editorConfig = function (config) {
        config.language = 'zh-cn';
        config.toolbar = [
            {name: 'document', items: ['Source']},
            {name: 'styles', items: ['Font', 'FontSize']},
            {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'RemoveFormat', 'TextColor', 'BGColor', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', 'NumberedList', 'BulletedList']},
            {name: 'uimage', items: ['Link', 'Unlink', 'Table', 'UploadImage', 'UploadVideo','UploadAudio','UpGoods']},
            {name: 'tools', items: ['Maximize']}
        ];
        config.allowedContent = true;
        config.extraPlugins = 'uimage,txvideo,uaudio,goods';
        config.format_tags = 'p;h1;h2;h3;pre';
        config.removeButtons = 'Underline,Subscript,Superscript';
        config.removeDialogTabs = 'image:advanced;link:advanced';
        config.font_names = '宋体/SimSun;新宋体/NSimSun;仿宋_GB2312/FangSong_GB2312;楷体_GB2312/KaiTi_GB2312;黑体/SimHei;微软雅黑/Microsoft YaHei;' + config.font_names;
        config.enterMode = CKEDITOR.ENTER_BR //：  屏蔽换行符<br>
        config.shiftEnterMode = CKEDITOR.ENTER_P //:屏蔽段落<p>
    };

    // 自定义图片上传插件
    CKEDITOR.plugins.add("uimage", {
        init: function (editor) {
            editor.ui.addButton("UploadImage", {label: "上传本地图片", command: 'uimage', icon: 'image', toolbar: 'insert,10'});
            editor.addCommand('uimage', {
                exec: function (editor) {
                    var field = '_editor_upload_' + Math.floor(Math.random() * 100000);
                    var url = window.ROOT_URL + '/index.php/admin/plugs/upfile.html?mode=one&type=png,jpg,gif,jpeg&field=' + field;
                    $('<input type="hidden" disabled>').attr('name', field).appendTo(editor.element.$).on('change', function () {
                        var element = CKEDITOR.dom.element.createFromHtml('<img src="' + this.value + '" style="max-width:500px" border="0" title="image" />');
                        editor.insertElement(element), $(this).remove();
                    });
                    $.form.iframe(url, '插入图片');
                }
            });
        }
    });

    // 自定义视频插入插件
    CKEDITOR.plugins.add('txvideo', {
        init: function (editor) {
            editor.ui.addButton("UploadVideo", {label: "插入视频", command: 'uvideo', icon: 'flash', toolbar: 'insert,10'});
            editor.addCommand('uvideo', {
                exec: function (editor) {
                    layer.confirm('请选择插入视频的方式', {
                        title: '添加视频',
                        time: 20000, //20s后自动关闭
                        btn: ['网络地址', '现在上传']
                    },function (index) {
                        layer.close(index);
                        layer.prompt({title: '插入视频地址', formType: 0}, function (url, index) {
                            layer.close(index);
                            // var html =  '<video  style="max-width:750px" src="'+url+'"  enable-danmu danmu-btn controls></video>';
                            var html = '<div class="authort-video" style="margin: .28rem 0 0 0;"><video  style="width: 100%;border-radius: 2px;" controls="controls" src="'+url+'"></video></div>'
                            var element = CKEDITOR.dom.element.createFromHtml( html);
                            editor.insertElement(element);
                        });
                    },function () {
                        var field = '_editor_upload_video_' + Math.floor(Math.random() * 100000);
                        var url = window.ROOT_URL + '/index.php/admin/plugs/upfile.html?mode=one&type=mp4,avi,rmvb,rm&field=' + field;
                        $('<input type="hidden" disabled>').attr('name', field).appendTo(editor.element.$).on('change', function () {
                            var html = '<div class="authort-video" style="width: 9.2rem;margin: .28rem 0 0 0;"><video  style="width: 100%;border-radius: 2px;" controls="controls" src="'+this.value+'"></video></div>'
                            var element = CKEDITOR.dom.element.createFromHtml(html);
                            editor.insertElement(element), $(this).remove();
                        });
                        $.form.iframe(url, '插入视频');
                    })
                }
            });
        }
    });
    CKEDITOR.plugins.add('uaudio', {
        init: function (editor) {
            editor.ui.addButton("UploadAudio", {label: "插入音频", command: 'uaudio', icon: 'iframe', toolbar: 'insert,10'});
            editor.addCommand('uaudio', {
                exec: function (editor) {
                    var field = '_editor_upload_' + Math.floor(Math.random() * 100000);
                    var url = window.ROOT_URL + '/index.php/admin/plugs/upaudio.html?&field=' + field;
                    $('<input type="hidden" disabled>').attr('name', field).appendTo(editor.element.$).on('change', function () {
                       var html = '<div class="audio-box" style="display: flex;justify-content: space-between;border: 1px solid #CCCCCC;\position: relative;">\n' +
                           '            <div class="audio-img" style=" width: 2rem;\n' +
                           '    height: 2rem;">\n' +
                           '                <img src="'+$(this).attr('thumb')+'" style="height: 100%;" alt="">\n' +
                           '                <a class="play" style="position: absolute;left: 0;" onclick="Play(this)" href="javascript:void(0)"><img style="width: 1.2rem;height: 1.2rem:margin:0;padding:0;outline:none;" src="/frontEnd/mobile/images/play.png" alt=""></a>\n' +
                           '                <a style="display: none" style="position: absolute;left: 0;"  onclick="Pause(this)" class="pause"  href="javascript:void(0)"><img src="/frontEnd/mobile/images/pause.png" alt=""></a>\n' +
                           '            </div>\n' +
                           '            <audio class="audio-content">\n' +
                           '                <source src="'+$(this).val()+'">\n' +
                           '            </audio>\n' +
                           '            <p style="    width: 6.5rem;line-height: 2rem;text-align: center;font-size: .35rem;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">'+$(this).attr('title')+'</p>\n' +
                           '            <span class="audio-time" style="position:absolute;top: .2rem;right: .5rem;font-size: .3rem">00:00</span>\n' +
                           '</div>';

                        var element = CKEDITOR.dom.element.createFromHtml(html);
                        editor.insertElement(element), $(this).remove();
                    });
                    $.form.iframe(url, '插入音频');
                }
            });
        }
    });

    CKEDITOR.plugins.add('goods', {
        init: function (editor) {
            editor.ui.addButton("UpGoods", {label: "插入商品", command: 'goods', icon: 'SpecialChar', toolbar: 'insert,10'});
            editor.addCommand('goods', {
                exec: function (editor) {
                    var field = '_editor_upload_' + Math.floor(Math.random() * 100000);
                    var url = window.ROOT_URL + '/index.php/admin/plugs/upgoods.html?&field=' + field;
                    $('<input type="hidden" disabled>').attr('name', field).appendTo(editor.element.$).on('change', function () {
                        var title = this.title;
                        var href   = `javascript:wx.miniProgram.navigateTo({ url:'/pages/index/activity/activityPro/proDetail/proDetail?id=`+this.value+`'})`;

                        var html = '<div class="purchase-box"  style="display: flex;justify-content: space-between;border: 1px solid #CCCCCC;padding: .2rem;font-size: .34rem;margin: .4rem 0;"><a style="display:inline-block;color: #222;width: 6.5rem;overflow: hidden;white-space:nowrap;text-overflow:ellipsis" class="buy-title" href="'+href+'">'+title+'</a><a href="'+href+'" class="buyBtn" style="height: .6rem;background-color: #F04848;color: #fff;text-align: center;line-height: .6rem;border-radius: .1rem;font-size: .29rem;display:inline-block">点击购买</a></div>';
                        // var html = "<navigator url='/pages/index/activity/activityPro/proDetail/proDetail?id="+id+"' ><view class='pro-buy' style='margin: 38rpx 0;display: inline-flex;flex-direction: row;flex-wrap: nowrap;justify-content: space-between;align-items: center;padding: 0 11rpx;height: 100rpx;border: 1px solid #ccc;'> <view class='pro-desc' style='font-size: 26rpx;font-family: PingFang-SC-Bold;color: rgba(38, 38, 38, 1);line-height: 44rpx;display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp: 1;overflow: hidden;width: 502rpx;'>"+title+"</view><view class='buy-url' style='height: 45rpx;background: rgba(255, 103, 101, 1);border-radius: 4rpx;font-size: 24rpx;font-family: PingFang-SC-Medium;color: rgba(255, 255, 255, 1);line-height: 45rpx;margin-left: 36rpx;text-align: center;padding: 0 18rpx;width: 130rpx;display: -webkit-box;overflow: hidden;-webkit-box-orient: vertical;-webkit-line-clamp: 1;box-sizing: border-box'>点击购买</view></view></navigator>";
                      var element = CKEDITOR.dom.element.createFromHtml(html);
                      editor.insertElement(element);
                       (this).remove();
                    });
                    $.form.iframe(url, '插入商品');
                }
            });
        }
    });
})(); 