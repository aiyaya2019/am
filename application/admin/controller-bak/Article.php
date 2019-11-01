<?php
namespace app\admin\controller;
use app\common\model\Article as ArticleModel;
use app\admin\model\Goods;
use app\common\model\ArticleGoods;

Class Article extends Common{

    /**
     * [index 文章列表]
     * @Author   PengJun
     * @DateTime 2019-01-24
     * @return   [type]     [description]
     */
    public function index()
    {   
        if(request()->isAjax()){
            $post = input('post.');
            $where = [];

            //名称搜索
            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }

            //发布类型搜索
            if(!empty($post['user_type'])){
                $where['user_type'] = $post['user_type'];
            }
            
            $where['type'] = 1;
            $list = ArticleModel::with('goods,user')->where($where)->order('add_time desc')->page(input('page'),20)->select();
            $count = ArticleModel::where($where)->count();
            return_ajax(200,'获取成功',$list,$count);
        }

        return $this->fetch();
    }

    /**
     * [getList 话题列表]
     * @Author   PengJun
     * @DateTime 2019-04-22
     * @return   [type]     [description]
     */
    public function topic()
    {   
        if(request()->isAjax()){
            $post = input('post.');
            $where = [];

            //名称搜索
            if(!empty($post['title'])){
                $where['title'] = ['like','%'.$post['title'].'%'];
            }

            //发布类型搜索
            if(!empty($post['user_type'])){
                $where['user_type'] = $post['user_type'];
            }
            
            $where['type'] = 2;
            $list = ArticleModel::with('goods,user')->where($where)->order('add_time desc')->page(input('page'),20)->select();
            $count = ArticleModel::where($where)->count();
            return_ajax(200,'获取成功',$list,$count);
        }

        return $this->fetch();
    }

    /**
     * [save 发布编辑文章]
     * @Author   PengJun
     * @DateTime 2019-04-09
     * @return   [type]     [description]
     */
    public function save()
    {   
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');
            
            if(empty($post['files'])){ return_ajax(400,'相册不能为空'); }
            $post['pic'] = implode(',',$post['files']);

            //视频上传
            if(request()->file('video')){
                $file = imgUpdate('video');
                if($file['code'] == 400){ return_ajax(400,$file['msg']); }
                $post['video'] = $file['data'];
            }

            if(empty($post['video'])){
                $post['data_type'] = 1;
            } else {
                $post['data_type'] = 2;
            }
            
            $post['tag'] = implode(',',$post['tag_id']);
            $this->saves('article',$post);
        }

        $goods = Goods::order('add_time desc')->field('id,title')->select();

        $list = ArticleModel::with('goods')->where('id',$id)->find();
        $tag = model('article_tag')->order('sort desc')->select();

        // p(toArray($list));
        return $this->fetch('',[
            'goods' => $goods,
            'list'  => $list,
            'tag'   => $tag,
        ]);
    }

    public function goods()
    {   
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');

            $post['where']['article_id'] = $id;
            $list = $this->selectAll('article_goods',$post);

            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }   

        return $this->fetch('');
    }

    /**
     * [goods_save 商品信息]
     * @Author   PengJun
     * @DateTime 2019-04-22
     * @return   [type]     [description]
     */
    public function goods_save()
    {   
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');

            //封面上传
            if(request()->file('pic')){
                $file = imgUpdate('pic');
                if($file['code'] == 400){ return_ajax(400,$file['msg']); }
                $post['goods_pic'] = $file['data'];
            }
            
            $this->saves('article_goods',$post);
        }   

        $list = ArticleGoods::get($id);

        return $this->fetch('',[
            'list' => $list
        ]);
    }

    /**
     * [tag 文章标签]
     * @Author   PengJun
     * @DateTime 2019-04-12
     * @return   [type]     [description]
     */
    public function tag()
    {
        if(request()->isPost()){
            $post = input('post.');

            $post['order'] = 'sort desc';
            $list = $this->selectAll('article_tag',$post);

            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }

        return $this->fetch();
    }

    /**
     * [save 发布编辑文章标签]
     * @Author   PengJun
     * @DateTime 2019-04-09
     * @return   [type]     [description]
     */
    public function tag_save()
    {   
        $id = input('id');

        if(request()->isPost()){
            $post = input('post.');

            $this->saves('article_tag',$post);
        }

        $list = model('article_tag')->where('id',$id)->find();

        return $this->fetch('',[
            'list'  => $list,
        ]);
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
            $post['where']['article_id'] = $post['aid'];
            $list = $this->selectAll('article_discuss',$post);

            return_ajax(200,'获取成功',$list['list'],$list['count']);
        }

        return $this->fetch();
    }
}