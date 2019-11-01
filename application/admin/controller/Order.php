<?php
namespace app\admin\controller;
use app\common\model\Order as Od;
use app\common\model\OrderType;
use app\common\model\OrderReason;


Class Order extends Common{

    /**
     * [index 订单列表]
     * @Author   PengJun
     * @DateTime 2019-01-24
     * @return   [type]     [description]
     */
    public function index()
    {
        if(request()->isPost()){
            $post = input('post.');
            if(!empty($post['order_sn'])){
                $post['where']['order_sn'] = ['like','%'.$post['order_sn'].'%'];
            }

            $list = $this->selectAll('order',$post);
            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }
        return $this->fetch();
    }

    /**
     * [cancel 取消原因]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function cancel()
    {
        if(request()->isPost()){
            $post = input('post.');
            $where = [];

            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }
            $list = OrderReason::where($where)->order('add_time desc')->page(input('page'),20)->select();

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
    public function cancel_save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $type = new OrderReason;
            $post['update_time'] = time();
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

        $type = OrderReason::get($id);

        return $this->fetch('',[
            'type' => $type
        ]);
    }

    //评价类型
    public function discuss()
    {
        if(request()->isPost()){
            $post = input('post.');
            $where = [];

            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }
            $list = OrderType::where($where)->order('add_time desc')->page(input('page'),20)->select();

            return_ajax(200,'获取成功',$list);
        }
        return $this->fetch();
    }

    /**
     * [discuss_save 添加编辑评价类型]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function discuss_save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $type = new OrderType;

            $post['update_time'] = time();
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

        $type = OrderType::where('id',$id)->find();

        return $this->fetch('',[
            'type' => $type
        ]);
    }

    /**
     * 订单详情
     * @author vevay
     * @time: 2019/7/5 10:12
     */
    public function info(){
        $id = input('id');
        $data = Od::where('id',$id)->find();
        return $this->fetch('',['data'=>$data]);
    }

    /**
     * [order_excel 导出所有订单]
     * @Author   PengJun
     * @DateTime 2019-01-29
     * @return   [type]     [description]
     */
    public function order_excel()
    {
        ini_set('memory_limit','3072M');
        set_time_limit(0);

        $order = Od::order('id desc')->select();

        $head = ['编号','订单编号','门店','理疗师','服务项目','应付','实付','优惠券','Bang权益','订单状态','取号时间'];
        $data = [];
        foreach($order as $key=>$vo){
            $data[] = [
                $vo['id'],
                $vo['order_sn'],
                $vo['goods_name'],
                $vo['name'],
                $vo['project'],
                $vo['total'],
                $vo['price'],
                '-'.$vo['coupon_price'],
                '-'.$vo['bang_price'],
                $vo['status_name'],
                $vo['add_time'],
            ];
        }
        excelExport('订单信息',$head,$data);
    }
}