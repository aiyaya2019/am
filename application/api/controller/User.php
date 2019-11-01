<?php
namespace app\api\controller;
use \think\Controller;
use app\common\model\User as UserModel;
use app\common\model\UserBang;
use app\common\model\Config;
use app\common\model\UserCoupon;
use app\common\model\UserPerfect;
use app\common\model\UserFeedback;
use app\common\model\Perfect;
use app\common\model\Plan;
use app\common\model\Order;
use app\common\model\Doctor;
use app\common\model\Goods;
use app\common\model\GoodsService;
use app\common\model\GoodsComp;


class User extends Common
{	  
    /**
     * [index 个人主页]
     * @Author   PengJun
     * @DateTime 2019-04-15
     * @return   [type]     [description]
     */
	public function index()
    {
        if (request()->isPost()) {
            $post = input('post.');
            if (empty($post['id'])) {
                return_ajax(400, '缺少用户id');
            }
            $user = UserModel::field('id,nickname,head_img,phone,state')->where('id', $post['id'])->find();

            $time = time();
            $res = UserBang::where(['uid'=>$post['id'],'status'=>1])->find();
            if ($res && $time >= $res['end_time']) {
                $user['bang'] = 2;//已到期
            }elseif ($res && $time < $res['end_time']){
                $user['bang_end_time'] = date('Y-m-d H:i',$res['end_time']);
                $user['bang'] = 1;//已开通未到期
            }else{
                $user['bang'] = 0;//未开通
            }

            //查询是否有可用的优惠券
            $time = time();
            $where = 'end_time >= '.$time.'';
            $count = UserCoupon::where(['uid'=>$post['id'],'status'=>1])->where($where)->count();
            $user['coupon'] =  $count;
            return_ajax(200, '获取成功', $user);
        }
    }



    /**
     * [perfect 完善用户信息]
     * @Author   PengJun
     * @DateTime 2019-04-15
     * @return   [type]     [description]
     */
    public function perfect()
    {
        if(request()->isPost()){
            $post = input('post.');
            $user = new UserModel;

            if(empty($post['uid'])){ return_ajax(400,'缺少必传参数uid'); }
            if(empty($post['phone'])){ return_ajax(400,'请输入手机号'); }
            if (empty($post['type'])) { return_ajax(400,'缺少必要参数type');}
            if (!isPhone($post['phone'])) { return_ajax(400,'请输入正确的手机号'); }
            if ($post['type'] == 1){
                //普通绑定
                if(empty($post['code'])){ return_ajax(400,'请先获取验证码'); }
                //判断验证码
                $this->is_code($post['phone'],$post['code']);
            }

            if($user->allowField(true)->save($post,['id'=>$post['uid']])){
                    return_ajax(200,'绑定成功');
            } else {
                    return_ajax(400,'网络繁忙');
            }
        }
    }

    //查看bang权益
    public function bang()
    {
        if(request()->isPost()){
            $post = input('post.');

            if (empty($post['id'])) {
                return_ajax(400, '缺少用户id');
            }

            $time = time();

            $res = UserBang::where(['uid'=>$post['id'],'status'=>1])->find();
            if ($res && $time >= $res['end_time']) {
                $res['state'] = 2;//已到期
            }elseif ($res && $time < $res['end_time']){
                $res['start_time'] = date('Y-m-d H:i',$res['start_time']);
                $res['end_time'] = date('Y-m-d H:i',$res['end_time']);
                $res['state'] = 1;//已开通未到期
            }else{
                $res['state'] = 0;//未开通
            }

            //查询bang权益开通价格和bang权益介绍
            $bang['price'] = Config::where('id',1)->value('bang_price');
            $bang['content'] = Config::where('id',1)->value('bang');
            return_ajax(200,'获取成功',$res,$bang);


        }
    }

    //个人档案
    public function archives()
    {
        if(request()->isPost()){
            //查询用户是否完善个人档案
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少用户id'); }
            $state = UserModel::where('id',$post['id'])->value('state');
            if ($state == 2) {
                //已完善
                $data = UserPerfect::where('uid',$post['id'])->find();

                return_ajax(200,'获取成功',$data,1);
            }else{
                //未完善
                $data = Perfect::order('id desc')->select();
                return_ajax(200,'获取成功',$data,0);
            }
        }
    }

