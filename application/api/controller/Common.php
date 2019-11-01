<?php
namespace app\api\controller;
use \think\Controller;
use app\common\model\User;
use app\common\model\Banner;
use app\common\model\Code;
use app\common\model\Config;
use app\common\model\UserForm;


class Common extends Controller
{	
    public function _initialize()
    {

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

    //收集form_id
    public function add_form()
    {
        if (request()->isPost()){
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少必传参数uid');}
            if (empty($post['form_id'])) { return_ajax(400,'缺少必传参数form_id');}
            $arr = [
                'uid'   => $post['uid'],
                'form_id'   => $post['form_id']
            ];
            $res = UserForm::create($arr);
            if ($res){
                return_ajax(200,'收集成功');
            }else{
                return_ajax(400,'网络繁忙');
            }
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
    public function getUser($field,$token)
    {
        $user = User::where('token',$token)->field($field)->find();

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
        $list = Banner::field('id,title,pic,sort,url')->order('sort desc')->select();

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
    public function sms()
    {
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

                if($retu['code'] == 103){ return_ajax(400,'请勿频繁发送验证码'); }
                if($retu['code'] == 104){ return_ajax(400,'服务器繁忙，请稍后重试！'); }
                if($retu['code'] == 0){ return_ajax(200,'验证码已发送'); }
            } else {
                return_ajax(400,'验证码发送失败，请重新操作');
            }
        }
    }

    //公共配置信息
   public function config()
   {
       $data = Config::where('id',1)->find();
       return_ajax(200,'获取成功',$data);
   }

    //一键绑定手机号
    public function bindPhone()
    {
        $request = input('post.');

        if (empty($request['iv'])) {
            echo return_ajax(400,'缺少必要参数iv');
        }

        if (empty($request['encryptedData'])) {
            echo return_ajax(400,'缺少必要参数encryptedData');
        }

        if (empty($request['session_key'])) {
            echo return_ajax(400,'缺少必要参数session_key');
        }


        //读取appid和session_key
        $appid = Config::where('id',1)->value('appid');
        $iv = $request['iv'];
        $sessionKey = $request['session_key'];
        $encryptedData = $request['encryptedData'];


        $row = $this->decryptData($appid,$sessionKey,$encryptedData, $iv);

        switch ($row){
            case '-41001':
                $msg = 'encodingAesKey 非法';
                return_ajax(400,$msg);
                break;
            case '-41002':
                $msg = 'iv 格式不正确';
                return_ajax(400,$msg);
                break;
            case '-41003':
                $msg = 'aes 解密失败';
                return_ajax(400,$msg);
                break;
            default:
                return_ajax(200,'解密成功',$row);
                break;
        }


    }

    /**
     * 检验数据的真实性，并且获取解密后的明文.
     * @param $encryptedData string 加密的用户数据
     * @param $iv string 与用户数据一同返回的初始向量
     * @param $data string 解密后的原文
     *
     * @return int 成功0，失败返回对应的错误码
     */
    public function decryptData($appid,$sessionKey,$encryptedData, $iv)
    {
        if (strlen($sessionKey) != 24) {
            return $sessionKey;
        }

        $aesKey=base64_decode($sessionKey);


        if (strlen($iv) != 24) {
            return '-41002';
        }
        $aesIV=base64_decode($iv);

        $aesCipher=base64_decode($encryptedData);

        $result=openssl_decrypt( $aesCipher, "AES-128-CBC", $aesKey, 1, $aesIV);

        $dataObj=json_decode($result);

        if( $dataObj  == NULL )
        {
            return '-41003';
        }
        if( $dataObj->watermark->appid != $appid )
        {
            return '-41003';
        }

        return $dataObj;
    }

}
