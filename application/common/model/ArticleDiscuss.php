<?php
namespace app\common\model;
use \think\Model;

Class ArticleDiscuss extends Model
{	
    protected $append = [];
	//时间自动写入
	protected $autoWriteTimestamp = true;
	//更改添加时间字段
	protected $createTime = 'add_time';

	//发布的用户
	public function user()
	{
		return $this->hasOne('User','id','uid')->field('id,nickname,head_img,sex,grade_id');
	}
}