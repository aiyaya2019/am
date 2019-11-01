<?php
namespace app\api\controller;
use app\common\model\GoodsComp;
use \think\Controller;
use app\common\model\Goods as GoodsModel;
use app\common\model\Config;
use app\common\model\DoctorLeave;
use app\common\model\Doctor;
use app\common\model\DoctorWork;
use app\common\model\Order;
use app\common\model\Plan;
use app\common\model\DoctorRefer;
use app\common\model\Feedback;
use app\common\model\Msg;
use app\common\model\GoodsDiscuss;

/**
 * 加盟商
 */
class Gshop extends Gdcommon{

    /**
     * 获取门店信息
     */
    public function getGoodsInfo(){
        $post = input('post.');
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id');
        }
        if (!$post['day']) {
            return_ajax(400, '缺少参数day');
        }

        // 门店销售总额
        $total = Order::where('goods_id', $post['goods_id'])->sum('price');

        $day_start   = strtotime($post['day']);
        $day_end     = $day_start + '86400';

        $week        = $this->getWeekMyActionAndEnd($post['day']);
        $week_start  = strtotime($week['week_start']);
        $week_end    = strtotime($week['week_end']) + '86400';

        $arr_day     = explode('-', $post['day']);
        $time        = $this->mFristAndLast($arr_day['0'], $arr_day['1']);
        $monty_start = $time['firstday'];
        $monty_end   = $time['lastday'];

        $where['status']   = ['in', ['3', '4']];
        $where['goods_id'] = $post['goods_id'];

        // 本日销售总额
        $day_money = Order::where($where)->where('treat_time', 'between time', [$day_start, $day_end])->sum('price');
        $day_money = $day_money ? $day_money : '0';

        // 本周销售总额
        $week_money = Order::where($where)->where('treat_time', 'between time', [$week_start, $week_end])->sum('price');
        $week_money = $week_money ? $week_money : '0';

        // 本月销售总额
        $monty_money = Order::where($where)->where('treat_time', 'between time', [$monty_start, $monty_end])->sum('price');
        $monty_money = $monty_money ? $monty_money : '0';

        // 今日订单
        $day_num = Order::where($where)->where('treat_time', 'between time', [$day_start, $day_end])->count('id');
        $day_num = $day_num ? $day_num : '0';
        
        // 本周订单
        $week_num = Order::where($where)->where('treat_time', 'between time', [$week_start, $week_end])->count('id');
        $week_num = $week_num ? $week_num : '0';
        
        // 本月订单
        $monty_num = Order::where($where)->where('treat_time', 'between time', [$monty_start, $monty_end])->count('id');
        $monty_num = $monty_num ? $monty_num : '0';

