<?php
namespace app\admin\controller;
use app\common\model\Doctor as Dt;
use app\common\model\Goods;
use app\common\model\GoodsComp;
use app\common\model\DoctorGrade;
use app\common\model\DoctorLeave;
use app\common\model\GoodsDiscuss;
use app\common\model\User;
use app\common\model\DoctorRefer;
use app\common\model\DoctorWork;
use app\common\model\DoctorWorkNew;
use app\common\model\Config;

use think\Db;

Class Doctor extends Common{

    /**
     * [index 理疗师列表]
     * @Author   PengJun
     * @DateTime 2019-04-17
     * @return   [type]     [description]
     */
    public function index()
    {
        if(request()->isPost()){
            $post = input('post.');

            if(!empty($post['name'])){
                $post['where']['name'] = ['like','%'.$post['name'].'%'];
            }
           $post['with'] = 'goods';
            $list = $this->selectAll('doctor',$post);

            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }   
        return $this->fetch();
    }

    /**
     * [save 发布/编辑理疗师]
     * @Author   PengJun
     * @DateTime 2019-04-17
     * @return   [type]     [description]
     */
    public function save(){   
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');

            //封面上传
            if(request()->file('pic')){
                $file = imgUpdate('pic');
                if($file['code'] == 400){ return_ajax(400,$file['msg']); }
                $post['pic'] = $file['data'];
            }

            if (!isPhone($post['phone'])) { return_ajax(400,'手机号格式有误');}

            $check = Dt::where(['phone'=>$post['phone']])->find();
            if ($check) {
                if ($check['id'] != $post['id']) {
                    return_ajax(400,'改手机号已存在');
                }
            }

            if (empty($post['comp_id'])) {
                return_ajax(400,'请选择服务');
            }else{
                $post['comp_id'] = implode(',',$post['comp_id']);
            }

            $post['grade_name'] = DoctorGrade::where('id', $post['grade_id'])->value('name');

            if ($id) {
                $rs = Dt::where(['id'=>$id,'password'=>$post['password']])->find();
                if (!$rs){
                    $post['password'] = md5($post['password']);
                }
            }else{
                $post['password'] = md5($post['password']);
            }

            $post['token'] = $this->GetToken($post['phone']);

            $this->saves('doctor',$post);
        }

        // $config = Config::field('day_money,wek_money,month_money,royalty_precent,royalty_rule,satisfaction,order_num,return_rate')->where('id', '1')->find();
        $list   = Dt::get($id);
        $goods  = Goods::select();
        $comp   = GoodsComp::where('goods_id',$list['goods_id'])->select();
        $grade  = DoctorGrade::select();
        $work   = DoctorWork::where('doctor_id', $list['id'])->order('id desc')->select();

        if ($list['images']) {
          $list['images'] = explode(',', $list['images']);
          # code...
        }

        return $this->fetch('',[
            'list'   => $list,
            'goods'  => $goods,
            'comp'   => $comp,
            'grade'  => $grade,
            'work'   => $work,
            // 'config' => $config,
        ]);
    }

    //获取对应的门店服务
    public function service()
    {
        $id = input('id');
        $data = GoodsComp::where('goods_id',$id)->field('id,title')->select();
        if ($data){
            return_ajax(200,'获取成功',$data);
        }else{
            return_ajax(400,'该门店暂无服务');
        }
    }
    
    /**
     * 请假
     */
    public function level(){
        $doctor_id = input('id');
        if(request()->isPost()){
            $post = input('post.');
            $post['where']['doctor_id'] = $doctor_id;
            $list = $this->selectAll('doctor_leave', $post);
            if ($list) {
                foreach ($list['list'] as $key => &$value) {
                    $list['list'][$key]['start_time'] = date('Y-m-d H:i:s', $value['start_time']);
                    $list['list'][$key]['end_time']   = date('Y-m-d H:i:s', $value['end_time']);
                    $list['list'][$key]['doctor_name'] = Dt::where('id', $value['doctor_id'])->value('name');
                    $list['list'][$key]['goods_name']  = Goods::where('id', $value['goods_id'])->value('title');
                }
            }
            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }
        return $this->fetch('');
    }

    /**
     * 请假审核
     */
    public function levelEdit(){
        if(request()->isPost()){
            $post  = input('post.');
            $leave = new DoctorLeave;

            if($leave->allowField(true)->save($post,['id'=>$post['id']])){
                return_ajax(200);
            } else {
                return_ajax(400,'操作失败');
            }
        }
    }

    /**
     * 评论列表
     */
    public function discuss(){
        $doctor_id = input('id');
        if(request()->isPost()){
            $post = input('post.');
            $post['where']['doctor_id'] = $doctor_id;
            $list = $this->selectAll('goods_discuss', $post);
            if ($list) {
                foreach ($list['list'] as $key => &$value) {
                  $list['list'][$key]['goods_name'] = Goods::where('id', $value['goods_id'])->value('title');
                  $list['list'][$key]['nickname']   = User::where('id', $value['uid'])->value('nickname');
                }
            }
            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }
        return $this->fetch('');
    }


    /**
     * 评论编辑
     */
    public function discussEdit(){
        if(request()->isPost()){
            $post  = input('post.');
            $discuss = new GoodsDiscuss;

            if($discuss->allowField(true)->save($post,['id'=>$post['id']])){
                return_ajax(200);
            } else {
                return_ajax(400,'操作失败');
            }
        }
    }

    /**
     * 档案
     */
    public function work(){
      // echo $_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];exit;
        $id = input('id');
        if(request()->isPost()){
            $post  = input('post.');
            $post['where']['doctor_id'] = $id;

            $where = $post;
            $where['where']['status'] = ['in', [1,3]];
            $check = $this->selectAll('doctor_work_new', $where);
            if ($check['list']) {
                foreach ($check['list'] as $key => &$value) {
                  $goods_id = Dt::where('id', $value['doctor_id'])->value('goods_id');
                  $check['list'][$key]['goods_name']  = Goods::where('id', $goods_id)->value('title');
                  $check['list'][$key]['doctor_name'] = Dt::where('id', $value['doctor_id'])->value('name');
                }
                return_ajax(200,'获取成功',$check['list'],$check['count']);
            }else{
              $list = $this->selectAll('doctor_work', $post);
              if ($list['list']) {
                  foreach ($list['list'] as $key => &$value) {
                    $goods_id = Dt::where('id', $value['doctor_id'])->value('goods_id');
                    $list['list'][$key]['goods_name']  = Goods::where('id', $goods_id)->value('title');
                    $list['list'][$key]['doctor_name'] = Dt::where('id', $value['doctor_id'])->value('name');
                  }
              }
              return_ajax(200,'获取成功',$list['list'],$list['count']);
            }
        }
        return $this->fetch('');
    }

    /**
     * 档案审核
     */
    public function workExamine(){
      $post = input('get.');
      $where['doctor_id'] = $post['doctor_id'];
      $where['status']    = ['in', [1,3]];
      $check_new = Db::name('doctor_work_new')->where($where)->select();
      if ($check_new) {
        if ($post['status'] == '2') {//审核通过
          foreach ($check_new as $key => &$value) {
            unset($value['id']);
            $check_new[$key]['status'] = $post['status'];
          }
          Db::startTrans();// 启动事务
          $rs_del_work = DoctorWork::where('doctor_id', $post['doctor_id'])->delete();
          $rs_add_work = DoctorWork::insertAll($check_new);
          $rs_del_new  = DoctorWorkNew::where('doctor_id', $post['doctor_id'])->delete();
          if (($rs_del_work && $rs_add_work) && $rs_del_new) {
            Db::commit();// 提交事务
          }else{
            Db::rollback();// 回滚事务
          }
        }else{//拒绝(未通过)
          $rs = DoctorWorkNew::where('doctor_id', $post['doctor_id'])->update(['status' => $post['status'], 'update_time' => time()]);
        }
        $this->redirect('Doctor/work', ['id' => $post['doctor_id']]);
        // header('location:/Admin/Doctor/work?id='.$post['doctor_id']);

      }else{
        $this->redirect('Doctor/work', ['id' => $post['doctor_id']]);
      }
    }


    /**
     * 转诊列表
     */
    public function refer(){
        $id = input('id');
        if(request()->isPost()){
            $post = input('post.');
            $post['where']['dotor_id'] = $id;
            $list = $this->selectAll('doctor_refer', $post);
            if ($list) {
                foreach ($list['list'] as $key => &$value) {
                  $list['list'][$key]['goods_name']  = Goods::where('id', $value['goods_id'])->value('title');
                  $list['list'][$key]['doctor_name'] = Dt::where('id', $value['dotor_id'])->value('name');
                }
            }
            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }
        return $this->fetch('');
    }

    //理疗师弹窗
    public function doctor()
    {
        if(request()->isPost()){
            $post = input('post.');
            $config = new Config;
            $post['update_time'] = time();
            if($config->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }
        $config = Config::get(1);

        return $this->fetch('',[
            'config' => $config,
        ]);
    }

}