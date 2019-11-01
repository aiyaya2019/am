<?php
namespace app\admin\controller;
use app\common\model\Plan;
use app\common\model\Feedback;
use app\common\model\Sickness;

use think\Db;

Class Plans extends Common{

    /**
     * 计划方案列表
     */
    public function index(){
        if(request()->isAjax()){
            $post = input('post.');
            $where = [];

            //计划方案名称搜索
            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }

            //病痛等级搜索
            if(!empty($post['sid'])){
                $where['sid'] = $post['sid'];
            }

            // 反馈类型搜索
            if(!empty($post['fid'])){
                $where['fid'] = $post['fid'];
            }

            $list = Plan::where($where)->order('id desc')->page(input('page'),20)->select();
            // if ($list) {
            //     foreach ($list as $key => $value) {
            //         $list[$key]['s_name'] = Sickness::where('id', $value['sid'])->value('name');
            //         $list[$key]['f_name'] = Feedback::where('id', $value['fid'])->value('name');
            //     }
            // }
            $count = Plan::where($where)->count();
            return_ajax(200,'获取成功',$list,$count);
        }

        //获取病痛等级
        // $sickness = sickness::where(['pid'=>0])->select();
        $sickness = sickness::select();
        $feedback = Feedback::select();

        return $this->fetch('',[
            'sickness' => $sickness,
            'feedback' => $feedback,
        ]);
    }

    /**
     * 添加/编辑 计划方案
     */
    public function save(){
        $id = input('id');
        if(request()->isPost()){
            $post = input('post.');
            $plan = new Plan;


            $post['update_time'] = time();
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $plan->allowField(true)->save($post);
            } else {
                $oper = $plan->allowField(true)->save($post,['id'=>$id]);
            }
            if($oper){
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $plan = Plan::get($id);
        if ($plan) {
            $img = explode(',', $plan['img']);
        }
        $sickness = sickness::select();
        $feedback = Feedback::select();
        return $this->fetch('',[
            'plan'     => $plan,
            'sickness' => $sickness,
            'feedback' => $feedback,
            'img'      => $img,
        ]);
    }


    /**
     * 删除 计划方案
     */
    public function delete_plan(){
        $id = input('id');

        if(Plans::destroy($id)){
            Plans::destroy(['pid'=>$id]);
            return_ajax(200,'删除成功');
        } else {
            return_ajax(200,'删除失败,请稍后重试');
        }
    }


    /**
     * 病痛等级
     */
    public function sickness(){
        if(input('json') == 1){
            $where = [];
            $list = Sickness::where($where)->order('sort desc')->select();
            return_ajax(200,'获取成功',$list);
        }
        return $this->fetch();
    }

    /**
     * 添加/编辑 病痛等级
     */
    public function sickness_save(){   
        $id = input('id');
        if(request()->isPost()){
            $post = input('post.');
            $sickness = new Sickness;

            $post['update_time'] = time();
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $sickness->allowField(true)->save($post);
            } else {
                $oper = $sickness->allowField(true)->save($post,['id'=>$id]);
            }
            if($oper){
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $data = Sickness::get($id);
        return $this->fetch('',[
            'data' => $data
        ]);
    }


    /**
     * 删除 病痛等级
     */
    public function delete_sickness(){
        $id = input('id');
        $check = Sickness::where('pid', $id)->find();
        if ($check) {
            return_ajax(200, '有子等级，不能删除');
        }

        $check_cases = Plan::where('sid', $id)->find();
        if ($check_cases) {
            return_ajax(200, '有计划方案，不能删除');
        }

        if(Sickness::destroy($id)){
            Sickness::destroy(['pid'=>$id]);
            return_ajax(200,'删除成功');
        } else {
            return_ajax(200,'删除失败,请稍后重试');
        }
    }

    /**
     * 反馈类型列表
     */
    public function feedback(){
        if(input('json') == 1){
            $where = [];
            $list = Feedback::where($where)->order('sort desc')->select();
            return_ajax(200,'获取成功',$list);
        }
        return $this->fetch();
    }

    /**
     * 添加/编辑 反馈类型
     */
    public function feedback_save(){   
        $id = input('id');
        if(request()->isPost()){
            $post = input('post.');
            $feedback = new feedback;

            $post['update_time'] = time();
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $feedback->allowField(true)->save($post);
            } else {
                $oper = $feedback->allowField(true)->save($post,['id'=>$id]);
            }
            if($oper){
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $data = Feedback::get($id);
        return $this->fetch('',[
            'data' => $data
        ]);
    }


    /**
     * 删除 反馈类型
     */
    public function delete_feedback(){
        $id = input('id');

        $check_plan = Plan::where('fid', $id)->find();
        if ($check_plan) {
            return_ajax(200, '有计划方案，不能删除');
        }

        if(Feedback::destroy($id)){
            Feedback::destroy(['pid'=>$id]);
            return_ajax(200,'删除成功');
        } else {
            return_ajax(200,'删除失败,请稍后重试');
        }
    }






}