/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : concert_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-07-09 19:40:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_concert`
-- ----------------------------
DROP TABLE IF EXISTS `t_concert`;
CREATE TABLE `t_concert` (
  `concertId` int(11) NOT NULL auto_increment COMMENT '演唱会id',
  `concertTypeObj` int(11) NOT NULL COMMENT '演唱会分类',
  `concertName` varchar(60) NOT NULL COMMENT '演唱会名称',
  `concertPhoto` varchar(60) NOT NULL COMMENT '演唱会图片',
  `concertTime` varchar(20) default NULL COMMENT '演唱会时间',
  `concertPlace` varchar(20) NOT NULL COMMENT '演唱会地点',
  `ycry` varchar(500) NOT NULL COMMENT '演出人员',
  `concertPrice` float NOT NULL COMMENT '门票价格',
  `concertDesc` varchar(8000) NOT NULL COMMENT '详细说明',
  PRIMARY KEY  (`concertId`),
  KEY `concertTypeObj` (`concertTypeObj`),
  CONSTRAINT `t_concert_ibfk_1` FOREIGN KEY (`concertTypeObj`) REFERENCES `t_concerttype` (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_concert
-- ----------------------------
INSERT INTO `t_concert` VALUES ('1', '1', '汪峰2018\"岁月\"巡回演唱会—杭州站 ', 'upload/f247f734-e9c0-47cf-ad2c-8114fe146b1d.jpg', '2018-05-26 19:45:00', '黄龙体育中心-体育场', '汪峰', '998', '<h3 class=\"mt20\" style=\"margin: 20px 0px 15px; padding: 0px 0px 8px; outline: none; border-bottom: 1px solid rgb(229, 229, 229); font-size: 14px; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; white-space: normal;\">演出详情</h3><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; text-indent: 2em;\">从2013年的“存在”到2014年的“峰暴来临”，从杭州黄龙体育馆到体育场，汪峰用自己的音乐感染了许多人。2018年，从伯乐汪夫子变身为摇滚战士，“无处安放”的音乐灵魂，再次释放，科技感十足的“X-Man”降临演唱会！</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; text-indent: 2em;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; text-align: center; text-indent: 0em;\"><img src=\"/JavaWebProject/upload/20180328/1522207684631037748.jpg\" title=\"1522207684631037748.jpg\" alt=\"2.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; text-align: center; text-indent: 0em;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; text-indent: 2em;\">本次巡演主题“岁月”是汪峰迄今为止11张作品辑147首录音室作品，是“存在”、“峰暴来临”的47场巡演，是从Livehouse到北展，工体首体五棵松，再到中国各地大小体育场馆，时间和地点的标注。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; text-align: center;\"><img src=\"/JavaWebProject/upload/20180328/1522207692326075945.jpg\" title=\"1522207692326075945.jpg\" alt=\"3.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; text-align: center;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; text-indent: 2em;\">“汪峰巡演”已经成为内地音乐人巡演的品牌之作，从2013起就不断刷新和突破巡演票房，创造非凡影响，其鼓舞人心的感召力量、引发共鸣的经典合唱、令人难忘的瞬间和场景，一直为观众津津乐道、交口称赞。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; text-indent: 2em;\">“汪峰巡演”一直高居华语音乐界巡演票房前列，从某种意义上，代表内地音乐人这一领域，与港台地区艺人演唱会项目分庭抗礼，象征荣耀与骄傲。</p><p><br/></p>');
INSERT INTO `t_concert` VALUES ('2', '2', '2018天漠音乐节', 'upload/194a7fee-91e1-4a2f-a0c7-288016157ff2.jpg', '2018-05-20 11:29:41', '天漠自然风景区', '尽请期待', '199', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">演出名称： 2018MTA天漠音乐节</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">演出时间： 2018年5月18日-20日（三天）每日14:30始-22:30止</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">演出地点： 河北省怀来县天漠自然风景区（距北京90公里）</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">2018MTA天漠音乐节全面升级 520沙漠三天“现实重混”</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">“2016，Alan Walker火之前，我在天漠撞见了；2017，Tizzy T还只有3w粉丝时，我在天漠撞见了...2018，还有哪些我遇上的人会身价翻十倍？”</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">“我也是在等赵雷的时候看过沙漠下雨的人了，2018年会在天漠看到外星人么，在线等。”</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">“不用去国外也能看到我们家的idol了，听说天漠2018会放大招，一定值回票价，不管啦，先买票！”</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">&nbsp;2016、2017两年，青山绿水环抱的天漠收藏了诸多回忆——</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-align: center;\"><img src=\"/JavaWebProject/upload/20180328/1522207905180024666.jpg\" title=\"1522207905180024666.jpg\" alt=\"2.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">2016年，Example/Rudimental/Alina Baraz/Alan Walker梦幻起势，</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">距北京仅一个半小时车程的大漠之中长蛇摆阵，外星人乘飞船驾到，</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">数万人齐聚定位“明日边界”。</p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-align: center;\"><img src=\"/JavaWebProject/upload/20180328/1522207911229036225.jpg\" title=\"1522207911229036225.jpg\" alt=\"3.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal;\"><br/></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; outline: none; color: rgb(76, 76, 76); font-family: arial, Tahoma, simsun, 宋体; font-size: 12px; white-space: normal; text-indent: 2em;\">2017年，Years &amp; Years / Clean Bandit引燃飞船引擎，</p><p><br/></p>');

-- ----------------------------
-- Table structure for `t_concerttype`
-- ----------------------------
DROP TABLE IF EXISTS `t_concerttype`;
CREATE TABLE `t_concerttype` (
  `typeId` int(11) NOT NULL auto_increment COMMENT '分类id',
  `typeName` varchar(20) NOT NULL COMMENT '分类名称',
  PRIMARY KEY  (`typeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_concerttype
