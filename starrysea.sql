/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : starrysea

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-12-13 09:56:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `activity_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(30) NOT NULL,
  `activity_content` text NOT NULL,
  `activity_status` tinyint(4) NOT NULL COMMENT '1-未开始\r\n2-进行中\r\n3-已结束',
  `activity_cover` varchar(50) NOT NULL,
  `activity_summary` varchar(50) NOT NULL,
  `activity_endtime` date DEFAULT NULL,
  PRIMARY KEY (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=440 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for activity_image
-- ----------------------------
DROP TABLE IF EXISTS `activity_image`;
CREATE TABLE `activity_image` (
  `activity_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) NOT NULL,
  `activity_image_path` varchar(50) NOT NULL,
  PRIMARY KEY (`activity_image_id`),
  KEY `activity_id` (`activity_id`) USING BTREE,
  CONSTRAINT `activity_image_ibfk_1` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_useraccount` varchar(10) NOT NULL,
  `admin_password` varchar(35) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `area_id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL,
  `area_name` varchar(10) NOT NULL,
  PRIMARY KEY (`area_id`),
  KEY `city_id` (`city_id`) USING BTREE,
  CONSTRAINT `area_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for city
-- ----------------------------
DROP TABLE IF EXISTS `city`;
CREATE TABLE `city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `province_id` int(11) NOT NULL,
  `city_name` varchar(10) NOT NULL,
  PRIMARY KEY (`city_id`),
  KEY `province_id` (`province_id`) USING BTREE,
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `province` (`province_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for funding
-- ----------------------------
DROP TABLE IF EXISTS `funding`;
CREATE TABLE `funding` (
  `funding_id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) NOT NULL,
  `funding_name` varchar(20) NOT NULL,
  `funding_money` decimal(7,2) NOT NULL,
  `funding_message` varchar(50) NOT NULL,
  PRIMARY KEY (`funding_id`),
  KEY `activity_id` (`activity_id`) USING BTREE,
  CONSTRAINT `funding_ibfk_1` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`activity_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for online
-- ----------------------------
DROP TABLE IF EXISTS `online`;
CREATE TABLE `online` (
  `online_id` varchar(10) NOT NULL,
  `online_email` varchar(50) NOT NULL,
  PRIMARY KEY (`online_id`),
  UNIQUE KEY `online_email` (`online_email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` varchar(10) NOT NULL,
  `work_id` int(11) NOT NULL,
  `order_num` varchar(30) NOT NULL,
  `order_name` varchar(10) NOT NULL,
  `order_area` int(11) NOT NULL,
  `order_address` varchar(50) NOT NULL,
  `order_status` tinyint(4) NOT NULL COMMENT '1-未发货\r\n2-已发货',
  `order_expressnum` varchar(30) DEFAULT NULL,
  `order_time` bigint(10) unsigned NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `order_area` (`order_area`) USING BTREE,
  KEY `work_id` (`work_id`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`order_area`) REFERENCES `area` (`area_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`work_id`) REFERENCES `work` (`work_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for province
-- ----------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province` (
  `province_id` int(11) NOT NULL AUTO_INCREMENT,
  `province_name` varchar(10) NOT NULL,
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for work
-- ----------------------------
DROP TABLE IF EXISTS `work`;
CREATE TABLE `work` (
  `work_id` int(11) NOT NULL AUTO_INCREMENT,
  `work_name` varchar(30) NOT NULL,
  `work_uploadtime` date NOT NULL,
  `work_pdfpath` varchar(50) NOT NULL,
  `work_stock` int(10) unsigned NOT NULL,
  `work_cover` varchar(50) NOT NULL,
  `work_summary` varchar(50) NOT NULL,
  `work_click` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`work_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for work_image
-- ----------------------------
DROP TABLE IF EXISTS `work_image`;
CREATE TABLE `work_image` (
  `work_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `work_id` int(11) NOT NULL,
  `work_image_path` varchar(50) NOT NULL,
  PRIMARY KEY (`work_image_id`),
  KEY `work_id` (`work_id`) USING BTREE,
  CONSTRAINT `work_image_ibfk_1` FOREIGN KEY (`work_id`) REFERENCES `work` (`work_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
