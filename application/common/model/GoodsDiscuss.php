<?php
namespace app\common\model;
use \think\Model;

Class GoodsDiscuss extends Model
{	
    protected $append = [];
	//时间自动写入
	protected $autoWriteTimestamp = true;
	//更改添加时间字段
	protected $createTime = 'add_time';

	public function user()
	{
		return $this->hasOne('User','id','uid')->field('id,nickname,head_img,phone');
	}

	public function getPicAttr($val)
	{
		if(!empty($val)){
			return explode(',',$val);
		}
	}
}