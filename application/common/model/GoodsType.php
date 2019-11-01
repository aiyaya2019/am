<?php
namespace app\common\model;
use \think\Model;

Class GoodsType extends Model
{
    protected $append = ['count'];
    //时间自动写入
    protected $autoWriteTimestamp = true;
    //更改添加时间字段
    protected $createTime = 'add_time';

    public function this()
    {
        return $this->hasMany('GoodsType','pid','id');
    }

    public function getCountAttr($val,$data){
        if(!empty($data['id'])){
            return model('Goods')->where(['type_id'=>$data['id']])->count();
        } else {
            return 0;
        }
    }

}