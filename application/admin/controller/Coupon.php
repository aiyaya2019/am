<?php
namespace app\admin\controller;

use app\common\model\Coupon as Cp;
use app\common\model\Goods;
use app\common\model\CouponCode;
use app\common\model\GoodsComp;
use app\common\model\Config;
use think\Db;

Class Coupon extends Common{


    /**
     * [coupon 优惠劵]
     * @Author   PengJun
     * @DateTime 2019-03-25
     * @return   [type]     [description]
     */
    public function index()
    {
        if(request()->isPost()){
            $post = input('post.');

            // $post['order'] = 'full_price asc';
            $list = $this->selectAll('Coupon',$post);

            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }

        return $this->fetch();
    }

    /**
     * [coupon_save 添加优惠劵]
     * @Author   PengJun
     * @DateTime 2019-03-25
     * @return   [type]     [description]
     */
    public function save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');

            if($post['type'] == 2){//指定门店可用
                if(empty($post['goods_id'])){
                    return_ajax(400,'请选择指定门店');
                }else{
                    $post['goods_id'] = implode(',',$post['goods_id']);
                }
            }

            if($post['service'] == 2){//指定服务可用
                if(empty($post['comp_id'])){
                    return_ajax(400,'请选择指定服务');
                }else{
                    $post['comp_id'] = implode(',',$post['comp_id']);
                }
            }

            if ($post['num'] == 0){
                return_ajax(400,'发放数量不能为0');
            }

            $save = $this->saves('Coupon',$post,true);

            if($save){
                //生成对应的优惠券码
                $this->coupon_code($save,$post['num']);
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $list  = Cp::get($id);
        $goods = Goods::select();
        $comp = GoodsComp::select();

        return $this->fetch('',[
            'list'  => $list,
            'goods'  => $goods,
            'comp'  => $comp,
        ]);
    }

    //门店服务
    public function service()
    {
        $post = input('post.');
        if ($post['id'] == 0){
            //获取所有服务
            $comp = GoodsComp::select();
        }else{
            $comp = GoodsComp::where('goods_id in ('.$post['id'].')')->select();
        }
        if ($comp){
            return_ajax(200,'获取成功',$comp);
        }else{
            return_ajax(400,'暂无服务');
        }
    }

    //优惠券兑换说明
    public function exchange()
    {
        if (request()->isPost()){

            $post = input('post.');

            $explain = new Config;

            $post['update_time'] = time();
            if($explain->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }

        $explain = Config::where('id',1)->find();
        return $this->fetch('',[
            'explain'   => $explain
        ]);
    }

    //优惠券使用说明
    public function explain()
    {
        if (request()->isPost()){

            $post = input('post.');

            $explain = new Config;

            $post['update_time'] = time();
            if($explain->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }

        $explain = Config::where('id',1)->find();
        return $this->fetch('',[
            'explain'   => $explain
        ]);
    }

    //查看兑换码
    public function code()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');

            $post['where']['coupon_id'] = $id;
            $list = $this->selectAll('coupon_code',$post);

            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }

        return $this->fetch('');
    }

    //修改兑换码
    public function code_save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');

            $res = CouponCode::where('id',$post['id'])->setField('code',$post['code']);

            if($res){
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $list = CouponCode::where('id',$id)->find();
        return $this->fetch('',[
            'list'   => $list
        ]);

    }

}