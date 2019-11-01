<?php
namespace app\admin\controller;
use app\admin\model\Problem;
use app\admin\model\Desk;
use app\admin\model\Config as ConfigModel;
use app\common\model\Check;
use app\common\model\Explain;

Class Config extends Common{

	/**
	 * [index 基础配置]
	 * @Author   PengJun
	 * @DateTime 2019-02-28
	 * @return   [type]     [description]
	 */
	public function index()
	{
        if(request()->isPost()){
        	$post = input('post.');
        	$config = new ConfigModel;

        	if(request()->file('file')){
        		$file = imgUpdate('file');
        		if($file['code'] == 400){ return_ajax(400,$file['msg']); }
        		$post['logo'] = $file['data'];
        	}

        	$post['update_time'] = time();
        	$post['start_time'] = strtotime($post['start_time']);
        	$post['end_time'] = strtotime($post['end_time']);
        	if($config->allowField(true)->save($post,['id'=>1])){
        		return_ajax(200,'修改成功');
        	} else {
        		return_ajax(400,'修改失败！请稍后重试');
        	}
        }

        $config = ConfigModel::get(1);

		return $this->fetch('',[
			'config' => $config,
		]);
	}

	/**
	 * [sign 签到]
	 * @Author   PengJun
	 * @DateTime 2019-04-19
	 * @return   [type]     [description]
	 */
	public function sign()
	{	
		if(request()->isPost()){
			$post = input('post.');

			$post['order'] = 'day asc';
			$list = $this->selectAll('check',$post);

			return_ajax(200,'获取成功',$list['list'],$list['count']);
		}
		return $this->fetch();
	}

	/**
	 * [sign_save 签到规格]
	 * @Author   PengJun
	 * @DateTime 2019-03-26
	 * @return   [type]     [description]
	 */
	public function sign_save()
	{	
		$id = input('id');

		if(request()->isPost()){
			$post = input('post.');

			$desk = Check::get(['day'=>$post['day']]);
			if($desk){ return_ajax(400,'天数重复，请重新输入'); }

			$this->saves('check',$post);
		}

		$list = Check::get($id);

		return $this->fetch('',[
			'list' => $list
		]);
	}

	/**
	 * [search 热门搜索]
	 * @Author   PengJun
	 * @DateTime 2019-04-27
	 * @return   [type]     [description]
	 */
	public function search()
	{
		if(request()->isPost()){
			$post = input('post.');

			$list = $this->selectAll('search',$post);

			return_ajax(200,'获取成功',$list['list'],$list['count']);
		}

		return $this->fetch();
	}

	/**
	 * [search_save 配置热门搜索]
	 * @Author   PengJun
	 * @DateTime 2019-04-27
	 * @return   [type]     [description]
	 */
	public function search_save()
	{
		$id = input('id');

		if(request()->isPost()){
			$post = input('post.');

			$this->saves('search',$post);
		}

		$list = $this->getFind('search',$id);

		return $this->fetch('',[
			'list' => $list
		]);
	}

	//BANG权益介绍
    public function bang()
    {
        if(request()->isPost()){
            $post = input('post.');
            $config = new Explain;

            $post['update_time'] = time();
            if($config->allowField(true)->save($post,['id'=>1])){
                return_ajax(200,'修改成功');
            } else {
                return_ajax(400,'修改失败！请稍后重试');
            }
        }

        $explain = Explain::get(1);

        return $this->fetch('',[
            'explain' => $explain,
        ]);
    }
}