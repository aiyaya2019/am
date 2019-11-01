<?php
namespace app\admin\controller;
use app\admin\model\User as UserModel;
use app\admin\model\Part;
use app\admin\model\Reco;
use app\admin\model\Goods;
use app\common\model\UserAtten;

Class User extends Common{

    public function index()
    {
        if(request()->isAjax()){
            $post = input('post.');

            $where = [];
            if(!empty($post['id'])){ $where['id'] = $post['id']; }
            if(!empty($post['nickname'])){ $where['nickname'] = ['like','%'.urlencode($post['nickname']).'%']; }


            $user = UserModel::where($where)->page(input('page'),20)->select();
            $count = UserModel::where($where)->count();

            return_ajax(200,'获取成功',$user,$count);
        }
        return $this->fetch();
    }

    /**
     * [save 添加粉丝]
     * @Author   PengJun
     * @DateTime 2019-04-29
     * @return   [type]     [description]
     */
    public function save()
    {   
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $user = new UserModel;

            //封面上传
            if(request()->file('pic')){
                $file = imgUpdate('pic');
                if($file['code'] == 400){ return_ajax(400,$file['msg']); }
                $post['head_img'] = $file['data'];
            }

            $post['nickname'] = emojiEncode($post['nickname']);
            $post['add_time'] = time();
            $post['update_time'] = time();
            $post['type'] = 2;
            if($user->allowField(true)->save($post)){
                //关注用户
                $data = [
                    'uid'         => $user->id,
                    'old_uid'     => $post['uid'],
                    'status'      => 1,
                    'add_time'    => time(),
                    'update_time' => time()
                ];
                $UserAtten = new UserAtten;
                if($UserAtten->allowField(true)->save($data)){
                    //增加用户粉丝数
                    UserModel::where('id',$post['uid'])->setInc('fan');
                    return_ajax(200,'关注成功');
                } else {
                    return_ajax(400,'服务器繁忙，请稍后重试');
                }
            }
        }
        return $this->fetch();
    }

    /**
     * [fan 查看粉丝]
     * @Author   PengJun
     * @DateTime 2019-04-29
     * @return   [type]     [description]
     */
    public function fan()
    {
        if(request()->isPost()){
            $post = input('post.');

            $post['with'] = 'user';
            $post['where']['old_uid'] = $post['uid'];
            $list = $this->selectAll('user_atten',$post);

            return_ajax(200,'关注成功',$list['list'],$list['count']);
        }
        return $this->fetch();
    }

    /**
     * [atten 查看关注的用户]
     * @Author   PengJun
     * @DateTime 2019-04-29
     * @return   [type]     [description]
     */
    public function atten()
    {
        if(request()->isPost()){
            $post = input('post.');

            $post['with'] = 'old_user';
            $post['where']['uid'] = $post['uid'];
            $list = $this->selectAll('user_atten',$post);

            return_ajax(200,'关注成功',$list['list'],$list['count']);
        }
        return $this->fetch();
    }


    /**
     * [edit 修改会员状态]
     * @Author   PengJun
     * @DateTime 2019-02-01
     * @return   [type]     [description]
     */
    public function edit()
    {
        if(request()->isPost()){
            $post = input('post.');
            $user = new UserModel;

            if($user->allowField(true)->save($post,['id'=>$post['uid']])){
                return_ajax(200);
            } else {
                return_ajax(400,'操作失败');
            }
        }
    }

    /**
     * [user_excel 导出所有用户]
     * @Author   PengJun
     * @DateTime 2019-01-29
     * @return   [type]     [description]
     */
    public function user_excel()
    {   
        ini_set('memory_limit','3072M');
        set_time_limit(0);

        $user = UserModel::all(['type'=>1]);

        $head = ['昵称','省份','城市','出生日期','粉丝数','关注数','openid','性别'];
        $data = [];
        foreach($user as $key=>$vo){
            $data[] = [
                filterEmoji(emojiDecode($vo['nickname'])),
                $vo['province'],
                $vo['city'],
                $vo['year'].$vo['month'].$vo['day'],
                $vo['fan'],
                $vo['atten'],
                $vo['openid'],
                $vo['sex_name'],
            ];
        }
        excelExport('用户信息',$head,$data);
    }
}