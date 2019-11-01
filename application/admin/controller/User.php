<?php
namespace app\admin\controller;
use app\admin\model\User as UserModel;
use app\admin\model\Part;
use app\admin\model\Reco;
use app\admin\model\Config;
use app\common\model\Perfect;
use app\common\model\UserAtten;
use app\common\model\UserFeedback;

Class User extends Common{

    public function index()
    {
        if(request()->isAjax()){
            $post = input('post.');

            $where = [];
            if(!empty($post['id'])){ $where['id'] = $post['id']; }
            if(!empty($post['nickname'])){ $where['nickname'] = ['like','%'.emojiDecode($post['nickname']).'%']; }


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

    //优惠券兑换说明
    public function bang()
    {
        if (request()->isPost()){

            $post = input('post.');

            $config = new Config;

            $post['update_time'] = time();
            if($config->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }

        $config = Config::where('id',1)->find();
        return $this->fetch('',[
            'config'   => $config
        ]);
    }

    //排队规则
    public function rules()
    {
        if (request()->isPost()){

            $post = input('post.');

            $config = new Config;

            $post['update_time'] = time();
            if($config->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }

        $config = Config::where('id',1)->find();
        return $this->fetch('',[
            'config'   => $config
        ]);
    }

    //用户协议
    public function agree()
    {
        if (request()->isPost()){

            $post = input('post.');

            $config = new Config;

            $post['update_time'] = time();
            if($config->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }

        $config = Config::where('id',1)->find();
        return $this->fetch('',[
            'config'   => $config
        ]);
    }

    //投诉反馈
    public function feedback()
    {
        if(request()->isAjax()){
            $post = input('post.');

            $where = [];

            if(!empty($post['name'])){ $where['name'] = ['like','%'.$post['name'].'%']; }


            $user = UserFeedback::with('user')->where($where)->page(input('page'),20)->select();
            $count = UserFeedback::where($where)->count();

            return_ajax(200,'获取成功',$user,$count);
        }
        return $this->fetch();
    }

    //投诉反馈详情
    public function feedback_details()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $feedback = new UserFeedback;

            $post['update_time'] = time();
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $feedback->allowField(true)->save($post);
            } else {
                $oper = $feedback->allowField(true)->save($post,['id'=>$id]);
            }

            if($oper)
            {
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $feedback = UserFeedback::get($id);

        return $this->fetch('',[
            'feedback' => $feedback,
        ]);
    }

    //接私单弹窗内容
    public function private()
    {
        if (request()->isPost()){

            $post = input('post.');

            $config = new Config;

            $post['update_time'] = time();
            if($config->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }

        $config = Config::where('id',1)->find();
        return $this->fetch('',[
            'config'   => $config
        ]);
    }

    /**
     * [cancel 取消原因]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function fdtype()
    {
        if(request()->isPost()){
            $post = input('post.');
            $where = ['type'=>5];

            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }
            $list = Perfect::where($where)->order('add_time desc')->page(input('page'),20)->select();

            return_ajax(200,'获取成功',$list);
        }
        return $this->fetch();
    }

    /**
     * [cancel_save 添加编辑取消原因]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function fdtype_save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $type = new Perfect;
            $post['update_time'] = time();
            $post['type'] = 5;
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $type->allowField(true)->save($post);
            } else {
                $oper = $type->allowField(true)->save($post,['id'=>$id]);
            }

            if($oper)
            {
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $type = Perfect::get($id);

        return $this->fetch('',[
            'type' => $type
        ]);
    }

    //奖励规则
    public function reward()
    {
        if (request()->isPost()){

            $post = input('post.');

            $config = new Config;

            $post['update_time'] = time();
            if($config->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }

        $config = Config::where('id',1)->find();
        return $this->fetch('',[
            'config'   => $config
        ]);
    }

    //邀请好友
    public function friend()
    {
        if (request()->isPost()){

            $post = input('post.');

            $config = new Config;

            if(request()->file('file')){
                $file = imgUpdate('file');
                if($file['code'] == 400){ return_ajax(400,$file['msg']); }
                $post['friend_pic'] = $file['data'];
            }

            if(request()->file('video')){
                $file = imgUpdate('video');
                if($file['code'] == 400){ return_ajax(400,$file['msg']); }
                $post['friend_video'] = $file['data'];
            }

            $post['update_time'] = time();
            if($config->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }

        $config = Config::where('id',1)->find();
        return $this->fetch('',[
            'config'   => $config
        ]);
    }

    /**
     * [position 疼痛的位置]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function position()
    {
        if(request()->isPost()){
            $post = input('post.');
            $where = ['type'=>1];

            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }
            $list = Perfect::where($where)->order('add_time desc')->page(input('page'),20)->select();

            return_ajax(200,'获取成功',$list);
        }
        return $this->fetch();
    }

    /**
     * [position_save 添加编辑疼痛的位置]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function position_save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $type = new Perfect;
            $post['update_time'] = time();
            $post['type'] = 1;
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $type->allowField(true)->save($post);
            } else {
                $oper = $type->allowField(true)->save($post,['id'=>$id]);
            }

            if($oper)
            {
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $type = Perfect::get($id);

        return $this->fetch('',[
            'type' => $type
        ]);
    }

    /**
     * [pattern 疼痛的方式]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function pattern()
    {
        if(request()->isPost()){
            $post = input('post.');
            $where = ['type'=>2];

            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }
            $list = Perfect::where($where)->order('add_time desc')->page(input('page'),20)->select();

            return_ajax(200,'获取成功',$list);
        }
        return $this->fetch();
    }

    /**
     * [position_save 添加编辑疼痛的位置]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function pattern_save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $type = new Perfect;
            $post['update_time'] = time();
            $post['type'] = 2;
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $type->allowField(true)->save($post);
            } else {
                $oper = $type->allowField(true)->save($post,['id'=>$id]);
            }

            if($oper)
            {
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $type = Perfect::get($id);

        return $this->fetch('',[
            'type' => $type
        ]);
    }

    /**
     * [pain 疼痛的时间]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function pain()
    {
        if(request()->isPost()){
            $post = input('post.');
            $where = ['type'=>3];

            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }
            $list = Perfect::where($where)->order('add_time desc')->page(input('page'),20)->select();

            return_ajax(200,'获取成功',$list);
        }
        return $this->fetch();
    }

    /**
     * [pain_save 添加编辑疼痛的时间]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function pain_save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $type = new Perfect;
            $post['update_time'] = time();
            $post['type'] = 3;
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $type->allowField(true)->save($post);
            } else {
                $oper = $type->allowField(true)->save($post,['id'=>$id]);
            }

            if($oper)
            {
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $type = Perfect::get($id);

        return $this->fetch('',[
            'type' => $type
        ]);
    }

    /**
     * [past 既往史]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function past()
    {
        if(request()->isPost()){
            $post = input('post.');
            $where = ['type'=>4];

            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }
            $list = Perfect::where($where)->order('add_time desc')->page(input('page'),20)->select();

            return_ajax(200,'获取成功',$list);
        }
        return $this->fetch();
    }

    /**
     * [past_save 既往史]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function past_save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $type = new Perfect;
            $post['update_time'] = time();
            $post['type'] = 4;
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $type->allowField(true)->save($post);
            } else {
                $oper = $type->allowField(true)->save($post,['id'=>$id]);
            }

            if($oper)
            {
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $type = Perfect::get($id);

        return $this->fetch('',[
            'type' => $type
        ]);
    }
}