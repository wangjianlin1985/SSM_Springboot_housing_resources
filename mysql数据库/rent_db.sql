/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : rent_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2019-03-23 00:56:35
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
-- Table structure for `t_area`
-- ----------------------------
DROP TABLE IF EXISTS `t_area`;
CREATE TABLE `t_area` (
  `areaId` int(11) NOT NULL auto_increment COMMENT '区域id',
  `areaName` varchar(20) NOT NULL COMMENT '区域名称',
  PRIMARY KEY  (`areaId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_area
-- ----------------------------
INSERT INTO `t_area` VALUES ('1', '成华区');
INSERT INTO `t_area` VALUES ('2', '锦江区');
INSERT INTO `t_area` VALUES ('3', '青羊区');
INSERT INTO `t_area` VALUES ('4', '武侯区');
INSERT INTO `t_area` VALUES ('5', '金牛区');

-- ----------------------------
-- Table structure for `t_house`
-- ----------------------------
DROP TABLE IF EXISTS `t_house`;
CREATE TABLE `t_house` (
  `houseId` int(11) NOT NULL auto_increment COMMENT '房源id',
  `areaObj` int(11) NOT NULL COMMENT '所在区域',
  `houseName` varchar(80) NOT NULL COMMENT '房源名称',
  `housePhoto` varchar(60) NOT NULL COMMENT '房源照片',
  `mj` float NOT NULL COMMENT '面积',
  `floor` varchar(20) NOT NULL COMMENT '所在楼层',
  `huxingObj` int(11) NOT NULL COMMENT '户型',
  `priceRangeObj` int(11) NOT NULL COMMENT '租金范围',
  `price` float NOT NULL COMMENT '租金价格',
  `chaoxiang` varchar(20) NOT NULL COMMENT '朝向',
  `address` varchar(80) NOT NULL COMMENT '小区地址',
  `lxr` varchar(20) NOT NULL COMMENT '联系人',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `houseDesc` varchar(20000) NOT NULL COMMENT '房源详情',
  `userObj` varchar(30) NOT NULL COMMENT '发布人',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  `shenHeState` varchar(20) NOT NULL COMMENT '审核状态',
  PRIMARY KEY  (`houseId`),
  KEY `areaObj` (`areaObj`),
  KEY `huxingObj` (`huxingObj`),
  KEY `priceRangeObj` (`priceRangeObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_house_ibfk_4` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`),
  CONSTRAINT `t_house_ibfk_1` FOREIGN KEY (`areaObj`) REFERENCES `t_area` (`areaId`),
  CONSTRAINT `t_house_ibfk_2` FOREIGN KEY (`huxingObj`) REFERENCES `t_huxing` (`huxingId`),
  CONSTRAINT `t_house_ibfk_3` FOREIGN KEY (`priceRangeObj`) REFERENCES `t_pricerange` (`rangeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_house
-- ----------------------------
INSERT INTO `t_house` VALUES ('1', '1', '理想城南卧', 'upload/fcc22aa6-de80-4d3f-9b34-de906d2ee095.JPG', '10.3', '12/32层', '1', '2', '930', '南', '成华区二环路东一段10号', '王先生', '13950812432', '<p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><strong>房源介绍：</strong>该卧室是自如装修风格，由自如配置部分家电，采光好视野佳，通风流畅。清新自然的风格很适合年轻人居住，一个人居住还很适宜。</p><p><br/></p>', 'user1', '2019-03-22 22:40:51', '已审核');
INSERT INTO `t_house` VALUES ('2', '3', '中大君悦金沙四期套二整租', 'upload/748cd007-6ef3-44a3-9e3a-5fafc356a029.jpg', '65', '14/28层', '3', '5', '2800', '西北', '清江西路12号', '黄先生', '18250831243', '<p><strong style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft Yahei&quot;, Arial, sans-serif, Arial, STHeiti; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">房源介绍：</strong><span style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft Yahei&quot;, Arial, sans-serif, Arial, STHeiti; font-size: 14px; background-color: rgb(255, 255, 255);\">舒适空间，居家小件随您安放；宽敞舒适、视野开阔，采光好小区风景尽收眼底；温馨安静，休息的时候可以坐在床上看一本喜欢的书；空调制暖，祝您一晚好睡眠。</span></p>', 'user2', '2019-03-22 23:59:22', '已审核');
INSERT INTO `t_house` VALUES ('3', '1', '交大归谷建设派4居室', 'upload/47440414-1afc-4403-af44-80a8b4de80f7.JPG', '9.9', '11/33层', '6', '2', '960', '东', '成华区二环路东一段12号', '张先生', '13950810842', '<p><strong style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft Yahei&quot;, Arial, sans-serif, Arial, STHeiti; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">房源介绍：</strong><span style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft Yahei&quot;, Arial, sans-serif, Arial, STHeiti; font-size: 14px; background-color: rgb(255, 255, 255);\">该卧室是自如装修风格，由自如配置部分家电，采光好视野佳，通风流畅。清新自然的风格很适合年轻人居住，一个人居住还很适宜。</span></p>', 'user1', '2019-03-23 00:21:33', '已审核');
INSERT INTO `t_house` VALUES ('4', '2', '中房优山3居室主卧', 'upload/cfe11193-bcb7-44fd-bfea-002561a214f4.JPG', '10.6', '19/32层', '5', '3', '1200', '东', '塔子山公园旁', '张小姐', '13980230842', '<p><strong style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft Yahei&quot;, Arial, sans-serif, Arial, STHeiti; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">房源介绍：</strong><span style=\"color: rgb(102, 102, 102); font-family: &quot;Microsoft Yahei&quot;, Arial, sans-serif, Arial, STHeiti; font-size: 14px; background-color: rgb(255, 255, 255);\">&nbsp;1，小区24小时安保，安全放心。 2，距离地铁特别近，到塔子山地铁公园地铁站步行只需要3分钟 3，大卧室带阳吧，视野很好。</span></p>', 'user1', '2019-03-23 00:24:35', '待审核');

-- ----------------------------
-- Table structure for `t_huxing`
-- ----------------------------
DROP TABLE IF EXISTS `t_huxing`;
CREATE TABLE `t_huxing` (
  `huxingId` int(11) NOT NULL auto_increment COMMENT '户型id',
  `huxingName` varchar(50) NOT NULL COMMENT '户型名称',
  PRIMARY KEY  (`huxingId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_huxing
-- ----------------------------
INSERT INTO `t_huxing` VALUES ('1', '一室一厅');
INSERT INTO `t_huxing` VALUES ('2', '两室一厅');
INSERT INTO `t_huxing` VALUES ('3', '两室两厅');
INSERT INTO `t_huxing` VALUES ('4', '三室一厅');
INSERT INTO `t_huxing` VALUES ('5', '三室两厅');
INSERT INTO `t_huxing` VALUES ('6', '四室以上');

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
INSERT INTO `t_leaveword` VALUES ('1', '房源发布有要求吗', '请问每个人发布的房源需要是自己的房子吗？', 'user1', '2019-03-22 22:37:57', '可以发布别人的', '2019-03-22 22:37:59');
INSERT INTO `t_leaveword` VALUES ('2', '合租房整租都可以吗', '这个租赁平台的房子，这2个类型都可以发布吗？', 'user1', '2019-03-22 23:18:40', '是的都可以', '2019-03-23 00:34:13');

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
INSERT INTO `t_notice` VALUES ('1', '房源发布平台成立了', '<p>同志们，你们自己的或者朋友的房源都可以发布到这里，管理审核通过后就可以展示了哦！</p>', '2019-03-22 22:38:12');

-- ----------------------------
-- Table structure for `t_pricerange`
-- ----------------------------
DROP TABLE IF EXISTS `t_pricerange`;
CREATE TABLE `t_pricerange` (
  `rangeId` int(11) NOT NULL auto_increment COMMENT '租金范围id',
  `rangeName` varchar(50) NOT NULL COMMENT '租金范围区段',
  PRIMARY KEY  (`rangeId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_pricerange
-- ----------------------------
INSERT INTO `t_pricerange` VALUES ('1', '0~500元');
INSERT INTO `t_pricerange` VALUES ('2', '500~1000元');
INSERT INTO `t_pricerange` VALUES ('3', '1000~1500元');
INSERT INTO `t_pricerange` VALUES ('4', '1500~2500元');
INSERT INTO `t_pricerange` VALUES ('5', '2500~4000元');
INSERT INTO `t_pricerange` VALUES ('6', '4000元以上');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
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
INSERT INTO `t_userinfo` VALUES ('user1', '123', '王夏天', '女', '2019-03-12', 'upload/b8053268-cbf2-419f-8ec6-656274f798e5.jpg', '13958342342', 'xiayu@163.com', '四川成都红星路13号', '2019-03-22 22:36:45');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '张晓丽', '女', '2019-03-13', 'upload/b2ecd613-4e11-4a17-b3d8-1eec4b039e9e.jpg', '13908130853', 'xiaoli@126.com', '四川南充滨江路', '2019-03-22 23:53:46');
