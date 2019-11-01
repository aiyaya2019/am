<?php
namespace app\admin\controller;
use app\common\model\Banner as BannerModel;

Class Banner extends Common{

	/**
	 * [index 轮播列表]
	 * @Author   PengJun
	 * @DateTime 2019-02-20
	 * @return   [type]     [description]
	 */
	public function index()
	{	
        if(request()->isAjax()){
            $post = input('post.');

            $list = BannerModel::order('sort desc,add_time desc')->select();
            $count = BannerModel::count();
            return_ajax(200,'获取成功',$list,$count);
        }

		return $this->fetch();
	}

	/**
	 * [save description]
	 * @Author   PengJun
	 * @DateTime 2019-02-20
	 * @return   [type]     [description]
	 */
	public function save()
	{
		$id = input('id');
		if(request()->isPost()){
            $post = input('post.');
            $banner = new BannerModel;

            if(request()->file('pic')){
                $file = imgUpdate('pic');
                if($file['code'] == 400){ return_ajax(400,$file['msg']); }
                $post['pic'] = $file['data'];
            }
            
            $post['update_time'] = time();
            if(empty($post['id'])){
                //新增
                // if(empty(request()->file('pic'))){ return_ajax(400,'请上传广告图'); }

                if($banner->allowField(true)->save($post)){
                    return_ajax(200,'添加成功');
                } else {
                    return_ajax(400,'添加失败,请稍后重试');
                }
            } else {
                //编辑
                if($banner->allowField(true)->save($post,['id'=>$post['id']])){
                    return_ajax(200,'编辑成功');
                } else {
                    return_ajax(400,'编辑失败,请稍后重试');
                }
            }
        }

		$banner = BannerModel::get($id);

		return $this->fetch('',[
			'banner' => $banner
		]);
	}
}