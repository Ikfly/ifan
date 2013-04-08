# MySQL-Front 5.1  (Build 4.2)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: localhost    Database: ifan
# ------------------------------------------------------
# Server version 5.1.55-community

#
# Source for table b_message
#

CREATE TABLE `b_message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `senderId` int(11) NOT NULL DEFAULT '0',
  `senderName` varchar(30) NOT NULL DEFAULT '',
  `receiverId` int(11) NOT NULL DEFAULT '0',
  `message` varchar(50) NOT NULL DEFAULT '0',
  `sendTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `isRead` int(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_id`)
) ENGINE=MyISAM AUTO_INCREMENT=393 DEFAULT CHARSET=utf8 COMMENT='聊天记录';

#
# Dumping data for table b_message
#

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
