<?php
namespace app\admin\controller;
use app\common\model\Goods;
use app\common\model\User;
use app\common\model\Order;
use app\common\model\Doctor;

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
		//订单数量
        $order = Order::count();
        $order_day = Order::whereTime('add_time','today')->count();
        //门店数量
        $doctor = Doctor::count();
        $doctor_day = Doctor::whereTime('add_time','today')->count();

		return $this->fetch('',[
			'goods'        => $goods,
			'goods_day'    => $goods_day,
			'user'         => $user,
			'user_day'     => $user_day,
			'order'     => $order,
			'order_day' => $order_day,
            'doctor'     => $doctor,
            'doctor_day' => $doctor_day,
		]);
	}
}