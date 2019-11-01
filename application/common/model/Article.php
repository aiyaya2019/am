<?php
namespace app\common\model;
use \think\Model;
use app\common\model\ArticleDiscuss;
use app\common\model\ArticleTag;

Class Article extends Model
{	
    protected $append = ['discus','tag_name','time_name'];
	//时间自动写入
	protected $autoWriteTimestamp = true;
	//更改添加时间字段
	protected $createTime = 'add_time';

	//分割标签
	public function getTagAttr($val)
	{
		if(!empty($val)){
			return explode(',',$val);
		}
	}

	//分割标签
	public function getPicAttr($val)
	{
		if(!empty($val)){
			return explode(',',$val);
		}
	}

	//标签内容
	public function getTagNameAttr($val,$data)
	{
		if(!empty($data['tag'])){
			$id = explode(',',$data['tag']);
			$tag = ArticleTag::where('id','in',$id)->field('id,title')->select();
			return $tag;
		}
	}

	//关联的商品
	public function goods()
	{
		return $this->hasMany('ArticleGoods','article_id','id');
	}

	//发布的用户
	public function user()
	{
		return $this->hasOne('User','id','uid')->field('id,nickname,head_img,sex,grade_id,fan');
	}

	//获取最新的评论内容
	public function getDiscusAttr($val,$data)
	{
		$info = ArticleDiscuss::with('user')->where('article_id',$data['id'])->field('id,article_id,uid,desc')->order('add_time desc')->find();

		return empty($info)?['id'=>0,'uid'=>0,'article_id'=>0,'desc'=>'']:$info;
	}

	//发布于多久之前
	public function getTimeNameAttr($val,$data)
	{
		if(!empty($data['add_time'])){
			return word_time($data['add_time']);
		}
	}
}