    //获取指定的个人档案
    public function get_archives()
    {
        if(request()->isPost()){
            $post = input('post.');

            if (!empty($post['id'])){
                if (!empty($post['pain'])){
                    $field = 'pain';
                    $res = $post['pain'];
                }elseif (!empty($post['mode'])){
                    $field = 'mode';
                    $res = $post['mode'];
                }elseif (!empty($post['time'])){
                    $field = 'time';
                    $res = $post['time'];
                }else{
                    $field = 'past';
                    $res = $post['past'];
                }
                //修改

                $row = UserPerfect::where('uid',$post['id'])->setField($field,$res);
                if ($row) {
                    return_ajax(200,'编辑成功');
                }else{

                    return_ajax(400,'网络繁忙');
                }
            }else{
                //获取
                if (empty($post['type'])) { return_ajax(400,'缺少必传参数type'); }
                $data = Perfect::order('id desc')->where('type',$post['type'])->select();
                if ($data){
                    return_ajax(200,'获取成功',$data);
                }else{
                    return_ajax(400,'暂无数据');
                }
            }

        }
    }

    //个人档案完成
    public function archives_success()
    {
        if(request()->isPost()){
            //查询用户是否完善个人档案
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }
            if (empty($post['pain'])) { return_ajax(400,'请选择疼痛位置'); }
            if (empty($post['mode'])) { return_ajax(400,'请选择疼痛的方式'); }
            if (empty($post['time'])) { return_ajax(400,'请选择疼痛的时间'); }
            if (empty($post['past'])) { return_ajax(400,'请选择既往史'); }
            $res = UserPerfect::create($post);
            if ($res) {
                UserModel::where('id',$post['uid'])->setField('state',2);
                return_ajax(200,'完善成功');
            }else{
                return_ajax(400,'网络繁忙');
            }

        }
    }

    //针对方案
    public function plan()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }
            $plan = Plan::where('uid',$post['uid'])->order('id desc')->select();
            if ($plan) {

                return_ajax(200,'获取成功',$plan);
            }else{
                return_ajax(400,'暂无数据');
            }
        }
    }

    //针对方案详情
    public function plan_detail()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少必传参数id');}
            $data = Plan::where('id',$post['id'])->find();
            return_ajax(200,'获取成功',$data);
        }
    }

    //领取红包
    public function red()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }
            //判断是否已领取红包
            $count = UserCoupon::where(['uid'=>$post['uid'],'state'=>2])->count();
            if ($count > 0) {
                //已领取
                return_ajax(200,'您已经领取个人优惠券',10);
            }
            if (empty($post['phone'])) { return_ajax(400,'缺少手机号'); }
            if (!isPhone($post['phone'])) { return_ajax(400,'请输入正确的手机号');}
            $phone = UserModel::where('id',$post['uid'])->value('phone');
            if (!$phone) { return_ajax(400,'请先绑定手机');}

            if ($phone != $post['phone']) {
                return_ajax(400,'请输入绑定的手机号');
            }

            $data = [
                'uid' => $post['uid'],
                'jian' => 5,
                'day' => 90,
                'state' => 2,
                'start_time' => time(),
                'end_time' => time()+24*3600*90,
            ];

            for ($i=0;$i<=1;$i++){
                $res = UserCoupon::create($data);
            }

            if ($res) {
                return_ajax(200,'领取成功');
            }else{
                return_ajax(400,'网络繁忙');
            }
        }
    }

    //获取意见反馈信息
    public function feedback()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }
            if (empty($post['type'])) { return_ajax(400,'缺少必传参数type'); }
            $data = Perfect::where('type',5)->order('id desc')->select();
            if ($post['type'] == 1){
                //取过号
                $doctor_id = Order::where('uid',$post['uid'])->column('doctor_id');
                if (count($doctor_id) > 0){
                    $doctor_id = implode(',',$doctor_id);
                    $doctor =Doctor::where('id in('.$doctor_id.')')->field('id,name')->select();
                }else{
                    $doctor = [];
                }
            }else {
                //未取过号
                $doctor = [];
            }

            return_ajax(200,'获取成功',$data,$doctor);

        }
    }

    //搜索理疗师
    public function search_doctor()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['name'])) { return_ajax(400,'请输入理疗师名称'); }
            $where = 'name like "%'.$post['name'].'%"';
            $res = Doctor::where($where)->field('id,name,pic')->select();
            if ($res) {
                return_ajax(200,'获取成功',$res);
            }else{
                return_ajax(400,'暂无数据');
            }
        }
    }

    //提交反馈
    public function  feedback_success()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }
            if (empty($post['title'])) { return_ajax(400,'请选择反馈类型'); }
            if (empty($post['content'])) { return_ajax(400,'请输入反馈内容'); }
            if (empty($post['type'])) { return_ajax(400,'缺少必传参数type'); }
            if (empty($post['phone'])) { return_ajax(400,'请输入手机号码'); }
            if (empty($post['name'])) { return_ajax(400,'请选择理疗师'); }
            $res = UserFeedback::create($post);
            if ($res) {
                return_ajax(200,'提交成功');
            }else{
                return_ajax(400,'暂无数据');
            }
        }
    }


    //我的卡券
    public  function coupon()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少用户id'); }
            if (empty($post['type'])) { return_ajax(400,'缺少必传参数type'); }
            if ($post['type'] == 1){
                //当前优惠券
                $time = time();
                $where = 'end_time > '.$time.'';
                $coupon = UserCoupon::where(['uid'=>$post['id'],'status'=>1])->where($where)->select();
                if ($coupon) {
                    foreach ($coupon as $k=>$v){
                        $coupon[$k]['start_time'] = date('Y-m-d', $coupon[$k]['start_time']);
                        $coupon[$k]['end_time'] = date('Y-m-d', $coupon[$k]['end_time']);
                        if ($coupon[$k]['goods_id'] != 0){
                            $coupon[$k]['goods'] = Goods::field('id,title')->where('id in ('.$coupon[$k]['goods_id'].')')->select();
                        }
                    }
                    return_ajax(200,'获取成功',$coupon);
                }else{
                    return_ajax(400,'暂无可用的优惠券');
                }
            }else{
                //历史优惠券
                $time = time();
                $where = 'end_time < '.$time.'';
                $coupon = UserCoupon::where(['uid'=>$post['id']])->where($where)->select();
                if ($coupon) {
                    foreach ($coupon as $k=>$v){
                        $coupon[$k]['start_time'] = date('Y-m-d', $coupon[$k]['start_time']);
                        $coupon[$k]['end_time'] = date('Y-m-d', $coupon[$k]['end_time']);
                        if ($coupon[$k]['goods_id'] != 0){
                            $coupon[$k]['goods'] = Goods::field('id,title')->where('id in ('.$coupon[$k]['goods_id'].')')->select();
                        }
                    }
                    return_ajax(200,'获取成功',$coupon);
                }else{
                    return_ajax(400,'暂无可用的优惠券');
                }
            }

        }
    }

    //优惠券详情
    public function coupon_detail()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少优惠券id'); }
            $res = UserCoupon::where('id',$post['id'])->find();

            $res['start_time'] = date('Y-m-d', $res['start_time']);
            $res['end_time'] = date('Y-m-d', $res['end_time']);
            if ($res['comp_id'] != 0) {
                $res['comp'] = GoodsComp::field('id,title')->where('id in('.$res['comp_id'].')')->select();
            }

            if ($res['goods_id'] != 0) {
                $res['goods'] = Goods::field('id,title')->where('id in('.$res['goods_id'].')')->select();
            }
            return_ajax(200,'获取成功',$res);
        }
    }

    //邀请好友
    public function friends()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少用户id'); }
            $user = UserModel::field('id,head_img,money')->where('id',$post['id'])->find();
            return_ajax(200,'获取成功',$user);
        }
    }

    //领取他人邀请的优惠券
    public function top_friend()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['top_id'])) { return_ajax(400,'缺少上级id'); }
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }
            $data = UserCoupon::where(['uid'=>$post['uid'],'state'=>3])->count();
            if ($data > 0) {
                return_ajax(400,'您已领取邀请优惠券');
            }
            $data = UserModel::where('id',$post['top_id'])->value('nickname');
            $data = emojiDecode($data);
            //获取服务标准
            $service = GoodsService::order('id desc')->select();
            return_ajax(200,'获取成功',$data,$service);
        }
    }

    //立即领取好友邀请的优惠券
    public function friend_success()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }
            $price = Config::where('id',1)->value('friend_money');
            $data = [
                'uid' => $post['uid'],
                'jian' => $price,
                'day' => 90,
                'state' => 3,
                'start_time' => time(),
                'end_time' => time()+24*3600*90,
            ];
           $res = UserCoupon::create($data);
            if ($res) {
                return_ajax(200,'领取成功');
            }else{
                return_ajax(400,'暂无数据');
            }

        }
    }

    //获取领取好友邀请优惠券后的页面
    public function get_friend()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }
            $data = UserCoupon::where(['uid'=>$post['uid'],'state'=>3])->select();
            if ($data) {
                foreach ($data as $k=>$v){
                    $data[$k]['start_time'] = date('Y-m-d',$data[$k]['start_time'] );
                    $data[$k]['end_time'] = date('Y-m-d',$data[$k]['end_time'] );
                }
            }

            return_ajax(200,'获取成功',$data);
        }
    }



}
