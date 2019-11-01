<?php
namespace app\api\controller;
use \think\Controller;
use app\common\model\User;
use app\common\model\Banner;
use app\common\model\Code;
use app\common\model\Doctor;
use app\common\model\DoctorGrade;

use \think\Session;


class Gdcommon extends Controller{
    public function _initialize(){

    }


    /**
     * [fileUp 文件上传]
     * @Author   PengJun
     * @DateTime 2019-04-12
     * @return   [type]     [description]
     */
    public function fileUp()
    {
    	if(request()->file('file')){
    		$file = imgUpdate('file');
    		if($file['code'] == 400){ return_ajax(400,$file['msg']); }

    		return_ajax(200,'上传成功',$file['data']);
    	}
    }



    /**
     * [selectAll 公共查询方法]
     * @Author   PengJun
     * @DateTime 2019-03-22
     * @return   [type]     [description]
     */
    public function selectAll($model,$data=[])
    {
        $table = model($model);
        $where = [];
        $order = 'add_time desc';
        $field = '*';

        $page = empty($data['page'])?1:$data['page'];
        $count = empty($data['count'])?20:$data['count'];
        $with = empty($data['with'])?[]:$data['with'];
        $ispage = empty($data['ispage'])?true:$data['ispage'];

        if(!empty($data['where'])){
            $where = $data['where'];
        }

        if(!empty($data['order'])){
            $order = $data['order'];
        }

        if(!empty($data['field'])){
            $field = $data['field'];
        }

        if($ispage == true){
            $info = $table->with($with)->where($where)->order($order)->field($field)->page($page,$count)->select();
        } else {
            $info = $table->with($with)->where($where)->order($order)->field($field)->select();
        }

        return $info;
    }

    /**
     * [getFind 查询单条数据]
     * @Author   PengJun
     * @DateTime 2019-04-24
     * @return   [type]     [description]
     */
    public function getFind($model,$data=[])
    {
        $table = model($model);
        $where = [];
        $order = 'add_time desc';
        $field = '*';
        $with = [];

        if(!empty($data['where'])){
            $where = $data['where'];
        }

        if(!empty($data['order'])){
            $order = $data['order'];
        }

        if(!empty($data['field'])){
            $field = $data['field'];
        }

        if(!empty($data['with'])){
            $with = $data['with'];
        }

        if(!is_array($data)){
            $where['id'] = $data;
        }

        $list = $table->with($with)->where($where)->order($order)->field($field)->find();

        return $list;
    }

    /**
     * [save 公共添加/编辑方法]
     * @Author   PengJun
     * @DateTime 2019-03-22
     * @return   [type]     [description]
     */
    public function saves($model,$data,$is_return=false)
    {
        $table = model($model);
        $data['update_time'] = time();
        if(empty($data['id'])){
            //新增
            $data['add_time'] = time();
            if($table->allowField(true)->save($data)){
                if($is_return == true){
                    return $table->id;
                } else {
                    return_ajax(200,'添加成功',$table->id);
                }
            } else {
                if($is_return == true){
                    return false;
                } else {
                    return_ajax(400,'添加失败,请稍后重试');
                }
            }
        } else {
            //编辑
            if($table->allowField(true)->save($data,['id'=>$data['id']])){
                if($is_return == true){
                    return $data['id'];
                } else {
                    return_ajax(200,'编辑成功');
                }
            } else {
                if($is_return == true){
                    return false;
                } else {
                    return_ajax(400,'编辑失败,请稍后重试');
                }
            }
        }
    }

    /**
     * [user_info 获取用户信息]
     * @Author   PengJun
     * @DateTime 2019-04-16
     * @return   [type]     [description]
     */
    public function getUser($field)
    {
        $user = User::where('id',$this->uid)->field('id')->field($field)->find();

        return $user;
    }



    /**
     * [banner 广告图]
     * @Author   PengJun
     * @DateTime 2019-04-27
     * @return   [type]     [description]
     */
    public function banner()
    {
        $list = Banner::field('id,pic,url,url_type')->select();

        return_ajax(200,'获取成功',$list);
    }

