<?php
namespace app\index\controller;
use think\Db;

class Index extends Common
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
//        dump(rd_rand());

        //获取酒店简介、总经理致辞
        $content = Db::name('WebContent')->where('call_id','in',[1,2])->column('content');
        $this->assign('speaking',$content[1]);
        $this->assign('desc',$content[0]);

        //获取联系方式
        $contact = Db::name('WebContact')->column('phone');
        $this->assign('contact',$contact);

        //获取轮播图
        $banners = Db::name("AppBanner")->where('type',1)->order('sort')->field('filename,title')->select();
        $this->assign('banners',$banners);

        $this->assign('title','首页');
        return $this->fetch();
    }

    /**
     * 会员卡信息说明
     * @return mixed
     */
    public function member(){
        $members = Db::name('AppMemberCard')->order('sort')->field('title,content')->select();
        $this->assign('members',$members);
        $this->assign('title','会员卡');
        return $this->fetch();
    }

}
