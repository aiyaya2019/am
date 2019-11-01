<?php
namespace app\api\controller;
use app\common\model\GoodsComp;
use \think\Controller;
use app\common\model\Goods as GoodsModel;
use app\common\model\Config;
use app\common\model\UserCoupon;
use app\common\model\GoodsType;
use app\common\model\GoodsService;
use app\common\model\CouponCode;
use app\common\model\Coupon;
use app\common\model\UserBang;
use app\common\model\DoctorLeave;
use app\common\model\Doctor;
use app\common\model\Order;
use app\common\model\User;
use app\common\model\GoodsDiscuss;


class Goods extends Common
{	  
    
    /**
     * [index 门店管理]
     * @Author
     * @DateTime 2019-04-16
     * @return   [type]     [description]
     */
    public function index()
    {
        if(request()->isPost()){
            $post = input('post.');

            if(empty($post['type_id'])){ 
                $where = '';
             }else{
             	$where = ['type_id'=>$post['type_id']];
             }


            if (empty($post['page'])){
                $page = 1;
            }else{
                $page = $post['page'];
            }

            if (!empty($post['title'])) {
                $map = 'title like "%'.$post['title'].'%"';
            }else{
                $map = [];
            }

            //查询是否开启/是否领取新人优惠券
            $config = Config::get(1);

            if ($config['is_status'] == 2){
                $status = 2;
            }else{
                if (empty($post['uid'])){
                    $status = 2;
                }else{

                    $coupon = UserCoupon::where(['uid'=>$post['uid'],'coupon_id'=>0,'state'=>1])->find();
                    if ($coupon){
                        $status = 2;
                    }else{
                        $status = 1;
                    }
                }
            }

            $data = model('Goods')->with('comp')->where($where)->where($map)->field('id,title,address,status,jingdu,weidu,bang')->page($page,10)->order('id desc')->select();

            if ($data){

                foreach ($data as $k=>$v){
                    if (empty($post['jingdu']) && empty($post['weidu'])){
                        $data[$k]['distance'] = 0;
                    }else{

                        $data[$k]['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$data[$k]['weidu'],$data[$k]['jingdu']);
                    }

                    $data[$k]['make'] = Order::where(['goods_id'=>$data[$k]['id'],'status'=>2])->count();//多少人正在治疗
                }
                $d = array_column($data,'distance');
                array_multisort($d,SORT_ASC,$data);
            }
//            $count['status'] = $status;
//            $count['zhe'] = $config['bang_zhe'];
            return json(['code'=>200,'msg'=>'获取成功','data'=>$data,'count'=>$status,'zhe'=>$config['bang_zhe']]);
//            return_ajax(200,'获取成功',$data,$count);
        }
    }


    //领取新人优惠券
    public function recei_coupon()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少uid');}

            $config = Config::get(1);
            $user = User::where('id',$post['uid'])->field('id')->find();

            $coupon = UserCoupon::where(['uid'=>$user['id'],'coupon_id'=>0,'state'=>1])->find();

            if ($coupon){
                return_ajax(400,'您已领取新人优惠券');
            }

            $data = [
                'uid'   =>$user['id'],
                'jian'   => 5,
                'day'   => $config['day'],
                'start_time'    => time(),
                'state'    =>1,
                'end_time'    => time() + 24 * 3600 * $config['day'],
            ];

            for ($i=0;$i<=1;$i++){

                $res = UserCoupon::create($data);
            }

            if ($res){
                return_ajax(200,'恭喜您，成功领取新人优惠券');
            }else{
                return_ajax(400,'领取失败');
            }

        }
    }

    //返回城市区域
    public function city()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['jingdu'])) { return_ajax(400,'缺少经度');}
            if (empty($post['weidu'])) { return_ajax(400,'缺少纬度');}
            $data = GoodsType::with('this')->order('id desc')->where('pid',0)->select();

            foreach ($data as $k=>$v)
            {

                $data[$k]['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$data[$k]['weidu'],$data[$k]['jingdu']);

                foreach ($v['this'] as $key=>$value)
                {
                    $value['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$value['weidu'],$value['jingdu']);
                }

                $a = $v['this'];
                $dd = array_column($a,'distance');
                array_multisort($dd,SORT_ASC,$a);
                $data[$k]['_this'] = $a;
                unset($data[$k]['this']);
            }

            $d = array_column($data,'distance');
            array_multisort($d,SORT_ASC,$data);

            return_ajax(200,'获取成功',$data);
        }
    }

    //地图找店
    public function map()
    {
        if(request()->isPost()){
            $post = input('post.');

            if (empty($post['id'])){

                //获取全国所有门店
                $arr['field'] = 'id,title,jingdu,weidu';
                $data = $this->selectAll('goods',$arr);

                $count = GoodsModel::count();

                return_ajax(200,'获取成功',$data,$count);

            }else{

                if (empty($post['jingdu'])) { return_ajax(400,'缺少经度');}
                if (empty($post['weidu'])) { return_ajax(400,'缺少纬度');}

                //获取单条详情
                $arr['where'] = 'id = '.$post['id'].'';
                $arr['with'] = 'comp';
                $arr['field'] = 'id,title,address,status,jingdu,weidu';
                $data = $this->getFind('goods',$arr);
                $data['make'] = Order::where(['goods_id'=>$data['id'],'status'=>2])->count();
                $data['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$data['weidu'],$data['jingdu']);
                return_ajax(200,'获取成功',$data);
            }
        }
    }

    //门店详情
    public function details()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少门店id');}
            $config = Config::get(1);
            $arr['with'] = 'compall';
            $arr['where'] = 'id='.$post['id'].'';

            $data = $this->getFind('goods',$arr);

            $data['start_time'] = date('H:i', $data['start_time']);
            $data['end_time'] = date('H:i', $data['end_time']);

            if (!in_array(0,$data['activity_id'])){
                $activity_id = implode(',',$data['activity_id']);
//                ['新用户首单满'.$config['man'].'减'.$config['jian'].''];
//                ['邀请好友奖励'.$config['friend_money'].''];
                if ($activity_id == '1'){
                        $data['activity'] = array(
                            array(
                                'title' => '新用户首单满'.$config['man'].'减'.$config['jian'].'',
                                'type' => 1,
                            )
                        );
                }elseif ($activity_id == '2'){

                    $data['activity'] = array(
                        array(
                            'title' => '邀请好友奖励'.$config['friend_money'].'',
                            'type' => 2,
                        )
                    );
                }else{
//                    $data['activity'] = ['新用户首单满'.$config['man'].'减'.$config['jian'].'','邀请好友奖励'.$config['friend_money'].''];
                    $data['activity'] = array(
                        array(
                            'title' => '新用户首单满'.$config['man'].'减'.$config['jian'].'',
                            'type' => 1,
                        ),
                        array(
                            'title' => '邀请好友奖励'.$config['friend_money'].'',
                            'type' => 2,
                        )
                    );
                }
            }else{
                $data['activity'] = [];
            }

            $data['service_name'] = $config['service_name'];
            $data['service_start_time'] = date('H:i', $config['start_time']);
            $data['service_end_time'] = date('H:i', $config['end_time']);

            //服务标准
            $data['service'] = GoodsService::select();
            //多少人正在治疗
            $data['make'] = Order::where(['goods_id'=>$data['id'],'status'=>2])->count();
            //评价
            $data['evaluate'] = GoodsDiscuss::with('user')->where(['goods_id'=>$data['id'],'is_show'=>1])->order('id desc')->find();

            //统计曲线图

            return_ajax(200,'获取成功',$data);
        }
    }

    //查看全部评价
    public function full_discuss()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少门店id');}

            if (empty($post['page'])){
                $page = 1;
            }else{
                $page = $post['page'];
            }

            if (empty($post['type'])) {
                $type = 7;
            }else{
                $type = $post['type'];
            }

            if ($type == 7){
                //返回全部评价
                $discuss = GoodsDiscuss::with('user')->where(['goods_id'=>$post['id'],'is_show'=>1])->order('id desc')->page($page,10)->select();
                $count = GoodsDiscuss::where(['goods_id'=>$post['id'],'is_show'=>1])->count();
                return_ajax(200,'获取成功',$discuss,$count);
            }elseif ($type == 6){
                //有图
                $discuss = GoodsDiscuss::with('user')->where(['goods_id'=>$post['id'],'is_show'=>1,'state'=>2])->order('id desc')->page($page,10)->select();
                $count = GoodsDiscuss::where(['goods_id'=>$post['id'],'is_show'=>1,'state'=>2])->count();
                return_ajax(200,'获取成功',$discuss,$count);
            }elseif ($type == 5){
                //超级满意
                $discuss = GoodsDiscuss::with('user')->where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>5])->order('id desc')->page($page,10)->select();
                $count = GoodsDiscuss::where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>5])->count();
                return_ajax(200,'获取成功',$discuss,$count);
            }elseif ($type == 4){
                //满意
                $discuss = GoodsDiscuss::with('user')->where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>4])->order('id desc')->page($page,10)->select();
                $count = GoodsDiscuss::where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>4])->count();
                return_ajax(200,'获取成功',$discuss,$count);
            }elseif ($type == 3){
                //不怎么样
                $discuss = GoodsDiscuss::with('user')->where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>3])->order('id desc')->page($page,10)->select();
                $count = GoodsDiscuss::where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>3])->count();
                return_ajax(200,'获取成功',$discuss,$count);
            }elseif ($type == 2){
                //不满意
                $discuss = GoodsDiscuss::with('user')->where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>2])->order('id desc')->page($page,10)->select();
                $count = GoodsDiscuss::where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>2])->count();
                return_ajax(200,'获取成功',$discuss,$count);
            }else{
                //很失望
                $discuss = GoodsDiscuss::with('user')->where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>1])->order('id desc')->page($page,10)->select();
                $count = GoodsDiscuss::where(['goods_id'=>$post['id'],'is_show'=>1,'star'=>1])->count();
                return_ajax(200,'获取成功',$discuss,$count);
            }
        }
    }

    //优惠券自主兑换
    public function exchange_coupon()
    {
        if(request()->isPost()){
            $post = input('post.');

            if (empty($post['code'])){
                //返回优惠券兑换说明
                $arr['field'] = 'id,coupon_exchange';
                $arr['where'] = 'id=1';
                $config = $this->getFind('config',$arr);
                return_ajax(200,'获取成功',$config);
            }else{
                //兑换优惠券
                if (empty($post['uid'])) { return_ajax(400,'缺少用户id');}
                $user = User::where('id',$post['uid'])->field('id')->find();

                $arr['where'] = ['code'=>$post['code']];

                $res = $this->getFind('coupon_code',$arr);
                if (!$res){
                    return_ajax(400,'请输入正确的兑换码');
                }elseif ($res['status'] == 2){
                    return_ajax(400,'该兑换码已使用');
                }else{
                    $map = ['id'=>$res['coupon_id']];
                    $coupon = $this->getFind('coupon',$map);
                    $data = [
                        'uid'   => $user['id'],
                        'coupon_id'   => $coupon['id'],
                        'man'   => $coupon['full_price'],
                        'jian'   => $coupon['less_price'],
                        'day'   => $coupon['day'],
                        'goods_id'   => $coupon['day'],
                        'comp_id'   => $coupon['day'],
                        'number'   => $post['code'],
                        'start_time'   => time(),
                        'end_time'   => time()+24*3600*$coupon['day'],
                    ];
                    $rs = $this->saves('user_coupon',$data,true);
                    if ($rs){
                        CouponCode::where('code',$post['code'])->setField('status',2);
                        Coupon::where('id',$coupon['id'])->setInc('set_num',1);
                        return_ajax(200,'兑换成功');
                    }else{
                        return_ajax(400,'网络繁忙');
                    }
                }
            }

        }
    }

    //选择理疗师
    public function choice()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['goods_id'])) { return_ajax(400,'缺少门店id');}
            if (empty($post['comp_id'])) { return_ajax(400,'缺少服务id');}
            $price = GoodsComp::where(['goods_id'=>$post['goods_id'],'id'=>$post['comp_id']])->value('price');
            $arr['field'] = 'id,pic,name,status,zhi';
            $arr['where'] = 'goods_id = '.$post['goods_id'].' and find_in_set('.$post['comp_id'].',comp_id)';
            $data = $this->selectAll('doctor',$arr);
            if ($data) {
                foreach ($data as $k=>$v){
                    $data[$k]['price'] = $price;
                    if ($data[$k]['status'] == 2){
                        //查出复工时间
                        $data[$k]['start_time'] = DoctorLeave::where('doctor_id',$data[$k]['id'])->value('start_time');
                        $data[$k]['day'] = DoctorLeave::where('doctor_id',$data[$k]['id'])->value('day');
                        $data[$k]['time'] = $data[$k]['start_time']+24*3600*$data[$k]['day'];
                        $data[$k]['time'] = date('m月d日 H:i复工',$data[$k]['time']);
                    }
                }
                return_ajax(200,'获取成功',$data);
            }else{
                return_ajax(400,'该服务没有理疗师');
            }
        }
    }

    //理疗师详情
    public function choice_details()
    {
        if(request()->isPost()){
            $post = input('post.');

            if (empty($post['id'])) { return_ajax(400,'缺少理疗师id');}
            if (empty($post['goods_id'])) { return_ajax(400,'缺少门店id');}
            if (empty($post['comp_id'])) { return_ajax(400,'缺少服务id');}
            if (empty($post['jingdu'])) { return_ajax(400,'缺少经度');}
            if (empty($post['weidu'])) { return_ajax(400,'缺少纬度');}
            $arr['where'] = ['id'=>$post['id']];
            $arr['with'] = 'works';
            $arr['field'] = 'id,pic,name,work,discuss,score,status';
            $doctor = $this->getFind('doctor',$arr);
            if ($doctor['status'] == 2) {
                //休息中
                $doctor['start_time'] = DoctorLeave::where('doctor_id',$doctor['id'])->value('start_time');
                $doctor['day'] = DoctorLeave::where('doctor_id',$doctor['id'])->value('day');
                $doctor['time'] = $doctor['start_time']+24*3600*$doctor['day'];
                $doctor['time'] = date('m月d日 H:i复工',$doctor['time']);
            }
            $price = GoodsComp::where(['goods_id'=>$post['goods_id'],'id'=>$post['comp_id']])->value('price');
            $bang = GoodsModel::where('id',$post['goods_id'])->value('bang');//查询店铺是否参加了bang权益

            if (empty($post['uid'])){
                $doctor['price'] = $price;
                $doctor['distance'] = 0;
            }else{

                $user = User::where('id',$post['uid'])->field('id')->find();
                $user_bang = UserBang::where('uid',$user['id'])->find();//查询用户是否开通了bang权益
                if ($bang && $user_bang) {
                    //查询bang权益打折
                    $bang_zhe = Config::where('id',1)->value('bang_zhe');
                    $doctor['old_price'] = $price * $bang_zhe;
                    $doctor['price'] = $price;
                }else{
                    $doctor['price'] = $price;
                }
                $goods = GoodsModel::where('id',$post['goods_id'])->field('id,weidu,jingdu')->find();
                $doctor['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$goods['weidu'],$goods['jingdu']);
            }


            $doctor['address'] = GoodsModel::where('id',$post['goods_id'])->value('address');
            $doctor['title'] = GoodsModel::where('id',$post['goods_id'])->value('title');
            $doctor['jingdu'] = GoodsModel::where('id',$post['goods_id'])->value('jingdu');
            $doctor['weidu'] = GoodsModel::where('id',$post['goods_id'])->value('weidu');
            $doctor['goods_pic'] = GoodsModel::where('id',$post['goods_id'])->value('pic');

            //查询理疗师评论
            $doctor['evaluate'] = GoodsDiscuss::with('user')->where(['doctor_id'=>$post['id'],'is_show'=>1])->order('id desc')->find();
            return_ajax(200,'获取成功',$doctor);
        }
    }

    //查看理疗师全部评价
    public function doctor_discuss()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少理疗师id');}

            if (empty($post['page'])){
                $page = 1;
            }else{
                $page = $post['page'];
            }

            $data = Doctor::where('id',$post['id'])->field('id,discuss,score')->find();
            if (empty($post['time'])){
                //返回所有
                $data['evaluate'] = GoodsDiscuss::with('user')->where(['doctor_id'=>$post['id'],'is_show'=>1])->page($page,10)->order('id desc')->select();

            }else{
                $time = strtotime($post['time']);
                $time1 = date('Y-m-d 00:00:00',$time);
                $time2 = date('Y-m-d 23:59:59',$time);
                $start_time = strtotime($time1);
                $end_time = strtotime($time2);
//
                $where = 'add_time >= '.$start_time.' and add_time <= '.$end_time.'';
                $data['evaluate'] = GoodsDiscuss::with('user')->where(['doctor_id'=>$post['id'],'is_show'=>1])->where($where)->page($page,10)->order('id desc')->select();

            }
            return_ajax(200,'获取成功',$data);
        }
    }

    //取号详情
    public function number()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少理疗师id'); }
            $data = Doctor::where('id',$post['id'])->field('id,name,pic,goods_id,comp_id')->find();
            if ($data){

                $comp_id = implode(',',$data['comp_id']);
                //查询理疗师拥有的服务
                $service = GoodsComp::field('id,title,desc,time,status,price')->where('goods_id',$data['goods_id'])->where('id in('.$comp_id.')')->order('status asc,price asc')->select();
                $data['service'] = $service;

                $add_time = Order::where(['doctor_id'=>$post['id'],'status'=>1])->where('uid = '.$post['uid'].'')->value('add_time');
                if ($add_time){
                    $where = 'add_time < '.$add_time.'';
                }else{
                    $where = '';
                }

                $count = Order::where(['doctor_id'=>$post['id']])->where('status = 1 or status = 2')->where('uid != '.$post['uid'].'')->where($where)->count();
                $data['number'] = $count;//前面有多少人

                $comp_id = Order::where(['doctor_id'=>$post['id'],'status'=>1])->where('uid != '.$post['uid'].'')->where($where)->column('comp_id');

                if (count($comp_id) > 0) {
                    $date = '';
                    foreach ($comp_id as $k=>$v){
                        $date += GoodsComp::where('id',$v)->value('time');
                    }
                }else{
                    $date = 0;
                }

                $res = Order::where(['doctor_id'=>$post['id'],'status'=>2])->where('uid != '.$post['uid'].'')->find();//治疗中

                if ($res) {
                    //查询还剩多少时间治疗完毕
                    $start_time = GoodsComp::where('id',$res['comp_id'])->value('time');//该项服务需要的时间
//                    $end_time = $res['treat_time']+60*$start_time;
                    $end_time = (time()-$res['treat_time']) / 60;
                    if ($end_time > 0) {
                        $date = $start_time - $end_time + $date;
                        $date = round($date, 0);
                    }else{
                        $end_time = 0;
                    }
                }
                if ($date < 0){
                    $date = 0;
                }
                $data['time'] = $date;//要等多少分钟
                return_ajax(200,'获取成功',$data);
            }else{
                return_ajax(400,'该理疗师暂无服务项目');
            }
        }
    }

    //获取服务价格
    public function getprice()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少服务id'); }
            $price = GoodsComp::where('id',$post['id'])->value('price');
            if ($price){
                return_ajax(200,'获取成功',$price);
            }else{
                return_ajax(400,'非法id');
            }
        }
    }

    //排队进度
    public function line_speed()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少理疗师id'); }
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }

            $data = Doctor::where('id',$post['id'])->field('id,name,pic,goods_id,comp_id,score')->find();

            $count = Order::where(['doctor_id'=>$post['id']])->where('status = 1 or status = 2')->where('uid != '.$post['uid'].'')->count();
            $data['number'] = $count;//前面有多少人

            if (!empty($post['uid'])){

                $order = Order::with('user')->where('doctor_id',$post['id'])->where('status = 1 or status = 2')->field('id,treat_time,status,uid,number,doctor_id,comp_id')->select();
                if ($order){
                    foreach ($order as $k=>$v){
                        if ($order[$k]['status'] == 2){
                            //计算服务中的还剩多长时间
                            $order[$k]['end_time'] = GoodsComp::where('id', $order[$k]['comp_id'])->value('time');//该项服务需要的时间
                            $order[$k]['start_time'] = (time()-$order[$k]['treat_time']) / 60;
                            if ($order[$k]['start_time'] <= 0) {
                                $order[$k]['start_time'] = 0;
                            }
                            $order[$k]['time'] = $order[$k]['end_time'] - $order[$k]['start_time'];
                            $order[$k]['time'] = round($order[$k]['time'],0);
                            if ($order[$k]['time'] < 0){
                                $order[$k]['time'] = 0;
                            }
                        }else{
                            $order[$k]['time'] = GoodsComp::where('id', $order[$k]['comp_id'])->sum('time');
                        }
                    }
                }else{
                    $order = [];
                }

            }
            $data['order'] = $order;
            return_ajax(200,'获取成功',$data);
        }
    }

    //确认取号
    public function take_number()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['doctor_id'])) { return_ajax(400,'缺少理疗师id'); }
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id'); }
            if (empty($post['comp_id'])) { return_ajax(400,'缺少服务id'); }
            if (empty($post['goods_id'])) { return_ajax(400,'缺少门店id'); }
            if (empty($post['form_id'])) { return_ajax(400,'缺少必要参数form_id'); }
