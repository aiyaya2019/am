<?php
namespace app\api\controller;
use \think\Controller;
use \think\Db;
use \think\Cache;
use app\common\model\Order;
use app\api\model\OrderGoods;
use app\common\model\User;
use app\common\model\UserBang;
use app\common\model\UserCoupon;
use app\common\model\Config;
use app\common\model\Goods;
use app\common\model\UserForm;
use app\common\model\FormMsg;

class Weix extends Controller
{
    /* 微信信息控制器 */

    /**
     * [getOpenid 获取用户openid和session_key]
     * @Author   谜一样的男人
     * @DateTime 2019-03-23
     * @return   [type]     [description]
     */
    public function getOpenid()
    {
        if (request()->isPost()) {
            $post = input('post.');
            $config = Config::get(1);

            if (empty($post['code'])) {
                return_ajax(400, '缺少code参数');
            }

            $url = 'https://api.weixin.qq.com/sns/jscode2session?appid=' . $config['appid'] . '&secret=' . $config['appsecret'] . '&js_code=' . $post['code'] . '&grant_type=authorization_code';
            $info = json_decode(curl_get_contents($url), true);

            return_ajax(200, '获取成功', $info);
        }
    }

    public function count()
    {

        $arr = [
            [
                'time'  => date('Y-m-d', strtotime('-1 days')),

            ],
            [
                'time'  => date('Y-m-d', strtotime('-2 days')),
            ],
            [
                'time'  => date('Y-m-d', strtotime('-3 days')),
            ],
            [
                'time'  => date('Y-m-d', strtotime('-4 days')),
            ],
            [
                'time'  => date('Y-m-d', strtotime('-5 days')),
            ],
            [
                'time'  => date('Y-m-d', strtotime('-6 days')),
            ],
            [
                'time'  => date('Y-m-d', strtotime('-7 days')),
            ],

        ];

        $weekarray=array("0","1","2","3","4","5","6");

        foreach ($arr as $k=>$v){
            $arr[$k]['wes'] = $weekarray[date("w",strtotime($v['time']))];
            if ($arr[$k]['wes'] != 0 && $arr[$k]['wes'] != 6){
//                $k = $k+1;
                $arr[$k]['start_time'] = date('Y-m-d 00:00:00', strtotime('-'.$arr[$k]['wes'].' days'));
               
            }
        }

        p($arr);

    }
    /**
     * [update_user 添加、更新用户信息]
     * @Author   PengJun
     * @DateTime 2019-03-23
     * @return   [type]     [description]
     */
    public function update_user()
    {
        if (request()->isPost()) {
            $post = input('post.');
            $user_model = new User;

            if (empty($post['openid'])) {
                return_ajax(400, '缺少用户openid');
            }
            if (empty($post['nickname'])) {
                return_ajax(400, '缺少用户名称');
            }

            $user = User::where('openid', $post['openid'])->find();

            $post['token'] = $this->GetToken($user['openid']);
            $post['nickname'] = emojiEncode($post['nickname']);
            $post['head_img'] = $post['headimgurl'];

            $post['update_time'] = time();

            if ($user) {
                //更新
                if ($user_model->allowField(true)->save($post, ['id' => $user['id']])) {
                    $post['nickname'] = emojiDecode($post['nickname']);
                    $post['id'] = $user['id'];
                    return_ajax(200, '登录成功', $post);
                } else {
                    return_ajax(400, '登录失败，请稍后重试！');
                }
            } else {
                //添加
                $post['add_time'] = time();
                if ($user_model->allowField(true)->save($post)) {
                    $post['nickname'] = emojiDecode($post['nickname']);
                    $user = User::where('openid', $post['openid'])->find();
                    $post['id'] = $user['id'];
                    return_ajax(200, '登录成功', $post);
                } else {
                    return_ajax(400, '登录失败，请稍后重试！');
                }
            }
        }
    }

    /**
     * [GetToken 获取用户token]
     * @Author   PengJun
     * @DateTime 2019-03-23
     */
    public function GetToken($openid)
    {
        $key = 'jigujigu';
        $token = md5(md5($openid) . md5($key) . time());

        $isset = User::get(['token' => $token]);
        if ($isset) {
            $this->GetToken($openid);
        } else {
            return $token;
        }
    }

