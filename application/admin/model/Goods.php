<?php
namespace app\admin\model;
use \think\Model;
use \app\common\model\GoodsBrand;

Class Goods extends Model
{	
    protected $append = ['brand_name'];
	//时间自动写入
	protected $autoWriteTimestamp = true;
	//更改添加时间字段
	protected $createTime = 'add_time';

	//商品分类信息
	public function getBrandNameAttr($val,$data)
	{
		if(!empty($data['brand_id'])){
			
			$type = GoodsBrand::get($data['brand_id']);

			return $type['title'];
		}	
	}
}