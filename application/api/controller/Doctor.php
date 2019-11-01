<?php
namespace app\api\controller;
use app\common\model\Doctor as Dt;
use app\common\model\Goods;
use app\common\model\GoodsComp;
use app\common\model\DoctorWork;
use app\common\model\DoctorLeave;
use app\common\model\Notice;
use app\common\model\DoctorRefer;
use app\common\model\Order;
use app\common\model\User;
use app\common\model\Plan;
use app\common\model\Feedback;
use app\common\model\Sickness;
use app\common\model\DoctorRoyalty;
use app\common\model\GoodsDiscuss;
use think\Db;

Class Doctor extends Dtcommon{

    /**
     * 理疗师信息
     */
    public function getDoctorInfo(){
        $data = Dt::where('id', $this->uid)->find();
        if ($data) {
            $goods = Goods::where('id', $data['goods_id'])->find();
            $data['goods_name'] = $goods['title'];
            $data['address']    = $goods['address'];
            $data['comp']       = GoodsComp::where('id', 'in', $data['comp_id'])->select();
            $data['images']     = explode(',', $data['images']);
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '获取失败');
        }
    }

    /**
     * 自动接单
     */
    public function orderTaking(){
        $post = input('post.');
        if (!$post['status']) {
            return_ajax(400, '缺少参数status');
        }
        $rs = Dt::where('id', $this->uid)->update(['status' => $post['status'], 'update_time' => time()]);
        if ($rs) {
            return_ajax(200, '操作成功');
        }else{
            return_ajax(400, '操作失败');
        }
    }

    /**
     * 获取个人档案
     */
    public function getInfo(){
        $data = Dt::where('id', $this->uid)->find();
        if ($data) {
            $data['images'] = explode(',', $data['images']);
            $data['info']   = DoctorWork::where('doctor_id', $this->uid)->order('start_time desc')->select();
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '获取失败');
        }
    }

    /**
     * 添加/编辑个人档案
     */
    public function editInfo(){
        $post = input('post.');
        if (!$post['work']) {
            return_ajax(400, '请填写工作经验');
        }
        if (!$post['cert']) {
            return_ajax(400, '请上传资质证书');
        }
        if (!$post['images']) {
            return_ajax(400, '请上传个人作品');
        }
        if (!$post['info']) {
            return_ajax(400, '请填写工作经历');
        }

        $post['images'] = implode(',', $post['images']);
        $post['update_time'] = time();

        foreach ($post['info'] as $key => $value) {
            $info[$key]['doctor_id']   = $this->uid;
            $info[$key]['title']       = $value['title'];
            $info[$key]['start_time']  = strtotime($value['start_time']);
            $info[$key]['end_time']    = strtotime($value['end_time']);
            $info[$key]['add_time']    = time();
            $info[$key]['update_time'] = time();
        }

        unset($post['token']);
        unset($post['info']);

        Db::startTrans();// 启动事务

        $rs_dt = Dt::where('id', $this->uid)->update($post);

        $check = DoctorWork::where('doctor_id', $this->uid)->select();
        if ($check) {
            $rs_del  = DoctorWork::where('doctor_id', $this->uid)->delete();
            $rs_work = DoctorWork::insertAll($info);
            if (($rs_dt && $rs_del) && $rs_work) {
                Db::commit();// 提交事务
                return_ajax(200, '操作成功');
            }else{
                Db::rollback();// 回滚事务
                return_ajax(400, '操作失败1');
            }
        }else{
            $rs_work = DoctorWork::insertAll($info);
            if ($rs_dt && $rs_work) {
                Db::commit();// 提交事务
                return_ajax(200, '操作成功');
            }else{
                Db::rollback();// 回滚事务
                return_ajax(400, '操作失败');
            }
        }
    }

    /**
     * 申请/修改 请假
     */
    public function applyLeave(){
        $post = input('post.');
        if (!$post['start_time']) {
            return_ajax(400, '请选择开始时间');
        }
        if (!$post['end_time']) {
            return_ajax(400, '请选择结束时间');
        }
        if (!$post['day']) {
            return_ajax(400, '请填写请假天数');
        }
        if (!$post['type']) {
            return_ajax(400, '请选择请假类型');
        }
        if (!$post['msg']) {
            return_ajax(400, '请输入内容');
        }

        $post['doctor_id'] = $this->uid;
        $post['goods_id']  = Dt::where('id', $this->uid)->value('goods_id');

        $leave = new DoctorLeave;
        // if ($post['id']) {
        //     $rs = $leave->allowField(true)->save($post, ['id'=>$post['id']]);
        // }else{
        //     $rs = $leave->allowField(true)->save($post);
        // }

        $rs = $leave->allowField(true)->save($post);
        
        if ($rs) {
            return_ajax(200, '操作成功');
        }else{
            return_ajax(400, '操作失败');
        }
    }

    /**
     * 请假记录
     */
    public function leaveLst(){
        $data = DoctorLeave::where('doctor_id', $this->uid)->order('id desc')->select();
        if ($data) {
            foreach ($data as $key => &$value) {
                switch ($value['status']) {
                    case '0':
                        $data[$key]['status'] = '未审核';
                        break;
                    case '1':
                        $data[$key]['status'] = '已同意';
                        break;
                    default:
                        $data[$key]['status'] = '已拒绝';
                        break;
                }
            }
            $start = mktime(0,0,0,date('m'),1,date('Y'));
            $end   = mktime(23,59,59,date('m'),date('t'),date('Y'));

            $month_num = DoctorLeave::where('doctor_id', $this->uid)->whereTime('start_time', 'between', [$start, $end])->count('id');

            return_ajax(200, '获取成功', $data, $month_num);
        }else{
            return_ajax(400, '获取失败');
        }
    }

    /**
     * 通知
     */
    public function getNotice(){
        $data = Notice::where('uid', $this->uid)->order('id desc')->select();
        if ($data) {
            foreach ($data as $key => $value) {
                switch ($value['is_read']) {
                    case '1':
                        $data[$key]['is_read'] = '未读';
                        break;
                    
                    default:
                        $data[$key]['is_read'] = '已读';
                        break;
                }
            }
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无通知');
        }
    }

    /**
     * 通知详情
     */
    public function getNoticeDetails(){
        $post = input('post.');
        if (!$post['id']) {
            return_ajax(400, '缺少通知id');
        }
        $data = Notice::where('id', $post['id'])->find();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
           return_ajax(400, '获取失败'); 
        }
    }

    /**
     * 标记通知已读
     */
    public function read(){
        $post = input('post.');
        if (!$post['id']) {
            return_ajax(400, '缺少通知id');
        }
        $rs = Notice::where('id', $post['id'])->update(['is_read' => '2', 'update_time' => time()]);
        if ($rs) {
            return_ajax(200, '操作成功', $rs);
        }else{
           return_ajax(400, '操作失败'); 
        }
    }


    /**
     * 转诊申请
     */
    public function doctorRefer(){
        $post = input('post.');
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

        $post['dotor_id'] = $this->uid;
        $post['goods_id'] = Dt::where('id', $this->uid)->value('goods_id');
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
        $data = DoctorRefer::where('dotor_id', $this->uid)->page($page, '20')->order('id desc')->select();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
           return_ajax(400, '暂无记录'); 
        }
    }


    /**
     * 回头率
     * 月回头率：理疗师个人客户回头率=当月理疗次数/当月天数
     * 整体回头率：理疗师个人的整体回头率=每人出现2次订单的人数/理疗师服务客户的总人数
     */
    public function returnRate(){
        $post = input('post.');
        $page = $post['page'] ? $post['page'] : '1';
        if (!$post['day']) {
            return_ajax(400, '缺少日期');
        }
        $arr_day = explode('-', $post['day']);

        $time = $this->mFristAndLast($arr_day['0'], $arr_day['1']);

        $where['treat_time'] = ['BETWEEN', [$time['firstday'], $time['lastday']]];
        $where['status']     = ['in', [3,4]];
        $where['doctor_id']   = $this->uid;

        $days = date('t', strtotime($post['day']));//当月天数
        $data = Order::with('user')->field('count(id) as nums, uid, status')->where($where)->order('id desc')->group('uid desc')->select();
        if ($data) {
            foreach ($data as $key => &$value) {
                $data[$key]['precent'] = sprintf('%.2f', $value['nums'] / $days) .'%';
            }

            // 总次数
            $allnum = Order::where($where)->count('id');
            // 成功治疗2次以上
            $num = Order::where($where)->having("count(id) >= 2")->group('doctor_id')->count('id');

            if ($allnum && $num) {
                $all_precent = sprintf('%.2f', $num/$allnum) .'%';
            }else{
                $all_precent = '0.00' .'%';
            }

            return_ajax(200, '获取成功', $data, $all_precent);
        }else{
           return_ajax(400, '暂无数据'); 
        }
    }

    /**
     * 订单
     */
    public function order(){
        $post = input('post.');
        $page = $post['page'] ? $post['page'] : '1';
        // if (!$post['doctor_id']) { return_ajax(400, '缺少参数doctor_id'); }

        if ($post['status']) {
            $where['status'] = $post['status'];
        }
        $where['doctor_id'] = $this->uid;

        // $arr['with'] = 'user';
        // $arr['field'] = 'id,uid,add_time';
        // $arr['where']
        // $data = $this->selectAll('order',$arr);
        
        $data = Order::with('user')->where($where)->page($page, '20')->select();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无订单'); 
        }
        
    }

    /**
     * 过号/确认治疗/确认结束
     */
    public function changeStatus(){
        $post = input('post.');
        if (!$post['status']) {
            return_ajax(400, '缺少参数status'); 
        }
        if (!$post['id']) {
            return_ajax(400, '缺少参数id'); 
        }
        $arr = [
            'status' => $post['status'],
            'update_time' => time()
        ];

        $order = Order::where('id', $post['id'])->find();

        if ($post['status'] != '3') {
            if ($post['status'] == '2') {
                // 检查是否还有其他人在治疗中
                $check_status2 = Order::where('doctor_id', $order['doctor_id'])->where('uid', '<>', $order['uid'])->where('status', '2')->find();
                if ($check_status2) {
                    return_ajax(400, '还有人在治疗中，请稍后操作');
                }
                $arr['treat_time'] = time();
            }
            $rs = Order::where('id', $post['id'])->update($arr);
            if ($rs) {
                return_ajax(200, '操作成功', $rs);
            }else{
               return_ajax(400, '操作失败'); 
            }
        }else{
            $arr['form_take_id'] = $post['form_take_id'];
            // 结束治疗 发放提成
            $data = $this->countRoyalty($post['id']);
            if ($data) {
                if ($data['money'] > '0') {
                    Db::startTrans();// 启动事务
                    $rs_roy   = DoctorRoyalty::insert($data);
                    $rs_order = Order::where('id', $post['id'])->update($arr);
                    $rs_doc   = Dt::where('id', $order['doctor_id'])->setInc('surplus', $data['money']);
                    if (($rs_roy && $rs_order) && $rs_doc) {
                        Db::commit();// 提交事务
                        return_ajax(200, '操作成功');
                    }else{
                        Db::rollback();// 回滚事务
                       return_ajax(400, '操作失败'); 
                    }
                }else{
                    Db::startTrans();// 启动事务
                    $rs_roy   = DoctorRoyalty::insert($data);
                    $rs_order = Order::where('id', $post['id'])->update($arr);
                    if ($rs_roy && $rs_order) {
                        Db::commit();// 提交事务
                        return_ajax(200, '操作成功');
                    }else{
                        Db::rollback();// 回滚事务
                       return_ajax(400, '操作失败'); 
                    }
                }
            }else{
                return_ajax(400, '操作失败');
            }
        }
    }

    /**
     * 添加计划方案
     */
    public function addPlan(){
        $post = input('post.');
        if (!$post['doctor_id']) {
            return_ajax(400, '缺少参数doctor_id'); 
        }
        if (!$post['goods_id']) {
            return_ajax(400, '缺少参数goods_id'); 
        }
        if (!$post['uid']) {
            return_ajax(400, '缺少参数uid'); 
        }
        if (!$post['fid']) {
            return_ajax(400, '缺少参数fid'); 
        }
        if (!$post['sid']) {
            return_ajax(400, '缺少参数sid'); 
        }
        if (!$post['name']) {
            return_ajax(400, '请输入理疗师名称'); 
        }
        if (!$post['project']) {
            return_ajax(400, '请输入服务项目'); 
        }
        if (!$post['content']) {
            return_ajax(400, '请输入理疗师方案'); 
        }
        if (!$post['img']) {
            return_ajax(400, '请输入上传图片'); 
        }

        $post['img'] = implode(',', $post['img']);

        $user = User::where('id', $post['uid'])->find();
        $post['nickname'] = $user['nickname'];
        $post['head_img'] = $user['head_img'];
        $post['f_name']   = Feedback::where('id', $post['fid'])->value('name');
        $post['s_name']   = Sickness::where('id', $post['sid'])->value('name');

        $plan = new Plan;

        $rs = $plan->allowField(true)->save($post);

        if ($rs) {
            return_ajax(200, '操作成功', $rs);
        }else{
           return_ajax(400, '操作失败'); 
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

    /**
     * 病痛等级
     */
    public function getSickness(){
        $data = Sickness::where('pid', '0')->order('sort desc')->select();
        if ($data) {
            foreach ($data as $key => &$value) {
                $data[$key]['child'] = Sickness::where('pid', $value['id'])->order('sort desc')->select();
            }
            return_ajax(200, '获取成功', $data);
        }else{
           return_ajax(400, '暂无数据'); 
        }
    }

    /**
     * 提成列表
     */
    public function getRoyalty(){
        $post = input('post.');
        // if (!$post['doctor_id']) {
        //     return_ajax(400, '缺少参数doctor_id'); 
        // }
        if (!$post['day']) {
            return_ajax(400, '缺少参数day'); 
        }
        $start_time = strtotime($post['day']);
        $end_time   = $start_time + '86400';
        $where['status']    = '1';
        $where['doctor_id'] = $this->uid;
        $where['add_time']  = ['between', [$start_time, $end_time]];
        $data = DoctorRoyalty::where($where)->order('id desc')->select();
        if ($data) {
            $map['status']     = ['in', ['3', '4']];
            $map['doctor_id']  = $this->uid;
            $map['treat_time'] = ['between', [$start_time, $end_time]];

            $day_royalty = DoctorRoyalty::where($where)->sum('money');
            $day_num     = Order::where($map)->count('id');
            return_ajax(200, '获取成功', $data, ['day_royalty' => $day_royalty, 'day_num' => $day_num]);
        }else{
            return_ajax(400, '暂无提成');
        }
    }

    /**
     * 基础参数
     */
    public function getBases(){
        $data = $this->getConfig();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无信息');
        }
    }


    public function test(){
        $arr = $this->getWeekMyActionAndEnd('2019-8-31');
        print_r($arr);exit;
    }

    /**
     * 获取个人业绩
     * $time 1本日 2本周 3本月
     */
    public function getAchievement(){
        $post = input('post.');
        // if (!$post['doctor_id']) {
        //     return_ajax(400, '缺少参数doctor_id'); 
        // }
        if (!$post['time']) {
            return_ajax(400, '缺少参数time'); 
        }
        if (!$post['day']) {
            return_ajax(400, '缺少参数day'); 
        }
        switch ($post['time']) {
            case '1':
                $start_time = strtotime($post['day']);
                $end_time   = $start_time + '86400';
                break;
            case '2':
                $time       = $this->getWeekMyActionAndEnd($post['day']);
                $start_time = strtotime($time['week_start']);
                $end_time   = strtotime($time['week_end']) + '86400';
                break;            
            default:
                $arr_day    = explode('-', $post['day']);
                $time       = $this->mFristAndLast($arr_day['0'], $arr_day['1']);
                $start_time = $time['firstday'];
                $end_time   = $time['lastday'];
                break;
        }

        $where['treat_time'] = ['between time', [$start_time, $end_time]];
        $where['status']     = ['in', ['3', '4']];
        $where['doctor_id']  = $this->uid;

        // $config = $this->getConfig();

        $doctor = Dt::where('id', $this->uid)->find();

        $money = Order::where($where)->sum('price');
        switch ($post['time']) {
            case '1':
                if ($doctor['day_money'] > $money) {
                    $need = $doctor['day_money'] - $money;//剩余指标
                    $more = '0';//超标
                }else{
                    $need = '0';//剩余指标
                    $more = $money - $doctor['day_money'];//超标
                }
                $ach_money = $doctor['day_money'];//业绩指标
                break;
            case '2':
                if ($doctor['week_money'] > $money) {
                    $need = $doctor['week_money'] - $money;//剩余指标
                    $more = '0';//超标
                }else{
                    $more = '0';//超标
                    $need = $money - $doctor['week_money'];//剩余指标
                }
                $ach_money = $doctor['week_money'];//业绩指标
                break;            
            default:
                if ($doctor['month_money'] > $money) {
                    $need = $doctor['month_money'] - $money;//剩余指标
                    $more = '0';//超标
                }else{
                    $need = '0';//剩余指标
                    $more = $money - $doctor['month_money'];//超标
                }
                $ach_money = $doctor['month_money'];//业绩指标
                break;
        }

        $arr = [
            'more' => $more,
            'need' => $need,
            'ach_money' => $ach_money,
        ];

        $all_num = Order::where($where)->count('id');//全部项目

        $data = Order::field('comp_id, project, count(id) as num, status, pay_status')->where($where)->group('comp_id')->select();
        if ($data) {
            foreach ($data as $key => &$value) {
                $data[$key]['precent'] = sprintf('%.2f', $value['num'] / $all_num) .'%';
                $data[$key]['desc']    = GoodsComp::where('id', $value['comp_id'])->value('desc');
            }
            return_ajax(200, '获取成功', $data, $arr);
        }else{
            return_ajax(400, '暂无信息');
        }

    }

    /**
     * 获取总业绩 总提成
     */
    public function getRoyAndAch(){
        $post = input('post.');
        $royalty     = DoctorRoyalty::where('doctor_id', $this->uid)->sum('money');
        $achievement = Order::where('doctor_id', $this->uid)->where('status', 'in', '3,4')->sum('price');
        $data = ['royalty' => $royalty, 'achievement' => $achievement];
        if ($royalty || $achievement) {
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无信息');
        }
    }

    /**
     * 获取评价
     */
    public function getDiscuss(){
        $post = input('post.');
        $page = $post['page'] ? $post['page'] : '1';
        if (!$post['day']) {
            return_ajax(400, '缺少参数day'); 
        }
        $start_time = strtotime($post['day']);
        $end_time   = $start_time + '86400';

        $where['is_show']   = '1';
        $where['doctor_id'] = $this->uid;
        $where['add_time']  = ['between time', [$start_time, $end_time]];

        $data = GoodsDiscuss::with('user')->where($where)->order('id desc')->page($page, '20')->select();
        if ($data) {
            return_ajax(200, '获取成功', $data);
        }else{
            return_ajax(400, '暂无评价');
        }
    }





















}