//            if ($post['num']) { return_ajax(400,'缺少等待人数'); }
//            if ($post['time']) { return_ajax(400,'缺少等待时间'); }

            //查询是否已经取过号
            $user = Order::where(['uid'=>$post['uid']])->where('status = 1 or status = 2')->find();
            if ($user){
                return_ajax(400,'治疗完成后可再次取号');
            }

            $s_user = Order::where(['uid'=>$post['uid']])->where(['status'=>3,'pay_status'=>1])->find();
            if ($s_user){
                return_ajax(400,'请先支付已完成的订单');
            }
            $doctor = Doctor::where('id',$post['doctor_id'])->find();
            $title  = GoodsModel::where('id',$doctor['goods_id'])->value('title');
            $comp = GoodsComp::where('id',$post['comp_id'])->find();

            //计算排队号码
            $start_time = date('Y-m-d 00:00:00',time());
            $end_time = date('Y-m-d 23:59:59',time());
            $start_time = strtotime($start_time);
            $end_time = strtotime($end_time);
            $where = 'add_time >= '.$start_time.' and add_time <= '.$end_time.'';
            $order = Order::where($where)->order('id desc')->find();

            if ($order){
                $str = substr($order['number'],1);
                $str = $str + 1;
                $number =  sprintf("%03d", $str);
                $number = 'A'.$number;

            }else{
                $number = 'A001';
            }

            $time = time();

            //查询店铺是否参加了bang权益
            $goods_bang = GoodsModel::where('id',$post['goods_id'])->value('bang');

            //查询用户是否开通了bang权益
            $res = UserBang::where(['status'=>1,'uid'=>$post['uid']])->find();

            $zhe = Config::where('id',1)->value('bang_zhe');

            if ($goods_bang && $res && $time < $res['end_time']){
                $bang_price = sprintf('%.2f',$comp['price'] * ($zhe / 100));
            }else{
                $bang_price = 0;
            }
            $data = [
                'doctor_id' => $post['doctor_id'],
                'goods_id' => $doctor['goods_id'],
                'comp_id' => $post['comp_id'],
                'uid' => $post['uid'],
                'number' =>$number,//排队号码
                'num' => $post['num'],//等待人数
                'time' => $post['time'],//等待时间
                'name' => $doctor['name'],//理疗师名称
                'form_id' => $post['form_id'],//form_id
                'project' => $comp['title'],//项目名称
                'order_sn' => order_sn('order'),
                'goods_name' => $title,//门店名称
                'total' => $comp['price'],//订单总价
                'bang_price' => $bang_price,//bang权益优惠金额
            ];

            $res = $this->saves('order',$data,true);
            if ($res){
                $o = Order::where('id',$res)->find();
                controller('Weix')->send(4,$res);
                if ($o['num'] == 1){
                    controller('Weix')->send(5,$res);//排队提醒A
                }elseif($o['time'] == 5){
                    controller('Weix')->send(6,$res);//排队提醒B
                }
                return_ajax(200,'取号成功',$o);
            }else{
                return_ajax(400,'网络繁忙');
            }

        }
    }


    public function bang()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['title'])){
                $where = [];
            }else{
                $where = 'title like "%'.$post['title'].'%"';
            }
            $goods = GoodsModel::with('comp')->where('bang',1)->where($where)->order('id desc')->select();
            if ($goods) {
                foreach ($goods as $k=>$v){
                    if (empty($post['jingdu']) && empty($post['weidu'])){
                        $goods[$k]['distance'] = 0;
                    }else{

                        $goods[$k]['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$goods[$k]['weidu'],$goods[$k]['jingdu']);
                    }
                }
                return_ajax(200,'获取成功',$goods);
            }else{
                return_ajax(400,'暂无数据');
            }

        }

    }

}