    /**
     * [pay 获取支付信息]
     * @Author   PengJun
     * @DateTime 2019-04-03
     * @return   [type]     [description]
     */
    public function pay()
    {
        if (request()->isPost()) {
            $post = input('post.');
            if (empty($post['uid'])) {
                return_ajax(400, '缺少用户id');
            }
            if (empty($post['type'])) {
                return_ajax(400, '缺少必传参数type');
            }

            $user = User::get(['id' => $post['uid']]);

            if (empty($user)) {
                return_ajax(400, '用户不存在！');
            }

            if ($post['type'] == 2) {
                //开通bang权益
                $backurl = 'http://' . $_SERVER['SERVER_NAME'] . '/api/Weix/bang';
                $order['price'] = Config::where('id', 1)->value('bang_price');
                $order['order_sn'] = order_sn('user_bang');
                $arr = [
                    'uid' => $post['uid'],
                    'price' => $order['price'],
                    'order_sn' => $order['order_sn'],
                    'start_time' => time(),
                    'end_time' => time()+24*3600*365,
                ];
                UserBang::create($arr);
            } else {
                if (empty($post['order_id'])) {
                    return_ajax(400, '缺少订单ID');
                }
                if (empty($post['form_id'])) {
                    return_ajax(400, '缺少form_id');
                }
                //支付订单
                $backurl = 'http://' . $_SERVER['SERVER_NAME'] . '/api/Weix/wxPayCallback';
                $order = Order::get(['id' => $post['order_id']]);
                if (empty($order)) {
                    return_ajax(400, '订单不存在');
                }

                if (empty($post['coupon_id'])) {
                    $data['jian'] = 0;
                    $price = sprintf('%.2f',$order['total'] - $order['bang_price']);
                } else {
                    $data = UserCoupon::where('id', $post['coupon_id'])->find();
                    if ($data['man'] == 0 || $order['total'] >= $data['man']) {
                        $price = sprintf('%.2f', $order['total'] - $data['jian']-$order['bang_price']);
                    } else {
                        $data['jian'] = 0;
                        $price =  sprintf('%.2f',$order['total'] - $order['bang_price']);
                    }
                }
                Order::where('id',$post['order_id'])->setField('form_pay_id',$post['form_id']);
                Order::where('id', $post['order_id'])->setField('coupon_price', $data['jian']);
                Order::where('id', $post['order_id'])->setField('price', $price);
                $order['price'] = $price;
            }


            $result = $this->wxpay('订单支付', $order['order_sn'], $order['price'], $user['openid'], $backurl);
            $result['order_sn'] = $order['order_sn'];  // 订单号
            $result['money'] = $order['price'];  // 实际支付金额

            return_ajax(200, '获取成功', $result);
        }
    }

    //开通bang权益取消支付回调
    public function delete_bang()
    {
        if (request()->isPost()) {
            $post = input('post.');
            if (empty($post['uid'])) { return_ajax(400,'缺少必传参数uid'); }
            $res =  UserBang::where(['uid'=>$post['uid'],'status'=>0])->delete();
            if ($res) {
                return_ajax(200,'操作成功');
            }else{
                return_ajax(400,'操作失败');
            }
        }
    }

    //支付回调
    public function wxPayCallback()
    {
        $xml = file_get_contents("php://input");
        if (!$xml) {
            echo "非法操作";
            return;
        }

        libxml_disable_entity_loader(true);
        $data = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);

