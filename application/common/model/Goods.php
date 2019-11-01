<?php
namespace app\common\model;
use \think\Model;
use \app\common\model\GoodsType;

Class Goods extends Model
{	
    protected $append = ['type_name'];
	//时间自动写入
	protected $autoWriteTimestamp = true;
	//更改添加时间字段
	protected $createTime = 'add_time';

	//商品分类信息
	public function getTypeNameAttr($val,$data)
	{
		if(!empty($data['type_id'])){
			
			$type = GoodsType::get($data['type_id']);

			return $type['title'];
		}	
	}

    public function getActivityIdAttr($val)
    {
        return explode(',',$val);
    }

    public function comp()
    {
        return $this->hasOne('GoodsComp','goods_id','id')->field('id,title,price,goods_id')->order('id desc');
    }

    public function compall()
    {
        return $this->hasMany('GoodsComp','goods_id','id')->field('id,title,price,goods_id,status,desc')->order('id desc');
    }
}