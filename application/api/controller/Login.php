<?php
namespace app\api\controller;
use \think\Controller;
use app\common\model\User;
use app\common\model\Banner;
use app\common\model\Code;
use app\common\model\Doctor;
use app\common\model\DoctorGrade;
use app\common\model\Goods;

use \think\Session;

class Login extends Controller{

    /**
     * 理疗师 登录
     */
    public function login(){
        $post = input('post.');
        if (!$post['phone']) {
            return_ajax(400,'请输入手机号');
        }
        if (!$post['password']) {
            return_ajax(400,'请输入密码');
        }

        $check = Doctor::where('phone', $post['phone'])->find();
        if (!$check) {
            return_ajax(400,'用户不存在');
        }

        if (md5($post['password']) != $check['password']) {
            return_ajax(400,'密码错误');
        }

        Session::set('doctor' .$check['id'], $check);

        return_ajax(200, '登陆成功', $check);
    }

    /**
     * 理疗师 退出登陆
     */
    public function loginout(){
        $post = input('post.');
        if (!$post['id']) {
            return_ajax(400,'缺少理疗师id');
        }
        Session::delete('doctor' .$post['id']);
        return_ajax(200, '退出成功');
    }

    /**
     * 门店登录
     */
    public function goodsLogin(){
        $post = input('post.');
        if (!$post['phone']) {
            return_ajax(400,'请输入手机号');
        }
        if (!$post['password']) {
            return_ajax(400,'请输入密码');
        }

        $check = Goods::where('phone', $post['phone'])->find();
        if (!$check) {
            return_ajax(400,'用户不存在');
        }

        if (md5($post['password']) != $check['pwd']) {
            return_ajax(400,'密码错误');
        }

        Session::set('goods' .$check['id'], $check);

        return_ajax(200, '登陆成功', $check);
    }

    /**
     * 门店 退出登陆
     */
    public function goodsLoginout(){
        $post = input('post.');
        if (!$post['id']) {
            return_ajax(400,'缺少门店id');
        }
        Session::delete('goods' .$post['id']);
        return_ajax(200, '退出成功');
    }





}
