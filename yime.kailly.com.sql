/*
Navicat MySQL Data Transfer

Source Server         : 39.108.144.247
Source Server Version : 50557
Source Host           : 39.108.144.247:3306
Source Database       : yime.kailly.com

Target Server Type    : MYSQL
Target Server Version : 50557
File Encoding         : 65001

Date: 2019-11-01 16:34:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for z_access
-- ----------------------------
DROP TABLE IF EXISTS `z_access`;
CREATE TABLE `z_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) NOT NULL COMMENT '权限名称',
  `url` varchar(100) NOT NULL COMMENT '页面URL',
  `parameter` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态 0生效 1无效',
  `pid` int(11) NOT NULL COMMENT '权限分类ID',
  `is_nav` tinyint(1) NOT NULL DEFAULT '2' COMMENT '是否加入菜单 1是 2否',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序 倒序',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限表';

-- ----------------------------
-- Records of z_access
-- ----------------------------
INSERT INTO `z_access` VALUES ('2', '管理员', 'index', '', '0', '2', '1', '9', '1514197382', '1529339312');
INSERT INTO `z_access` VALUES ('3', '角色管理', 'role', '', '0', '2', '1', '8', '1514197392', '1529339333');
INSERT INTO `z_access` VALUES ('4', '权限列表', 'node', '', '0', '2', '1', '7', '1514197402', '1529339338');
INSERT INTO `z_access` VALUES ('29', '添加/编辑角色', 'addrole', '', '0', '2', '2', '6', '1528954933', '1529339351');
INSERT INTO `z_access` VALUES ('46', '配置权限', 'access', '', '0', '2', '2', '0', '1529338363', '1529338363');
INSERT INTO `z_access` VALUES ('47', '删除角色', 'delerole', '', '0', '2', '2', '5', '1529338413', '1529339364');
INSERT INTO `z_access` VALUES ('48', '添加/编辑管理', 'addadmin', '', '0', '2', '2', '0', '1529338540', '1529338577');
INSERT INTO `z_access` VALUES ('49', '激活/冻结管理', 'isstatus', '', '0', '2', '2', '0', '1529338608', '1529338608');
INSERT INTO `z_access` VALUES ('50', '删除管理', 'deleadmin', '', '0', '2', '2', '0', '1529338626', '1529338626');
INSERT INTO `z_access` VALUES ('115', '用户列表', 'index', '', '0', '30', '1', '20', '1553070811', '1553070811');
INSERT INTO `z_access` VALUES ('114', '城市管理', 'type', '', '0', '29', '1', '8', '1553050672', '1554771950');
INSERT INTO `z_access` VALUES ('113', '门店列表', 'index', '', '0', '29', '1', '9', '1552891706', '1552891706');
INSERT INTO `z_access` VALUES ('116', '基础配置', 'index', '', '0', '31', '1', '9', '1554689902', '1554689902');
INSERT INTO `z_access` VALUES ('117', '服务标准', 'service', '', '0', '29', '1', '8', '1554690988', '1554690988');
INSERT INTO `z_access` VALUES ('118', '添加/编辑产品', 'save', '', '0', '29', '2', '7', '1554691004', '1554691004');
INSERT INTO `z_access` VALUES ('119', '订单列表', 'index', '', '0', '32', '1', '9', '1554797177', '1554797177');
INSERT INTO `z_access` VALUES ('120', '优惠券列表', 'index', '', '0', '33', '1', '9', '1554948950', '1554948950');
INSERT INTO `z_access` VALUES ('121', '添加/编辑文章', 'save', '', '0', '32', '2', '8', '1555031929', '1555031929');
INSERT INTO `z_access` VALUES ('122', '评价类型', 'discuss', '', '0', '32', '1', '7', '1555031940', '1555031940');
INSERT INTO `z_access` VALUES ('123', '添加编辑文章标签', 'tag_save', '', '0', '32', '2', '6', '1555031957', '1555031957');
INSERT INTO `z_access` VALUES ('124', '理疗师列表', 'index', '', '0', '34', '1', '9', '1555465926', '1555465926');
INSERT INTO `z_access` VALUES ('125', '信息审核', 'xxxx', '', '0', '34', '2', '8', '1555468011', '1567567106');
INSERT INTO `z_access` VALUES ('126', '请假审核', 'xxxx', '', '0', '34', '2', '7', '1555490582', '1567567102');
INSERT INTO `z_access` VALUES ('127', '取消原因', 'cancel', '', '0', '32', '1', '8', '1555551438', '1555551438');
INSERT INTO `z_access` VALUES ('128', '签到配置', 'sign', '', '0', '31', '2', '8', '1555657550', '1555657550');
INSERT INTO `z_access` VALUES ('129', '活动参与记录', 'record', '', '0', '33', '2', '8', '1555983266', '1555983266');
INSERT INTO `z_access` VALUES ('130', '添加/编辑活动', 'save', '', '0', '33', '2', '8', '1555983278', '1555983290');
INSERT INTO `z_access` VALUES ('131', '添加/编辑榜单', 'save', '', '0', '34', '2', '7', '1555983334', '1555983334');
INSERT INTO `z_access` VALUES ('132', '抽取锦鲤', 'lottery', '', '0', '33', '2', '6', '1555987985', '1555987993');
INSERT INTO `z_access` VALUES ('133', '评论信息', 'discuss', '', '0', '33', '2', '5', '1556004693', '1556004693');
INSERT INTO `z_access` VALUES ('134', '评论信息', 'discuss', '', '0', '32', '2', '6', '1556004706', '1556004706');
INSERT INTO `z_access` VALUES ('135', '广告列表', 'index', '', '0', '35', '1', '9', '1556331474', '1556331474');
INSERT INTO `z_access` VALUES ('136', '热门搜索', 'search', '', '0', '31', '2', '7', '1556333653', '1556333653');
INSERT INTO `z_access` VALUES ('137', '兑换说明', 'exchange', '', '0', '33', '1', '8', '1566144000', '1566144000');
INSERT INTO `z_access` VALUES ('138', '使用说明', 'explain', '', '0', '33', '1', '7', '1566144000', '1566144000');
INSERT INTO `z_access` VALUES ('139', 'BANG权益介绍', 'bang', '', '0', '31', '1', '7', '1566144000', '1566144000');
INSERT INTO `z_access` VALUES ('140', '反馈类型列表', 'feedback', '', '0', '36', '1', '1', '1566970480', '1566970491');
INSERT INTO `z_access` VALUES ('141', '添加/编辑反馈类型', 'feedback_save', '', '0', '36', '2', '2', '1566970512', '1566970512');
INSERT INTO `z_access` VALUES ('142', '删除反馈类型', 'delete_feedback', '', '0', '36', '2', '3', '1566970544', '1566970544');
INSERT INTO `z_access` VALUES ('143', '病痛等级', 'sickness', '', '0', '36', '1', '4', '1566970573', '1566970573');
INSERT INTO `z_access` VALUES ('144', '添加/编辑 病痛等级', 'sickness_save', '', '0', '36', '2', '5', '1566970587', '1566970587');
INSERT INTO `z_access` VALUES ('145', '删除 病痛等级', 'delete_sickness', '', '0', '36', '2', '6', '1566970604', '1566970604');
INSERT INTO `z_access` VALUES ('146', '计划方案列表', 'index', '', '0', '36', '1', '7', '1566970634', '1566970634');
INSERT INTO `z_access` VALUES ('147', '添加/编辑 计划方案', 'save', '', '0', '36', '2', '8', '1566970661', '1566970661');
INSERT INTO `z_access` VALUES ('148', 'bang权益介绍', 'bang', '', '0', '30', '1', '8', '1566974567', '1566974567');
INSERT INTO `z_access` VALUES ('149', '选择理疗师弹窗', 'doctor', '', '0', '34', '1', '8', '1566974567', '1566974567');
INSERT INTO `z_access` VALUES ('150', '排队规则', 'rules', '', '0', '30', '1', '13', '1568168902', '1568168902');
INSERT INTO `z_access` VALUES ('151', '用户协议', 'agree', '', '0', '30', '1', '11', '1568168902', '1568168902');
INSERT INTO `z_access` VALUES ('152', '投诉反馈', 'feedback', '', '0', '30', '1', '19', '1568168902', '1568168902');
INSERT INTO `z_access` VALUES ('153', '接私单弹窗', 'private', '', '0', '30', '1', '12', '1568168902', '1568168902');
INSERT INTO `z_access` VALUES ('154', '反馈类型', 'fdtype', '', '0', '30', '1', '18', '1568168902', '1568168902');
INSERT INTO `z_access` VALUES ('160', '奖励规则', 'reward', '', '0', '30', '1', '9', '1568104234', '1568104234');
INSERT INTO `z_access` VALUES ('156', '邀请好友', 'friend', '', '0', '30', '1', '10', '1568168902', '1568168902');
INSERT INTO `z_access` VALUES ('157', '既往史', 'past', '', '0', '30', '1', '14', '1568190634', '1568190634');
INSERT INTO `z_access` VALUES ('158', '疼痛的时间', 'pain', '', '0', '30', '1', '17', '1568168902', '1568168902');
INSERT INTO `z_access` VALUES ('159', '疼痛的方式', 'pattern', '', '0', '30', '1', '16', '1568168902', '1568168902');
INSERT INTO `z_access` VALUES ('155', '疼痛的位置', 'position', '', '0', '30', '1', '15', '1568168902', '1568168902');

-- ----------------------------
-- Table structure for z_access_role
-- ----------------------------
DROP TABLE IF EXISTS `z_access_role`;
CREATE TABLE `z_access_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `rid` int(11) NOT NULL COMMENT '角色ID',
  `acc_id` int(11) NOT NULL COMMENT '权限ID',
  `addtime` int(11) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='角色权限关系表';

-- ----------------------------
-- Records of z_access_role
-- ----------------------------
INSERT INTO `z_access_role` VALUES ('1', '1', '6', '1514197463');
INSERT INTO `z_access_role` VALUES ('2', '1', '1', '1514198168');
INSERT INTO `z_access_role` VALUES ('4', '1', '7', '1514361292');
INSERT INTO `z_access_role` VALUES ('5', '1', '8', '1514455230');
INSERT INTO `z_access_role` VALUES ('6', '1', '9', '1514455230');
INSERT INTO `z_access_role` VALUES ('7', '1', '10', '1514455230');
INSERT INTO `z_access_role` VALUES ('8', '1', '11', '1514455230');
INSERT INTO `z_access_role` VALUES ('9', '2', '1', '1526385621');
INSERT INTO `z_access_role` VALUES ('25', '5', '2', '1529338677');
INSERT INTO `z_access_role` VALUES ('26', '5', '3', '1529338677');
INSERT INTO `z_access_role` VALUES ('30', '6', '58', '1546409369');
INSERT INTO `z_access_role` VALUES ('31', '6', '59', '1546409369');
INSERT INTO `z_access_role` VALUES ('32', '6', '60', '1546409369');
INSERT INTO `z_access_role` VALUES ('33', '6', '61', '1546409369');
INSERT INTO `z_access_role` VALUES ('34', '6', '62', '1546409369');
INSERT INTO `z_access_role` VALUES ('35', '6', '63', '1546409369');
INSERT INTO `z_access_role` VALUES ('36', '6', '64', '1546409369');
INSERT INTO `z_access_role` VALUES ('37', '6', '65', '1546409369');
INSERT INTO `z_access_role` VALUES ('38', '7', '2', '1567843643');
INSERT INTO `z_access_role` VALUES ('39', '7', '3', '1567843643');
INSERT INTO `z_access_role` VALUES ('40', '7', '4', '1567843643');
INSERT INTO `z_access_role` VALUES ('41', '7', '29', '1567843643');
INSERT INTO `z_access_role` VALUES ('42', '7', '47', '1567843643');
INSERT INTO `z_access_role` VALUES ('43', '7', '46', '1567843643');
INSERT INTO `z_access_role` VALUES ('44', '7', '48', '1567843643');
INSERT INTO `z_access_role` VALUES ('45', '7', '49', '1567843643');
INSERT INTO `z_access_role` VALUES ('46', '7', '50', '1567843643');
INSERT INTO `z_access_role` VALUES ('47', '7', '120', '1567843643');
INSERT INTO `z_access_role` VALUES ('48', '7', '129', '1567843643');
INSERT INTO `z_access_role` VALUES ('49', '7', '137', '1567843643');

-- ----------------------------
-- Table structure for z_access_type
-- ----------------------------
DROP TABLE IF EXISTS `z_access_type`;
CREATE TABLE `z_access_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) NOT NULL COMMENT '控制器名称',
  `url` varchar(50) NOT NULL COMMENT '控制器',
  `icon` varchar(255) NOT NULL DEFAULT '',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序 倒序',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限分类表';

-- ----------------------------
-- Records of z_access_type
-- ----------------------------
INSERT INTO `z_access_type` VALUES ('2', '后台管理', 'admins', 'icon-shezhi', '99', '1514197373', '1531962285');
INSERT INTO `z_access_type` VALUES ('29', '门店管理', 'goods', 'icon-mendianguanli', '9', '1552891675', '1552891692');
INSERT INTO `z_access_type` VALUES ('30', '用户管理', 'user', 'icon-jiaosequnti', '0', '1553070786', '1553070786');
INSERT INTO `z_access_type` VALUES ('31', '网站配置', 'config', 'icon-peizhiguanli', '20', '1554689885', '1554689885');
INSERT INTO `z_access_type` VALUES ('32', '订单管理', 'order', 'icon-text', '0', '1554796922', '1554796922');
INSERT INTO `z_access_type` VALUES ('33', '优惠券管理', 'coupon', 'icon-zhinengyouhua', '8', '1554947712', '1554947712');
INSERT INTO `z_access_type` VALUES ('34', '理疗师管理', 'doctor', 'icon-liebiao', '8', '1555465887', '1555465887');
INSERT INTO `z_access_type` VALUES ('35', '广告管理', 'banner', 'icon-tupian-xianxing', '7', '1556331435', '1556331435');
INSERT INTO `z_access_type` VALUES ('36', '方案管理', 'plans', 'icon-fanganguanli-', '1', '1566970389', '1566970389');

-- ----------------------------
-- Table structure for z_activity
-- ----------------------------
DROP TABLE IF EXISTS `z_activity`;
CREATE TABLE `z_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '封面',
  `desc` text COMMENT '详情',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '关联的商品',
  `start_time` int(11) NOT NULL DEFAULT '0' COMMENT '活动开始时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '活动结束时间',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '活动商品试用装份数',
  `max_num` int(11) NOT NULL DEFAULT '0' COMMENT '活动最大可参与人数',
  `join_num` int(11) NOT NULL DEFAULT '0' COMMENT '已报名参与人数',
  `like` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `scan` int(11) NOT NULL DEFAULT '0' COMMENT '浏览数',
  `discuss` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `keep` int(11) NOT NULL DEFAULT '0' COMMENT '收藏数',
  `is_koi` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开奖 1否 2是',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='活动表';

-- ----------------------------
-- Records of z_activity
-- ----------------------------
INSERT INTO `z_activity` VALUES ('1', '肌肤清洁大作战', '/uploads/20190411/ba0e49f4f7d5f510ae67a66eb5f640ef.jpg', '<p>活动说明：</p><p>1、xxxxxxxxxxxxxxxx</p><p>2、xxxxxxxxxxxxxxxxxxxxx</p><p>3、xxxxxxxx</p><p>4、xxxxxxxxxxxxxxxxxxxxxxxxxxxxx</p>', '2', '1555030800', '1555322400', '30', '100', '0', '0', '0', '0', '0', '2', '1554970897', '1555987918');
INSERT INTO `z_activity` VALUES ('2', '口红的魅力', '/uploads/20190411/df481e1aff3fdec4726b443a8547541a.jpg', '<p>活动说明：</p><p>1、xxxxxxxxxxxxxxx</p><p>2、xxxxxxxxxxxxxxxxxxxxxxxx</p>', '2', '1555034400', '1555581600', '20', '100', '2', '0', '0', '1', '0', '1', '1554972748', '1554972748');

-- ----------------------------
-- Table structure for z_admin
-- ----------------------------
DROP TABLE IF EXISTS `z_admin`;
CREATE TABLE `z_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '管理员名称',
  `admin_user` varchar(50) NOT NULL COMMENT '账号',
  `password` char(32) DEFAULT NULL COMMENT '密码',
  `addtime` int(11) DEFAULT NULL COMMENT '注册时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `forst` int(1) NOT NULL DEFAULT '0' COMMENT '是否冻结 0否 1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of z_admin
-- ----------------------------
INSERT INTO `z_admin` VALUES ('1', '超级管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1514163261', '1526385304', '0');

-- ----------------------------
-- Table structure for z_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `z_admin_role`;
CREATE TABLE `z_admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态 0有效 1无效',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '角色描述',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  `update_time` int(11) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';

-- ----------------------------
-- Records of z_admin_role
-- ----------------------------
INSERT INTO `z_admin_role` VALUES ('7', 'boss', '0', '全权', '1567843598', '1567843598');
INSERT INTO `z_admin_role` VALUES ('8', 'boss', '0', '全权', '1567843620', '1567843620');

-- ----------------------------
-- Table structure for z_admin_roles
-- ----------------------------
DROP TABLE IF EXISTS `z_admin_roles`;
CREATE TABLE `z_admin_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `aid` int(11) NOT NULL COMMENT '管理员ID',
  `rid` int(11) NOT NULL COMMENT '角色ID',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='用户角色关系表';

-- ----------------------------
-- Records of z_admin_roles
-- ----------------------------
INSERT INTO `z_admin_roles` VALUES ('3', '6', '2', '1526384853');
INSERT INTO `z_admin_roles` VALUES ('4', '2', '5', '1528873113');
INSERT INTO `z_admin_roles` VALUES ('7', '9', '6', '1546427140');
INSERT INTO `z_admin_roles` VALUES ('8', '7', '6', '1547003146');
INSERT INTO `z_admin_roles` VALUES ('9', '10', '9', '1570516492');

-- ----------------------------
-- Table structure for z_banner
-- ----------------------------
DROP TABLE IF EXISTS `z_banner`;
CREATE TABLE `z_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '广告标题',
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '图片地址',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '跳转地址',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序 倒序',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告图';

-- ----------------------------
-- Records of z_banner
-- ----------------------------
INSERT INTO `z_banner` VALUES ('1', '邀请好友送代金券', '/uploads/20190917/2ebe64fdbfcac816813cf2bfe70a2ab5.png', '/pages/my/frend/frend', '2', '1556333417', '1568788189');
INSERT INTO `z_banner` VALUES ('2', '按摩小程序上线啦！！！！！！！！！', '/uploads/20190907/98e77716d68423138aef57d9a74213e8.png', '', '1', '1567841753', '1567841763');

-- ----------------------------
-- Table structure for z_check
-- ----------------------------
DROP TABLE IF EXISTS `z_check`;
CREATE TABLE `z_check` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `day` int(11) NOT NULL DEFAULT '0' COMMENT '天数',
  `point` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='连续签到设置';

-- ----------------------------
-- Records of z_check
-- ----------------------------
INSERT INTO `z_check` VALUES ('1', '7', '10', '1555554371', '1555554371');
INSERT INTO `z_check` VALUES ('2', '12', '20', '1555657877', '1555657877');

-- ----------------------------
-- Table structure for z_code
-- ----------------------------
DROP TABLE IF EXISTS `z_code`;
CREATE TABLE `z_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` int(11) NOT NULL DEFAULT '0' COMMENT '验证码',
  `phone` char(11) NOT NULL DEFAULT '' COMMENT '手机号',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '发送时间',
  `end_time` int(11) NOT NULL DEFAULT '0' COMMENT '过期时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1待使用 2已使用',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='验证码表';

-- ----------------------------
-- Records of z_code
-- ----------------------------
INSERT INTO `z_code` VALUES ('1', '727323', '16620183944', '1567697797', '1567697977', '1', '1567697797');
INSERT INTO `z_code` VALUES ('2', '833674', '18825105253', '1567697648', '1567697828', '1', '1567697648');
INSERT INTO `z_code` VALUES ('3', '737873', '13129087405', '1568627197', '1568627377', '1', '1568627197');
INSERT INTO `z_code` VALUES ('4', '685948', '15007517166', '1567739271', '1567739451', '1', '1567739271');
INSERT INTO `z_code` VALUES ('5', '805250', '13312875877', '1567772361', '1567772541', '1', '1567772361');
INSERT INTO `z_code` VALUES ('6', '653609', '13724158053', '1568016399', '1568016579', '1', '1568016399');
INSERT INTO `z_code` VALUES ('7', '349373', '13212908705', '1568627178', '1568627358', '1', '1568627178');
INSERT INTO `z_code` VALUES ('8', '614597', '18124901487', '1569655749', '1569655929', '1', '1569655749');
INSERT INTO `z_code` VALUES ('9', '66174', '15310618120', '1569747710', '1569747890', '1', '1569747710');
INSERT INTO `z_code` VALUES ('10', '604127', '13360502899', '1570588195', '1570588375', '1', '1570588195');

-- ----------------------------
-- Table structure for z_config
-- ----------------------------
DROP TABLE IF EXISTS `z_config`;
CREATE TABLE `z_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_tel` varchar(155) NOT NULL DEFAULT '' COMMENT '客服电话',
  `friend_title` varchar(255) NOT NULL DEFAULT '' COMMENT '邀请好友页面标题',
  `friend_video` varchar(255) NOT NULL DEFAULT '' COMMENT '邀请好友页面视频',
  `friend_pic` varchar(255) NOT NULL DEFAULT '' COMMENT '邀请好友页面图片',
  `doctor_title` varchar(255) NOT NULL DEFAULT '' COMMENT '选择理疗师弹窗标题',
  `doctor_desc` text NOT NULL COMMENT '选择理疗师弹窗内容',
  `rules` text NOT NULL COMMENT '排队规则',
  `private_list` text NOT NULL COMMENT '接私单弹窗内容',
  `base_money` varchar(30) NOT NULL DEFAULT '' COMMENT '基础指标/元',
  `day_money` varchar(30) NOT NULL DEFAULT '' COMMENT '日指标/元',
  `week_money` varchar(30) NOT NULL DEFAULT '' COMMENT '周指标/元',
  `month_money` varchar(30) NOT NULL DEFAULT '' COMMENT '月指标/元',
  `royalty_precent` varchar(30) NOT NULL DEFAULT '' COMMENT '提成比例',
  `royalty_rule` varchar(255) NOT NULL DEFAULT '' COMMENT '提成规则',
  `satisfaction` varchar(30) NOT NULL DEFAULT '' COMMENT '满意度',
  `order_num` int(11) NOT NULL DEFAULT '0' COMMENT '工单量',
  `return_rate` varchar(10) NOT NULL DEFAULT '' COMMENT '回头率',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '网站标题',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '网站logo',
  `appid` varchar(100) NOT NULL DEFAULT '' COMMENT '微信APPID',
  `appsecret` varchar(255) NOT NULL DEFAULT '' COMMENT 'appsecret',
  `key` varchar(255) NOT NULL DEFAULT '' COMMENT '微信支付key',
  `mchid` int(11) NOT NULL DEFAULT '0' COMMENT '商户号',
  `work_time` varchar(255) NOT NULL COMMENT '门店地址',
  `check_point` int(11) NOT NULL DEFAULT '0' COMMENT '签到获取积分',
  `upgrade_point` int(11) NOT NULL DEFAULT '0' COMMENT '每次升级所需积分',
  `today_topic` varchar(255) NOT NULL DEFAULT '' COMMENT '今日话题',
  `friend_money` decimal(10,0) DEFAULT '0',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `man` decimal(10,0) DEFAULT '0',
  `jian` decimal(10,0) DEFAULT '0',
  `new_coupon` int(10) DEFAULT '0' COMMENT '新人优惠券金额',
  `is_status` tinyint(1) DEFAULT '1' COMMENT '1:开启新人优惠券2不开启',
  `bang_price` decimal(10,2) DEFAULT '0.00' COMMENT 'bang权益开通价格',
  `bang_zhe` varchar(100) DEFAULT '0',
  `day` int(10) DEFAULT '0' COMMENT '新人优惠券有效天数',
  `start_time` int(10) DEFAULT '0' COMMENT '客服工作时间',
  `end_time` int(10) DEFAULT NULL,
  `service_name` varchar(255) DEFAULT '' COMMENT '客服名称',
  `coupon_exchange` text COMMENT '优惠券兑换说明',
  `coupon_explain` text COMMENT '优惠券使用说明',
  `bang` text COMMENT 'bang权益介绍',
  `reward` text COMMENT '奖励规则',
  `user_agree` text COMMENT '用户协议',
  `notice_time` int(10) DEFAULT '0' COMMENT '待支付通知时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='配置表';

-- ----------------------------
-- Records of z_config
-- ----------------------------
INSERT INTO `z_config` VALUES ('1', '020-84131620', '开启咖啡新模式', '/uploads/20190911/1671a6abb7936ba1aee88f12d4b0682c.mp4', '/uploads/20190911/963e13883ed8f1fb69e55e956ee367e1.jpg', '专业标准服务 实惠亲民价格', '<p>1、流程自动，标准服务</p><p>2、优化空间，亲民价格</p><p>3、人机结合，专业呵护</p><p>4、联网运营，个性管理</p>', '<p>1、请提前到店等候</p><p>2、如叫号超过3分钟，你的排队将进行延后处理</p><p>3、等待时间仅供参考</p>', '<p>接私单治疗师未通过医么公众号/小程序为您服务，私自接单的行为。一经核实，将提供奖励2000元。</p>', '20', '10', '70', '300', '0.5', '提成规则', '80', '100', '80', '医么小程序', '/uploads/20191025/fa61e556d39926f0e56155a2b2e5cd5f.jpg', 'wxa98ef6e84c776ce2', 'da9001e4c844b05e04019581ba243fbe', '2fas225121251524125asdasadaasfsa', '1556972661', '广州市天河区车陂南', '5', '200', '#今日美妆课堂', '3', '1551341451', '1571969363', '30', '5', '10', '1', '19.90', '9', '90', '1571965200', '1572008400', '小帮', '<p style=\"margin: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-sizing: content-box; color: rgb(102, 102, 102); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;\">1、大众点评、口碑团购券兑换后仅支持在本门店使用，请您确认好门店后核销</p><p style=\"margin: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-sizing: content-box; color: rgb(102, 102, 102); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;\">2、输入兑换码，点击确认即可兑换医么体验券</p><p style=\"margin: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-sizing: content-box; color: rgb(102, 102, 102); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;\">3、支持医么自有兑换码、大众点评团购、口碑兑换码</p>', '<p style=\"margin: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-sizing: content-box; color: rgb(102, 102, 102); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;\">1：如何获得优惠券</p><p style=\"margin: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-sizing: content-box; color: rgb(102, 102, 102); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;\">通过抢微信好友分享的优惠券、参与医么推出的活动</p><p style=\"margin: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-sizing: content-box; color: rgb(102, 102, 102); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;\">2：如何使用优惠券</p><p style=\"margin: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-sizing: content-box; color: rgb(102, 102, 102); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;\">优惠券仅支持在线支付使用，每个订单只能使用一张优惠券</p><p style=\"margin: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-sizing: content-box; color: rgb(102, 102, 102); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;\">3：优惠券什么时候生效？什么时候到期</p><p style=\"margin: 0px; padding: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0); box-sizing: content-box; color: rgb(102, 102, 102); font-family: &quot;Helvetica Neue&quot;, Helvetica, &quot;PingFang SC&quot;, Tahoma, Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;\">优惠券生效时间内，皆为有效</p>', '<p>超级权益</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 1、理疗9折起全年不限次数<br></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 2、在中心店享受更多优惠<br></p>', '<p>1、当好友打开邀请链接，好友可领取10元优惠券</p><p>2、当好友完成首次理疗体验后，你将收到奖励10元</p><p>3、邀请好友的次数无上限</p><p>4、优惠券不可叠加使用</p>', '<p style=\"text-align: center;\">《百可帮BANG权益用户服务协议》</p><p>重要提示:</p><p>欢迎您使用百可帮BANG权益服务!</p><p>为了保障您的权益，请在使用百可帮BANG权益服务(简称为:本服务)之前，详细阅读《百可帮BANG权益用户服务协议》(简称为: 本协议)所有内容，未成年人则应在法定监护人陪同下阅读。</p><p>除非您已阅读并接受本协议所有条款，否则您无权使用本服务。当您点击“开通并支付”按钮或其他类型含义的按钮时，即表示您同意并签署了本协议，同意遵守本协议的所有约定。</p><p><b>第一条定义</b></p><p>1、BANG权益:指广州天瑞医疗器械邮箱公司的百可帮平台(简称为:本平台)为您提供的按摩服务，您在开通BANG权益后，可以依本协议享有一定的权益优惠或参加活动，具体服务内容以百可帮提供的为准。BANG权益的所有权和运营权，以及BANG权益制度和活动的制订权均归本平台所有，本平台在法律规定的范围内拥有解释权。</p><p>2、“用户”或“您”:指享受本平台提供的BANG权益服务的消费者个人。</p><p><b>第二条</b><b>BANG权益</b><b>服务内容</b></p><p>如您希望使用本服务，可以在开通服务界面中，通过本平台认可的支付方式完成支付，来开通本服务。您在开通服务时，应仔细核对帐号名称、开通服务类型与时长等具体信息。如因您个人原因造成充错帐号、开通错服务或时长，本平台不予退还已收取的费用。</p><p>2、您成功申请开通本服务后，依本协议可享受多项专属权益和服务，详细内容请以本平台的本服务内容为准。</p><p>3、本平台有权在必要时通过在网页上发出公告等合理方式修改本条款。您在使用本服务时，应当及时查阅了解修改的内容，并自觉遵守本服务协议的相关内容。若您继续使用本服务，则视为对修改内容的同意，当发生有关争议时，以最新的服务协议为准;您在不同意修改内容的情况下，有权停止使用本服务协议涉及的服务。</p><p>4、本服务有效期为365天，自用户付款之日起计算。本服务一经开通，服务有效期内不得取消，服务有效期届满后，BANG权益服务资格自动失效。若您中途因违反本协议及相关规则被本平台终止BANG权益服务资格，您为开通本服务而支付的费用将不予退还。</p><p><b>&nbsp;第三条</b><b>&nbsp;</b><b>BANG权益</b><b>使用规范</b></p><p>&nbsp;1、在申请开通和使用本服务过程中，您应当是具备完全民事权利能力和完全民事行为能力的自然人、法人或其他组织，有能力对您使用本服务的一切行为独立承担责任。若您不具备前述主体资格，则须在监护人的监护参与下参与体验本服务。</p><p>2、您理解并保证，本服务仅限本人使用，您不得以任何形式将其享有的本服务借予他人使用，不得以任何形式转让其享有的本服务，不得利用本服务获取非法利益。本平台有合理理由怀疑您存在前述行为的，有权取消您的BANG权益服务资格。若您因前述行为给本平台造成损失的，本平台保留向您追偿的权利。</p><p>3、您知悉并同意，本平台有权通过邮件、短信、电话或其他通讯形式，向其发送相关活动信息。</p><p>4、在已开通的BANG权益有效期内，若您中途主动取消或终止BANG权益资格的，将不会退还开通本服务而支付的费用。</p><p>5、如您实施了下列行为之一，本平台有完全的权利在不通知您的情况下，终止提供本服务，并有权限制、冻结或终止与本服务相关联的百可帮帐号使用。本平台无须给予任何补偿和退费，由此产生的责任由您自行独立承担。因此给本平台或第三方造成损失的，您应负责全额赔偿:</p><p>(1)以营利为目的为自己或他人获得本服务;</p><p>(2)将享有BANG权益服务的帐号以出租、出借、出售等任何形式提供给第三方使用;</p><p>(3)将通过本服务获得的任何内容用于BANG权益服务之外的用途;</p><p>(4)盗用他人百可帮帐号进行BANG权益开通或使用;</p><p>(5)以任何机器人软件、蜘蛛软件、爬虫软件、刷屏软件或其它非正规方式获得本服务;</p><p>(6)通过不正当手段或以违反诚实信用原则的行为获得本服务;</p><p>(7)您未经本平台允许，开展未经本平台同意的行为，包括但不限于对通过百可帮获得的信息进行商业化活动，如附加广告、商业内容或链接等;</p><p>(8)您利用BANG权益进行任何违法行为。</p><p><b>第四条</b><b>&nbsp;</b><b>责任声明</b></p><p>1、您须对您自身及您所邀请的宾客在参加本平台组织的活动或使用由本平台提供的各项优惠及增值服务时的实施的一切行为承担全部法律责任。</p><p>2、本平台不对您因第三方的行为或不作为造成的损失、不可抗力原因造，成的损失承担任何责任，包括但不限于支付服务、网络接入服务、电信部门的通讯线路故障、通讯技术问题、网络、电脑故障、系统不稳定性、任意第三方的侵权行为等。</p><p>3、本平台根据自身商业决策、政府行为、不可抗力等原因可能会选择中止、中断及终止本服务。如有此等情形发生，本平台会采取公告的形式通知您，但不承担由此对您造成的任何损失且不退还开通本服务而支付的费用。</p><p>4、本平台不行使、未能及时行使或者未充分行使本协议或者按照法律规定所享有的权利，不应被视为放弃该权利，也不影响本平台在将来行使该权利。</p><p>5、本协议适用中华人民共和国的法律，并且排除一切冲突法规定的适用。如出现纠纷，您和本平台一致同意将纠纷提交中国国际经济贸易仲裁委员会根据其现行有效的仲裁规则进行仲裁。仲裁裁决是终局的，对双方都有约束力。仲裁费用由败诉一方承担。</p><p>广州天瑞医疗器械有限公司</p>', '2');

-- ----------------------------
-- Table structure for z_coupon
-- ----------------------------
DROP TABLE IF EXISTS `z_coupon`;
CREATE TABLE `z_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '条件金额',
  `less_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '折扣金额',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型 1是所有门店 2指定门店 ',
  `service` tinyint(1) DEFAULT '1' COMMENT '1:所有服务2:指定服务',
  `goods_id` varchar(255) NOT NULL DEFAULT '0' COMMENT '0所有门店其他逗号拼接则为门店id',
  `comp_id` varchar(255) DEFAULT '0' COMMENT '0所有服务其他逗号拼接则为服务id',
  `day` int(11) NOT NULL DEFAULT '0' COMMENT '领取后的有效天数',
  `num` int(10) DEFAULT '0' COMMENT '发放数量',
  `set_num` int(11) NOT NULL DEFAULT '0' COMMENT '已领取数',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '发放时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='优惠劵';

-- ----------------------------
-- Records of z_coupon
-- ----------------------------
INSERT INTO `z_coupon` VALUES ('1', '30.00', '5.00', '1', '1', '0', '0', '3', '4', '0', '1566205342', '1566205342');
INSERT INTO `z_coupon` VALUES ('2', '100.00', '10.00', '2', '2', '1,2', '6,7', '5', '10', '0', '1566205363', '1566205363');
INSERT INTO `z_coupon` VALUES ('3', '200.00', '20.00', '2', '2', '1,4', '4,7', '4', '5', '1', '1566205383', '1566205383');
INSERT INTO `z_coupon` VALUES ('4', '500.00', '50.00', '2', '1', '1,2,3', '0', '8', '2', '0', '1567670792', '1567670792');
INSERT INTO `z_coupon` VALUES ('5', '80.00', '8.00', '2', '2', '7', '10', '1', '5', '1', '1567841104', '1567841104');

-- ----------------------------
-- Table structure for z_coupon_code
-- ----------------------------
DROP TABLE IF EXISTS `z_coupon_code`;
CREATE TABLE `z_coupon_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` int(10) DEFAULT '0' COMMENT '优惠券id',
  `code` varchar(255) DEFAULT '' COMMENT '券码',
  `status` tinyint(1) DEFAULT '1' COMMENT '1未兑换2已兑换',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='优惠券兑换码';

-- ----------------------------
-- Records of z_coupon_code
-- ----------------------------
INSERT INTO `z_coupon_code` VALUES ('1', '1', 'o2wu5zo7x4cs0zdbjqu597ul27cas44o', '1', '1566205342', '1566205342');
INSERT INTO `z_coupon_code` VALUES ('2', '1', 'rtyfbnpuwzktxqzl1736g911nasehf8j', '1', '1566205342', '1566205342');
INSERT INTO `z_coupon_code` VALUES ('3', '1', '2m7i14htqq9sr47yqgnmzvwzqb0yvkh3', '1', '1566205342', '1566205342');
INSERT INTO `z_coupon_code` VALUES ('4', '1', 'ubms1y9brgy55gky1t9ahced739s4url', '1', '1566205342', '1566205342');
INSERT INTO `z_coupon_code` VALUES ('5', '2', 'nragt3llu178cxl06m5akbr3grdpadmm', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('6', '2', 'kmcc8qoqft2uvob8jwrzwn77jsn5jdnk', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('7', '2', 'as2r1ylh1eau8nfdgz4tqcgyay837ff4', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('8', '2', '49ezvq40bgd87cfgn9u8irmjigqzgbke', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('9', '2', '7oyu0dv3idu1epaiivmptocepfqb2fti', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('10', '2', 'qkq9rdkb0k8qfxk41vgij418v2tbx8lo', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('11', '2', 'rhqjesff6502odu5a2pdze3n5vmbtddh', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('12', '2', 'hcv1m1gx1vd6mtrte2tryi3iixq5g00e', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('13', '2', '3zzfsibvhqka14wb0uea7kx54fpodn9r', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('14', '2', 'ale1n74uu16pwimgucsfxu2jnaq7vsoj', '1', '1566205363', '1566205363');
INSERT INTO `z_coupon_code` VALUES ('15', '3', 'bzzrmiia459facrrnoi68ht87z7gv2ht', '2', '1566205383', '1566205383');
INSERT INTO `z_coupon_code` VALUES ('16', '3', 'kkc3f019ho3u9q5lqypi08pahcsq3bz9', '1', '1566205383', '1566205383');
INSERT INTO `z_coupon_code` VALUES ('17', '3', 'gh0wdp26y5fdmd9n44b8pc4nap30s3pq', '1', '1566205383', '1566205383');
INSERT INTO `z_coupon_code` VALUES ('18', '3', 'onsevjicq9fynu5tvxy9nzgr3vsiqcsm', '1', '1566205383', '1566205383');
INSERT INTO `z_coupon_code` VALUES ('19', '3', 'k1e4nexf8repdgkyitbp1sghtk6m56x3', '1', '1566205383', '1566205383');
INSERT INTO `z_coupon_code` VALUES ('20', '4', '14c2u5pyymmxsr4i3ofdzm8vf070qiz7', '1', '1567670792', '1567670792');
INSERT INTO `z_coupon_code` VALUES ('21', '4', 'h8qgw5j9pndqm6f2j4wkmpdsktu3r9ns', '1', '1567670792', '1567670792');
INSERT INTO `z_coupon_code` VALUES ('22', '5', '456002', '2', '1567841104', '1567841104');
INSERT INTO `z_coupon_code` VALUES ('23', '5', 'zqkp8aiuxxo0bl6ia2er2o2ysbrrgp5e', '1', '1567841104', '1567841104');
INSERT INTO `z_coupon_code` VALUES ('24', '5', '3d1z792kbvesdvh0g5qsq878a9zagypv', '1', '1567841104', '1567841104');
INSERT INTO `z_coupon_code` VALUES ('25', '5', 'y1etdk5lciu86pibr5h0rwpjh4qqz7uh', '1', '1567841104', '1567841104');
INSERT INTO `z_coupon_code` VALUES ('26', '5', 'wa4r8qoakwm938ufs8p36s102yrjwjpl', '1', '1567841104', '1567841104');

-- ----------------------------
-- Table structure for z_doctor
-- ----------------------------
DROP TABLE IF EXISTS `z_doctor`;
CREATE TABLE `z_doctor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) DEFAULT '0' COMMENT '门店id',
  `comp_id` varchar(255) DEFAULT '0' COMMENT '服务id',
  `name` varchar(255) DEFAULT '' COMMENT '理疗师名称',
  `pic` varchar(255) DEFAULT '' COMMENT '理疗师头像',
  `grade_id` int(11) DEFAULT '0' COMMENT '等级id',
  `grade_name` varchar(255) DEFAULT '' COMMENT '理疗师等级名称',
  `work` varchar(100) DEFAULT '0' COMMENT '理疗师工作经验',
  `price` varchar(100) DEFAULT '0' COMMENT '理疗师底薪',
  `token` varchar(255) DEFAULT '' COMMENT 'token',
  `zhi` varchar(100) DEFAULT '0' COMMENT '理疗值',
  `phone` char(11) DEFAULT '' COMMENT '手机号',
  `status` tinyint(1) DEFAULT '1' COMMENT '1正常工作2休息中',
  `cert` varchar(255) DEFAULT '' COMMENT '资质证书',
  `password` varchar(255) DEFAULT '' COMMENT '密码',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  `images` text COMMENT '个人作品',
  `score` decimal(10,2) DEFAULT '0.00' COMMENT '评分',
  `discuss` int(11) DEFAULT '0' COMMENT '评论数',
  `entry_day` varchar(20) DEFAULT NULL COMMENT '入职日期',
  `base_money` varchar(30) DEFAULT NULL COMMENT '基础指标/元',
  `day_money` varchar(30) DEFAULT NULL COMMENT '日指标/元',
  `week_money` varchar(30) DEFAULT NULL COMMENT '周指标/元',
  `month_money` varchar(30) DEFAULT NULL COMMENT '月指标/元',
  `royalty_precent` varchar(30) DEFAULT NULL COMMENT '提成比例',
  `satisfaction` varchar(30) DEFAULT NULL COMMENT '满意度',
  `order_num` varchar(30) DEFAULT NULL COMMENT '工单量',
  `return_rate` varchar(300) DEFAULT NULL COMMENT '回头率',
  `is_global` tinyint(1) DEFAULT '1' COMMENT '1使用全局统计；2个人统计',
  `surplus` decimal(10,2) DEFAULT '0.00' COMMENT '余额',
  `level` int(11) DEFAULT '0' COMMENT '等级id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='理疗师';

-- ----------------------------
-- Records of z_doctor
-- ----------------------------
INSERT INTO `z_doctor` VALUES ('1', '5', '1,2,3', 'kaili', '/uploads/20190820/c80331f7eccab8d74cfa3a4e7024f40b.jpg', '1', 'v1', '5年', '6.5k', '31096f52a4719e178c9351b797065eb5', '80', '13111111111', '1', '/uploads/20190829/975ea1c58f3b658319f0e1808d6aeed9.png', 'c3b831951baf129b6aaf94e24a278265', '1566289281', '1568715463', '/uploads/20190830/1e93cdc378288b634d6d2d1e953c66a8.jpg', '4.00', '5', '2019-09-04', '20', '10', '70', '300', '0.5', '8', '200', '80', '2', '0.17', '0');
INSERT INTO `z_doctor` VALUES ('2', '4', '4', '杨幂', '/uploads/20190820/757766285708a3760c8573f4787cf45b.jpg', '1', 'v3', '理疗经验', '7k', '845275f43f2d28f71337c5920a6a4dd2', '70', '18503623932', '2', '资质证书img', 'e10adc3949ba59abbe56e057f20f883e', '1566291301', '1566889074', 'img1,img2', '0.00', '0', null, '20', '10', '70', '300', '0.5', '8', '200', '80', '1', '0.00', '0');
INSERT INTO `z_doctor` VALUES ('3', '2', '6', '刘亦菲', '/uploads/20190820/ad1d4dded31473bb8a79a8b36dda9860.jpg', '1', 'v4', '8年', '8k', '3efd9807718373c2dd451057eb37b45a', '90', '17452360236', '1', '', 'df91adef3117e0523443f487251f3ff9', '1566291352', '1566292062', null, '4.00', '3', null, '20', '10', '70', '300', '0.5', '8', '200', '80', '1', '0.00', '0');
INSERT INTO `z_doctor` VALUES ('4', '3', '5', '月月', '/uploads/20190820/125b64d83a65f89842659acb591d99c2.jpg', '1', 'v1', '3年', '9k', '0fd236d12288ca181139540ef07ba0a0', '86', '13122222222', '1', '', '825dcce76b2c1ab4ce6d25a751c49c60', '1566291418', '1568683378', null, '3.00', '1', '2019-09-17', '20', '10', '70', '300', '0.5', '8', '200', '80', '2', '0.00', '0');
INSERT INTO `z_doctor` VALUES ('5', '1', '7', '景甜', '/uploads/20190820/f358d9f8bf8588b0f3c9aa41290ca68d.jpg', '1', 'v1', '4年', '8k', '892e4ed0f7dc3680cc664e7af6dc61e7', '99', '18452365023', '1', '/uploads/20190912/5bc0c8ea0ac5d4dba4aebd6bdb2242b5.png', 'e10adc3949ba59abbe56e057f20f883e', '1566291481', '1568260931', '/uploads/20190912/ed865458a7db53ef475e262a7e3dc49e.jpg,/uploads/20190830/1e93cdc378288b634d6d2d1e953c66a8.jpg', '5.00', '1', '', '20', '10', '70', '300', '0.5', '8', '200', '80', '2', '0.20', '0');
INSERT INTO `z_doctor` VALUES ('6', '5', '1,2,3', '伊素婉', '/uploads/20190820/8f15deddce6a9b956ac740a108a078bc.jpg', '1', 'v1', '7年', '7k', '8bee29faa34e57742f4a9d6c2a8d3fe3', '85', '18420365236', '1', '/uploads/20190925/fbe66b19df4a52d20beff48a4395b901.jpg', 'e10adc3949ba59abbe56e057f20f883e', '1566293949', '1572073097', '/uploads/20190925/22f8420d7faca5aeb8ae95b3a10c68c3.jpg,/uploads/20190925/ba058acc405888de6d453af7370c8f83.jpg', '4.00', '2', '', '20', '10', '70', '300', '0.5', '8', '200', '80', '2', '0.00', '0');
INSERT INTO `z_doctor` VALUES ('7', '1', '12,13,14,15', 'test', '/uploads/20190907/a732ebe4180656ea3be2c8a5ecdaa3aa.png', '1', 'v1', '1', '1', '05654e97ad182c96b06bb565c3ef7f44', '2', '13129087405', '1', '/uploads/20190917/7741c851a856c80abb4a0788c2ff8fdc.png', 'e10adc3949ba59abbe56e057f20f883e', '1567844529', '1572084171', '/uploads/20190917/1e507aec88b634e6359f077c0d33ab5e.jpg,/uploads/20190917/e663c2aae94d492f52c6450d82f14652.png', '3.67', '6', '2019-09-07', '20', '10', '70', '300', '0.5', '80', '100', '80', '2', '1.25', '0');
INSERT INTO `z_doctor` VALUES ('10', '5', '1,2,3', '周杰伦', '/uploads/20191009/32942334395bb7b46460374a1332d87e.jpg', '1', 'v1', '2', '3000', 'b56cc1fa47e3b50504cc1456ea507912', '85', '15007517166', '1', '/uploads/20191009/5f7dc2c2ccfdb27896920d47033d1ea8.png', 'e10adc3949ba59abbe56e057f20f883e', '1570607605', '1571971041', '/uploads/20191009/109a123608342b641314b1baf96a37ab.png,/uploads/20191009/a710f0ffb21a13d33845048c9b169014.png', '4.40', '5', '2018-09-01', '20', '10', '70', '300', '0.5', '80', '100', '80', '2', '2.18', '0');
INSERT INTO `z_doctor` VALUES ('11', '4', '4', '测试用', '', '1', 'v1', '0', '4k', '5dc74067f2c35b37212281418fd14131', '50', '13724158053', '1', '/uploads/20190820/f358d9f8bf8588b0f3c9aa41290ca68d.jpg', 'e10adc3949ba59abbe56e057f20f883e', '1570610011', '1572075346', '/uploads/20190820/f358d9f8bf8588b0f3c9aa41290ca68d.jpg,/uploads/20190820/f358d9f8bf8588b0f3c9aa41290ca68d.jpg', '3.54', '13', '2019-10-08', '20', '10', '70', '300', '0.5', '80', '100', '80', '2', '7.61', '1');

-- ----------------------------
-- Table structure for z_doctor_grade
-- ----------------------------
DROP TABLE IF EXISTS `z_doctor_grade`;
CREATE TABLE `z_doctor_grade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '等级名称',
  `standard` int(11) NOT NULL DEFAULT '0' COMMENT '升级标准值',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '等级说明',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='等级表';

-- ----------------------------
-- Records of z_doctor_grade
-- ----------------------------
INSERT INTO `z_doctor_grade` VALUES ('1', 'v1', '20', 'vi等级说明', '0', '0');

-- ----------------------------
-- Table structure for z_doctor_leave
-- ----------------------------
DROP TABLE IF EXISTS `z_doctor_leave`;
CREATE TABLE `z_doctor_leave` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) DEFAULT '0' COMMENT '门店id',
  `doctor_id` int(10) DEFAULT '0' COMMENT '理疗师id',
  `day` varchar(100) DEFAULT '0' COMMENT '请假天数',
  `start_time` int(10) DEFAULT '0' COMMENT '请假开始时间',
  `end_time` int(10) DEFAULT '0' COMMENT '请假结束时间',
  `type` tinyint(1) DEFAULT '1' COMMENT '1:正常请假2有事请假',
  `msg` varchar(255) DEFAULT '' COMMENT '请假事由',
  `status` tinyint(1) DEFAULT '0' COMMENT '0未审核1已同意2已拒绝',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='理疗师请假表';

-- ----------------------------
-- Records of z_doctor_leave
-- ----------------------------
INSERT INTO `z_doctor_leave` VALUES ('1', '0', '1', '2', '1566283155', '1566283155', '1', '测试请假', '0', '1566440034', '1566893428');
INSERT INTO `z_doctor_leave` VALUES ('2', '0', '1', '1', '2019', '2019', '1', 'qqqqqq', '0', '1566956714', '1566956714');
INSERT INTO `z_doctor_leave` VALUES ('3', '0', '1', '111', '2019', '2019', '1', '11111', '0', '1566958036', '1566958036');
INSERT INTO `z_doctor_leave` VALUES ('4', '0', '1', '111', '2019', '2019', '2', '111', '0', '1566977595', '1566977595');
INSERT INTO `z_doctor_leave` VALUES ('5', '5', '1', '2', '2019', '2019', '1', '注意', '0', '1567681455', '1567681455');
INSERT INTO `z_doctor_leave` VALUES ('6', '5', '6', '2', '2019', '2019', '1', '测试', '0', '1567775301', '1567775301');
INSERT INTO `z_doctor_leave` VALUES ('7', '5', '6', '2', '2019', '2019', '1', '妹妹你飞', '0', '1569569953', '1569569953');

-- ----------------------------
-- Table structure for z_doctor_refer
-- ----------------------------
DROP TABLE IF EXISTS `z_doctor_refer`;
CREATE TABLE `z_doctor_refer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) DEFAULT '0' COMMENT '门店id',
  `dotor_id` int(10) DEFAULT '0' COMMENT '理疗师id',
  `username` varchar(255) DEFAULT '' COMMENT '用户名称',
  `phone` char(11) DEFAULT '' COMMENT '联系方式',
  `number` varchar(255) DEFAULT '' COMMENT '体验卡号',
  `msg` varchar(255) DEFAULT '' COMMENT '转诊原因',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='理疗师转诊治疗';

-- ----------------------------
-- Records of z_doctor_refer
-- ----------------------------
INSERT INTO `z_doctor_refer` VALUES ('1', '4', '2', '用户名称1', '13111111111', '体验卡号', '转诊原因', '1566889090', '1566889090');
INSERT INTO `z_doctor_refer` VALUES ('2', '5', '1', '用户名称', '联系方式', '体验卡号', '转诊原因', '1566958635', '1566958635');
INSERT INTO `z_doctor_refer` VALUES ('3', '5', '1', '用户名称', '13111111111', '体验卡号', '转诊原因', '1566958645', '1566958645');
INSERT INTO `z_doctor_refer` VALUES ('4', '5', '1', 'lijiancheng', '13129087405', '000000', '11111', '1566977047', '1566977047');
INSERT INTO `z_doctor_refer` VALUES ('5', '5', '1', '123132', '13129087405', '123456', '11', '1566977173', '1566977173');
INSERT INTO `z_doctor_refer` VALUES ('6', '1', '0', '12313', '13129087405', '10', '12313', '1567503834', '1567503834');
INSERT INTO `z_doctor_refer` VALUES ('7', '1', '0', '2134123', '13129087405', '10', '22', '1567503899', '1567503899');
INSERT INTO `z_doctor_refer` VALUES ('8', '1', '0', '2323', '13129087405', '10', '2', '1567503956', '1567503956');
INSERT INTO `z_doctor_refer` VALUES ('9', '5', '1', '12132', '13129087405', '10', '1213', '1567568803', '1567568803');
INSERT INTO `z_doctor_refer` VALUES ('10', '5', '1', '123', '15813323540', '123456', '不好', '1567681592', '1567681592');
INSERT INTO `z_doctor_refer` VALUES ('11', '1', '0', '1212', '15915744188', '123', '测试', '1567773794', '1567773794');
INSERT INTO `z_doctor_refer` VALUES ('12', '5', '6', '测试', '13800000000', '123', '测试', '1567775362', '1567775362');
INSERT INTO `z_doctor_refer` VALUES ('13', '1', '0', '李小明', '15007517188', '258698', '跟韩庚更', '1569426123', '1569426123');

-- ----------------------------
-- Table structure for z_doctor_royalty
-- ----------------------------
DROP TABLE IF EXISTS `z_doctor_royalty`;
CREATE TABLE `z_doctor_royalty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单id',
  `doctor_id` int(11) NOT NULL DEFAULT '0' COMMENT '理疗师id',
  `project` varchar(255) DEFAULT '' COMMENT '服务项目',
  `treat_time` int(11) DEFAULT '0' COMMENT '治疗时间',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '订单支付金额',
  `total` decimal(10,2) DEFAULT '0.00' COMMENT '订单总价',
  `money` varchar(10) DEFAULT '' COMMENT '提成金额',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1显示；2隐藏',
  `add_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  `base_money` varchar(30) DEFAULT NULL COMMENT '基础指标/元',
  `royalty_precent` varchar(30) DEFAULT NULL COMMENT '提成比例',
  `satisfaction` varchar(30) DEFAULT NULL COMMENT '满意度',
  `order_num` int(10) DEFAULT '0' COMMENT '设定工单量',
  `return_rate` varchar(30) DEFAULT NULL COMMENT '设定回头率',
  `score` int(5) DEFAULT '0' COMMENT '订单评分',
  `complete_num` int(11) DEFAULT '0' COMMENT '服务客户总次数(已完成订单量)',
  `reality` varchar(30) DEFAULT NULL COMMENT '实际满意度',
  `sat_ratio` varchar(30) DEFAULT NULL COMMENT '满意度提成系数',
  `task` varchar(30) DEFAULT NULL COMMENT '任务量提成系数',
  `allnum` int(11) DEFAULT '0' COMMENT '当月新增人数(截止于该订单完成时)',
  `more_num` int(11) DEFAULT '0' COMMENT '第一次为该理疗师治疗，且服务2次以上(第2次以上不限制某个理疗师)  新客回头人数',
  `rea_return_rate` varchar(30) DEFAULT NULL COMMENT '实际回头率',
  `return_rate_ratio` varchar(30) DEFAULT NULL COMMENT '回头率提成系数',
  `assess` varchar(30) DEFAULT NULL COMMENT '考核评估系数',
  `achievement` decimal(10,2) DEFAULT '0.00' COMMENT '实际业绩',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8 COMMENT='提成表';

-- ----------------------------
-- Records of z_doctor_royalty
-- ----------------------------
INSERT INTO `z_doctor_royalty` VALUES ('120', '120', '7', '足疗按摩', '1569745709', '0.00', '140.00', '0', '1', '1569745709', '1569745709', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '0', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('121', '121', '1', '头肩颈理疗服务', '1569745815', '0.00', '120.00', '0', '1', '1569745815', '1569745815', '20', '0.5', '8', '200', '80', '0', '1', '0', '0', '0.005', '1', '0', '0', '0', '0.0016666666666667', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('122', '128', '3', '腰部按摩', '1569849454', '0.00', '180.00', '0', '1', '1569849454', '1569849454', '20', '0.5', '8', '200', '80', '0', '1', '0', '0', '0.005', '2', '0', '0', '0', '0.0016666666666667', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('123', '130', '3', '腰部按摩', '1569850017', '0.00', '180.00', '0', '1', '1569850017', '1569850017', '20', '0.5', '8', '200', '80', '0', '1', '0', '0', '0.005', '0', '0', '0', '0', '0.0016666666666667', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('124', '133', '8', '手部放松按摩', '1570589305', '0.00', '80.00', '0', '1', '1570589305', '1570589305', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '0', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('125', '135', '8', '手部放松按摩', '1570589750', '0.00', '80.00', '0', '1', '1570589750', '1570589750', '20', '0.5', '80', '100', '80', '0', '2', '0', '0', '0.02', '0', '0', '0', '0', '0.0066666666666667', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('126', '136', '8', '手部放松按摩', '1570589765', '0.00', '80.00', '0', '1', '1570589765', '1570589765', '20', '0.5', '80', '100', '80', '0', '3', '0', '0', '0.03', '1', '0', '0', '0', '0.01', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('128', '136', '8', '手部放松按摩', '1570589765', '0.00', '80.00', '0', '1', '1570589765', '1570589765', '20', '0.5', '80', '100', '80', '0', '4', '0', '0', '0.04', '2', '2', '1', '0.0125', '0.0175', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('129', '137', '10', '颈肩腰理疗服务', '1570607771', '0.00', '100.00', '0', '1', '1570607771', '1570607771', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '2', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('130', '139', '11', '手部放松按摩', '1570610220', '0.00', '80.00', '0', '1', '1570610220', '1570610220', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '2', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('131', '140', '11', '手部放松按摩', '1570610303', '0.00', '80.00', '0.20', '1', '1570610303', '1570610303', '20', '0.5', '80', '100', '80', '0', '2', '0', '0', '0.02', '3', '0', '0', '0', '0.0066666666666667', '80.00');
INSERT INTO `z_doctor_royalty` VALUES ('132', '141', '10', '颈肩腰理疗服务', '1570610697', '0.00', '100.00', '0.25', '1', '1570610697', '1570610697', '20', '0.5', '80', '100', '80', '0', '2', '0', '0', '0.02', '4', '0', '0', '0', '0.0066666666666667', '95.00');
INSERT INTO `z_doctor_royalty` VALUES ('133', '143', '7', '舒肩松颈', '1570762714', '0.00', '38.80', '0', '1', '1570762714', '1570762714', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '5', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('134', '144', '11', '手部放松按摩', '1570774226', '0.00', '80.00', '0.70', '1', '1570774226', '1570774226', '20', '0.5', '80', '100', '80', '0', '3', '0', '0', '0.03', '4', '0', '0', '0', '0.01', '160.00');
INSERT INTO `z_doctor_royalty` VALUES ('135', '145', '11', '手部放松按摩', '1570774368', '0.00', '80.00', '1.43', '1', '1570774368', '1570774368', '20', '0.5', '80', '100', '80', '0', '4', '0', '0', '0.04', '4', '0', '0', '0', '0.013333333333333', '235.00');
INSERT INTO `z_doctor_royalty` VALUES ('136', '160', '11', '手部放松按摩', '1571035943', '0.00', '80.00', '0', '1', '1571035943', '1571035943', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '0', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('137', '2', '11', '手部放松按摩', '1571037922', '0.00', '80.00', '0', '1', '1571037922', '1571037922', '20', '0.5', '80', '100', '80', '5', '1', '5', '0.0625', '0.01', '0', '0', '0', '0', '0.024166666666667', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('138', '6', '10', '颈肩腰理疗服务', '1571101776', '0.00', '100.00', '0', '1', '1571101776', '1571101776', '20', '0.5', '80', '100', '80', '5', '1', '5', '0.0625', '0.01', '0', '0', '0', '0', '0.024166666666667', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('139', '7', '10', '颈肩腰理疗服务', '1571102045', '0.00', '100.00', '0.68', '1', '1571102045', '1571102045', '20', '0.5', '80', '100', '80', '5', '2', '2.5', '0.03125', '0.02', '1', '0', '0', '0', '0.017083333333333', '100.00');
INSERT INTO `z_doctor_royalty` VALUES ('140', '8', '11', '手部放松按摩', '1571106983', '0.00', '80.00', '0', '1', '1571106983', '1571106983', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '2', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('141', '12', '11', '手部放松按摩', '1571111075', '0.00', '80.00', '0', '1', '1571111075', '1571111075', '20', '0.5', '80', '100', '80', '5', '2', '2.5', '0.03125', '0.02', '2', '0', '0', '0', '0.017083333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('142', '13', '11', '手部放松按摩', '1571111904', '0.00', '80.00', '0.26', '1', '1571111904', '1571111904', '20', '0.5', '80', '100', '80', '0', '3', '0', '0', '0.03', '2', '0', '0', '0', '0.01', '72.80');
INSERT INTO `z_doctor_royalty` VALUES ('143', '17', '11', '手部放松按摩', '0', '0.00', '80.00', '1.34', '1', '1571220522', '1571220522', '20', '0.5', '80', '100', '80', '0', '4', '0', '0', '0.04', '1', '0', '0', '0', '0.013333333333333', '220.60');
INSERT INTO `z_doctor_royalty` VALUES ('144', '22', '7', '舒肩松颈', '1571823012', '0.00', '38.80', '0', '1', '1571823014', '1571823014', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '1', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('145', '23', '7', '舒肩松颈', '1571823372', '0.00', '38.80', '0', '1', '1571823375', '1571823375', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '1', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('146', '24', '7', '舒肩松颈', '1571823670', '0.00', '38.80', '0', '1', '1571823672', '1571823672', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '1', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('147', '25', '7', '舒肩松颈', '1571824063', '0.00', '38.80', '0', '1', '1571824064', '1571824064', '20', '0.5', '80', '100', '80', '0', '1', '0', '0', '0.01', '1', '0', '0', '0', '0.0033333333333333', '0.00');
INSERT INTO `z_doctor_royalty` VALUES ('148', '7', '10', '颈肩腰理疗服务', '1571102045', '0.00', '100.00', '0.68', '1', '1571826833', '1571826833', '20', '0.5', '80', '100', '80', '5', '2', '2.5', '0.03125', '0.02', '0', '0', '0', '0', '0.017083333333333', '100.00');
INSERT INTO `z_doctor_royalty` VALUES ('149', '26', '10', '头肩颈理疗服务', '1571826836', '0.00', '120.00', '0.57', '1', '1571826842', '1571826842', '20', '0.5', '80', '100', '80', '0', '3', '0', '0', '0.03', '2', '2', '1', '0.0125', '0.014166666666667', '100.00');
INSERT INTO `z_doctor_royalty` VALUES ('150', '27', '7', '颈肩背推拿', '1571880871', '0.00', '58.80', '0.05', '1', '1571880874', '1571880874', '20', '0.5', '80', '100', '80', '0', '2', '0', '0', '0.02', '3', '0', '0', '0', '0.0066666666666667', '35.31');
INSERT INTO `z_doctor_royalty` VALUES ('151', '28', '7', '颈肩背推拿', '1571881448', '0.00', '58.80', '0.05', '1', '1571881451', '1571881451', '20', '0.5', '80', '100', '80', '0', '2', '0', '0', '0.02', '3', '0', '0', '0', '0.0066666666666667', '35.31');
INSERT INTO `z_doctor_royalty` VALUES ('152', '29', '7', '提神醒脑', '1571881995', '0.00', '68.80', '0.05', '1', '1571881998', '1571881998', '20', '0.5', '80', '100', '80', '0', '2', '0', '0', '0.02', '3', '0', '0', '0', '0.0066666666666667', '35.31');
INSERT INTO `z_doctor_royalty` VALUES ('153', '30', '7', '舒肩松颈', '1571882310', '0.00', '38.80', '0.05', '1', '1571882312', '1571882312', '20', '0.5', '80', '100', '80', '0', '2', '0', '0', '0.02', '3', '0', '0', '0', '0.0066666666666667', '35.31');
INSERT INTO `z_doctor_royalty` VALUES ('154', '31', '7', '舒肩松颈', '1571882625', '0.00', '38.80', '0.05', '1', '1571882627', '1571882627', '20', '0.5', '80', '100', '80', '0', '2', '0', '0', '0.02', '3', '0', '0', '0', '0.0066666666666667', '35.31');
INSERT INTO `z_doctor_royalty` VALUES ('155', '36', '11', '手部放松按摩', '1572073120', '0.00', '80.00', '1.67', '1', '1572073439', '1572073439', '20', '0.5', '80', '100', '80', '0', '5', '0', '0', '0.05', '3', '0', '0', '0', '0.016666666666667', '220.60');
INSERT INTO `z_doctor_royalty` VALUES ('156', '39', '11', '手部放松按摩', '1572073524', '0.00', '80.00', '2.01', '1', '1572074736', '1572074736', '20', '0.5', '80', '100', '80', '0', '6', '0', '0', '0.06', '3', '0', '0', '0', '0.02', '220.60');
INSERT INTO `z_doctor_royalty` VALUES ('157', '34', '7', '舒肩松颈', '1572077651', '0.00', '38.80', '0.25', '1', '1572078396', '1572078396', '20', '0.5', '80', '100', '80', '0', '3', '0', '0', '0.03', '3', '0', '0', '0', '0.01', '70.62');
INSERT INTO `z_doctor_royalty` VALUES ('158', '41', '7', '颈肩背推拿', '1572078768', '0.00', '58.80', '0.25', '1', '1572078775', '1572078775', '20', '0.5', '80', '100', '80', '0', '3', '0', '0', '0.03', '3', '0', '0', '0', '0.01', '70.62');
INSERT INTO `z_doctor_royalty` VALUES ('159', '42', '7', '颈肩背推拿', '1572082624', '0.00', '58.80', '0.25', '1', '1572082628', '1572082628', '20', '0.5', '80', '100', '80', '0', '3', '0', '0', '0.03', '3', '0', '0', '0', '0.01', '70.62');
INSERT INTO `z_doctor_royalty` VALUES ('160', '44', '7', '提神醒脑', '1572084176', '0.00', '68.80', '0.25', '1', '1572084179', '1572084179', '20', '0.5', '80', '100', '80', '0', '3', '0', '0', '0.03', '3', '0', '0', '0', '0.01', '70.62');

-- ----------------------------
-- Table structure for z_doctor_work
-- ----------------------------
DROP TABLE IF EXISTS `z_doctor_work`;
CREATE TABLE `z_doctor_work` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doctor_id` int(10) DEFAULT '0' COMMENT '理疗师id',
  `title` varchar(255) DEFAULT '' COMMENT '工作单位名称',
  `start_time` int(10) DEFAULT '0' COMMENT '在职开始时间',
  `end_time` int(10) DEFAULT '0' COMMENT '在职结束时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '1待审核；2审核通过；3未通过',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='理疗师个人档案';

-- ----------------------------
-- Records of z_doctor_work
-- ----------------------------
INSERT INTO `z_doctor_work` VALUES ('2', '2', '工作单位名称', '1566880496', '0', '1', '1566889074', '1566889074');
INSERT INTO `z_doctor_work` VALUES ('5', '1', '梵尼美', '1533052800', '1564588800', '1', '1567127871', '1567127871');
INSERT INTO `z_doctor_work` VALUES ('7', '5', '开利', '1568217600', '1568304000', '1', '1568259879', '1568259879');
INSERT INTO `z_doctor_work` VALUES ('8', '5', '开利2', '1568217600', '1568390400', '1', '1568259879', '1568259879');
INSERT INTO `z_doctor_work` VALUES ('10', '7', '理疗师李总', '1567267200', '1567267200', '1', '1568701635', '1568701635');
INSERT INTO `z_doctor_work` VALUES ('11', '6', '12', '1493049600', '1569340800', '1', '1569426367', '1569426367');
INSERT INTO `z_doctor_work` VALUES ('12', '6', '22', '1096041600', '1369411200', '1', '1569426367', '1569426367');
INSERT INTO `z_doctor_work` VALUES ('13', '10', '门店1', '1539014400', '1570550400', '1', '1570608507', '1570608507');

-- ----------------------------
-- Table structure for z_doctor_work_new
-- ----------------------------
DROP TABLE IF EXISTS `z_doctor_work_new`;
CREATE TABLE `z_doctor_work_new` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doctor_id` int(10) DEFAULT '0' COMMENT '理疗师id',
  `title` varchar(255) DEFAULT '' COMMENT '工作单位名称',
  `start_time` int(10) DEFAULT '0' COMMENT '在职开始时间',
  `end_time` int(10) DEFAULT '0' COMMENT '在职结束时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '1待审核；2审核通过；3未通过',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='理疗师个人档案';

-- ----------------------------
-- Records of z_doctor_work_new
-- ----------------------------

-- ----------------------------
-- Table structure for z_explain
-- ----------------------------
DROP TABLE IF EXISTS `z_explain`;
CREATE TABLE `z_explain` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `coupon_exchange` text COMMENT '优惠券兑换说明',
  `coupon_explain` text COMMENT '优惠券使用说明',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  `bang` text COMMENT 'BANG权益介绍',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='各类说明';

-- ----------------------------
-- Records of z_explain
-- ----------------------------
INSERT INTO `z_explain` VALUES ('1', '<p>1、大众点评、口碑团购券兑换后仅支持在本门店使用，请您确认好门店后核销</p><p>2、输入兑换码，点击确认即可兑换医么体验券</p><p>3、支持医么自有兑换码、大众点评团购、口碑兑换码</p>', '<p>1：如何获得优惠券</p><p>通过抢微信好友分享的优惠券、参与医么推出的活动</p><p>2：如何使用优惠券</p><p>优惠券仅支持在线支付使用，每个订单只能使用一张优惠券</p><p>3：优惠券什么时候生效？什么时候到期</p><p>优惠券生效时间内，皆为有效</p>', '1566144000', '1567839487', '<p>1、理疗9折起，全年不限次数</p><p>2、开通首单后，后续按摩服务可享受9折</p><p>3、参与BANG权益活动的门店，支付时自动抵扣&nbsp;&nbsp;&nbsp;&nbsp;</p><p>4、仅限本账号使用BANG权益的特权</p>');

-- ----------------------------
-- Table structure for z_feedback
-- ----------------------------
DROP TABLE IF EXISTS `z_feedback`;
CREATE TABLE `z_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '上级id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '标题',
  `sort` int(11) DEFAULT '0' COMMENT '排序 倒序',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='反馈类型';

-- ----------------------------
-- Records of z_feedback
-- ----------------------------
INSERT INTO `z_feedback` VALUES ('4', '0', 'test', '1', '1570521382', '1570521382');

-- ----------------------------
-- Table structure for z_form_msg
-- ----------------------------
DROP TABLE IF EXISTS `z_form_msg`;
CREATE TABLE `z_form_msg` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT '' COMMENT '标题',
  `msg` varchar(255) DEFAULT '',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='模板消息提示语';

-- ----------------------------
-- Records of z_form_msg
-- ----------------------------
INSERT INTO `z_form_msg` VALUES ('1', '取号成功提醒', '您已取号成功，感谢您选择医么。', '1572080005', '1572081354');
INSERT INTO `z_form_msg` VALUES ('2', '排队提醒A', '下一个就是你啦，建议现在到店等候，避免等候时间延长。如叫号超过3分钟，您的排队将进行延后处理。', '1572080005', '1572080918');
INSERT INTO `z_form_msg` VALUES ('3', '排队提醒B', '即将到您的号，等待时间还需5分钟。', '1572080005', '1572081152');
INSERT INTO `z_form_msg` VALUES ('4', '支付提醒', '您好。点击“详情”，确认订单并支付吧。', '1572080005', '1572081001');
INSERT INTO `z_form_msg` VALUES ('5', '付款成功提醒', '您好，您已成功付款。一周按一次，肩颈好轻松。期待我们再次相遇。', '1572080005', '1572081028');
INSERT INTO `z_form_msg` VALUES ('6', '评价提醒', '理疗师对您的肩颈情况做了专业评估和建议，点击详情查看。您对本次的服务体验如何呢？', '1572080005', '1572081041');

-- ----------------------------
-- Table structure for z_goods
-- ----------------------------
DROP TABLE IF EXISTS `z_goods`;
CREATE TABLE `z_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '封面',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '门店标题',
  `welfare` varchar(255) NOT NULL DEFAULT '' COMMENT '额外福利',
  `type_id` int(11) NOT NULL DEFAULT '0' COMMENT '城市id',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `jingdu` varchar(255) NOT NULL DEFAULT '' COMMENT '经度',
  `weidu` varchar(255) NOT NULL DEFAULT '' COMMENT '纬度',
  `discuss` int(11) NOT NULL DEFAULT '0' COMMENT '评论数',
  `score` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '评分',
  `activity_id` varchar(10) DEFAULT '' COMMENT '1新用户首单2邀请好友奖励',
  `status` tinyint(1) DEFAULT '1' COMMENT '1:正在营业2:即将开业',
  `bang` tinyint(1) DEFAULT '1' COMMENT '是否参加bang权益 1参加2不参加',
  `phone` varchar(15) NOT NULL DEFAULT '',
  `pwd` varchar(255) NOT NULL DEFAULT '' COMMENT '密码',
  `start_time` int(10) DEFAULT '0',
  `end_time` int(10) DEFAULT '0',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `tel` varchar(255) DEFAULT '' COMMENT '店铺电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='门店管理';

-- ----------------------------
-- Records of z_goods
-- ----------------------------
INSERT INTO `z_goods` VALUES ('1', '/uploads/20190819/2ded9000d3571bfba1618a04e8d7e09f.jpg', '足三里按摩', '今日不打折', '10', '广州市越秀区中山大学附属第一医院', '113.271857', '23.107386', '11', '3.82', '1,2', '1', '1', '13111111111', 'e10adc3949ba59abbe56e057f20f883e', '1567029600', '1567065600', '1554694638', '1567050394', '020-1265412');
INSERT INTO `z_goods` VALUES ('2', '/uploads/20190819/4f1a00d1f3e13ad7175e2cbe5e6f7429.jpg', '妙手按摩店', '今日不打折', '10', '广州市番禺区广州南站-地铁站', '113.256747', '22.976483', '3', '4.00', '1', '1', '1', '', '', '1566795600', '1566824400', '1554714681', '1566809384', '020-6854124');
INSERT INTO `z_goods` VALUES ('3', '/uploads/20190819/f585cc3f8c75e7a8acf8ac98abfdf363.jpg', '逸东堂', '今日不打折', '10', '广州市番禺区广州南站', '113.256456', '22.976215', '1', '3.00', '1,2', '1', '1', '', '', '1566792000', '1566824400', '1554945485', '1566809525', '020-9420236');
INSERT INTO `z_goods` VALUES ('4', '/uploads/20190819/c076b7d7df8bb0f502d271e437a73a32.jpg', '紫轩堂', '享8折优惠', '10', '广州市天河区广州摩登百货股份有限公司(岗顶店)', '113.306471', '23.106421', '14', '3.64', '1', '1', '1', '13724158053', '25f9e794323b453885f5181f1b624d0b', '1571014800', '1571047200', '1554945618', '1571043432', '020-5874023');
INSERT INTO `z_goods` VALUES ('5', '/uploads/20190819/08feb6530f85fa905c80cf94f9da3ae7.jpg', '天天按摩', '今日活动5折优惠', '10', '广州市越秀区北京路-地铁站', '113.268950', '23.125380', '8', '4.44', '2', '1', '1', '', '', '1566784800', '1566824400', '1554946082', '1566809399', '020-7541032');
INSERT INTO `z_goods` VALUES ('6', '/uploads/20190907/9e4829ef7cd65c6bc199147d50421150.jpg', '联合社区店', '100', '10', '广州市天河区广州市开利网络科技有限公司', '113.40271', '23.125253', '0', '0.00', '1,2', '1', '1', '13500102578', 'e10adc3949ba59abbe56e057f20f883e', '1567818061', '1567868891', '1567839829', '1567839829', '');
INSERT INTO `z_goods` VALUES ('7', '/uploads/20190907/ee3aad53dcdadb80b1ce7e9ba31e712e.png', '1联合社区', '100', '10', '广州市天河区Hi.TEA茶室(车陂联合社区店)', '113.402382', '23.124739', '0', '0.00', '1,2', '2', '2', '18320569658', '733d7be2196ff70efaf6913fc8bdcabf', '1567832461', '1567861327', '1567840078', '1567840078', '');
INSERT INTO `z_goods` VALUES ('8', '/uploads/20191030/3da573d4e094fc29939c82c99d55d77a.png', '测试', '新客户优惠', '18', '广东省佛山市佛山市', '113.115468', '23.016137', '0', '0.00', '1', '1', '2', '13129087405', 'e10adc3949ba59abbe56e057f20f883e', '1572364800', '1572451199', '1572422385', '1572422539', '');

-- ----------------------------
-- Table structure for z_goods_comp
-- ----------------------------
DROP TABLE IF EXISTS `z_goods_comp`;
CREATE TABLE `z_goods_comp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID',
  `pic` varchar(255) NOT NULL DEFAULT '' COMMENT '服务图片',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `price` decimal(10,2) DEFAULT '0.00',
  `time` int(10) DEFAULT '0' COMMENT '服务时间',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) DEFAULT '2' COMMENT '1:推荐2:不推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='门店服务';

-- ----------------------------
-- Records of z_goods_comp
-- ----------------------------
INSERT INTO `z_goods_comp` VALUES ('1', '5', '/uploads/20190819/c8d6ff6df86dabc56975204eed6dae89.jpg', '头肩颈理疗服务', '疏通经络 缓解疲劳 解压助眠', '120.00', '120', '1566181212', '1566284507', '2');
INSERT INTO `z_goods_comp` VALUES ('2', '5', '/uploads/20190819/0eb98b61573a9684b03eeaca9bc2b159.jpg', '腰腿骨理疗服务', '祛湿驱寒 放松肌肉 唤醒活力', '110.00', '80', '1566181734', '1566284502', '2');
INSERT INTO `z_goods_comp` VALUES ('3', '5', '/uploads/20190819/90408e328881c67abc03638874a30bd5.jpg', '颈肩腰理疗服务', '通畅循环 百通可帮 时刻健康', '100.00', '60', '1566181782', '1566284261', '2');
INSERT INTO `z_goods_comp` VALUES ('4', '4', '/uploads/20190819/4772821ab6d277c638b346322b66a8ec.jpg', '手部放松按摩', '疏通经络 加速循环 放松肌肉', '80.00', '60', '1566181892', '1566284518', '2');
INSERT INTO `z_goods_comp` VALUES ('5', '3', '/uploads/20190819/05b210d436a38ce059e8e8526df1d8fd.jpg', '头部放松', '解压助眠 血液循环 通畅循环', '140.00', '70', '1566182097', '1566284527', '2');
INSERT INTO `z_goods_comp` VALUES ('6', '2', '/uploads/20190819/4cc8ca8b7fe4bfb4b0f05c07939528ad.jpg', '腰部按摩', '减压放松 祛湿驱寒 释放活力', '180.00', '60', '1566182170', '1566284536', '2');
INSERT INTO `z_goods_comp` VALUES ('8', '6', '/uploads/20190907/6d59a3fb80fc405e9da81067fe77caf2.png', '免费按摩', '全身放松', '0.00', '50', '1567839873', '1567839873', '2');
INSERT INTO `z_goods_comp` VALUES ('9', '7', '', '颈肩背推拿', '低头族首选 松解僵硬 解除疲劳', '58.80', '30', '1567840102', '1569807033', '1');
INSERT INTO `z_goods_comp` VALUES ('10', '7', '', '舒肩松颈', '久坐办公族  放松首选   舒解酸痛', '38.00', '20', '1567840122', '1569806873', '2');
INSERT INTO `z_goods_comp` VALUES ('12', '1', '', '落枕速解', '落枕修复 解放颈椎 消除疼痛', '68.80', '30', '1569807197', '1569807197', '2');
INSERT INTO `z_goods_comp` VALUES ('13', '1', '', '提神醒脑', '缓解压力 安享睡眠 改善头晕头痛', '68.80', '30', '1569807227', '1569807227', '2');
INSERT INTO `z_goods_comp` VALUES ('14', '1', '', '颈肩背推拿', '低头族首选 松解僵硬 解除疲劳', '58.80', '30', '1569807687', '1569807687', '2');
INSERT INTO `z_goods_comp` VALUES ('15', '1', '', '舒肩松颈', '久坐办公族 放松首选 舒解酸痛', '38.80', '20', '1569807738', '1569807738', '2');
INSERT INTO `z_goods_comp` VALUES ('16', '8', '', '按摩', '...', '10.00', '100', '1572422587', '1572422587', '2');

-- ----------------------------
-- Table structure for z_goods_discuss
-- ----------------------------
DROP TABLE IF EXISTS `z_goods_discuss`;
CREATE TABLE `z_goods_discuss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺id',
  `doctor_id` int(10) DEFAULT '0' COMMENT '理疗师id',
  `star` int(10) DEFAULT '0' COMMENT '评论星级',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '评分',
  `type` varchar(255) DEFAULT '' COMMENT '评价类型',
  `pic` text COMMENT '图片',
  `desc` varchar(255) NOT NULL DEFAULT '' COMMENT '评论内容',
  `is_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示 1是 2否',
  `name` varchar(255) DEFAULT '' COMMENT '理疗师名称',
  `comp_name` varchar(255) DEFAULT '' COMMENT '服务名称',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '评论时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `state` tinyint(1) DEFAULT '1' COMMENT '1无图2有图',
  `oid` int(10) DEFAULT '0' COMMENT '订单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='评论表';

-- ----------------------------
-- Records of z_goods_discuss
-- ----------------------------
INSERT INTO `z_goods_discuss` VALUES ('1', '1', '5', '2', '5', '5', '1', null, '还不错', '1', '杨幂', '手部放松按摩', '1566525222', '1566525222', '1', '6');
INSERT INTO `z_goods_discuss` VALUES ('2', '2', '5', '1', '5', '5', '放松舒服', null, '测试', '2', '迪丽热巴', '头肩颈理疗服务', '1566899016', '1567565624', '1', '7');
INSERT INTO `z_goods_discuss` VALUES ('3', '4', '1', '1', '3', '3', '服务热情', '/uploads/20190830/716da937787059d4cff3c8adf5e17c1d.png,/uploads/20190830/4c3d7c2310182517123cce1bebe029e4.png,/uploads/20190830/03c74069cda5660a02265f76e43fc7cd.png', 'dfafaf阿砂浆', '1', '迪丽热巴', '头肩颈理疗服务', '1567135400', '1567135400', '2', '11');
INSERT INTO `z_goods_discuss` VALUES ('4', '4', '1', '1', '5', '5', '放松舒服', '/uploads/20190830/0ddebe70b066e9500218fc59a401f3f0.png,/uploads/20190830/fdc7482397781d677a7a54ff60408cd6.png', '法发顺丰噶', '1', '迪丽热巴', '颈肩腰理疗服务', '1567135428', '1567135428', '2', '12');
INSERT INTO `z_goods_discuss` VALUES ('5', '4', '1', '1', '3', '3', '服务热情', '/uploads/20190830/cc8b070fc1079ba29b7ef2ad167b07bb.png,/uploads/20190830/bef5c91513c86b952f94da313abadf0c.png', '大法师短发飞洒啊啊啊啊啊啊啊啊啊啊啊啊', '1', '迪丽热巴', '腰腿骨理疗服务', '1567144976', '1567144976', '2', '15');
INSERT INTO `z_goods_discuss` VALUES ('6', '4', '1', '1', '4', '4', '体验很棒', '/uploads/20190830/8cad3a57f341c2d813df485b6e43caee.png,/uploads/20190830/c18f57e01ad0a821033877c095adce13.png', '市的富商大贾的', '1', '迪丽热巴', '腰腿骨理疗服务', '1567144994', '1567144994', '2', '15');
INSERT INTO `z_goods_discuss` VALUES ('7', '13', '2', '3', '4', '4', '服务热情', '/uploads/20190916/e17df2e26049a90ac575e1afe5ffca12.jpg,/uploads/20190916/dcc9e7d9576f2bfe2be2022ab9a1ed8d.jpg', '很好', '1', '刘亦菲', '腰部按摩', '1568620695', '1568620695', '2', '53');
INSERT INTO `z_goods_discuss` VALUES ('8', '6', '3', '4', '3', '3', '放松舒服', null, '很不错哈', '1', '月月', '头部放松', '1569479711', '1569479711', '1', '80');
INSERT INTO `z_goods_discuss` VALUES ('9', '18', '1', '7', '5', '5', '放松舒服', null, '', '1', 'test', '足疗按摩', '1569481213', '1569481213', '1', '81');
INSERT INTO `z_goods_discuss` VALUES ('10', '13', '5', '6', '5', '5', '性比价高', '/uploads/20190926/68ae1cb46ea400cb991e9e82ff56403f.jpg', '嗯的呢', '1', '伊素婉', '颈肩腰理疗服务', '1569487044', '1569487044', '2', '2');
INSERT INTO `z_goods_discuss` VALUES ('11', '13', '2', '3', '3', '3', '服务热情', '/uploads/20190927/89b29b03d565a56696042765864021da.jpg,/uploads/20190927/015e3591de03b447cd39461d12c5c120.jpg,/uploads/20190927/2e4deb25c541a9e3bdaa9186a8417533.jpg,/uploads/20190927/a2c468fdba970f9bd9c39c1374c292ca.jpg', '5698536', '1', '刘亦菲', '腰部按摩', '1569547684', '1569547684', '2', '87');
INSERT INTO `z_goods_discuss` VALUES ('12', '13', '5', '6', '3', '3', '', null, '很好', '1', '伊素婉', '颈肩腰理疗服务', '1569566177', '1569566177', '1', '86');
INSERT INTO `z_goods_discuss` VALUES ('13', '13', '1', '7', '3', '3', '', null, '好的', '1', 'test', '足疗按摩', '1569566266', '1569566266', '1', '88');
INSERT INTO `z_goods_discuss` VALUES ('14', '13', '1', '7', '3', '3', '', null, '好的', '1', 'test', '足疗按摩', '1569566267', '1569566267', '1', '88');
INSERT INTO `z_goods_discuss` VALUES ('15', '26', '1', '7', '4', '4', '', null, '喝喜酒橡胶机械橡胶机械', '1', 'test', '足疗按摩', '1569569054', '1569569054', '1', '89');
INSERT INTO `z_goods_discuss` VALUES ('16', '13', '2', '3', '5', '5', '', '/uploads/20190927/e1c88e2dd9e03c5e8cf2b7ccd80495f7.jpg,/uploads/20190927/b1c5baaa6a968f40d085e0e53d87f739.jpg,/uploads/20190927/08b92a59262933af75510b5a3cf1ce87.jpg', '乐克乐克可可粉', '1', '刘亦菲', '腰部按摩', '1569570159', '1569570159', '2', '91');
INSERT INTO `z_goods_discuss` VALUES ('17', '13', '1', '7', '3', '3', '服务热情,体验很棒', null, '看看哦KKK', '1', 'test', '足疗按摩', '1569724602', '1569724602', '1', '104');
INSERT INTO `z_goods_discuss` VALUES ('18', '18', '1', '5', '5', '5', '放松舒服,体验很棒', '/uploads/20190929/8816b1411b8ad7cbae5e3d2c94d3ec64.jpg', '123475', '1', '景甜', '足疗按摩', '1569744480', '1569744480', '2', '118');
INSERT INTO `z_goods_discuss` VALUES ('19', '13', '5', '10', '4', '4', '服务', '/uploads/20191009/27ffe3f77c812b62a842ef33eca51fe0.jpg', '嗯嗯嗯嗯嗯嗯', '2', '周杰伦', '颈肩腰理疗服务', '1570607841', '1570607841', '2', '137');
INSERT INTO `z_goods_discuss` VALUES ('20', '27', '4', '8', '5', '5', '服务,专业,服务,专业,服务,服务,专业', null, '哈哈哈哈哈哈哈哈哈', '1', 'yh', '手部放松按摩', '1570610250', '1570610250', '1', '2');
INSERT INTO `z_goods_discuss` VALUES ('21', '37', '4', '11', '3', '3', '服务,专业', null, '啦啦啦啦', '1', '测试用', '手部放松按摩', '1570610367', '1570610367', '1', '139');
INSERT INTO `z_goods_discuss` VALUES ('22', '27', '4', '11', '1', '1', '服务', null, '7777777', '1', '测试用', '手部放松按摩', '1570774187', '1570774187', '1', '140');
INSERT INTO `z_goods_discuss` VALUES ('23', '18', '4', '11', '4', '4', '服务', null, '12356', '1', '测试用', '手部放松按摩', '1570775283', '1570775283', '1', '145');
INSERT INTO `z_goods_discuss` VALUES ('24', '37', '4', '11', '3', '3', '服务', null, '哥哥哥哥哥哥', '1', '测试用', '手部放松按摩', '1570775471', '1570775471', '1', '144');
INSERT INTO `z_goods_discuss` VALUES ('25', '37', '4', '11', '3', '3', '服务', null, '哥哥哥哥哥哥', '1', '测试用', '手部放松按摩', '1570775471', '1570775471', '1', '144');
INSERT INTO `z_goods_discuss` VALUES ('26', '37', '4', '11', '3', '3', '服务', null, '哥哥哥哥哥哥', '1', '测试用', '手部放松按摩', '1570775471', '1570775471', '1', '144');
INSERT INTO `z_goods_discuss` VALUES ('27', '13', '5', '10', '5', '5', '专业', null, '哈哈哈', '1', '周杰伦', '颈肩腰理疗服务', '1571111042', '1571111042', '1', '6');
INSERT INTO `z_goods_discuss` VALUES ('28', '13', '5', '10', '5', '5', '专业', null, '哈哈哈', '1', '周杰伦', '颈肩腰理疗服务', '1571111043', '1571111043', '1', '6');
INSERT INTO `z_goods_discuss` VALUES ('29', '13', '5', '10', '5', '5', '专业', null, '哈哈哈', '1', '周杰伦', '颈肩腰理疗服务', '1571111043', '1571111043', '1', '6');
INSERT INTO `z_goods_discuss` VALUES ('30', '25', '4', '11', '5', '5', '专业', '/uploads/20191015/0b5db564ee8c3ff5a90ab9a57f5a2852.jpg', '121', '1', '测试用', '手部放松按摩', '1571111730', '1571111730', '2', '12');
INSERT INTO `z_goods_discuss` VALUES ('31', '25', '4', '11', '5', '5', '专业', '/uploads/20191015/0b5db564ee8c3ff5a90ab9a57f5a2852.jpg', '121', '1', '测试用', '手部放松按摩', '1571111731', '1571111731', '2', '12');
INSERT INTO `z_goods_discuss` VALUES ('32', '25', '4', '11', '5', '5', '服务好', '/uploads/20191015/61a527aed56f9ed1b45a25d0bc68c299.jpg', '11', '1', '测试用', '手部放松按摩', '1571111997', '1571111997', '2', '13');
INSERT INTO `z_goods_discuss` VALUES ('33', '25', '4', '11', '3', '3', '方便', null, '1231', '1', '测试用', '手部放松按摩', '1571820744', '1571820744', '1', '13');
INSERT INTO `z_goods_discuss` VALUES ('34', '25', '4', '11', '4', '4', '智能化操作', null, '一直', '1', '测试用', '手部放松按摩', '1571822274', '1571822274', '1', '17');
INSERT INTO `z_goods_discuss` VALUES ('35', '25', '4', '11', '2', '2', '智能化操作', null, '有什么', '1', '测试用', '手部放松按摩', '1571822720', '1571822720', '1', '17');
INSERT INTO `z_goods_discuss` VALUES ('36', '25', '1', '7', '4', '4', '专业', null, '不用上班啊', '1', 'test', '舒肩松颈', '1571824095', '1571824095', '1', '25');
INSERT INTO `z_goods_discuss` VALUES ('37', '13', '5', '10', '3', '3', '方便', null, '很好', '1', '周杰伦', '头肩颈理疗服务', '1571889295', '1571889295', '1', '26');
INSERT INTO `z_goods_discuss` VALUES ('38', '19', '4', '11', '5', '5', '服务好,网红养生,专业', '/uploads/20191026/d8424b291cdc73acc8d749c4cb6b184d.jpg', '真不错！', '1', '测试用', '手部放松按摩', '1572075088', '1572075088', '2', '39');

-- ----------------------------
-- Table structure for z_goods_service
-- ----------------------------
DROP TABLE IF EXISTS `z_goods_service`;
CREATE TABLE `z_goods_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pic` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='服务标准';

-- ----------------------------
-- Records of z_goods_service
-- ----------------------------
INSERT INTO `z_goods_service` VALUES ('1', '/uploads/20190916/5724112e553b37df09c87bc9d7f5bff4.png', '标准服务流程', '1554691587', '1568604868');
INSERT INTO `z_goods_service` VALUES ('2', '/uploads/20190916/524a41ae83f6d60a46d5bf47f8fbbae7.png', '专业理疗仪器', '1554691888', '1568604859');
INSERT INTO `z_goods_service` VALUES ('3', '/uploads/20190916/ca730b34f537a95594a170164318c2eb.png', '标准员工培训', '1554694127', '1568604847');
INSERT INTO `z_goods_service` VALUES ('4', '/uploads/20190916/46749c62036e51caf12f3064ed58c4da.png', '绝不推销办卡', '1554694154', '1568604834');
INSERT INTO `z_goods_service` VALUES ('5', '/uploads/20190916/b9271a36332616e03dec2ad927e73f84.png', '标准质量控制', '1554694194', '1568604768');
INSERT INTO `z_goods_service` VALUES ('6', '/uploads/20190916/3857ec0412833b6dd86baaa0eacc1235.png', '个性理疗方案', '1554694262', '1568604756');

-- ----------------------------
-- Table structure for z_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `z_goods_type`;
CREATE TABLE `z_goods_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(11) NOT NULL DEFAULT '1' COMMENT '排序 倒序',
  `jingdu` varchar(255) DEFAULT '',
  `weidu` varchar(255) DEFAULT '',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品分类';

-- ----------------------------
-- Records of z_goods_type
-- ----------------------------
INSERT INTO `z_goods_type` VALUES ('1', '深圳市', '0', '9', '114.05956', '22.54286', '1554692034', '1569383830');
INSERT INTO `z_goods_type` VALUES ('2', '广州市', '0', '8', '113.26436', '23.12908', '1554692045', '1569383914');
INSERT INTO `z_goods_type` VALUES ('3', '佛山市', '0', '7', '113.12192', '23.02185', '1566027190', '1569383970');
INSERT INTO `z_goods_type` VALUES ('4', '上海市', '0', '6', '121.4737', '31.23037', '1566027199', '1569383961');
INSERT INTO `z_goods_type` VALUES ('6', '福田区', '1', '9', '114.05454', '22.52291', '1566027524', '1569383849');
INSERT INTO `z_goods_type` VALUES ('7', '罗湖区', '1', '8', '114.13166', '22.54836', '1566029069', '1569383876');
INSERT INTO `z_goods_type` VALUES ('9', '宝安区', '1', '7', '113.88308', '22.55329', '1566029271', '1569383903');
INSERT INTO `z_goods_type` VALUES ('10', '天河区', '2', '10', '113.36199', '23.12463', '1566029289', '1569383928');
INSERT INTO `z_goods_type` VALUES ('12', '番禺区', '2', '8', '113.38424', '22.93772', '1566029305', '1569383995');
INSERT INTO `z_goods_type` VALUES ('13', '从化区', '2', '7', '113.58646', '23.54835', '1566029324', '1569384005');
INSERT INTO `z_goods_type` VALUES ('14', '黄埔区', '2', '6', '113.48067', '23.18139', '1566029374', '1569391761');
INSERT INTO `z_goods_type` VALUES ('15', '海珠区', '2', '5', '113.3172', '23.08331', '1566029385', '1569391778');
INSERT INTO `z_goods_type` VALUES ('16', '荔湾区', '2', '4', '113.24428', '23.12586', '1566029458', '1569391787');
INSERT INTO `z_goods_type` VALUES ('17', '南海区', '3', '10', '113.14278', '23.02882', '1566029531', '1569391805');
INSERT INTO `z_goods_type` VALUES ('18', '顺德区', '3', '9', '113.29321', '22.80536', '1566029662', '1569391814');
INSERT INTO `z_goods_type` VALUES ('19', '三水区', '3', '8', '112.89629', '23.15623', '1566029673', '1569391825');
INSERT INTO `z_goods_type` VALUES ('20', '长宁区', '4', '10', '121.42394', '31.22024', '1566029685', '1569391840');
INSERT INTO `z_goods_type` VALUES ('22', '静安区', '4', '8', '121.45591', '31.22352', '1566029708', '1569391858');
INSERT INTO `z_goods_type` VALUES ('23', '闵行区', '4', '7', '121.38206', '31.11325', '1566029716', '1569391901');
INSERT INTO `z_goods_type` VALUES ('24', '徐汇区', '4', '6', '121.43687', '31.18826', '1566029775', '1569391873');
INSERT INTO `z_goods_type` VALUES ('26', '花都区', '2', '10', '113.22026', '23.40391', '1567840944', '1569391796');
INSERT INTO `z_goods_type` VALUES ('27', '湛江市', '0', '8', '110.35894', '21.27134', '1567841013', '1569383942');
INSERT INTO `z_goods_type` VALUES ('28', '遂溪县', '27', '1', '110.25006', '21.37708', '1567841029', '1569383950');

-- ----------------------------
-- Table structure for z_msg
-- ----------------------------
DROP TABLE IF EXISTS `z_msg`;
CREATE TABLE `z_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '门店id',
  `fid` int(11) DEFAULT '0' COMMENT '反馈类型id',
  `f_name` varchar(30) NOT NULL DEFAULT '' COMMENT '反馈类型名称',
  `content` varchar(255) DEFAULT '' COMMENT '反馈内容',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1显示；2隐藏',
  `add_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='提议反馈表';

-- ----------------------------
-- Records of z_msg
-- ----------------------------
INSERT INTO `z_msg` VALUES ('1', '1', '1', '反馈类型1', '反馈内容', '1', '1567410136', '1567410136');
INSERT INTO `z_msg` VALUES ('2', '1', '1', '反馈类型1', '反馈内容2', '1', '1567410181', '1567410181');
INSERT INTO `z_msg` VALUES ('3', '1', '3', '反馈类型3', '111', '1', '1567495516', '1567495516');
INSERT INTO `z_msg` VALUES ('4', '1', '3', '反馈类型3', '111', '1', '1567495599', '1567495599');
INSERT INTO `z_msg` VALUES ('5', '1', '3', '反馈类型3', '测试', '1', '1567774102', '1567774102');
INSERT INTO `z_msg` VALUES ('6', '1', '3', '反馈类型3', '考虑兔兔KTV图', '1', '1569426141', '1569426141');

-- ----------------------------
-- Table structure for z_notice
-- ----------------------------
DROP TABLE IF EXISTS `z_notice`;
CREATE TABLE `z_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '理疗师id/doctor表id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '内容',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1请假通知；2档案审核通知',
  `is_read` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1未读；2已读',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='通知表';

-- ----------------------------
-- Records of z_notice
-- ----------------------------
INSERT INTO `z_notice` VALUES ('1', '1', '请假通知', '内容', '1', '2', '0', '1567649404');

-- ----------------------------
-- Table structure for z_order
-- ----------------------------
DROP TABLE IF EXISTS `z_order`;
CREATE TABLE `z_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `doctor_id` int(10) DEFAULT '0' COMMENT '理疗师id',
  `goods_id` int(10) DEFAULT '0' COMMENT '门店id',
  `comp_id` int(10) DEFAULT '0' COMMENT '服务id',
  `uid` int(10) DEFAULT '0',
  `number` varchar(255) DEFAULT '0' COMMENT '排队号码',
  `num` int(10) DEFAULT '0' COMMENT '前面等待人数',
  `time` int(10) DEFAULT '0' COMMENT '等待时间',
  `name` varchar(255) DEFAULT '' COMMENT '理疗师',
  `project` varchar(255) DEFAULT '' COMMENT '服务项目',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '支付金额，减掉优惠券优惠过后',
  `add_time` int(10) DEFAULT '0' COMMENT '取号时间',
  `update_time` int(10) DEFAULT NULL,
  `pay_time` int(10) DEFAULT '0' COMMENT '支付时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '1待消费2治疗中3已完成4已评价5已过号6已取消',
  `order_sn` varchar(255) DEFAULT '0' COMMENT '订单号',
  `coupon_id` int(10) DEFAULT '0' COMMENT '优惠券id',
  `coupon_price` decimal(10,2) DEFAULT '0.00' COMMENT '优惠券优惠金额',
  `total` decimal(10,2) DEFAULT '0.00' COMMENT '订单总价',
  `goods_name` varchar(255) DEFAULT '' COMMENT '门店名称',
  `treat_time` int(10) DEFAULT '0' COMMENT '治疗时间',
  `reason` varchar(255) DEFAULT '' COMMENT '取消原因',
  `bang_price` decimal(10,2) DEFAULT '0.00' COMMENT 'bang权益优惠金额',
  `pay_status` tinyint(1) DEFAULT '1' COMMENT '1未支付2已支付',
  `form_id` varchar(255) DEFAULT '',
  `user_coupon_id` int(10) DEFAULT '0',
  `form_pay_id` varchar(255) DEFAULT '',
  `form_discuss_id` varchar(255) DEFAULT NULL,
  `form_take_id` varchar(255) DEFAULT '' COMMENT '取号成功提醒form_id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of z_order
-- ----------------------------
INSERT INTO `z_order` VALUES ('1', '11', '4', '4', '25', 'A001', '0', '0', '测试用', '手部放松按摩', '0.00', '1571038217', '1571045480', '0', '6', '201910141530918719', '0', '0.00', '80.00', '紫轩堂', '0', '', '7.20', '1', 'the formId is a mock one', '0', '', null, '');
INSERT INTO `z_order` VALUES ('2', '11', '4', '4', '33', 'A002', '1', '60', '测试用', '手部放松按摩', '80.00', '1571038320', '1571041677', '1571041677', '6', '201910141532476473', '0', '0.00', '80.00', '紫轩堂', '1571037922', '', '0.00', '2', '1571038312884', '0', '', null, '');
INSERT INTO `z_order` VALUES ('3', '11', '4', '4', '24', 'A003', '2', '120', '测试用', '手部放松按摩', '0.00', '1571038980', '1571038980', '0', '6', '201910141543077199', '0', '0.00', '80.00', '紫轩堂', '0', '', '0.00', '1', '023d960762dc46849e5d00f4a3d69310', '0', '', null, '');
INSERT INTO `z_order` VALUES ('4', '11', '4', '4', '22', 'A004', '3', '126', '测试用', '手部放松按摩', '0.00', '1571039198', '1571039198', '0', '6', '201910141546305775', '0', '0.00', '80.00', '紫轩堂', '0', '', '0.00', '1', 'd61bd23fcfea4bcbad8d1fa7b36c4373', '0', '', null, '');
INSERT INTO `z_order` VALUES ('5', '11', '4', '4', '18', 'A005', '3', '180', '测试用', '手部放松按摩', '0.00', '1571045403', '1571045474', '0', '6', '201910141730927574', '0', '0.00', '80.00', '紫轩堂', '0', '', '0.00', '1', '92eac21aaf3d416cbe522aafbe7bae92', '0', '', null, '');
INSERT INTO `z_order` VALUES ('6', '10', '5', '3', '13', 'A001', '0', '0', '周杰伦', '颈肩腰理疗服务', '100.00', '1571101689', '1571101999', '1571101999', '4', '201910150908877624', '0', '0.00', '100.00', '天天按摩', '1571101776', '', '0.00', '2', 'e621d9cb1ad945dfae130d28b912153e', '0', '', null, '');
INSERT INTO `z_order` VALUES ('7', '10', '5', '3', '6', 'A002', '1', '60', '周杰伦', '颈肩腰理疗服务', '0.00', '1571101750', '1571826832', '0', '3', '201910150909641184', '79', '0.00', '100.00', '天天按摩', '1571102045', '', '0.00', '1', '8a697b75b52f47fab10d844fe4142050', '0', '', null, '');
INSERT INTO `z_order` VALUES ('8', '11', '4', '4', '18', 'A003', '0', '0', '测试用', '手部放松按摩', '75.00', '1571106886', '1571119766', '1571119766', '3', '201910151034031811', '0', '5.00', '80.00', '紫轩堂', '1571106983', '', '0.00', '2', '87a527b439854fcea6017e4e85942a35', '0', '', null, '');
INSERT INTO `z_order` VALUES ('9', '11', '4', '4', '37', 'A004', '1', '60', '测试用', '手部放松按摩', '0.00', '1571106916', '1571107017', '0', '5', '201910151035043925', '0', '0.00', '80.00', '紫轩堂', '0', '', '0.00', '1', '7faa327a304f48d1b5414441c23a597e', '0', '', null, '');
INSERT INTO `z_order` VALUES ('10', '11', '4', '4', '25', 'A005', '0', '0', '测试用', '手部放松按摩', '0.00', '1571110253', '1571110253', '0', '6', '201910151130741392', '0', '0.00', '80.00', '紫轩堂', '0', '计划有变', '7.20', '1', 'the formId is a mock one', '0', '', null, '');
INSERT INTO `z_order` VALUES ('11', '11', '4', '4', '25', 'A006', '0', '0', '测试用', '手部放松按摩', '0.00', '1571110320', '1571110441', '0', '5', '201910151132536580', '0', '0.00', '80.00', '紫轩堂', '0', '', '7.20', '1', 'the formId is a mock one', '0', '', null, '');
INSERT INTO `z_order` VALUES ('12', '11', '4', '4', '25', 'A007', '0', '0', '测试用', '手部放松按摩', '72.80', '1571110593', '1571111110', '1571111110', '4', '201910151136679086', '0', '0.00', '80.00', '紫轩堂', '1571111075', '', '7.20', '2', 'the formId is a mock one', '0', '', null, '');
INSERT INTO `z_order` VALUES ('13', '11', '4', '4', '25', 'A008', '0', '0', '测试用', '手部放松按摩', '72.80', '1571111891', '1571111970', '1571111970', '4', '201910151158647960', '0', '0.00', '80.00', '紫轩堂', '1571111904', '', '7.20', '2', 'the formId is a mock one', '0', '', 'the formId is a mock one', '');
INSERT INTO `z_order` VALUES ('14', '11', '4', '4', '18', 'A009', '0', '0', '测试用', '手部放松按摩', '0.00', '1571119798', '1571119834', '0', '5', '201910151409646563', '0', '0.00', '80.00', '紫轩堂', '0', '', '0.00', '1', '3be169614c1c46c8aea65dd75f5daca3', '0', '', null, '');
INSERT INTO `z_order` VALUES ('15', '11', '4', '4', '18', 'A010', '0', '0', '测试用', '手部放松按摩', '0.00', '1571119857', '1571119857', '0', '6', '201910151410663280', '0', '0.00', '80.00', '紫轩堂', '0', '等待时间太久了', '0.00', '1', '5f4eccbf1ba044609097fcfaff3aac30', '0', '', null, '');
INSERT INTO `z_order` VALUES ('16', '11', '4', '4', '25', 'A001', '0', '0', '测试用', '手部放松按摩', '0.00', '1571207372', '1571207372', '0', '6', '201910161429077190', '0', '0.00', '80.00', '紫轩堂', '0', '重复取号', '7.20', '1', 'the formId is a mock one', '0', '', null, '');
INSERT INTO `z_order` VALUES ('17', '11', '4', '4', '25', 'A002', '0', '0', '测试用', '手部放松按摩', '72.80', '1571220248', '1571822263', '1571822263', '4', '201910161804821338', '61', '0.00', '80.00', '紫轩堂', '0', '', '7.20', '2', 'the formId is a mock one', '0', '3545efd8e96643c2aabbdfffa363bb91', '3c20609a14774176842d4570ea0cc9bd', '');
INSERT INTO `z_order` VALUES ('18', '11', '4', '4', '19', 'A001', '0', '0', '测试用', '手部放松按摩', '0.00', '1571709330', '1571709330', '0', '6', '201910220955935607', '0', '0.00', '80.00', '紫轩堂', '0', '其他', '0.00', '1', '93a96180424f46b5b03af265d0057601', '0', '', null, '');
INSERT INTO `z_order` VALUES ('19', '7', '1', '15', '19', 'A002', '0', '0', 'test', '舒肩松颈', '0.00', '1571710351', '1571710351', '0', '6', '201910221012761961', '0', '0.00', '38.80', '足三里按摩', '0', '等待时间太久了', '0.00', '1', 'ad1f4e3634a142eeb1d20b731391fe2f', '0', '', null, '');
INSERT INTO `z_order` VALUES ('20', '7', '1', '15', '19', 'A003', '0', '0', 'test', '舒肩松颈', '0.00', '1571710402', '1571710402', '0', '6', '201910221013975557', '0', '0.00', '38.80', '足三里按摩', '0', '等待时间太久了', '0.00', '1', '7ad4af3ac5024ae7a3a4b962e77103a0', '0', '', null, '');
INSERT INTO `z_order` VALUES ('25', '7', '1', '15', '25', 'A001', '0', '0', 'test', '舒肩松颈', '35.31', '1571824053', '1571824077', '1571824077', '4', '201910231747251579', '0', '0.00', '38.80', '足三里按摩', '1571824063', '', '3.49', '2', 'b2ff8bee8e2e455abab2b7bbede0b93a', '0', '5b72102c686f4cc484757a1fabcae0ab', '7a5a3071079a4cdfb10269bd6cc59ea8', '');
INSERT INTO `z_order` VALUES ('26', '10', '5', '1', '13', 'A002', '1', '0', '周杰伦', '头肩颈理疗服务', '120.00', '1571826808', '1571889036', '1571889036', '4', '201910231833546864', '0', '0.00', '120.00', '天天按摩', '1571826836', '', '0.00', '2', 'e53db5b194f5441b9ceb33dd00377442', '0', '6fe19109f4e64a36825cd297ecdccd3f', 'ef9097f1da824f1bab6d135ae2233907', '');
INSERT INTO `z_order` VALUES ('31', '7', '1', '15', '25', 'A001', '0', '0', 'test', '舒肩松颈', '35.31', '1571882612', '1571889412', '1571889412', '3', '201910241003941178', '0', '0.00', '38.80', '足三里按摩', '1571882625', '', '3.49', '2', 'fef9f4c91bbe4f379af77d2caa0edd3e', '0', 'the formId is a mock one', null, '');
INSERT INTO `z_order` VALUES ('32', '11', '4', '4', '18', 'A002', '0', '0', '测试用', '手部放松按摩', '0.00', '1571909642', '1571909642', '0', '6', '201910241734562191', '0', '0.00', '80.00', '紫轩堂', '0', '等待时间太久了', '0.00', '1', '5d358e47f5354799840be578733cb26c', '0', '', null, '');
INSERT INTO `z_order` VALUES ('33', '11', '4', '4', '18', 'A003', '0', '0', '测试用', '手部放松按摩', '0.00', '1571909731', '1571909731', '0', '6', '201910241735526773', '0', '0.00', '80.00', '紫轩堂', '0', '价格贵', '0.00', '1', '443484ecf7be4ef0a509b79897b66b67', '0', '', null, '');
INSERT INTO `z_order` VALUES ('53', '11', '4', '4', '19', 'A001', '0', '0', '测试用', '手部放松按摩', '0.00', '1572234768', '1572234768', '0', '6', '201910281152506576', '0', '0.00', '80.00', '紫轩堂', '0', '等待时间太久了', '7.20', '1', '643173b2a3b241b0a53bb9a911507604', '0', '', null, '');
INSERT INTO `z_order` VALUES ('54', '11', '4', '4', '19', 'A002', '0', '0', '测试用', '手部放松按摩', '0.00', '1572253735', '1572253735', '0', '6', '201910281708456468', '0', '0.00', '80.00', '紫轩堂', '0', '等待时间太久了', '7.20', '1', '64d6608118aa4a50a9f64d056ae11bc1', '0', '', null, '');

-- ----------------------------
-- Table structure for z_order_reason
-- ----------------------------
DROP TABLE IF EXISTS `z_order_reason`;
CREATE TABLE `z_order_reason` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT '' COMMENT '取消原因',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='取消订单原因';

-- ----------------------------
-- Records of z_order_reason
-- ----------------------------
INSERT INTO `z_order_reason` VALUES ('36', '等待时间太久了', '1569806565', '1569806565');
INSERT INTO `z_order_reason` VALUES ('37', '喜爱的理疗师不在', '1569806585', '1569806585');
INSERT INTO `z_order_reason` VALUES ('38', '重复取号', '1569806601', '1569806601');
INSERT INTO `z_order_reason` VALUES ('39', '到店无人服务', '1569806612', '1569806612');
INSERT INTO `z_order_reason` VALUES ('40', '沟通不顺畅', '1569806623', '1569806623');
INSERT INTO `z_order_reason` VALUES ('41', '服务态度不好', '1569806631', '1569806631');
INSERT INTO `z_order_reason` VALUES ('42', '选错了（店/人/服务）', '1569806652', '1569806652');
INSERT INTO `z_order_reason` VALUES ('43', '想换一个理疗师', '1569806665', '1569806665');
INSERT INTO `z_order_reason` VALUES ('44', '计划有变', '1569806674', '1569806674');
INSERT INTO `z_order_reason` VALUES ('45', '价格贵', '1569806683', '1569806683');
INSERT INTO `z_order_reason` VALUES ('46', '有理疗禁忌', '1569806695', '1569806695');
INSERT INTO `z_order_reason` VALUES ('47', '其他', '1569806702', '1569806702');

-- ----------------------------
-- Table structure for z_order_type
-- ----------------------------
DROP TABLE IF EXISTS `z_order_type`;
CREATE TABLE `z_order_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='评价类型表';

-- ----------------------------
-- Records of z_order_type
-- ----------------------------
INSERT INTO `z_order_type` VALUES ('20', '服务好', '1570522235', '1570776257');
INSERT INTO `z_order_type` VALUES ('21', '专业', '1570522243', '1570522243');
INSERT INTO `z_order_type` VALUES ('22', '方便', '1570776248', '1570776248');
INSERT INTO `z_order_type` VALUES ('23', '智能化操作', '1570776270', '1570776270');
INSERT INTO `z_order_type` VALUES ('24', '性价比高', '1570776280', '1570776280');
INSERT INTO `z_order_type` VALUES ('25', '网红养生', '1570776300', '1570776300');

-- ----------------------------
-- Table structure for z_perfect
-- ----------------------------
DROP TABLE IF EXISTS `z_perfect`;
CREATE TABLE `z_perfect` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT '' COMMENT '说明',
  `type` tinyint(1) DEFAULT '1' COMMENT '1疼痛位置2疼痛方式3疼痛时间4既往史5反馈类型',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='个人档案基本信息';

-- ----------------------------
-- Records of z_perfect
-- ----------------------------
INSERT INTO `z_perfect` VALUES ('1', '颈部', '1', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('2', '背部', '1', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('3', '腰部', '1', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('4', '大腿', '1', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('5', '小腿', '1', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('6', '脚', '1', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('7', '有时候痛有时候不痛', '2', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('8', '持续性疼痛，但强度不同', '2', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('9', '一直感觉痛，强度不变', '2', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('10', '白天居多', '3', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('11', '晚上居多', '3', '1567652916', '1568689432');
INSERT INTO `z_perfect` VALUES ('12', '时间不定', '3', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('13', '曾有重大疾病或手术史', '4', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('14', '无', '4', '1567652916', '0');
INSERT INTO `z_perfect` VALUES ('15', '接私单', '5', '1575454000', '1568187901');
INSERT INTO `z_perfect` VALUES ('16', '治疗师上班离岗', '5', '1575454000', '0');
INSERT INTO `z_perfect` VALUES ('17', '服务沟通&态度', '5', '1575454000', '0');
INSERT INTO `z_perfect` VALUES ('18', '肌骨理疗效果', '5', '1575454000', '0');
INSERT INTO `z_perfect` VALUES ('19', '门店卫生&陈列', '5', '1575454000', '0');
INSERT INTO `z_perfect` VALUES ('20', '手法优化', '5', '1575454000', '0');
INSERT INTO `z_perfect` VALUES ('21', '其他', '5', '1575454000', '0');

-- ----------------------------
-- Table structure for z_plan
-- ----------------------------
DROP TABLE IF EXISTS `z_plan`;
CREATE TABLE `z_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单id',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '门店id',
  `doctor_id` int(11) NOT NULL DEFAULT '0' COMMENT '理疗师id',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `fid` int(11) DEFAULT '0' COMMENT '反馈类型id',
  `sid` int(11) DEFAULT '0' COMMENT '病痛级别id',
  `f_name` varchar(30) NOT NULL DEFAULT '' COMMENT '反馈类型名称',
  `s_name` varchar(30) NOT NULL DEFAULT '' COMMENT '病痛级别名称',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `head_img` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '理疗师名称',
  `project` varchar(255) DEFAULT '' COMMENT '服务项目',
  `content` varchar(255) DEFAULT '' COMMENT '理疗师方案',
  `img` varchar(255) DEFAULT '' COMMENT '图片',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='针对方案';

-- ----------------------------
-- Records of z_plan
-- ----------------------------
INSERT INTO `z_plan` VALUES ('7', '6', '1', '1', '2', '1', '4', '反馈类型1', '关节痛', '天', 'https://wx.qlogo.cn/mmopen/vi_32/v5gEtVWR1F2ajG24OkDdviaibxt0lLkVp7kic5WiazdUZmEUYhKcMKMzGEwXhh0JjJRMicameysBgUksRicuWic1d99ww/132', '迪丽热巴', '头肩颈理疗服务', '你的', '/uploads/20190905/30ae15e63c7093f681040cbf4e80e509.jpg', '1567678051', '1567678051');
INSERT INTO `z_plan` VALUES ('4', '6', '1', '1', '2', '3', '4', '反馈类型3', '关节痛', '景甜', 'https://wx.qlogo.cn/mmopen/vi_32/v5gEtVWR1F2ajG24OkDdviaibxt0lLkVp7kic5WiazdUZmEUYhKcMKMzGEwXhh0JjJRMicameysBgUksRicuWic1d99ww/132', '迪丽热巴', '头肩颈理疗服务', '111', '/uploads/20190829/904bd84618c0f8fd47281761cfd31862.jpg', '1567069275', '1567069275');
INSERT INTO `z_plan` VALUES ('5', '6', '1', '1', '2', '1', '4', '反馈类型1', '关节痛', '开门七件事', 'https://wx.qlogo.cn/mmopen/vi_32/v5gEtVWR1F2ajG24OkDdviaibxt0lLkVp7kic5WiazdUZmEUYhKcMKMzGEwXhh0JjJRMicameysBgUksRicuWic1d99ww/132', '迪丽热巴', '头肩颈理疗服务', 'qqq', '/uploads/20190829/fcfa3844e5e57b195aa5f0430099b0af.jpg', '1567069500', '1567069500');
INSERT INTO `z_plan` VALUES ('3', '1', '1', '1', '1', '1', '1', '反馈类型1', '骨科', '腔棘鱼', 'https://wx.qlogo.cn/mmopen/vi_32/QUZym24btYS2VK9MTCticGjR3m44QYPBTUWvq4pgTdXXG7F6WibDEEBcVY2wgDwdcBVMg5Ruy6IKCHyDAXg4UFMg/132', '理疗师名称', '服务项目', '理疗师方案', '/uploads/20190819/08feb6530f85fa905c80cf94f9da3ae7.jpg,/uploads/20190819/08feb6530f85fa905c80cf94f9da3ae7.jpg', '1566971188', '1566971188');
INSERT INTO `z_plan` VALUES ('6', '6', '1', '1', '2', '1', '4', '反馈类型1', '关节痛', '李剑成', 'https://wx.qlogo.cn/mmopen/vi_32/v5gEtVWR1F2ajG24OkDdviaibxt0lLkVp7kic5WiazdUZmEUYhKcMKMzGEwXhh0JjJRMicameysBgUksRicuWic1d99ww/132', '迪丽热巴', '头肩颈理疗服务', '11', '/uploads/20190905/24541b5d66091ba00078344e3a7de676.jpg', '1567677922', '1567677922');
INSERT INTO `z_plan` VALUES ('8', '32', '1', '5', '11', '1', '8', '反馈类型1', '好痛', '谜一样的男人', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLbw8jIDlh1ngMSEjD7iawBUUerKT0gN26Hibjm4KwBiaLKU5EHA3icfPIYfWib32qCqbd0d1I9dzSzlEQ/132', '景甜', '足疗按摩', '可以', '/uploads/20190909/f12a7d8a51c36695c9cc7be7cb1318b6.jpg', '1568012797', '1568012797');
INSERT INTO `z_plan` VALUES ('9', '69', '2', '3', '25', '3', '8', '反馈类型3', '好痛', '', 'https://wx.qlogo.cn/mmopen/vi_32/b6aXRqRBDMs7ibg1T0UbuNtyvgHc2SwAZM8FjAynz9eT5jYLFLLdx8drPLp390UkcLUzrMzeTb4ict2DRq9WhRnA/132', '刘亦菲', '腰部按摩', '45552685366', '/uploads/20190925/90c07888bd3a60f7545a658efdcb9f57.png,/uploads/20190925/5cf5366abbf6648f89d2e65f2678fc7e.jpg', '1569425184', '1569425184');
INSERT INTO `z_plan` VALUES ('10', '69', '2', '3', '25', '3', '8', '反馈类型3', '好痛', '', 'https://wx.qlogo.cn/mmopen/vi_32/b6aXRqRBDMs7ibg1T0UbuNtyvgHc2SwAZM8FjAynz9eT5jYLFLLdx8drPLp390UkcLUzrMzeTb4ict2DRq9WhRnA/132', '刘亦菲', '腰部按摩', '嗯嗯嗯嗯嗯嗯', '/uploads/20190925/f6e40f36329daca6ea4aceb228fc119b.jpg,/uploads/20190925/4f6c032d7232f159e0f23ff6c3ff4cf7.jpg', '1569426283', '1569426283');
INSERT INTO `z_plan` VALUES ('11', '80', '3', '4', '6', '3', '8', '反馈类型3', '好痛', '', 'https://wx.qlogo.cn/mmopen/vi_32/dXVQUw2puRniaHaWibYWgwFoHG0dtBfRiauJhwLlxjfwv5xpEuV7DJgaX7Ugjckibz1UPX1Irr4mohr1kfeCf6s7FQ/132', '月月', '头部放松', '黑莓民工你还好吗', '/uploads/20190926/19737b1a4d16d9930405f569872a3b16.jpg,/uploads/20190926/67dee6338bb7a077c39d13b5e7386f01.jpg', '1569479785', '1569479785');
INSERT INTO `z_plan` VALUES ('12', '119', '1', '5', '13', '3', '8', '反馈类型3', '好痛', 'If this is the reality', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIl6xZHpyeyRRO7CtEaKq9f1TMmqwYS9ruqk2xqYicF78cE0NM5cx8V5icftfOxlIGL7ZD39XIv7MGg/132', '景甜', '足疗按摩', '123456789', '/uploads/20190929/528f77ae4e2dac8c0c10c30a3c4abea3.jpg', '1569744614', '1569744614');
INSERT INTO `z_plan` VALUES ('13', '139', '4', '11', '37', '4', '8', 'test', '好痛', 'ss', 'https://wx.qlogo.cn/mmopen/vi_32/Vdnr6JvGjZOYxBk2pY6GsntrrgPiaib6a0ibcd1brzzmOBrLQp8rTEuYP9iawLT7tYGgQedQTCCSMd9baVv5iaQRicvw/132', '测试用', '手部放松按摩', '123456', '/uploads/20191009/07063a14532e84885e7ef14ba4af6072.jpg', '1570610378', '1570610378');
INSERT INTO `z_plan` VALUES ('14', '141', '5', '10', '13', '4', '8', 'test', '好痛', 'If this is the reality', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIl6xZHpyeyRRO7CtEaKq9f1TMmqwYS9ruqk2xqYicF78cE0NM5cx8V5icftfOxlIGL7ZD39XIv7MGg/132', '周杰伦', '颈肩腰理疗服务', '方案方案方案', '/uploads/20191009/b7b9074e3e1e08776b6fc38dae3da152.jpg', '1570610777', '1570610777');
INSERT INTO `z_plan` VALUES ('15', '6', '5', '10', '13', '4', '8', 'test', '好痛', 'If this is the reality', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIl6xZHpyeyRRO7CtEaKq9f1TMmqwYS9ruqk2xqYicF78cE0NM5cx8V5icftfOxlIGL7ZD39XIv7MGg/132', '周杰伦', '颈肩腰理疗服务', '还拉巴巴巴拉粑粑啊粉末', '/uploads/20191015/c0ecd8d87b6375741fb33f62d9cde990.png', '1571102113', '1571102113');

-- ----------------------------
-- Table structure for z_search
-- ----------------------------
DROP TABLE IF EXISTS `z_search`;
CREATE TABLE `z_search` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '热搜单词',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of z_search
-- ----------------------------
INSERT INTO `z_search` VALUES ('1', '面膜', '1556334483', '1556345579');
INSERT INTO `z_search` VALUES ('2', '口红', '1556345569', '1556345569');

-- ----------------------------
-- Table structure for z_sickness
-- ----------------------------
DROP TABLE IF EXISTS `z_sickness`;
CREATE TABLE `z_sickness` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT '0' COMMENT '上级id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '标题',
  `sort` int(11) DEFAULT '0' COMMENT '排序 倒序',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='病痛级别';

-- ----------------------------
-- Records of z_sickness
-- ----------------------------
INSERT INTO `z_sickness` VALUES ('1', '0', '骨科', '1', '1566961300', '1566961300');
INSERT INTO `z_sickness` VALUES ('2', '0', '内科2', '2', '1566961316', '1566961557');
INSERT INTO `z_sickness` VALUES ('4', '1', '关节痛', '1', '1566961355', '1566961355');
INSERT INTO `z_sickness` VALUES ('5', '1', '颈椎', '2', '1566961368', '1566961368');
INSERT INTO `z_sickness` VALUES ('7', '0', '通风', '3', '1567842471', '1567842471');
INSERT INTO `z_sickness` VALUES ('8', '7', '好痛', '4', '1567842485', '1567842485');

-- ----------------------------
-- Table structure for z_user
-- ----------------------------
DROP TABLE IF EXISTS `z_user`;
CREATE TABLE `z_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `head_img` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别 1男 2女',
  `age` int(11) NOT NULL DEFAULT '0' COMMENT '用户年龄段 1小于等于17  2/18-25 3/26-35 4/36-45 5/大于等于47',
  `province` varchar(255) NOT NULL DEFAULT '' COMMENT '省份',
  `city` varchar(255) NOT NULL DEFAULT '' COMMENT '城市',
  `openid` varchar(255) NOT NULL DEFAULT '' COMMENT '用户openid',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 1 正常 2冻结',
  `token` varchar(255) NOT NULL DEFAULT '' COMMENT '用户 token 接口凭证',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `phone` char(11) DEFAULT '' COMMENT '手机号',
  `state` tinyint(1) DEFAULT '1' COMMENT '1未完善个人档案2已完善',
  `money` decimal(10,2) DEFAULT '0.00' COMMENT '累计获得奖励',
  `top_id` int(10) DEFAULT '0' COMMENT '上级id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of z_user
-- ----------------------------
INSERT INTO `z_user` VALUES ('1', '腔棘鱼\\ue522', 'https://wx.qlogo.cn/mmopen/vi_32/QUZym24btYS2VK9MTCticGjR3m44QYPBTUWvq4pgTdXXG7F6WibDEEBcVY2wgDwdcBVMg5Ruy6IKCHyDAXg4UFMg/132', '1', '2', '广西', '南宁', 'ouZZK5NJSLZVvAUpXkDgx-HU38wg', '1', 'bbcb2998febe5d3d107635a0fb115169', '1555121675', '1555376501', '13520365236', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('2', '\\ud83c\\uddf2 \\ud83c\\uddf7 ·\\ud83c\\uddf5 \\ud83c\\uddef\\ud83d\\ude43', 'https://wx.qlogo.cn/mmopen/vi_32/v5gEtVWR1F2ajG24OkDdviaibxt0lLkVp7kic5WiazdUZmEUYhKcMKMzGEwXhh0JjJRMicameysBgUksRicuWic1d99ww/132', '1', '2', '贵州', '六盘水', 'ouZZK5KhgnGtZ0Z3h_CDxWj3_KC8', '1', '817f5a00bf6a3ae98d76c6a7bf349c37', '1555395758', '1555395758', '18502053636', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('4', '烟℃', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eogiawZOpKUbcH4G5JROIJKkibO77P6yK0Iia1Gp35DwD7M889ibia19PkM4RibveXib8asaicZVVPnxf5Pog/132', '1', '0', '广东', '广州', 'oxLld5fHkVwaPc9RCgVsI0CyzNjc', '1', 'ab1aeaa5781e3a5000dea2b468302868', '1566627483', '1567697812', '16620183944', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('6', '\\ud83c\\uddf2 \\ud83c\\uddf7 ·\\ud83c\\uddf5 \\ud83c\\uddef\\ud83d\\ude43', 'https://wx.qlogo.cn/mmopen/vi_32/dXVQUw2puRniaHaWibYWgwFoHG0dtBfRiauJhwLlxjfwv5xpEuV7DJgaX7Ugjckibz1UPX1Irr4mohr1kfeCf6s7FQ/132', '1', '0', '贵州', '六盘水', 'oxLld5dHOUU42p43tvSmxPCTIfQs', '1', '8ba48fac4084dc4bb1b18b3d47c84a20', '1567411255', '1567411255', '', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('13', 'If this is the reality', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIl6xZHpyeyRRO7CtEaKq9f1TMmqwYS9ruqk2xqYicF78cE0NM5cx8V5icftfOxlIGL7ZD39XIv7MGg/132', '1', '0', '广东', '韶关', 'oxLld5SvFuKMowUHDL1B4EqPYmNs', '1', 'e73a70e51bc8eb6f5437e186820bf474', '1567733024', '1571101573', '15007517166', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('14', '娃娃', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLicicvOrs7nC7afjR26j51a58gwKHg36ib3rkRqqx7PwpInQALgbiaic2zGZ7p6iakcrOV7DiaIeVgI2UQg/132', '2', '0', '北京', '', 'oxLld5QZ5ceMTSz00fDITlGJhXio', '1', 'b653f5896760380856b86ed6381da838', '1567751285', '1567751285', '', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('16', 'Gavin', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLyUx9XUpg7yHq0rHgOLbYXoPMosKPJ5TxYPVyiaERrH6OTt1Hgn6hyIWQrCBHZ3vbRCx5eWce7t6g/132', '1', '0', '广东', '广州', 'oxLld5T8_Qc1dDqrD-ejYGy8mSoY', '1', '0b52e0c0a2fd4422e00e37386edcacbd', '1567768179', '1567768179', '', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('17', '付立军', 'https://wx.qlogo.cn/mmopen/vi_32/chAUVopjF69vqZq8AWx7DtSIpxNnXudnaqejibJ9nz1QxkVscdjc9tFROWLgqiaPpjb7yGGhhBzl9j8YTiaYkBeZg/132', '1', '0', '广东', '广州', 'oxLld5TKq7A6lvEYi_jAYWHSWcew', '1', '78e2d2db51af95a9e8ec9bab58c618ec', '1567772385', '1567772399', '13312875877', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('18', 'gigi', 'https://wx.qlogo.cn/mmopen/vi_32/auX6vLoEiamVLCGH2EPOw9SUwSx2PzS8YGPpVicRF1TqfwBc0TM2W2ddicahL8cNac4x3GafUYJybefbIsBg0Kq1Q/132', '2', '0', '广东', '广州', 'oxLld5Xz8PaA2Udi-AfbTELcp8Cc', '1', 'dab76014bc456c1283e43bb9ec267172', '1567992356', '1568095460', '13724158053', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('19', '.  K', 'https://wx.qlogo.cn/mmopen/vi_32/4jIAAY4JiaDNYYcVlT93loo0I93hDTEqcWLB1mvNeBSPPLnibGm50o49vBL6EWP0IZDB9udcIXr1HlbF0TftmqZg/132', '1', '0', '', '', 'oxLld5Uz96tXyptEC4S7moSHITeQ', '1', '997e50108c9baf967d123d4692f2a0c8', '1567998344', '1572245348', '18676888831', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('22', 'A\\ud83d\\udc8b网站建设、全国营销', 'https://wx.qlogo.cn/mmopen/vi_32/RqqhH41MRXv0BQRicfYQd0ice6wCUd8q1fuZJrYqjwknFUA9JU2kg0on5ZciaO8g0tUHysM3rq1G05eWicGMN1H7JA/132', '1', '0', '江西', '赣州', 'oxLld5TbNB-mzBh1iyLhYRI6ojSI', '1', '4b88130567378ffd5c367b0f653da400', '1568269173', '1568534427', '', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('24', '谜一样的男人', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLbw8jIDlh1ngMSEjD7iawBUUerKT0gN26Hibjm4KwBiaLKU5EHA3icfPIY7jickS65Be5egF7iaeB3wocw/132', '1', '0', '⁡⁢', '受相关部门保护  不予公开', 'oxLld5QAyE0D_KlEXmE22htAj9Ck', '1', '9b4e590c99449397d74cf89fdac5dd02', '1568600060', '1571037274', '', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('25', '\\ud83c\\uddf1 \\ud83c\\uddef \\ud83c\\udde8', 'https://wx.qlogo.cn/mmopen/vi_32/b6aXRqRBDMs7ibg1T0UbuNtyvgHc2SwAZM8FjAynz9eT5jYLFLLdx8drPLp390UkcLUzrMzeTb4ict2DRq9WhRnA/132', '1', '0', '广东', '广州', 'oxLld5cONDEtlMd2Xkug57vv0JPw', '1', '6dcd98d960729cd6355315521c177d85', '1568600108', '1572424648', '13129087405', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('26', 'yzc', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJEzsfQaBEHvaW2wwmNANjBoKDtbAHGhfFYUrNsK0jRrhTTDDib7AibHUOzOBdoVldNX3q6CD6bC7vA/132', '0', '0', '', '', 'oxLld5bmugJnNPxKW0Ts-wxnAYhY', '1', '587b2c74802d2f77c047c61631ed608b', '1568691240', '1569655767', '18124901487', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('27', '\\ud83c\\udf11\\ud83c\\udf18\\ud83c\\udf17\\ud83c\\udf16\\ud83c\\udf1d', 'https://wx.qlogo.cn/mmopen/vi_32/gA6n5hGTNVFzOJrquibYGibJf2PUNresHf8cVa3tdmAEZU1s9WM4M11Rzpz4HtUqWABKFMd2vM8KiaonYhUc0xmkA/132', '1', '0', '广东', '广州', 'oxLld5bWvbPURIz3zKbup0gok0rg', '1', 'd111d6369555848e2ed723cae41d8a34', '1569297097', '1569307125', '', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('28', 'C.C', 'https://wx.qlogo.cn/mmopen/vi_32/A9sgAd9PVbOK0J2S5BY8d5ibbDvyvGribncaOacDucibWyZtKhyibPliaHMXPGL9aY8nralu9DgD8fmRTuTyY2ziapUA/132', '2', '0', '', '', 'oxLld5Y-IEaOOEehbNDrydzsmE_c', '1', '25650648fff0ab76b4a53820222d101b', '1569579619', '1569579620', '', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('33', '哎呀จุ๊บ', 'https://wx.qlogo.cn/mmopen/vi_32/nrXJ146UEAeTHTIK5wclPmyA8dc1b34gBMJbp2uW9fmMuLLYzN4o40EA2icAKkn9K7DOGsIsOAGyQ3QwnlloKwQ/132', '1', '0', '广东', '广州', 'oxLld5U_0yAssMCfaTUruvU1_AQg', '1', '5fbb85a373d8981443b93242feb4b554', '1569744964', '1569744964', '', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('35', 'Dexter.\\ue04c', 'https://wx.qlogo.cn/mmopen/vi_32/GvYzEoLTe1CLbA5dRkqc00IHvmhKB23tMLexicfmBL2c88tcEzNfF0XYWOZgreicZJXOSx4L3N2ibd470uyzThn8w/132', '2', '0', '广东', '广州', 'oxLld5Watpg_VvyLrKZ0dFn5rvvE', '1', '0b16b0d464749d88411c02bb37a5e9f9', '1569747649', '1569808437', '15310618120', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('36', '初心不忘（Robert）', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoIMojnSiaCx5z34gdTtN18707EIqtPBMN6sCicUsU32974ibVaqNV2coKu7d0kUWZGxwoS6IrPt9jpg/132', '1', '0', '广东', '深圳', 'oxLld5c2Npp6yzngDLJnLFGgZiXg', '1', '7de07faadf9aa14d54a79916b8b20e7b', '1570588209', '1570588216', '13360502899', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('37', 'ss', 'https://wx.qlogo.cn/mmopen/vi_32/Vdnr6JvGjZOYxBk2pY6GsntrrgPiaib6a0ibcd1brzzmOBrLQp8rTEuYP9iawLT7tYGgQedQTCCSMd9baVv5iaQRicvw/132', '2', '0', 'JO', '', 'oxLld5R_csIen0zJV3D99om_A838', '1', '81a1cd98debb7e819120e7e2e9f8cd0e', '1570588242', '1570588242', '', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('38', '千夏之初', 'https://wx.qlogo.cn/mmopen/vi_32/nsEyia5yEE3xxxGpxbHL2UrY0tcAMBu0VjEDaZg6RIx7zAf7FNIpw4VibZx9LO7DQlEPae5DxGc9eUUicAXpgJVCw/132', '0', '0', '', '', 'oxLld5V-KZ-mdJBqZymz7XURs9RQ', '1', '33b12a3df48b860b76bb3eef6d9f2b20', '1571970672', '1571970672', '', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('39', '母笑阳', 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEJCjnwIk13AenBEg33O01lIZARibg7Ua8GriavPmvqb1SyMrWXj6J60QHlERkJj05UibzvtddIePmSKQ/132', '2', '0', 'Hebei', 'Baoding', 'oxLld5R_N-EyvGScw8eg2uLqQcr8', '1', 'c255e2b8e720266e446e427da0b96262', '1572085168', '1572085168', '', '2', '0.00', '0');
INSERT INTO `z_user` VALUES ('40', '陈致希', 'https://wx.qlogo.cn/mmhead/KGibZnZyTbMvia3vye6IMXy4QFhNp7xx0PtfzftmqsibvQ/132', '0', '0', '', '', 'oxLld5fWB-He1HuIjRi3tKCoEins', '1', '0db1ba0f71b5a6d9f9329bdab3fa3d6d', '1572085181', '1572085181', '', '1', '0.00', '0');
INSERT INTO `z_user` VALUES ('41', '宋光', 'https://wx.qlogo.cn/mmopen/vi_32/RibjRDqUzNfpRLFMOGFOicV432mkZUgeqzpbpWWBicSOKcG56vibCaJuhf2DB3OFKLoevYN7xF4BveYQPTTDg4dibEw/132', '1', '0', '广东', '广州', 'oxLld5fibbbfd1Sp8U-gtww43Udc', '1', 'b8d65ff18706ad1caaecd8cde08d956a', '1572268554', '1572268554', '', '1', '0.00', '19');

-- ----------------------------
-- Table structure for z_user_address
-- ----------------------------
DROP TABLE IF EXISTS `z_user_address`;
CREATE TABLE `z_user_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `tel` char(11) NOT NULL DEFAULT '0' COMMENT '收货人手机号',
  `zip_code` int(11) NOT NULL DEFAULT '0' COMMENT '邮政编码',
  `province` varchar(255) NOT NULL DEFAULT '' COMMENT '省',
  `city` varchar(255) NOT NULL DEFAULT '' COMMENT '市',
  `area` varchar(255) NOT NULL DEFAULT '' COMMENT '区',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '详细地址',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户收货地址';

-- ----------------------------
-- Records of z_user_address
-- ----------------------------
INSERT INTO `z_user_address` VALUES ('1', '0', '11', '222', '12', '广东省', '广州市', '海珠区', '11', '1555401769', '1555401769');
INSERT INTO `z_user_address` VALUES ('2', '0', '黄湘黄', '13790038275', '23', '广东省', '广州市', '海珠区', '车陂', '1555402133', '1555402133');
INSERT INTO `z_user_address` VALUES ('3', '0', '杭黄', '13789993234', '3456', '广东省', '广州市', '海珠区', '12', '1555402177', '1555402177');
INSERT INTO `z_user_address` VALUES ('4', '0', '黄湘', '13755543488', '234', '广东省', '广州市', '海珠区', '`122', '1555402254', '1555402254');
INSERT INTO `z_user_address` VALUES ('5', '0', '小白', '13789903526', '345', '广东省', '广州市', '天河区', '车陂路', '1555665788', '1555665788');

-- ----------------------------
-- Table structure for z_user_bang
-- ----------------------------
DROP TABLE IF EXISTS `z_user_bang`;
CREATE TABLE `z_user_bang` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) DEFAULT '0',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT 'bang权益价格',
  `start_time` int(10) DEFAULT '0' COMMENT '开通时间',
  `end_time` int(10) DEFAULT '0' COMMENT '过期时间',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  `order_sn` varchar(255) DEFAULT '',
  `status` tinyint(1) DEFAULT '0' COMMENT '0未支付1已支付',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='用户bang权益记录表';

-- ----------------------------
-- Records of z_user_bang
-- ----------------------------
INSERT INTO `z_user_bang` VALUES ('12', '25', '19.90', '1569401254', '1600937254', '1569401254', '1569401254', '201909251647981050', '1');
INSERT INTO `z_user_bang` VALUES ('13', '26', '19.90', '1569657062', '1601193062', '1569657062', '1569657062', '201909281551717167', '0');
INSERT INTO `z_user_bang` VALUES ('14', '33', '19.90', '1569850033', '1601386033', '1569850033', '1569850033', '201909302127591929', '0');
INSERT INTO `z_user_bang` VALUES ('15', '19', '19.90', '1571896930', '1603432930', '1571896930', '1571896930', '201910241402462090', '1');
INSERT INTO `z_user_bang` VALUES ('16', '13', '19.90', '1571993672', '1603529672', '1571993672', '1571993672', '201910251654529176', '1');
INSERT INTO `z_user_bang` VALUES ('17', '36', '19.90', '1572074057', '1603610057', '1572074057', '1572074057', '201910261514153007', '1');
INSERT INTO `z_user_bang` VALUES ('18', '40', '19.90', '1572085223', '1603621223', '1572085223', '1572085223', '201910261820762221', '0');

-- ----------------------------
-- Table structure for z_user_coupon
-- ----------------------------
DROP TABLE IF EXISTS `z_user_coupon`;
CREATE TABLE `z_user_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `coupon_id` int(11) NOT NULL DEFAULT '0' COMMENT '优惠券id',
  `man` decimal(10,2) DEFAULT '0.00' COMMENT '满多少',
  `jian` decimal(10,2) DEFAULT '0.00' COMMENT '减',
  `day` int(10) DEFAULT '0' COMMENT '有效天数',
  `status` tinyint(1) DEFAULT '1' COMMENT '1未使用2已使用',
  `goods_id` varchar(100) DEFAULT '0' COMMENT '门店id 0则所有门店通用',
  `comp_id` varchar(100) DEFAULT '0' COMMENT '服务id 0则所有服务可用',
  `number` varchar(200) DEFAULT '0' COMMENT '兑换码 0则为新人优惠券',
  `state` tinyint(1) DEFAULT '0' COMMENT '1新人优惠券2个人档案红包3邀请有礼',
  `start_time` int(10) DEFAULT '0' COMMENT '开始时间',
  `end_time` int(10) DEFAULT '0' COMMENT '过期时间',
  `add_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户优惠券';

-- ----------------------------
-- Records of z_user_coupon
-- ----------------------------
INSERT INTO `z_user_coupon` VALUES ('61', '25', '0', '0.00', '3.00', '90', '2', '0', '0', '0', '3', '1568618610', '1576394610', '1568618610', '1571220522');
INSERT INTO `z_user_coupon` VALUES ('62', '25', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568618653', '1576394653', '1568618653', '1568618653');
INSERT INTO `z_user_coupon` VALUES ('63', '25', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568618653', '1576394653', '1568618653', '1568618653');
INSERT INTO `z_user_coupon` VALUES ('64', '13', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568618995', '1576394995', '1568618995', '1568618995');
INSERT INTO `z_user_coupon` VALUES ('65', '13', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568618995', '1576394995', '1568618995', '1568618995');
INSERT INTO `z_user_coupon` VALUES ('66', '13', '0', '0.00', '3.00', '90', '1', '0', '0', '0', '3', '1568619310', '1576395310', '1568619310', '1568619310');
INSERT INTO `z_user_coupon` VALUES ('67', '13', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1568626806', '1576402806', '1568626806', '1568626806');
INSERT INTO `z_user_coupon` VALUES ('68', '13', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1568626806', '1576402806', '1568626806', '1568626806');
INSERT INTO `z_user_coupon` VALUES ('69', '25', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1568627211', '1576403211', '1568627211', '1568627211');
INSERT INTO `z_user_coupon` VALUES ('70', '25', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1568627211', '1576403211', '1568627211', '1568627211');
INSERT INTO `z_user_coupon` VALUES ('71', '19', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568682359', '1576458359', '1568682359', '1568682359');
INSERT INTO `z_user_coupon` VALUES ('72', '19', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568682359', '1576458359', '1568682359', '1568682359');
INSERT INTO `z_user_coupon` VALUES ('73', '18', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568683317', '1576459317', '1568683317', '1568683317');
INSERT INTO `z_user_coupon` VALUES ('74', '18', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568683317', '1576459317', '1568683317', '1568683317');
INSERT INTO `z_user_coupon` VALUES ('75', '26', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568691243', '1576467243', '1568691243', '1568691243');
INSERT INTO `z_user_coupon` VALUES ('76', '26', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1568691243', '1576467243', '1568691243', '1568691243');
INSERT INTO `z_user_coupon` VALUES ('77', '27', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569297110', '1577073110', '1569297110', '1569297110');
INSERT INTO `z_user_coupon` VALUES ('78', '27', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569297110', '1577073110', '1569297110', '1569297110');
INSERT INTO `z_user_coupon` VALUES ('79', '25', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569479448', '1577255448', '1569479448', '1569479448');
INSERT INTO `z_user_coupon` VALUES ('80', '25', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569479448', '1577255448', '1569479448', '1569479448');
INSERT INTO `z_user_coupon` VALUES ('81', '13', '5', '80.00', '8.00', '1', '1', '1', '1', '456002', '0', '1569482209', '1569568609', '1569482209', '1569482209');
INSERT INTO `z_user_coupon` VALUES ('82', '28', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569579623', '1577355623', '1569579623', '1569579623');
INSERT INTO `z_user_coupon` VALUES ('83', '28', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569579623', '1577355623', '1569579623', '1569579623');
INSERT INTO `z_user_coupon` VALUES ('84', '26', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569655877', '1577431877', '1569655877', '1569655877');
INSERT INTO `z_user_coupon` VALUES ('85', '26', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569655877', '1577431877', '1569655877', '1569655877');
INSERT INTO `z_user_coupon` VALUES ('86', '24', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569668138', '1577444138', '1569668138', '1569668138');
INSERT INTO `z_user_coupon` VALUES ('87', '24', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569668138', '1577444138', '1569668138', '1569668138');
INSERT INTO `z_user_coupon` VALUES ('88', '29', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569723463', '1577499463', '1569723463', '1569723463');
INSERT INTO `z_user_coupon` VALUES ('89', '29', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569723463', '1577499463', '1569723463', '1569723463');
INSERT INTO `z_user_coupon` VALUES ('90', '29', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569723607', '1577499607', '1569723607', '1569723607');
INSERT INTO `z_user_coupon` VALUES ('91', '29', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569723607', '1577499607', '1569723607', '1569723607');
INSERT INTO `z_user_coupon` VALUES ('92', '30', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569724131', '1577500131', '1569724131', '1569724131');
INSERT INTO `z_user_coupon` VALUES ('93', '30', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569724131', '1577500131', '1569724131', '1569724131');
INSERT INTO `z_user_coupon` VALUES ('94', '30', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569724312', '1577500312', '1569724312', '1569724312');
INSERT INTO `z_user_coupon` VALUES ('95', '30', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569724312', '1577500312', '1569724312', '1569724312');
INSERT INTO `z_user_coupon` VALUES ('96', '31', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569725590', '1577501590', '1569725590', '1569725590');
INSERT INTO `z_user_coupon` VALUES ('97', '31', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569725590', '1577501590', '1569725590', '1569725590');
INSERT INTO `z_user_coupon` VALUES ('98', '31', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569725699', '1577501699', '1569725699', '1569725699');
INSERT INTO `z_user_coupon` VALUES ('99', '31', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569725699', '1577501699', '1569725699', '1569725699');
INSERT INTO `z_user_coupon` VALUES ('100', '32', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569744116', '1577520116', '1569744116', '1569744116');
INSERT INTO `z_user_coupon` VALUES ('101', '32', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569744116', '1577520116', '1569744116', '1569744116');
INSERT INTO `z_user_coupon` VALUES ('102', '32', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569744426', '1577520426', '1569744426', '1569744426');
INSERT INTO `z_user_coupon` VALUES ('103', '32', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569744426', '1577520426', '1569744426', '1569744426');
INSERT INTO `z_user_coupon` VALUES ('104', '34', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569746317', '1577522317', '1569746317', '1569746317');
INSERT INTO `z_user_coupon` VALUES ('105', '34', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569746317', '1577522317', '1569746317', '1569746317');
INSERT INTO `z_user_coupon` VALUES ('106', '34', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569746701', '1577522701', '1569746701', '1569746701');
INSERT INTO `z_user_coupon` VALUES ('107', '34', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569746701', '1577522701', '1569746701', '1569746701');
INSERT INTO `z_user_coupon` VALUES ('108', '35', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569747727', '1577523727', '1569747727', '1569747727');
INSERT INTO `z_user_coupon` VALUES ('109', '35', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1569747727', '1577523727', '1569747727', '1569747727');
INSERT INTO `z_user_coupon` VALUES ('110', '35', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569747742', '1577523742', '1569747742', '1569747742');
INSERT INTO `z_user_coupon` VALUES ('111', '35', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569747742', '1577523742', '1569747742', '1569747742');
INSERT INTO `z_user_coupon` VALUES ('112', '33', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569846789', '1577622789', '1569846789', '1569846789');
INSERT INTO `z_user_coupon` VALUES ('113', '33', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1569846789', '1577622789', '1569846789', '1569846789');
INSERT INTO `z_user_coupon` VALUES ('114', '36', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1570588224', '1578364224', '1570588224', '1570588224');
INSERT INTO `z_user_coupon` VALUES ('115', '36', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1570588224', '1578364224', '1570588224', '1570588224');
INSERT INTO `z_user_coupon` VALUES ('116', '37', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1570588296', '1578364296', '1570588296', '1570588296');
INSERT INTO `z_user_coupon` VALUES ('117', '37', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1570588296', '1578364296', '1570588296', '1570588296');
INSERT INTO `z_user_coupon` VALUES ('118', '22', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1571039165', '1578815165', '1571039165', '1571039165');
INSERT INTO `z_user_coupon` VALUES ('119', '22', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1571039165', '1578815165', '1571039165', '1571039165');
INSERT INTO `z_user_coupon` VALUES ('120', '38', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1571970711', '1579746711', '1571970711', '1571970711');
INSERT INTO `z_user_coupon` VALUES ('121', '38', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1571970711', '1579746711', '1571970711', '1571970711');
INSERT INTO `z_user_coupon` VALUES ('122', '36', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1572074273', '1579850273', '1572074273', '1572074273');
INSERT INTO `z_user_coupon` VALUES ('123', '36', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '2', '1572074273', '1579850273', '1572074273', '1572074273');
INSERT INTO `z_user_coupon` VALUES ('124', '39', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1572085169', '1579861169', '1572085169', '1572085169');
INSERT INTO `z_user_coupon` VALUES ('125', '39', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1572085169', '1579861169', '1572085169', '1572085169');
INSERT INTO `z_user_coupon` VALUES ('126', '40', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1572085191', '1579861191', '1572085191', '1572085191');
INSERT INTO `z_user_coupon` VALUES ('127', '40', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1572085191', '1579861191', '1572085191', '1572085191');
INSERT INTO `z_user_coupon` VALUES ('128', '41', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1572268556', '1580044556', '1572268556', '1572268556');
INSERT INTO `z_user_coupon` VALUES ('129', '41', '0', '0.00', '5.00', '90', '1', '0', '0', '0', '1', '1572268556', '1580044556', '1572268556', '1572268556');

-- ----------------------------
-- Table structure for z_user_feedback
-- ----------------------------
DROP TABLE IF EXISTS `z_user_feedback`;
CREATE TABLE `z_user_feedback` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) DEFAULT NULL,
  `title` varchar(255) DEFAULT '' COMMENT '反馈类型',
  `content` varchar(1000) DEFAULT '' COMMENT '反馈内容',
  `images` text COMMENT '图片',
  `type` tinyint(1) DEFAULT '1' COMMENT '1取过号2未取号',
  `name` varchar(255) DEFAULT '' COMMENT '理疗师名称',
  `phone` varchar(255) DEFAULT '' COMMENT '手机号码',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='用户投诉反馈';

-- ----------------------------
-- Records of z_user_feedback
-- ----------------------------
INSERT INTO `z_user_feedback` VALUES ('2', '1', '接私单', '测试', null, '1', '杨幂', '13526320236', '1567680112', '1567680112');
INSERT INTO `z_user_feedback` VALUES ('3', '4', '手法优化', 'fasfasfa', '/uploads/20190905/d18298cba45a26ecb959c5a8bc949e0f.png', '2', '杨幂', '13113306050', '1567692520', '1567692520');
INSERT INTO `z_user_feedback` VALUES ('4', '13', '手法优化', '嗯嗯嗯嗯嗯', '/uploads/20190906/e6c80f88ef09e72be2fd7b87fd3b56f9.jpg,/uploads/20190906/4884279294c26b374bb6db0c99d0e1b4.jpg,/uploads/20190906/6d5b7aa4a9741c868491572b65452c02.jpg', '1', '月月', '13800000000', '1567739062', '1567739062');
INSERT INTO `z_user_feedback` VALUES ('5', '14', '其他', '测试测试测试', '', '1', '伊素婉', '15915744188', '1567751571', '1567751571');
INSERT INTO `z_user_feedback` VALUES ('6', '14', '其他', '测试测试测试', '', '1', '伊素婉', '15915744188', '1567751583', '1567751583');
INSERT INTO `z_user_feedback` VALUES ('7', '15', '接私单', '123123123', '/uploads/20190906/f1557e08fdaa6727a678010720356133.jpg', '2', 'kaili', '13129087405', '1567765173', '1567765173');
INSERT INTO `z_user_feedback` VALUES ('8', '15', '其他', '1111', '', '1', '景甜', '13129087405', '1567765688', '1567765688');
INSERT INTO `z_user_feedback` VALUES ('9', '15', '其他', '121', '/uploads/20190906/504fca6f135b99ab8bd697141cec8b0b.jpg', '1', '景甜', '13129087405', '1567765729', '1567765729');
INSERT INTO `z_user_feedback` VALUES ('10', '18', '其他', '12345678', '', '1', '景甜', '13724158053', '1568014532', '1568014532');
INSERT INTO `z_user_feedback` VALUES ('11', '13', '接私单', 'e66嫩模哦们默默', '/uploads/20190925/a4dfaba9e2075f66b35349a9b63a57b7.jpg,/uploads/20190925/99000b1595058fb13d9222a4d43c79bc.jpg', '2', '杨幂', '13000000000', '1569425781', '1569425781');
INSERT INTO `z_user_feedback` VALUES ('12', '31', '其他', 'asdsa', '', '1', 'kaili', '15310618120', '1569741057', '1569741057');
INSERT INTO `z_user_feedback` VALUES ('13', '27', '接私单', '1234567891011121314151617181920', '', '1', '测试用', '12345678910', '1570611273', '1570611273');

-- ----------------------------
-- Table structure for z_user_form
-- ----------------------------
DROP TABLE IF EXISTS `z_user_form`;
CREATE TABLE `z_user_form` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) DEFAULT '0',
  `form_id` varchar(255) DEFAULT '',
  `status` tinyint(1) DEFAULT '1' COMMENT '1未使用2已使用',
  `add_time` int(10) DEFAULT '0',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='用户formid表';

-- ----------------------------
-- Records of z_user_form
-- ----------------------------
INSERT INTO `z_user_form` VALUES ('35', '25', 'e14bac599c014c55b2ebc1d0de38a13d', '1', '1572084794', '1572084794');
INSERT INTO `z_user_form` VALUES ('36', '25', '2628a14bd4204188a91cc25c49b16115', '1', '1572084801', '1572084801');
INSERT INTO `z_user_form` VALUES ('37', '25', 'aa80e18773144522b612ad0324727be6', '1', '1572084811', '1572084811');
INSERT INTO `z_user_form` VALUES ('38', '25', 'the formId is a mock one', '1', '1572084857', '1572084857');
INSERT INTO `z_user_form` VALUES ('39', '25', 'the formId is a mock one', '1', '1572084861', '1572084861');
INSERT INTO `z_user_form` VALUES ('40', '25', '59c0f8ca077c471194a5325b3e871254', '1', '1572085048', '1572085048');
INSERT INTO `z_user_form` VALUES ('41', '25', 'dbd1d971e4c64835ae98e068fa89fdae', '1', '1572085052', '1572085052');
INSERT INTO `z_user_form` VALUES ('42', '24', 'c32dd8fd903c41679e4fca677d08f127', '1', '1572225933', '1572225933');
INSERT INTO `z_user_form` VALUES ('43', '24', 'dcb2c047606642249d1b8669fc12192e', '1', '1572225937', '1572225937');
INSERT INTO `z_user_form` VALUES ('44', '24', '7f7e3f18868d422289bbf0f796885f77', '1', '1572225941', '1572225941');
INSERT INTO `z_user_form` VALUES ('45', '24', '636e0b296ddd4a7884cfc59afbdbd95d', '1', '1572226058', '1572226058');
INSERT INTO `z_user_form` VALUES ('46', '25', 'the formId is a mock one', '1', '1572226271', '1572226271');
INSERT INTO `z_user_form` VALUES ('47', '25', 'the formId is a mock one', '1', '1572226321', '1572226321');
INSERT INTO `z_user_form` VALUES ('48', '25', 'the formId is a mock one', '1', '1572226330', '1572226330');
INSERT INTO `z_user_form` VALUES ('49', '25', 'the formId is a mock one', '1', '1572226567', '1572226567');
INSERT INTO `z_user_form` VALUES ('50', '25', 'the formId is a mock one', '1', '1572226571', '1572226571');
INSERT INTO `z_user_form` VALUES ('51', '25', 'the formId is a mock one', '1', '1572226618', '1572226618');
INSERT INTO `z_user_form` VALUES ('52', '25', 'the formId is a mock one', '1', '1572226640', '1572226640');
INSERT INTO `z_user_form` VALUES ('53', '25', 'the formId is a mock one', '1', '1572227879', '1572227879');
INSERT INTO `z_user_form` VALUES ('54', '25', 'the formId is a mock one', '1', '1572227885', '1572227885');
INSERT INTO `z_user_form` VALUES ('55', '25', 'the formId is a mock one', '1', '1572228274', '1572228274');
INSERT INTO `z_user_form` VALUES ('56', '25', 'the formId is a mock one', '1', '1572228328', '1572228328');
INSERT INTO `z_user_form` VALUES ('57', '25', 'the formId is a mock one', '1', '1572228336', '1572228336');
INSERT INTO `z_user_form` VALUES ('58', '25', 'the formId is a mock one', '1', '1572228413', '1572228413');
INSERT INTO `z_user_form` VALUES ('59', '25', 'the formId is a mock one', '1', '1572228494', '1572228494');
INSERT INTO `z_user_form` VALUES ('60', '25', 'the formId is a mock one', '1', '1572228570', '1572228570');
INSERT INTO `z_user_form` VALUES ('61', '25', 'the formId is a mock one', '1', '1572228608', '1572228608');
INSERT INTO `z_user_form` VALUES ('62', '25', 'the formId is a mock one', '1', '1572228674', '1572228674');
INSERT INTO `z_user_form` VALUES ('63', '25', 'the formId is a mock one', '1', '1572228707', '1572228707');
INSERT INTO `z_user_form` VALUES ('64', '25', 'the formId is a mock one', '1', '1572228807', '1572228807');
INSERT INTO `z_user_form` VALUES ('65', '25', 'the formId is a mock one', '1', '1572228853', '1572228853');
INSERT INTO `z_user_form` VALUES ('66', '25', 'the formId is a mock one', '1', '1572228885', '1572228885');
INSERT INTO `z_user_form` VALUES ('67', '25', 'the formId is a mock one', '1', '1572228909', '1572228909');
INSERT INTO `z_user_form` VALUES ('68', '25', 'the formId is a mock one', '1', '1572229014', '1572229014');
INSERT INTO `z_user_form` VALUES ('69', '25', 'the formId is a mock one', '1', '1572229038', '1572229038');
INSERT INTO `z_user_form` VALUES ('70', '25', 'the formId is a mock one', '1', '1572229113', '1572229113');
INSERT INTO `z_user_form` VALUES ('71', '25', 'the formId is a mock one', '1', '1572229154', '1572229154');
INSERT INTO `z_user_form` VALUES ('72', '25', 'the formId is a mock one', '1', '1572229182', '1572229182');
INSERT INTO `z_user_form` VALUES ('73', '25', 'the formId is a mock one', '1', '1572229232', '1572229232');
INSERT INTO `z_user_form` VALUES ('74', '25', 'the formId is a mock one', '1', '1572229278', '1572229278');
INSERT INTO `z_user_form` VALUES ('75', '25', 'the formId is a mock one', '1', '1572229414', '1572229414');
INSERT INTO `z_user_form` VALUES ('76', '25', 'the formId is a mock one', '1', '1572229436', '1572229436');
INSERT INTO `z_user_form` VALUES ('77', '25', 'the formId is a mock one', '1', '1572229452', '1572229452');
INSERT INTO `z_user_form` VALUES ('80', '19', '4e3eaa09266a4e86ab59991724ace9f6', '1', '1572234814', '1572234814');
INSERT INTO `z_user_form` VALUES ('81', '19', '2c33b955c9e64db7a3bce333fe941241', '1', '1572253721', '1572253721');
INSERT INTO `z_user_form` VALUES ('82', '19', '4508f297373c427b8765aefdf8bd0a7a', '1', '1572253732', '1572253732');
INSERT INTO `z_user_form` VALUES ('83', '33', '1572259254726', '1', '1572259258', '1572259258');
INSERT INTO `z_user_form` VALUES ('84', '41', 'b484f97d59a74968b4e1e212462f1ba4', '1', '1572268557', '1572268557');
INSERT INTO `z_user_form` VALUES ('85', '19', 'c467e1ff9ad7406ebde509cf7fc8b38d', '1', '1572313761', '1572313761');
INSERT INTO `z_user_form` VALUES ('86', '25', 'da5ef6f4b15a4b1ab1c575b72ce7b0c4', '1', '1572424249', '1572424249');
INSERT INTO `z_user_form` VALUES ('87', '25', 'abe22ea0930a416fb6cfb7553ffc4f98', '1', '1572424584', '1572424584');
INSERT INTO `z_user_form` VALUES ('88', '25', 'bf7fc00918f64f8e8292dceb01145e75', '1', '1572424619', '1572424619');
INSERT INTO `z_user_form` VALUES ('89', '25', '0ebd112dc5ae47b69947eba097a3d7cf', '1', '1572424627', '1572424627');
INSERT INTO `z_user_form` VALUES ('90', '25', '43fc22489f8545ab844e7b1d52952911', '1', '1572424629', '1572424629');
INSERT INTO `z_user_form` VALUES ('91', '25', '675ab8601113449fbc30872223bfb3a4', '1', '1572424633', '1572424633');
INSERT INTO `z_user_form` VALUES ('92', '25', 'the formId is a mock one', '1', '1572424666', '1572424666');
INSERT INTO `z_user_form` VALUES ('93', '25', 'the formId is a mock one', '1', '1572424846', '1572424846');
INSERT INTO `z_user_form` VALUES ('94', '19', '019af620afa547abb4a4be51c1dca107', '1', '1572487669', '1572487669');
INSERT INTO `z_user_form` VALUES ('95', '19', '4efa8e19a0864addae8c941a718015b8', '1', '1572487678', '1572487678');

-- ----------------------------
-- Table structure for z_user_perfect
-- ----------------------------
DROP TABLE IF EXISTS `z_user_perfect`;
CREATE TABLE `z_user_perfect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型 1是文章 2商品 3活动',
  `perfect_id` int(11) NOT NULL DEFAULT '0' COMMENT '对应的ID',
  `pain` varchar(255) DEFAULT '' COMMENT '疼痛位置',
  `mode` varchar(255) DEFAULT '' COMMENT '疼痛方式',
  `time` varchar(255) DEFAULT '' COMMENT '疼痛时间',
  `past` varchar(255) DEFAULT '' COMMENT '既往史',
  `add_time` int(11) DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户个人档案记录表';

-- ----------------------------
-- Records of z_user_perfect
-- ----------------------------
INSERT INTO `z_user_perfect` VALUES ('1', '1', '0', '小腿', '有时候痛有时候不痛', '白天居多', '无', '1567652916', '1567652916');
INSERT INTO `z_user_perfect` VALUES ('5', '4', '0', '大腿', '有时候痛有时候不痛', '白天居多', '无', '1567692447', '1569753603');
INSERT INTO `z_user_perfect` VALUES ('7', '15', '0', '腰部', '一直感觉痛，强度不变', '时间不定', '无', '1567762734', '1567762734');
INSERT INTO `z_user_perfect` VALUES ('11', '19', '0', '颈部', '有时候痛有时候不痛', '晚上居多', '无', '1567998791', '1569757439');
INSERT INTO `z_user_perfect` VALUES ('15', '18', '0', '颈部', '持续性疼痛，但强度不同', '晚上居多', '无', '1568000849', '1568000849');
INSERT INTO `z_user_perfect` VALUES ('16', '11', '0', '小腿', '一直感觉痛，强度不变', '时间不定', '无', '1568272763', '1568272763');
INSERT INTO `z_user_perfect` VALUES ('17', '11', '0', '小腿', '一直感觉痛，强度不变', '时间不定', '无', '1568272774', '1568272774');
INSERT INTO `z_user_perfect` VALUES ('18', '21', '0', '小腿', '一直感觉痛，强度不变', '时间不定', '无', '1568272976', '1568272976');
INSERT INTO `z_user_perfect` VALUES ('19', '21', '0', '小腿', '一直感觉痛，强度不变', '时间不定', '无', '1568274789', '1568274789');
INSERT INTO `z_user_perfect` VALUES ('20', '23', '0', '脚', '一直感觉痛，强度不变', '完善居多', '无', '1568274917', '1568274917');
INSERT INTO `z_user_perfect` VALUES ('21', '25', '0', '脚', '一直感觉痛，强度不变', '晚上居多', '无', '1568605045', '1568605045');
INSERT INTO `z_user_perfect` VALUES ('22', '27', '0', '颈部', '有时候痛有时候不痛', '白天居多', '曾有重大疾病或手术史', '1569297159', '1569297159');
INSERT INTO `z_user_perfect` VALUES ('23', '6', '0', '脚', '一直感觉痛，强度不变', '晚上居多', '无', '1569492742', '1569492742');
INSERT INTO `z_user_perfect` VALUES ('26', '26', '0', '脚', '一直感觉痛，强度不变', '晚上居多', '无', '1569571864', '1569571864');
INSERT INTO `z_user_perfect` VALUES ('28', '29', '0', '脚', '一直感觉痛，强度不变', '时间不定', '无', '1569723572', '1569723572');
INSERT INTO `z_user_perfect` VALUES ('35', '30', '0', '脚', '一直感觉痛，强度不变', '晚上居多', '无', '1569724102', '1569758401');
INSERT INTO `z_user_perfect` VALUES ('37', '31', '0', '小腿', '一直感觉痛，强度不变', '时间不定', '无', '1569725569', '1569725569');
INSERT INTO `z_user_perfect` VALUES ('40', '32', '0', '脚', '一直感觉痛，强度不变', '时间不定', '无', '1569744389', '1569744389');
INSERT INTO `z_user_perfect` VALUES ('41', '34', '0', '脚', '一直感觉痛，强度不变', '时间不定', '无', '1569746293', '1569746293');
INSERT INTO `z_user_perfect` VALUES ('43', '32', '0', '脚', '一直感觉痛，强度不变', '时间不定', '无', '1569747339', '1569747339');
INSERT INTO `z_user_perfect` VALUES ('44', '35', '0', '腰部', '有时候痛有时候不痛', '时间不定', '曾有重大疾病或手术史', '1569747694', '1569747694');
INSERT INTO `z_user_perfect` VALUES ('45', '34', '0', '脚', '一直感觉痛，强度不变', '时间不定', '无', '1569808354', '1569808354');
INSERT INTO `z_user_perfect` VALUES ('46', '37', '0', '颈部', '有时候痛有时候不痛', '白天居多', '无', '1570589022', '1570589022');
INSERT INTO `z_user_perfect` VALUES ('47', '39', '0', '颈部', '有时候痛有时候不痛', '白天居多', '曾有重大疾病或手术史', '1572085247', '1572085247');
