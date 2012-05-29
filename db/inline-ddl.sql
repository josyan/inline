-- MySQL dump 10.11
--
-- Host: 127.0.0.1    Database: inline_development
-- ------------------------------------------------------
-- Server version	5.0.51b-community-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `inline_development`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `inline_development` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `inline_development`;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL default '',
  `address` varchar(200) default NULL,
  `phone` varchar(50) default NULL,
  `fax` varchar(50) default NULL,
  `logo` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `database_translation_fields`
--

DROP TABLE IF EXISTS `database_translation_fields`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `database_translation_fields` (
  `id` int(11) NOT NULL auto_increment,
  `table` varchar(50) NOT NULL default '',
  `field` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `database_translations`
--

DROP TABLE IF EXISTS `database_translations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `database_translations` (
  `id` int(11) NOT NULL auto_increment,
  `record_id` int(11) NOT NULL default '0',
  `table` varchar(50) NOT NULL default '',
  `field` varchar(50) NOT NULL default '',
  `fr` text,
  `en` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=251 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dimensions`
--

DROP TABLE IF EXISTS `dimensions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `dimensions` (
  `id` int(11) NOT NULL auto_increment,
  `serie_id` int(11) NOT NULL default '0',
  `value` float NOT NULL default '0',
  `type` varchar(6) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=581 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `openings`
--

DROP TABLE IF EXISTS `openings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `openings` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `abbreviation` varchar(5) NOT NULL default '',
  `openable` tinyint(1) NOT NULL default '0',
  `preview_image_name` varchar(100) default NULL,
  `glasses_quantity` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `openings_series`
--

DROP TABLE IF EXISTS `openings_series`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `openings_series` (
  `opening_id` int(11) NOT NULL default '0',
  `serie_id` int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `options`
--

DROP TABLE IF EXISTS `options`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `options` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(50) NOT NULL default '',
  `comments` text,
  `pricing_method_id` int(11) NOT NULL default '0',
  `price` float NOT NULL default '0',
  `minimum_quantity` float NOT NULL default '0',
  `options_minimum_unit_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `options_minimum_units`
--

DROP TABLE IF EXISTS `options_minimum_units`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `options_minimum_units` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(50) NOT NULL default '',
  `comments` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `options_quotation_lines`
--

DROP TABLE IF EXISTS `options_quotation_lines`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `options_quotation_lines` (
  `option_id` int(11) NOT NULL default '0',
  `quotation_line_id` int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `options_series`
--

DROP TABLE IF EXISTS `options_series`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `options_series` (
  `option_id` int(11) NOT NULL default '0',
  `serie_id` int(11) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `permissions` (
  `id` int(11) NOT NULL auto_increment,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pricing_methods`
--

DROP TABLE IF EXISTS `pricing_methods`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pricing_methods` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(50) NOT NULL default '',
  `comments` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `quotation_lines`
--

DROP TABLE IF EXISTS `quotation_lines`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `quotation_lines` (
  `id` int(11) NOT NULL auto_increment,
  `quotation_id` int(11) NOT NULL default '0',
  `serie_id` int(11) NOT NULL default '0',
  `shape_id` int(11) NOT NULL default '0',
  `width` float NOT NULL default '0',
  `height` float NOT NULL default '0',
  `quantity` int(11) NOT NULL default '0',
  `price` float NOT NULL default '0',
  `label` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=369 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `quotation_lines_openings`
--

DROP TABLE IF EXISTS `quotation_lines_openings`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `quotation_lines_openings` (
  `id` int(11) NOT NULL auto_increment,
  `quotation_line_id` int(11) NOT NULL default '0',
  `opening_id` int(11) NOT NULL default '0',
  `sort_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=648 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `quotations`
--

DROP TABLE IF EXISTS `quotations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `quotations` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(50) NOT NULL default '',
  `comments` text,
  `project_name` varchar(150) default NULL,
  `customer_name` varchar(150) default NULL,
  `customer_address` varchar(200) default NULL,
  `customer_phone` varchar(50) default NULL,
  `customer_fax` varchar(50) default NULL,
  `customer_email` varchar(50) default NULL,
  `transport` float NOT NULL default '0',
  `discount` float NOT NULL default '0',
  `taxes` float NOT NULL default '0',
  `notes` text,
  `ready_to_sign` tinyint(1) default '0',
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `rolename` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `section_dimensions`
--

DROP TABLE IF EXISTS `section_dimensions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `section_dimensions` (
  `id` int(11) NOT NULL auto_increment,
  `quotation_line_id` int(11) NOT NULL default '0',
  `sort_order` int(11) NOT NULL default '0',
  `value` float NOT NULL default '0',
  `type` varchar(13) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2464 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `serie_prices`
--

DROP TABLE IF EXISTS `serie_prices`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `serie_prices` (
  `id` int(11) NOT NULL auto_increment,
  `width_id` int(11) NOT NULL default '0',
  `height_id` int(11) NOT NULL default '0',
  `opening_id` int(11) NOT NULL default '0',
  `price` float NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17566 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `series`
--

DROP TABLE IF EXISTS `series`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `series` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `description` varchar(255) NOT NULL default '',
  `comments` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `shapes`
--

DROP TABLE IF EXISTS `shapes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `shapes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `sections_width` int(11) NOT NULL default '0',
  `sections_height` int(11) NOT NULL default '0',
  `corners` int(11) NOT NULL default '4',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `translations` (
  `id` int(11) NOT NULL auto_increment,
  `translation_key` varchar(100) NOT NULL default '',
  `fr` text,
  `comments` text,
  `en` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=378 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(255) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `activation_code` varchar(40) default NULL,
  `activated_at` datetime default NULL,
  `password_reset_code` varchar(40) default NULL,
  `enabled` tinyint(1) default '1',
  `discount` float NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-08-05  1:22:45
