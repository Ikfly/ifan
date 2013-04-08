# MySQL-Front 5.1  (Build 4.2)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: localhost    Database: ifan
# ------------------------------------------------------
# Server version 5.1.55-community

#
# Source for table b_order_user
#

CREATE TABLE `b_order_user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) NOT NULL DEFAULT '',
  `userPassword` varchar(50) NOT NULL DEFAULT '',
  `userRealName` varchar(50) NOT NULL DEFAULT '0',
  `email` varchar(255) DEFAULT NULL,
  `registIp` varchar(100) NOT NULL DEFAULT '0' COMMENT '注册时的ip',
  `loginIp` varchar(100) DEFAULT '0' COMMENT '上次登录ip',
  `typeId` int(11) NOT NULL DEFAULT '3',
  `recentEmail` datetime DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='用户表';

#
# Dumping data for table b_order_user
#

INSERT INTO `b_order_user` VALUES (42,'liuhang','96e79218965eb72c92a549dd5a330112','刘航','124915122@qq.com','192.168.1.110','192.168.1.189',2,'2012-06-05 16:50:19');

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
