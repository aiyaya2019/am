<?php
namespace app\common\model;
use \think\Model;

Class DoctorWorkNew extends Model
{
    protected $append = [];
    //时间自动写入
    protected $autoWriteTimestamp = true;
    //更改添加时间字段
    protected $createTime = 'add_time';

    public function getStartTimeAttr($val)
    {
        return date('Y-m',$val);
    }

    public function getEndTimeAttr($val)
    {
        return date('Y-m',$val);
    }
}