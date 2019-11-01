<?php
namespace app\admin\controller;
use app\common\model\Doctor as Dt;
use app\common\model\Goods;
use app\common\model\GoodsComp;
use app\common\model\DoctorGrade;


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
    public function save()
    {   
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

        $list  = Dt::get($id);
        $goods = Goods::select();
        $comp  = GoodsComp::where('goods_id',$list['goods_id'])->select();
        $grade = DoctorGrade::select();
        return $this->fetch('',[
            'list'  => $list,
            'goods' => $goods,
            'comp'  => $comp,
            'grade' => $grade,
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

}