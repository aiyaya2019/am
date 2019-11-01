<?php
namespace app\common\model;
use app\common\model\DoctorGrade;
use \think\Model;

Class Doctor extends Model
{
    protected $append = [];
    //时间自动写入
    protected $autoWriteTimestamp = true;
    //更改添加时间字段
    protected $createTime = 'add_time';

   public function goods()
   {
       return $this->hasOne('Goods','id','goods_id')->field('id,title,address');
   }

   public function getCompIdAttr($val)
   {
       if (!empty($val)){
           return explode(',',$val);
       }
   }
   public function getLevelAttr($val)
   {
       if (!empty($val)){
           return DoctorGrade::where('id', $val)->value('name');
       }
   }
   public function works()
   {
        return $this->hasMany('DoctorWork','doctor_id','id');
   }
   
}