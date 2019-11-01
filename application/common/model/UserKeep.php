<?php
namespace app\common\model;
use \think\Model;

Class UserKeep extends Model
{	
    protected $append = [];
	//时间自动写入
	protected $autoWriteTimestamp = true;
	//更改添加时间字段
	protected $createTime = 'add_time';

	//关联文章
	public function article()
	{
		return $this->hasOne('Article','id','pid')->field('id,title,pic,uid,keep,add_time,scan,like,type');
	}

	//关联商品
	public function goods()
	{
		return $this->hasOne('Goods','id','pid')->field('id,title,pic,discuss,score,brand_id');
	}

	//关联活动
	public function activity()
	{
		return $this->hasOne('Activity','id','pid')->field('id,title,pic,uid,keep,add_time,scan,like');
	}
}