-- ----------------------------
INSERT INTO `t_concerttype` VALUES ('1', '明星演唱会');
INSERT INTO `t_concerttype` VALUES ('2', '音乐节演唱会');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL auto_increment COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) default NULL COMMENT '留言时间',
  `replyContent` varchar(1000) default NULL COMMENT '管理回复',
  `replyTime` varchar(20) default NULL COMMENT '回复时间',
  PRIMARY KEY  (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', 'aa', 'bb', 'user1', '2018-03-28 11:26:03', 'cc', '2018-03-28 11:26:07');
INSERT INTO `t_leaveword` VALUES ('2', '1111', '222', 'user1', '2018-04-01 19:37:06', '大家来看演唱会了', '2018-04-01 23:39:26');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '一起来看演唱会', '<p>演唱会门票销售网站成立了，来买票吧！</p>', '2018-03-28 11:26:17');

-- ----------------------------
-- Table structure for `t_orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_orderinfo`;
CREATE TABLE `t_orderinfo` (
  `orderId` int(11) NOT NULL auto_increment COMMENT '订单id',
  `userObj` varchar(30) NOT NULL COMMENT '下单用户',
  `concertObj` int(11) NOT NULL COMMENT '演唱会名称',
  `orderCount` int(11) NOT NULL COMMENT '订单数量',
  `totalMoney` float NOT NULL COMMENT '订单总金额',
  `orderStateObj` varchar(20) NOT NULL COMMENT '订单状态',
  `orderTime` varchar(20) default NULL COMMENT '下单时间',
  `receiveName` varchar(20) NOT NULL COMMENT '收货人',
  `telephone` varchar(20) NOT NULL COMMENT '收货人电话',
  `address` varchar(80) NOT NULL COMMENT '收货人地址',
  `orderMemo` varchar(500) default NULL COMMENT '订单备注',
  PRIMARY KEY  (`orderId`),
  KEY `userObj` (`userObj`),
  KEY `concertObj` (`concertObj`),
  CONSTRAINT `t_orderinfo_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`),
  CONSTRAINT `t_orderinfo_ibfk_2` FOREIGN KEY (`concertObj`) REFERENCES `t_concert` (`concertId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderinfo
-- ----------------------------
INSERT INTO `t_orderinfo` VALUES ('1', 'user1', '1', '2', '1996', '已出票', '2018-03-28 11:24:22', '李明', '13980834983', '成都红星路13号', '测试');
INSERT INTO `t_orderinfo` VALUES ('2', 'user2', '1', '2', '1996', '已出票', '2018-04-01 23:34:37', '李小英', '13895081343', ' 四川南充滨江路', '我和男朋友一起去看');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `userType` varchar(20) NOT NULL COMMENT '会员级别',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '普通会员', '李明芬', '女', '2018-03-14', 'upload/dca13819-3e84-4a82-b25b-25d381fe7d56.jpg', '13985980834', 'mingfen@163.com', '四川成都红星路13号', '2018-03-28 11:22:20');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '普通会员', '李小英', '女', '2018-04-01', 'upload/1805af6b-737f-4215-b0f7-728cf35d3faf.jpg', '13895081343', 'xiaoying@163.com', '四川南充滨江路', '2018-04-01 23:31:49');