    /*
  * 1.纬度1，经度1，纬度2，经度2
  * 2.返回结果是单位是KM。
  * 3.保留一位小数
  */
    function getDistance($lat1,$lng1,$lat2,$lng2)
    {
        //将角度转为狐度
        $radLat1 = deg2rad($lat1);//deg2rad()函数将角度转换为弧度
        $radLat2 = deg2rad($lat2);
        $radLng1 = deg2rad($lng1);
        $radLng2 = deg2rad($lng2);
        $a = $radLat1 - $radLat2;
        $b = $radLng1 - $radLng2;
        $s = 2 * asin(sqrt(pow(sin($a / 2), 2) + cos($radLat1) * cos($radLat2) * pow(sin($b / 2), 2))) * 6371;
        return round($s, 1);
    }

    /**
     * [is_code 验证验证码]
     * @Author   PengJun
     * @DateTime 2018-09-15
     * @return   boolean    [description]
     */
    public function is_code($phone,$code)
    {
        $info = Code::where(['phone'=>$phone,'status'=>1])->find();
        if(!$info){ return_ajax(400,'请先获取验证码'); }
        if($info['end_time'] < time()){ return_ajax(400,'验证码已过期，请重新获取'); }
        if($info['code'] != $code){ return_ajax(400,'验证码错误！'); }

        return true;
    }


    /**
     * [sms 发送手机验证码]
     * @Author   PengJun
     * @DateTime 2018-09-15
     * @return   [type]     [description]
     */
    public function sms(){
        $post = input('post.');
        $sms = new Code;
        if(empty($post['phone'])){ return_ajax(400,'请输入手机号'); }
        if(!isPhone($post['phone'])){ return_ajax(400,'请输入正确的手机号'); }

        $code = rand_number(0,999999);

        $info = Code::get(['phone'=>$post['phone']]);

        if($info){
            $info->add_time = time();
            $info->end_time = time() + (60 * 3);
            $info->status = 1;
            $info->code = $code;
            if($info->save()){
                $retu = sendSMS($post['phone'],$code);
                $retu = json_decode($retu,true);
                if($retu['code'] == 103){ return_ajax(400,'请勿频繁发送验证码'); }
                if($retu['code'] == 104){ return_ajax(400,'服务器繁忙，请稍后重试！'); }
                if($retu['code'] == 0){ return_ajax(200,'验证码已发送'); }
            } else {
                return_ajax(400,'验证码发送失败，请重新操作');
            }
        } else {
            $data = [
                'code'     => $code,
                'phone'    => $post['phone'],
                'add_time' => time(),
                'end_time' => time()+(60*3),
            ];
            if($sms->allowField(true)->save($data)){
                $retu = sendSMS($post['phone'],$code);
                $retu = json_decode($retu,true);
                if($retu['code'] == 103){ return_ajax(400,'请勿频繁发送验证码'); }
                if($retu['code'] == 104){ return_ajax(400,'服务器繁忙，请稍后重试！'); }
                if($retu['code'] == 0){ return_ajax(200,'验证码已发送'); }
            } else {
                return_ajax(400,'验证码发送失败，请重新操作');
            }
        }
    }


    /**
     * 获取指定月份开始结束时间
     */
    public function mFristAndLast($y = "", $m = ""){
        if ($y == "") $y = date("Y");
        if ($m == "") $m = date("m");
        $m = sprintf("%02d", intval($m));
        $y = str_pad(intval($y), 4, "0", STR_PAD_RIGHT);
     
        $m>12 || $m<1 ? $m=1 : $m=$m;
        $firstday = strtotime($y . $m . "01000000");
        $firstdaystr = date("Y-m-01", $firstday);
        $lastday = strtotime(date('Y-m-d 23:59:59', strtotime("$firstdaystr +1 month -1 day")));
     
        return array(
            "firstday" => $firstday,
            "lastday" => $lastday
        );
    }

    /*
     * 获取某星期的开始时间和结束时间
     * date 时间
     * first 表示每周星期一为开始日期 0表示每周日为开始日期
     */
    public function getWeekMyActionAndEnd($date = '', $first = 1){
        //当前日期
        if (!$date) $date = date('Y-m-d', time());
        $sdefaultDate = $date;
        //$first =1 表示每周星期一为开始日期 0表示每周日为开始日期
        //获取当前周的第几天 周日是 0 周一到周六是 1 - 6
        $w = date('w', strtotime($sdefaultDate));
        //获取本周开始日期，如果$w是0，则表示周日，减去 6 天
        $week_start = date('Y-m-d', strtotime("$sdefaultDate -" . ($w ? $w - $first : 6) . ' days'));
        //本周结束日期
        $week_end = date('Y-m-d', strtotime("$week_start +6 days"));
        return array("week_start" => $week_start, "week_end" => $week_end);
    }




}