        $data = [
            'day_money'   => $day_money,
            'week_money'  => $week_money,
            'monty_money' => $monty_money,
            'day_num'     => $day_num,
            'week_num'    => $week_num,
            'monty_num'   => $monty_num,
        ];
        return_ajax(200, '获取成功', $data);
    }

    /**
     * 门店订单
     * time 1日 2周 3月
     */
    public function getOrder(){
        $post = input('post.');
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id');
        }
        if (!$post['time']) {
            return_ajax(400, '缺少参数time');
        }
        if (!$post['day']) {
            return_ajax(400, '缺少参数day');
        }
        $page = $post['page'] ? $post['page'] : '1';

        switch ($post['time']) {
            case '1':
                $start_time = strtotime($post['day']);
                $end_time   = $start_time + '86400';
                break;

            case '2':
                $week       = $this->getWeekMyActionAndEnd($post['day']);
                $start_time = strtotime($week['week_start']);
                $end_time   = strtotime($week['week_end']) + '86400';
                break;
            default:
                $arr_day    = explode('-', $post['day']);
                $time       = $this->mFristAndLast($arr_day['0'], $arr_day['1']);
                $start_time = $time['firstday'];
                $end_time   = $time['lastday'];
                break;
        }

        $where['status']   = ['in', ['3', '4']];
        $where['goods_id'] = $post['goods_id'];
        $where['treat_time'] = ['between time', [$start_time, $end_time]];

        // 订单总数
        $num = Order::where($where)->count('id');
        // 总额
        $all_money = Order::where($where)->sum('price');

        // 订单
        $data = Order::where($where)->order('id desc')->page($page, '20')->select();
        if ($data) {
            foreach ($data as $key => &$value) {
                $data[$key]['treat_time'] = date('Y-m-d H:i:s', $value['treat_time']);
            }
            $arr = ['num' => $num, 'all_money' => $all_money];
            return_ajax(200, '获取成功', $data, $arr);
        }else{
            return_ajax(400, '暂无订单');
        }
    }

    /**
     * 获取理疗师
     */
    public function getDoctor(){
        $post = input('post.');
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id');
        }
        $page = $post['page'] ? $post['page'] : '1';

        $where['goods_id'] = $post['goods_id'];
        $data = Doctor::where($where)->order('id desc')->page($page, '20')->select();
        if ($data) {
            foreach ($data as $key => &$value) {
                switch ($value['status']) {
                    case '1':
                        $data[$key]['status_name'] = '工作中';
                        break;
                    default:
                        $data[$key]['status_name'] = '休息中';
                        break;
                }
            }
            $count = Doctor::where($where)->count('id');
            return_ajax(200, '获取成功', $data, $count);
        }else{
            return_ajax(400, '暂无订单');
        }
    }
 
    /**
     * 获取理疗师详情
     */
    public function getDoctorDetail(){
        $post = input('post.');
        if (!$post['doctor_id']) {
            return_ajax(400, '缺少参数doctor_id');
        }

        $where['id'] = $post['doctor_id'];
        $data = Doctor::where($where)->find();
        if ($data) {
            // 授权服务
            $data['comp'] = GoodsComp::where('id', 'in', $data['comp_id'])->order('id desc')->select();
            // 工作经历
            $data['works'] = DoctorWork::where('doctor_id', $data['id'])->order('id desc')->select();

            $map['status']    = ['in', ['3', '4']];
            $map['doctor_id'] = $post['doctor_id'];

            // 当天开始结束时间戳
            $day_start = mktime(0,0,0,date('m'),date('d'),date('Y'));
            $day_end   = mktime(0,0,0,date('m'),date('d')+1,date('Y'))-1;

            // 本周开始结束时间戳
            $week_start = mktime(0,0,0,date('m'),date('d')-date('w')+1,date('Y'));
            $week_end   = mktime(23,59,59,date('m'),date('d')-date('w')+7,date('Y'));

            // 本月开始结束时间戳
            $monty_start = mktime(0,0,0,date('m'),1,date('Y'));
            $monty_end   = mktime(23,59,59,date('m'),date('t'),date('Y'));

            // 本日完成指标
            $day_money = Order::where($map)->where('treat_time', 'between time', [$day_start, $day_end])->sum('price');
            $day_money = $day_money ? $day_money : '0';

            // 本周完成指标
            $week_money = Order::where($map)->where('treat_time', 'between time', [$week_start, $week_end])->sum('price');
            $week_money = $week_money ? $week_money : '0';

            // 本月完成指标
            $monty_money = Order::where($map)->where('treat_time', 'between time', [$monty_start, $monty_end])->sum('price');
            $monty_money = $monty_money ? $monty_money : '0';

            $data['com_day_money']   = $day_money;
            $data['com_week_money']  = $week_money;
            $data['com_monty_money'] = $monty_money;

            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无订单');
        }
    }

    /**
     * 获取服务产品
     */
    public function getGoodsComp(){
        $post = input('post.');
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id');
        }
        $page = $post['page'] ? $post['page'] : '1';

        $where['goods_id'] = $post['goods_id'];
        $data = GoodsComp::where($where)->order('id desc')->page($page, '20')->select();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无产品');
        }
    }

    /**
     * 获取客户病案列表
     */
    public function getPlans(){
        $post = input('post.');
        $page = $post['page'] ? $post['page'] : '1';
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id');
        }
        if ($post['nickname']) {
            $where['nickname'] = ['like', '%'.$post['nickname'].'%'];
        }

        $where['goods_id'] = $post['goods_id'];
        $data = Plan::where($where)->order('id desc')->page($page, '20')->select();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无产品');
        }
    }

    /**
     * 获取客户病案详情
     */
    public function getPlansDetail(){
        $post = input('post.');
        if (!$post['plan_id']) {
            return_ajax(400, '缺少参数plan_id');
        }

        $where['id'] = $post['plan_id'];
        $data = Plan::where($where)->find();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无产品');
        }
    }


    /**
     * 转诊申请
     */
    public function doctorRefer(){
        $post = input('post.');
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id');
        }
        if (!$post['username']) {
            return_ajax(400, '请输入用户名称');
        }
        if (!$post['phone']) {
            return_ajax(400, '请输入联系方式');
        }
        if (!$post['number']) {
            return_ajax(400, '请输入体验卡号');
        }
        if (!$post['msg']) {
            return_ajax(400, '请输入转诊原因');
        }

        $doctorRefer = new DoctorRefer;

        $rs = $doctorRefer->allowField(true)->save($post);
        if ($rs) {
            return_ajax(200, '操作成功', $rs);
        }else{
           return_ajax(400, '操作失败'); 
        }
    }

    /**
     * 转诊记录
     */
    public function referLst(){
        $post = input('post.');
        $page = $post['page'] ? $post['page'] : '1';
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id');
        }
        $data = DoctorRefer::where('goods_id', $post['goods_id'])->page($page, '20')->order('id desc')->select();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
           return_ajax(400, '暂无记录'); 
        }
    }

    /**
     * 转诊记录详情
     */
    public function referLstDetail(){
        $post = input('post.');
        if (!$post['refer_id']) {
            return_ajax(400, '缺少参数refer_id');
        }
        $data = DoctorRefer::where('id', $post['refer_id'])->find();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
           return_ajax(400, '暂无记录'); 
        }
    }

    /**
     * 添加提议反馈
     */
    public function addMsg(){
        $post = input('post.');
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id');
        }
        if (!$post['fid']) {
            return_ajax(400, '缺少参数fid');
        }
        if (!$post['content']) {
            return_ajax(400, '缺少参数content');
        }
        $post['f_name'] = Feedback::where('id', $post['fid'])->value('name');

        $msg = new Msg;
        $rs  = $msg->allowField(true)->save($post);
        if ($rs) {
            return_ajax(200, '操作成功', $rs);
        }else{
           return_ajax(400, '操作失败'); 
        }
    }


    /**
     * 获取评价
     */
    public function getDiscuss(){
        $post = input('post.');
        $page = $post['page'] ? $post['page'] : '1';
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id'); 
        }

        if ($post['have_img']) {
            $where['pic'] = ['<>', 'null'];
        }
        if ($post['star']) {
            $where['star'] = $post['star'];
        }

        $where['is_show']  = '1';
        $where['goods_id'] = $post['goods_id'];

        $data = GoodsDiscuss::with('user')->where($where)->order('id desc')->page($page, '20')->select();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无评价');
        }
    }

    /**
     * 获取评论统计
     */
    public function getDiscussCount(){
        $post = input('post.');
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id'); 
        }

        $where['is_show']  = '1';
        $where['goods_id'] = $post['goods_id'];

        // 评价总数
        $all_num = GoodsDiscuss::where($where)->count('id');
        // 有图评价总数
        $have_pic_num = GoodsDiscuss::where($where)->where('pic', '<>', 'null')->count('id');
        // 超级满意评价总数
        $star_num5 = GoodsDiscuss::where($where)->where('star', '5')->count('id');
        // 满意评价总数
        $star_num4 = GoodsDiscuss::where($where)->where('star', '4')->count('id');
        // 不怎么样评价总数
        $star_num3 = GoodsDiscuss::where($where)->where('star', '3')->count('id');
        // 不满意评价总数
        $star_num2 = GoodsDiscuss::where($where)->where('star', '2')->count('id');
        // 很失望评价总数
        $star_num1 = GoodsDiscuss::where($where)->where('star', '1')->count('id');

        // 总评分
        $all_score = GoodsDiscuss::where($where)->sum('score');
        if ($all_num && $all_score) {
            // 综合评分
            $avg_score = sprintf('%.2f', $all_score / $all_num);
        }else{
            // 综合评分
            $avg_score = '0';
        }
        if ($all_num) {
            $data = [
                'all_num'      =>$all_num,
                'have_pic_num' => $have_pic_num,
                'star_num5'    => $star_num5,
                'star_num4'    => $star_num4,
                'star_num3'    => $star_num3,
                'star_num2'    => $star_num2,
                'star_num1'    => $star_num1,
                'avg_score'    => $avg_score,
            ];
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无评价');
        }

    }

    /**
     * 反馈类型
     */
    public function getFeedback(){
        $data = Feedback::order('sort desc')->select();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
           return_ajax(400, '暂无数据'); 
        }
    }


}
