<?php
namespace app\admin\controller;
use app\common\model\Goods as GoodsModel;
use app\common\model\GoodsType;
use app\common\model\GoodsService;
use app\common\model\GoodsComp;
use app\common\model\Config;

Class Goods extends Common{

    /**
     * [index 门店列表]
     * @Author   PengJun
     * @DateTime 2019-01-24
     * @return   [type]     [description]
     */
    public function index()
    {   
        if(request()->isAjax()){
            $post = input('post.');
            $where = [];

            //商品名称搜索
            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }

            //商品分类搜索
            if(!empty($post['type_id'])){
                $where['type_id'] = $post['type_id'];
            }

            $list = GoodsModel::where($where)->order('add_time desc')->page(input('page'),20)->select();
            $count = GoodsModel::where($where)->count();
            return_ajax(200,'获取成功',$list,$count);
        }

        //获取商品分类
        $type = GoodsType::where('pid',0)->select();

        return $this->fetch('',[
            'type' => $type
        ]);
    }

    /**
     * [save 添加/编辑门店]
     * @Author   PengJun
     * @DateTime 2019-01-24
     * @return   [type]     [description]
     */
    public function save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
           
            $goods = new GoodsModel;

            //封面上传
            if(request()->file('pic')){
                $file = imgUpdate('pic');
                if($file['code'] == 400){ return_ajax(400,$file['msg']); }
                $post['pic'] = $file['data'];
            }

            //转换坐标
            $url = 'https://apis.map.qq.com/ws/coord/v1/translate?locations='.$post['weidu'].','.$post['jingdu'].'&type=3&key=FNZBZ-RDHWS-TYSOP-6GTGS-RTYYH-GNFUG';
            $res = curl_get_contents($url);
            $res = json_decode($res,true);

            if ($res['status'] == 0){
                $post['jingdu'] = $res['locations'][0]['lng'];
                $post['weidu'] = $res['locations'][0]['lat'];
            }


            $post['start_time'] = strtotime($post['start_time']);
            $post['end_time'] = strtotime($post['end_time']);

            if (!empty($post['activity_id'])){
                $post['activity_id'] = implode(',',$post['activity_id']);
            }else{
                $post['activity_id'] = 0;
            }

            $post['update_time'] = time();
            if(empty($post['id'])){
                //新增
                if($goods->allowField(true)->save($post)){
                    return_ajax(200,'添加成功',$goods->id);
                } else {
                    return_ajax(400,'添加失败,请稍后重试');
                }
            } else {
                //编辑
                if($goods->allowField(true)->save($post,['id'=>$post['id']])){
                    return_ajax(200,'编辑成功');
                } else {
                    return_ajax(400,'编辑失败,请稍后重试');
                }
            }
        }

        $goods = GoodsModel::get($id);

        //获取商品分类
        $type = GoodsType::with('this')->where(['pid'=>0])->select();



        //获取门店活动
       $config = Config::get(1);
        return $this->fetch('',[
            'goods' => $goods,
            'type'  => $type,
           
            'config' => $config,
        ]);
    }

    //门店服务
    public function comp()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');

            $post['where']['goods_id'] = $id;
            $list = $this->selectAll('goods_comp',$post);

            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }

        return $this->fetch('');
    }

    /**
     * [ 门店服务]
     * @Author   PengJun
     * @DateTime 2019-04-22
     * @return   [type]     [description]
     */
    public function comp_save()
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

            $this->saves('goods_comp',$post);
        }

        $list = GoodsComp::get($id);

        return $this->fetch('',[
            'list' => $list
        ]);
    }

    /**
     * [type 城市管理]
     * @Author   PengJun
     * @DateTime 2019-03-20
     * @return   [type]     [description]
     */
    public function type()
    {
        if(input('json') == 1){

            $where = [];
            $list = GoodsType::where($where)->select();

            return_ajax(200,'获取成功',$list);
        }

        return $this->fetch();
    }

    /**
     * [type_save 城市管理编辑]
     * @Author   PengJun
     * @DateTime 2019-05-05
     * @return   [type]     [description]
     */
    public function type_save()
    {
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $type = new GoodsType;

            $post['update_time'] = time();
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $type->allowField(true)->save($post);
            } else {
                $oper = $type->allowField(true)->save($post,['id'=>$id]);
            }


            if($oper)
            {
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $type = GoodsType::get($id);

        return $this->fetch('',[
            'type' => $type
        ]);
    }

    /**
     * [DeployDele 删除城市管理]
     * @Author   PengJun
     * @DateTime 2018-10-06
     */
    public function delete_type()
    {
        $id = input('id');

        if(GoodsType::destroy($id)){
            GoodsType::destroy(['pid'=>$id]);
            return_ajax(200,'删除成功');
        } else {
            return_ajax(200,'删除失败,请稍后重试');
        }
    }
    /**
     * [service 服务标准]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function service()
    {   
        if(request()->isPost()){
            $post = input('post.');
            $where = [];

            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }
            $list = GoodsService::where($where)->order('add_time desc')->page(input('page'),20)->select();

            return_ajax(200,'获取成功',$list);
        }
        return $this->fetch();
    }

    /**
     * [type_save 添加编辑商品品牌]
     * @Author   PengJun
     * @DateTime 2019-04-08
     * @return   [type]     [description]
     */
    public function service_save()
    {   
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            $type = new GoodsService;

            if(request()->file('pic')){
                $file = imgUpdate('pic');
                if($file['code'] == 400){ return_ajax(400,$file['msg']); }
                $post['pic'] = $file['data'];
            }

            $post['update_time'] = time();
            if(empty($post['id'])){
                $post['add_time'] = time();
                $oper = $type->allowField(true)->save($post);
            } else {
                $oper = $type->allowField(true)->save($post,['id'=>$id]);
            }

            if($oper)
            {
                return_ajax(200,'操作成功');
            } else {
                return_ajax(400,'操作失败，请稍后重试');
            }
        }

        $type = GoodsService::get($id);

        return $this->fetch('',[
            'type' => $type
        ]);
    }

    //是否推荐
    public function status()
    {
        $post = input('post.');
        if ($post['status'] == 1){
            $status = 2;
        }else{
            $status = 1;
        }
        $res = GoodsComp::where('id',$post['id'])->setField('status',$post['status']);
        GoodsComp::where('id != '.$post['id'].'')->setField('status',$status);
        if ($res) {
            return_ajax(200,'操作成功');
        }else{
            return_ajax(400,'网络繁忙');
        }
    }
    /**
     * [discuss 评论信息]
     * @Author   PengJun
     * @DateTime 2019-04-23
     * @return   [type]     [description]
     */
    public function discuss()
    {
        if(request()->isPost()){
            $post = input('post.');

            $post['with'] = 'user';
            $post['where']['goods_id'] = $post['aid'];
            $list = $this->selectAll('goods_discuss',$post);

            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }
        return $this->fetch();
    }
}