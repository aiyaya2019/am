<?php
namespace app\admin\controller;
use app\common\model\Goods;
use app\common\model\User;
use app\common\model\Activity;
use app\common\model\Article;

Class Index extends Common{

	public function index()
	{

		return $this->fetch();
	}

	public function console()
	{	
		//商品数量
		$goods = Goods::count();
		$goods_day = Goods::whereTime('add_time','today')->count();
		//用户数量
		$user = User::count();
		$user_day = User::whereTime('add_time','today')->count();
		//活动数量
		$activity = 1;
		$activity_day = 1;
		//文章
		$article = Article::count();
		$article_day = Article::whereTime('add_time','today')->count();

		return $this->fetch('',[
			'goods'        => $goods,
			'goods_day'    => $goods_day,
			'user'         => $user,
			'user_day'     => $user_day,
			'activity'     => $activity,
			'activity_day' => $activity_day,
			'article'      => $article,
			'article_day'  => $article_day,
		]);
	}
}