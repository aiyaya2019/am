<?php
namespace app\common\model;
use \think\Model;

Class Order extends Model
{
    protected $append = ['status_name'];
    //时间自动写入
    protected $autoWriteTimestamp = true;
    //更改添加时间字段
    protected $createTime = 'add_time';

    public function user(){
      return $this->hasOne('User','id','uid')->field('id,nickname,head_img,sex');
    }

    // 订单状态
    public function getStatusNameAttr($val,$data)
    {
        // 状态 1待付款 2待发货 3待收货 4已完成 5申请售后  6已取消
        switch ($data['status']) {
            case 1:
                return '待消费';
                break;
            case 2:
                return '治疗中';
                break;
            case 3:
                if ($data['pay_status'] == 1){
                    return '待支付';
                }else{
                    return '已完成';
                }
                break;
            case 4:
                return '已评价';
                break;
            case 5:
                return '已过号';
                break;
            case 6:
                return '已取消';
                break;

        }
    }
}