        if ($data['result_code'] == 'SUCCESS' && $data['return_code'] == 'SUCCESS') {

            //查询订单信息

            $order = Order::get(['order_sn'=>$data['out_trade_no']]);
            $id = Order::where('order_sn',$data['out_trade_no'])->value('id');
            $this->send(2,$id);
            $this->send(3,$id);
            if ($order['coupon_id']) {
                UserCoupon::where('id', $order['coupon_id'])->setField('status', 2);
            }


                $order->pay_status = 2;
                $order->pay_time = time();
                $order->save();

                //查询是否是首次消费
                $user = Order::where('uid', $order['uid'])->where(['status'=>3,'pay_status'=>2])->count();
                if ($user > 1) {
                    $top_id = User::where('id', $order['uid'])->value('top_id');
                    if ($top_id != 0) {
                        User::where('id', $top_id)->setInc('money', $data['total_fee']);
                    }
                }

        }
        echo "SUCCESS";
    }


    //开通bang回调
    public function bang()
    {
        $xml = file_get_contents("php://input");
        if (!$xml) {
            echo "非法操作";
            return;
        }
        libxml_disable_entity_loader(true);
        $data = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);

        if ($data['result_code'] == 'SUCCESS' && $data['return_code'] == 'SUCCESS') {
            $res = UserBang::where('order_sn',$data['out_trade_no'])->find();
            UserBang::where('uid',$res['uid'])->where('order_sn != '.$res['order_sn'].'')->delete();
            UserBang::where('order_sn',$data['out_trade_no'])->setField('status',1);

        }
        echo "SUCCESS";
    }

    // 接口微信支付
    public function wxpay($body, $order_no, $money, $openid, $backurl)
    {
        $money = 0.01;    // 上线需删除
        $url = 'https://api.mch.weixin.qq.com/pay/unifiedorder';
        $base = Db::name('config')->field('id,appid,mchid,key')->where('id', 1)->find();

        // 接口所需参数(数组形式)
        $parameter = [
            'appid'            => $base['appid'],//小程序ID
            'mch_id'           => $base['mchid'],//商户号
            'nonce_str'        => getNonceStr(),//随机字符串
            'body'             => $body,//商品描述
            'out_trade_no'     => $order_no,//商户订单号
            'total_fee'        => intval($money * 100),//总金额
            'spbill_create_ip' => $_SERVER['REMOTE_ADDR'],//终端IP
            'notify_url'       => $backurl,//通知地址
            'trade_type'       => 'JSAPI',//交易类型
            'openid'           => $openid, //用户标识
        ];

        $parameter['sign'] = $this->getSign($parameter, $base['key']);
       
        // p($parameter);
        //接口所需参数(数组转XML格式)
        $xmldata = $this->arrayToXml($parameter);
        //初始一个curl会话
        $return = curlPost($url, $xmldata);
        //禁止引用外部xml实体
        libxml_disable_entity_loader(true);
        //先把xml转换为simplexml对象，再把simplexml对象转换成 json，再将 json 转换成数组。
        $return = json_decode(json_encode(simplexml_load_string($return, 'SimpleXMLElement', LIBXML_NOCDATA)), true);
        // return $return;
        if ($return['return_code'] != 'SUCCESS' || $return['result_code'] != 'SUCCESS') {
            return_ajax(400,$return['return_msg']);
        }

        //生成小程序支付签名所需参数
        $parameters = [
            'appId'     => $base['appid'],//小程序ID
            'timeStamp' => '' . time() . '',//时间戳
            'nonceStr'  => getNonceStr(),//随机串
            'package'   => 'prepay_id=' . $return['prepay_id'],//数据包
            'signType'  => 'MD5',//签名方式
        ];
        $parameters['paySign'] = $this->getSign($parameters, $base['key']);
        return $parameters;
    }


    //作用：生成签名
    private function getSign($Obj, $key)
    {
        foreach ($Obj as $k => $v) {
            $Parameters[$k] = $v;
        }
        // 签名步骤一：按字典序排序参数
        ksort($Parameters);
        $String = $this->formatBizQueryParaMap($Parameters, false);
        // 签名步骤二：在string后加入KEY
        $String = $String . "&key=" . $key;

        // 签名步骤三：MD5加密
        $String = md5($String);
        // 签名步骤四：所有字符转为大写
        $result = strtoupper($String);
        return $result;
    }

    /* 以下为微信支付所需要的 */
    private function formatBizQueryParaMap($paraMap, $urlencode)
    {
        $buff = "";
        ksort($paraMap);
        foreach ($paraMap as $k => $v) {
            if ($urlencode) {
                $v = urlencode($v);
            }
            $buff .= $k . "=" . $v . "&";
        }
        $reqPar = '';
        if (strlen($buff) > 0) {
            $reqPar = substr($buff, 0, strlen($buff) - 1);
        }
        return $reqPar;
    }

    //数组转XML格式
    public function arrayToXml($arr)
    {
        $xml = "<xml>";
        foreach ($arr as $key => $val) {
            if (is_array($val)) {
                $xml .= "<" . $key . ">" . $this->arrayToXml($val) . "</" . $key . ">";
            } else {
                $xml .= "<" . $key . ">" . $val . "</" . $key . ">";
            }
        }
        $xml .= "</xml>";
        return $xml;
    }




    public function cancel()
    {

        $this->send(1);

        //删除已使用的form_id
        $form = UserForm::where('status',2)->select();
        if ($form) {
            foreach ($form as $key=>$val){
                UserForm::where('id',$val['id'])->delete();
            }
        }
        $time = time();
        $id = Order::where('status',1)->column('id');
        if (count($id) > 0){
            //取消所有正在排队的订单
            $id = implode(',',$id);
            $data = Goods::where('id in('.$id.')')->select();
            foreach ($data as $k=>$v){
                $data[$k]['c_time'] = date('H:i:s',$data[$k]['end_time']);
                $data[$k]['cc_time'] = date('Y-m-d '.$data[$k]['c_time'].'',time());
                $data[$k]['cancel_time'] = strtotime($data[$k]['cc_time']);
                if ($data[$k]['cancel_time'] < $time){
                    Order::where('goods_id',$v['id'])->setField('status',6);
                }
            }

        }


        $over_id = Order::where('status',5)->column('id');
        if (count($over_id) > 0){
            //清除已过号数据
            $over_id = implode(',',$over_id);
            $data = Goods::where('id in('.$over_id.')')->select();
            foreach ($data as $key=>$val){
                $data[$k]['c_time'] = date('H:i:s',$data[$k]['end_time']);
                $data[$k]['cc_time'] = date('Y-m-d '.$data[$k]['c_time'].'',time());
                $data[$k]['cancel_time'] = strtotime($data[$k]['cc_time']);
                if ($data[$key]['cancel_time'] < $time){
                    Order::where(['goods_id'=>$val['id'],'status'=>5])->delete();
                }
            }
        }


    }

  
    /**
     * [getAccessToken 获取小程序access_token]
     * @Author   谜一样得男人
     * @DateTime 2019-07-26
     * @return   [type]     [description]
     */
    public function getAccessToken()
    {
        $access_token = Cache::get('access_token');
        if (empty($access_token)){
            $config = Config::get(1);
            $url = 'https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid='.$config['appid'].'&secret='.$config['appsecret'];
            $info = json_decode(curl_get_contents($url),true);
            Cache::set('access_token',$info['access_token'],7200);
            $access_token = $info['access_token'];
        }

        return $access_token;
    }

    public function dd()
    {
        $this->send(4,43);
    }

    public function send($type,$id = 0)
    {

        $time = time();
        $access_token = $this->getAccessToken();
        $url = 'https://api.weixin.qq.com/cgi-bin/message/wxopen/template/send?access_token='.$access_token.'';
        if ($type == 1){
            //待支付提醒
            $notice_time = Config::where('id',1)->value('notice_time');
            $order = Order::where(['status'=>3,'pay_status'=>1])->select();
            if ($order){
                $order = collection($order)->toArray();
                foreach ($order as $k=>$v){
                    $order[$k]['add_time2']  = strtotime($order[$k]['treat_time']);
                    $order[$k]['notice_time'] = $order[$k]['add_time2'] + 60*$notice_time;
                    $order[$k]['openid'] = User::where('id',$order[$k]['uid'])->value('openid');
                    if ($time >= $order[$k]['notice_time']){
                        $data = [
                            'touser'    => $order[$k]['openid'],
                            'template_id'    =>  '2DEjMkwB5mf1b3H2CQQMfufwD-VTQQJ8GDbcyWMmxaE',
                            'page'    => 'pages/bill/noconsume/noconsume?state=3',
                            'form_id'    => $order[$k]['form_id'],
                            'data'=>[
                                'keyword1'=>[
                                    'value' => $order[$k]['order_sn']
                                ],
                                'keyword2'=>[
                                    'value' => $order[$k]['total']
                                ],
                                'keyword3'=>[
                                    'value' => '待支付'
                                ],
                                'keyword4'=>[
                                    'value' => $order[$k]['total']
                                ],
                                'keyword5'=>[
                                    'value' => $order[$k]['add_time']
                                ],
                                'keyword6'=>[
                                    'value' => $order[$k]['project']
                                ],
                                'keyword7'=>[
                                    'value' => '已完成'
                                ],
                            ]
                        ];

                    }
                }
            }
        }elseif ($type == 2){
            //付款成功提醒
            $order = Order::where('id',$id)->find();
            $order['openid'] = User::where('id',$order['uid'])->value('openid');
            $data = [
                'touser'    => $order['openid'],
                'template_id'    =>  'ORj-5XMEROCubO26lw1qHJQ2Eb-oQdpJVu1zFdK9pME',
                'page'    => '/pages/bill/detail/detail?id='.$id.'',
                'form_id'    => $order['form_pay_id'],
                'data'=>[
                    'keyword1'=>[
                        'value' => $order['total']
                    ],
                    'keyword2'=>[
                        'value' => $order['goods_name']
                    ],
                    'keyword3'=>[
                        'value' => $order['project']
                    ],
                    'keyword4'=>[
                        'value' => $order['order_sn']
                    ],
                    'keyword5'=>[
                        'value' => $order['add_time']
                    ],
                    'keyword6'=>[
                        'value' => date('Y-m-d H:i',$order['pay_time'])
                    ],
                ]
            ];
        }elseif ($type == 3){
            //服务评价待提醒
            $order = Order::where('id',$id)->find();
            $order['openid'] = User::where('id',$order['uid'])->value('openid');
            $form_id = UserForm::where(['status'=>1,'uid'=>$order['uid']])->value('form_id');
            $data = [
                'touser'    => $order['openid'],
                'template_id'    =>  'df0XGnNevyvE-Jpv62UY7p-mFqFCDiXMYgf-rrN0E1s',
                'page'    => '/pages/bill/detail/detail?id='.$id.'',
                'form_id'    => $form_id,
                'data'=>[
                    'keyword1'=>[
                        'value' => $order['goods_name']
                    ],
                    'keyword2'=>[
                        'value' => $order['name']
                    ],
                    'keyword3'=>[
                        'value' => $order['project']
                    ],
                ]
            ];
            UserForm::where('form_id',$form_id)->setField('status',2);
        }elseif ($type == 4){
            //取号成功提醒
            $order = Order::where('id',$id)->find();
            $order['openid'] = User::where('id',$order['uid'])->value('openid');
            $msg = FormMsg::where('id',1)->value('msg');
            $form_id = UserForm::where(['status'=>1,'uid'=>$order['uid']])->value('form_id');
            $data = [
                'touser'    => $order['openid'],
                'template_id'    =>  't2fkPQ2TYrvCmVUYpt8LVnv5Pzp0uQj3O-yoSyu3niQ',
                'page'    => '/pages/bill/detail/detail?id='.$id.'',
                'form_id'    => $form_id,
                'data'=>[
                    'first'=>[
                        'value' => $msg,
                        'color' => '#f22c2c'
                    ],
                    'keyword1'=>[
                        'value' => $order['goods_name'],
                        
                    ],
                    'keyword2'=>[
                        'value' => $order['number']
                    ],
                    'keyword3'=>[
                        'value' => $order['num']
                    ],
                    'keyword4'=>[
                        'value' => $order['add_time']
                    ],
                ]
            ];
            UserForm::where('form_id',$form_id)->setField('status',2);
        }elseif ($type == 5){
            //排队提醒A
            $order = Order::where('id',$id)->find();
            $order['openid'] = User::where('id',$order['uid'])->value('openid');
            $msg = FormMsg::where('id',2)->value('msg');
            $form_id = UserForm::where(['status'=>1,'uid'=>$order['uid']])->value('form_id');
            $data = [
                'touser'    => $order['openid'],
                'template_id'    =>  '5PbAajleuZ4mBh5mFUEzSSMvmG-HWhTEg20-Qk2v_Js',
                'page'    => '/pages/bill/detail/detail?id='.$id.'',
                'form_id'    =>  $form_id,
                'data'=>[
                    'first'=>[
                        'value' => $msg,
                        'color' => '#f22c2c'
                    ],
                    'keyword1'=>[
                        'value' => $order['goods_name']
                    ],
                    'keyword2'=>[
                        'value' => $order['number']
                    ],
                    'keyword3'=>[
                        'value' => '1人，预计等待'.$order['time'].'分钟（仅供参考）'
                    ],
                ]
            ];
            UserForm::where('form_id',$form_id)->setField('status',2);
        }else{
            //排队提醒B
            $order = Order::where('id',$id)->find();
            $order['openid'] = User::where('id',$order['uid'])->value('openid');
            $msg = FormMsg::where('id',3)->value('msg');
            $form_id = UserForm::where(['status'=>1,'uid'=>$order['uid']])->value('form_id');
            $data = [
                'touser'    => $order['openid'],
                'template_id'    =>  '5PbAajleuZ4mBh5mFUEzSSMvmG-HWhTEg20-Qk2v_Js',
                'page'    => '/pages/bill/detail/detail?id='.$id.'',
                'form_id'    =>  $form_id,
                'data'=>[
                    'first'=>[
                        'value' => $msg,
                        'color' => '#f22c2c'
                    ],
                    'keyword1'=>[
                        'value' => $order['goods_name']
                    ],
                    'keyword2'=>[
                        'value' => $order['number']
                    ],
                    'keyword3'=>[
                        'value' => ''.$order['num'].'人，预计等待'.$order['time'].'分钟（仅供参考）'
                    ],
                ]
            ];
            UserForm::where('form_id',$form_id)->setField('status',2);
        }

        $data = json_encode($data);
        $info = curlPost($url,$data);
//        $info  = json_decode($info,true);

    }
}
