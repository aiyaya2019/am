<?php
namespace app\admin\model;
use \think\Model;
use app\admin\model\UserGrade;

Class User extends Model
{	
    protected $append = [];
	//时间自动写入
	protected $autoWriteTimestamp = true;
	//更改添加时间字段
	protected $createTime = 'add_time';

    public function getNicknameAttr($val)
    {
        return emojiDecode($val);
    }


}