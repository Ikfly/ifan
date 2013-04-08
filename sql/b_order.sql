# MySQL-Front 5.1  (Build 4.2)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: localhost    Database: ifan
# ------------------------------------------------------
# Server version 5.1.55-community

#
# Source for table b_order
#

CREATE TABLE `b_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `real_username` varchar(50) NOT NULL DEFAULT '',
  `order_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `extra_number` int(11) NOT NULL DEFAULT '0',
  `checked` int(4) NOT NULL DEFAULT '0',
  `note` varchar(50) DEFAULT '0',
  `changeNote` varchar(25) DEFAULT '',
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=908 DEFAULT CHARSET=utf8;

#
# Dumping data for table b_order
#

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
