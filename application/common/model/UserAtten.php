<?php
namespace app\common\model;
use \think\Model;

Class UserAtten extends Model
{	
    protected $append = [];
	//时间自动写入
	protected $autoWriteTimestamp = true;
	//更改添加时间字段
	protected $createTime = 'add_time';

	//关联用户
	public function user()
	{
		return $this->hasOne('User','id','uid')->field('id,nickname,head_img,sex,age,skin,grade_id');
	}

	//关联被关注用户
	public function oldUser()
	{
		return $this->hasOne('User','id','old_uid')->field('id,nickname,head_img,sex,age,skin,grade_id');
	}
}