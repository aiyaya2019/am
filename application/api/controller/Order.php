<?php
namespace app\api\controller;
use \think\Controller;
use app\common\model\Order as Od;
use app\common\model\Goods;
use app\common\model\GoodsDiscuss;
use app\common\model\User;
use app\common\model\GoodsComp;
use app\common\model\OrderReason;
use app\common\model\OrderType;
use app\common\model\Doctor;
use app\common\model\Config;
use app\common\model\UserCoupon;

class Order extends Common
{
    public function index()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id');}
            if (empty($post['status'])) {
                $post['status'] = 1;
            }
            if (empty($post['jingdu'])) { return_ajax(400,'缺少参数jingdu');}
            if (empty($post['weidu'])) { return_ajax(400,'缺少参数weidu');}

            if ($post['status'] == 1) {
                //待消费
                $arr['where'] = ['uid'=>$post['uid'],'status'=>1];
                $order = $this->getFind('order',$arr);
//                $order = Od::where(['uid'=>$post['uid'],'status'=>1])->find();
                if ($order){

                        $order['tel'] = Goods::where('id',$order['goods_id'])->value('tel');//一键呼叫
                        $order['jingdu'] = Goods::where('id',$order['goods_id'])->value('jingdu');//经度
                        $order['weidu'] = Goods::where('id',$order['goods_id'])->value('weidu');//纬度
                        $order['state'] = User::where('id',$order['uid'])->value('state');//是否完善个人档案

//                        $add_time = Order::where(['doctor_id'=>$order['doctor_id']])->where('uid = '.$post['uid'].'')->value('add_time');
                        $add_time = strtotime($order['add_time']);
                        $where = 'add_time < '.$add_time.'';


                        $count = Od::where(['doctor_id'=>$order['doctor_id']])->where('status = 1 or status = 2')->where('uid != '.$post['uid'].'')->where($where)->count();
                        $order['count'] = $count;//前面有多少人
                        if ($order['count'] == 1){
                            //发送模板消息
                            controller('Weix')->send(5,$order['id']);
                        }
                        $comp_id = Od::where(['doctor_id'=>$order['doctor_id'],'status'=>1])->where('uid != '.$post['uid'].'')->where($where)->column('comp_id');
                        if (count($comp_id) > 0) {
                            $date = '';
                            foreach ($comp_id as $k=>$v){
                                $date += GoodsComp::where('id',$v)->value('time');
                            }
                        }else{
                            $date = 0;
                        }

                        $res = Od::where(['doctor_id'=>$order['doctor_id'],'status'=>2])->where('uid != '.$post['uid'].'')->find();//治疗中

                        if ($res) {
                            //查询还剩多少时间治疗完毕
                            $start_time = GoodsComp::where('id',$res['comp_id'])->value('time');//该项服务需要的时间
                            $end_time = (time()-$res['treat_time']) / 60;
                            if ($end_time <= 0) {
                                $end_time = 0;
                            }
                            $date = $start_time - $end_time + $date;
                            $date = round($date, 0);
                        }

                        if ($date < 0){
                            $date = 0;
                        }

                      $order['time'] = $date;//要等多少分钟
                    if ($order['time'] == 5){
                        //发送模板消息
                        controller('Weix')->send(6,$order['id']);
                    }
                      $order['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$order['weidu'],$order['jingdu']);//距离
                    //查询用户是否已完善个人档案
                    $order['state'] = User::where('id',$order['uid'])->value('state');
                }
            }elseif ($post['status'] == 2){
                //治疗中
                $order = Od::where(['uid'=>$post['uid'],'status'=>2])->find();
                if ($order){

                    $order['jingdu'] = Goods::where('id',$order['goods_id'])->value('jingdu');//经度
                    $order['weidu'] = Goods::where('id',$order['goods_id'])->value('weidu');//纬度
                    $order['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$order['weidu'],$order['jingdu']);//距离
                }
            }elseif ($post['status'] == 3){
                //已完成
                $order = Od::where(['uid'=>$post['uid']])->where('status = 3 or status = 4')->order('id desc,pay_status asc')->select();
                if ($order){
                    foreach ($order as $k=>$v){
                        $order[$k]['jingdu'] = Goods::where('id',$order[$k]['goods_id'])->value('jingdu');//经度
                        $order[$k]['weidu'] =  Goods::where('id',$order[$k]['goods_id'])->value('weidu');//经度
                        $order[$k]['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$order[$k]['weidu'],$order[$k]['jingdu']);//距离
                    }
                    $order = array_values($order);
                }
            }else{
                //已取消/过号
                $arr['where'] = 'uid = '.$post['uid'].' and status = 5 or status = 6';
                $order =$this->selectAll('order',$arr);

//                $order = Od::where(['uid'=>$post['uid']])->where('status = 5 or status = 6')->select();
                if ($order){
                    foreach ($order as $k=>$v){
                        $order[$k]['jingdu'] = Goods::where('id',$order[$k]['goods_id'])->value('jingdu');//经度
                        $order[$k]['weidu'] =  Goods::where('id',$order[$k]['goods_id'])->value('weidu');//经度
                        $order[$k]['distance'] = $this->getDistance($post['weidu'],$post['jingdu'],$order[$k]['weidu'],$order[$k]['jingdu']);//距离
                    }
                    $order = array_values($order);
                }
            }

            if ($order) {

                return_ajax(200,'获取成功',$order);
            }else{
                return_ajax(400,'暂无订单');
            }
        }

    }

    //取消排号
    public function cancel()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])){
                //返回取消原因
                $data = OrderReason::select();
                return_ajax(200,'获取成功',$data);
            }else{

                if (empty($post['id'])) { return_ajax(400,'缺少订单id');}
                if (empty($post['title'])) { return_ajax(400,'缺少取消原因');}
                $res = Od::where('id',$post['id'])->setField('status',6);
                Od::where('id',$post['id'])->setField('reason',$post['title']);
                if ($res){
                    return_ajax(200,'操作成功');
                }else{
                    return_ajax(400,'网络繁忙');
                }
            }
        }
    }

    //去评价
    public function discuss()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])){
                //返回取消原因
                $data = OrderType::select();
                return_ajax(200,'获取成功',$data);
            }else{

                if (empty($post['id'])) { return_ajax(400,'缺少订单id');}
                if (empty($post['form_id'])) { return_ajax(400,'缺少form_id');}
                if (empty($post['title'])) { return_ajax(400,'缺少评价类型');}
                if (empty($post['star'])) { return_ajax(400,'请选择评价星级');}
                $order = Od::where('id',$post['id'])->find();
                $data = [
                    'uid'   => $order['uid'],
                    'goods_id'   => $order['goods_id'],
                    'doctor_id'   => $order['doctor_id'],
                    'star'  => $post['star'],
                    'score'  => $post['star'],
                    'type'  => $post['title'],
                    'desc'  => $post['desc'],
                    'oid'  => $post['id'],
                    'name'  => $order['name'],
                    'comp_name'  => $order['project'],
                ];
                if (!empty($post['pic'])){
                    $data['pic'] = $post['pic'];
                    $data['state'] = 2;
                }

                $res = $this->saves('goods_discuss',$data,true);
                if ($res){
                    Od::where('id',$post['id'])->setField('status',4);
                    Od::where('id',$post['id'])->setField('form_discuss_id',$post['form_id']);
                    //计算评分
                    $goods_score = GoodsDiscuss::where('goods_id',$order['goods_id'])->sum('score');
                    $comp_score = GoodsDiscuss::where('doctor_id',$order['doctor_id'])->sum('score');
                    $goods_count = GoodsDiscuss::where('goods_id',$order['goods_id'])->count();
                    $comp_count = GoodsDiscuss::where('doctor_id',$order['doctor_id'])->count();
                    $g_score = sprintf('%.2f',$goods_score / $goods_count);
                    $c_score = sprintf('%.2f',$comp_score / $comp_count);
                    Goods::where('id',$order['goods_id'])->setField('score',$g_score);
                    Goods::where('id',$order['goods_id'])->setInc('discuss',1);
                    Doctor::where('id',$order['doctor_id'])->setField('score',$c_score);
                    Doctor::where('id',$order['doctor_id'])->setInc('discuss',1);
//                    controller('Weix')->send(3,$post['id']);
                    return_ajax(200,'评价成功');
                }else{
                    return_ajax(400,'网络繁忙');
                }
            }
        }

    }



    //评价详情
    public function discuss_details()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少订单id');}
            $discuss = GoodsDiscuss::where('oid',$post['id'])->find();
            if ($discuss){
                return_ajax(200,'获取成功',$discuss);
            }else{
                return_ajax(400,'网络繁忙');
            }
        }
    }

    //获取优惠券
    public function coupon()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少用户id');}
            $time = time();
            $where = 'end_time >= '.$time.'';
            $coupon = UserCoupon::where(['uid'=>$post['uid'],'status'=>1])->where($where)->select();
            if ($coupon){
                foreach ($coupon as $k=>$v){
                    $coupon[$k]['end_time'] = date('Y-m-d H:i',$coupon[$k]['end_time']);
                    $coupon[$k]['start_time'] = date('Y-m-d H:i',$coupon[$k]['start_time']);
                }
                return_ajax(200,'获取成功',$coupon);
            }else{
                return_ajax(400,'暂无可用的优惠券');
            }
        }
    }

    //订单详情
    public function detail()
    {
        if(request()->isPost()){
            $post = input('post.');
            if (empty($post['id'])) { return_ajax(400,'缺少订单id');}
            $data = Od::where('id',$post['id'])->find();
            if ($data) {
                return_ajax(200,'获取成功',$data);
            }else{
                return_ajax(400,'网络繁忙');
            }
        }
    }

}
