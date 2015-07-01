-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: banshee_dev
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.04.1

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
-- Table structure for table `agenda`
--

DROP TABLE IF EXISTS `agenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agenda` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(100) NOT NULL,
  `value` mediumtext NOT NULL,
  `timeout` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collection_album`
--

DROP TABLE IF EXISTS `collection_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collection_album` (
  `collection_id` int(10) unsigned NOT NULL,
  `album_id` int(10) unsigned NOT NULL,
  KEY `collection_id` (`collection_id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `collection_album_ibfk_1` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`),
  CONSTRAINT `collection_album_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(100) NOT NULL,
  `short_description` text NOT NULL,
  `long_description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dummy`
--

DROP TABLE IF EXISTS `dummy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dummy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `line` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `boolean` tinyint(1) NOT NULL,
  `date` date NOT NULL,
  `enum` enum('value1','value2','value3') NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `dummy_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dummy`
--

LOCK TABLES `dummy` WRITE;
/*!40000 ALTER TABLE `dummy` DISABLE KEYS */;
INSERT INTO `dummy` VALUES (1,72,'hello world','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus erat urna, accumsan at, mattis eu, euismod nec, justo. Integer consectetur. Aliquam erat volutpat. Sed ac ipsum. Maecenas pretium, felis non blandit pellentesque, arcu nulla adipiscing dui, ac sollicitudin ipsum nisl a dolor. Praesent in dolor consequat massa molestie mollis. In viverra eleifend purus. Nunc vel sapien. Etiam risus. Morbi auctor commodo nunc. In hac habitasse platea dictumst. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse posuere lectus non sapien. Mauris congue dolor a magna.\r\n\r\nMauris tristique justo ac sem. Vivamus pharetra quam et nunc. Proin quis erat. Proin pharetra mattis enim. Sed diam. Aliquam tempor eros sed odio aliquam fringilla. Nulla posuere. Phasellus eleifend sem a odio feugiat vehicula. Integer dignissim, est sed consectetur vestibulum, massa arcu ultrices nulla, ac consequat ligula justo at tellus. Etiam interdum est quis felis. Mauris lacinia.',0,'2009-02-18','value2',1),(2,23,'Lorum ipsum','ouifhilduvnxaifs driaurfc iweurnfcisaeurnbc iseruvsieurbviaceurbnfc iscdbn ilzdbv sraerf ase rgc sr cae rgv sfgb vaergcfh seirfc togvcn eufnseirgubc sertcgse riguncs eriuneizrung caieunrfgc iaeurb vsiubre viseurb viauerf ciaseur vciauwe nrisuviaeruniapwuenfc awijf wrtunh gviasuebr vciaubervn isubeviauebrf isbv iauebrf iauebnrv iaunerv iaubf visuubenrv iaeubnrfv aiebviAHWBE FIWY4BTGV9QUHB3 FIAUUBFPIUbi suuebrfiauuwbef istrbv isdbfv aidfvb',1,'2009-01-23','value3',NULL);
/*!40000 ALTER TABLE `dummy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faq_sections`
--

DROP TABLE IF EXISTS `faq_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faqs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `section_id` int(10) unsigned NOT NULL,
  `question` tinytext NOT NULL,
  `answer` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `section_id` (`section_id`),
  CONSTRAINT `faqs_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `faq_sections` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flags`
--

DROP TABLE IF EXISTS `flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `module` varchar(50) NOT NULL,
  `flag` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_last_view`
--

DROP TABLE IF EXISTS `forum_last_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_last_view` (
  `user_id` int(10) unsigned NOT NULL,
  `last_view` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `forum_last_view_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_messages`
--

DROP TABLE IF EXISTS `forum_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` text NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `topic_id` (`topic_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `forum_messages_ibfk_1` FOREIGN KEY (`topic_id`) REFERENCES `forum_topics` (`id`),
  CONSTRAINT `forum_messages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_messages`
--

LOCK TABLES `forum_messages` WRITE;
/*!40000 ALTER TABLE `forum_messages` DISABLE KEYS */;
INSERT INTO `forum_messages` VALUES (1,1,1,NULL,'2013-04-30 08:54:44','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ac elit quam. Nullam aliquam justo et nisi dictum pretium interdum tellus hendrerit. Aenean tristique posuere dictum. Maecenas nec sapien ut magna suscipit euismod quis ut metus. Aenean sit amet metus a turpis iaculis mollis. Nam faucibus mauris vel ligula ultricies dapibus. Nullam quis orci ac sem convallis malesuada nec id nisi. Praesent quis tellus nec sapien viverra blandit at ut erat. Curabitur bibendum malesuada erat, in suscipit leo porta et. Cras quis arcu sit amet nibh molestie mollis eu eget nulla. Vivamus sed enim fringilla elit pretium feugiat. Nullam elementum fermentum nunc in sodales.\r\n\r\nMauris nec nunc quis enim porttitor consectetur at et lorem. Vivamus ac rutrum sapien. Nullam metus lectus, lobortis sit amet vulputate sit amet, fermentum sed velit. Phasellus ac libero urna. Maecenas tellus massa, ultrices sed pretium non, faucibus ut lorem. Donec aliquam vehicula ante, eu sodales felis ullamcorper at. Sed sed odio ipsum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam laoreet tristique est in molestie. Sed lacinia euismod porttitor. Praesent ullamcorper fringilla arcu sit amet viverra. Aliquam erat volutpat.\r\n\r\nNulla vel eros quam. Nam nec turpis ac turpis pulvinar facilisis non non nunc. Nam bibendum nunc in velit cursus rutrum. Integer at ultricies orci. Suspendisse vitae sodales dui. Integer malesuada hendrerit dui, a ullamcorper mauris aliquam sit amet. Nulla dignissim tortor accumsan velit laoreet non eleifend massa aliquet. Quisque luctus dapibus viverra. Aliquam sed lorem diam. Phasellus condimentum lectus vitae ipsum molestie a vestibulum risus malesuada. Duis posuere urna a arcu facilisis sit amet blandit lacus tempus. Vestibulum vel arcu nunc, ut imperdiet massa. Donec congue risus nec urna laoreet et euismod magna semper. Fusce pharetra porttitor ultrices.','84.29.202.23');
/*!40000 ALTER TABLE `forum_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_topics`
--

DROP TABLE IF EXISTS `forum_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `forum_id` int(10) unsigned NOT NULL,
  `subject` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_id` (`forum_id`),
  CONSTRAINT `forum_topics_ibfk_1` FOREIGN KEY (`forum_id`) REFERENCES `forums` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_topics`
--

LOCK TABLES `forum_topics` WRITE;
/*!40000 ALTER TABLE `forum_topics` DISABLE KEYS */;
INSERT INTO `forum_topics` VALUES (1,1,'Lorum ipsum');
/*!40000 ALTER TABLE `forum_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forums`
--

DROP TABLE IF EXISTS `forums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forums` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `order` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forums`
--

LOCK TABLES `forums` WRITE;
/*!40000 ALTER TABLE `forums` DISABLE KEYS */;
INSERT INTO `forums` VALUES (1,'Lorum ipsum','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a purus velit, et porttitor diam.',1);
/*!40000 ALTER TABLE `forums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guestbook`
--

DROP TABLE IF EXISTS `guestbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guestbook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `en` text NOT NULL,
  `nl` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `page` (`page`,`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `text` varchar(100) NOT NULL,
  `link` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `links`
--

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` VALUES (1,'Hiawatha webserver','https://www.hiawatha-webserver.org/'),(2,'Banshee PHP framework','http://www.banshee-php.org/');
/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_clients`
--

DROP TABLE IF EXISTS `log_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `os` tinytext NOT NULL,
  `browser` tinytext NOT NULL,
  `date` date NOT NULL,
  `count` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_page_views`
--

DROP TABLE IF EXISTS `log_page_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_page_views` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page` tinytext NOT NULL,
  `date` date NOT NULL,
  `count` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_referers`
--

DROP TABLE IF EXISTS `log_referers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_referers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hostname` tinytext NOT NULL,
  `url` text NOT NULL,
  `date` date NOT NULL,
  `count` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_search_queries`
--

DROP TABLE IF EXISTS `log_search_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_search_queries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `query` tinytext NOT NULL,
  `date` date NOT NULL,
  `count` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_visits`
--

DROP TABLE IF EXISTS `log_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_visits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `count` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailbox`
--

DROP TABLE IF EXISTS `mailbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailbox` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(10) unsigned NOT NULL,
  `subject` tinytext NOT NULL,
  `message` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read` tinyint(4) NOT NULL DEFAULT '0',
  `deleted_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailbox`
--

LOCK TABLES `mailbox` WRITE;
/*!40000 ALTER TABLE `mailbox` DISABLE KEYS */;
INSERT INTO `mailbox` VALUES (1,2,1,'Hello','Hi user,\r\n\r\nHow are you today?\r\n\r\nGreetings,\r\nAdministrator','2013-02-13 13:31:02',0,NULL);
/*!40000 ALTER TABLE `mailbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `text` varchar(100) NOT NULL,
  `link` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,0,'Home','/'),(2,0,'Modules','/modules'),(3,0,'Demos','/demos'),(4,3,'Test','/test'),(5,0,'CMS','/cms');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'Lorum ipsum','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ac elit quam. Nullam aliquam justo et nisi dictum pretium interdum tellus hendrerit. Aenean tristique posuere dictum. Maecenas nec sapien ut magna suscipit euismod quis ut metus. Aenean sit amet metus a turpis iaculis mollis. Nam faucibus mauris vel ligula ultricies dapibus. Nullam quis orci ac sem convallis malesuada nec id nisi. Praesent quis tellus nec sapien viverra blandit at ut erat. Curabitur bibendum malesuada erat, in suscipit leo porta et. Cras quis arcu sit amet nibh molestie mollis eu eget nulla. Vivamus sed enim fringilla elit pretium feugiat. Nullam elementum fermentum nunc in sodales.</p>\r\n\r\n<p>Mauris nec nunc quis enim porttitor consectetur at et lorem. Vivamus ac rutrum sapien. Nullam metus lectus, lobortis sit amet vulputate sit amet, fermentum sed velit. Phasellus ac libero urna. Maecenas tellus massa, ultrices sed pretium non, faucibus ut lorem. Donec aliquam vehicula ante, eu sodales felis ullamcorper at. Sed sed odio ipsum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam laoreet tristique est in molestie. Sed lacinia euismod porttitor. Praesent ullamcorper fringilla arcu sit amet viverra. Aliquam erat volutpat.</p>\r\n\r\n<p>Nulla vel eros quam. Nam nec turpis ac turpis pulvinar facilisis non non nunc. Nam bibendum nunc in velit cursus rutrum. Integer at ultricies orci. Suspendisse vitae sodales dui. Integer malesuada hendrerit dui, a ullamcorper mauris aliquam sit amet. Nulla dignissim tortor accumsan velit laoreet non eleifend massa aliquet. Quisque luctus dapibus viverra. Aliquam sed lorem diam. Phasellus condimentum lectus vitae ipsum molestie a vestibulum risus malesuada. Duis posuere urna a arcu facilisis sit amet blandit lacus tempus. Vestibulum vel arcu nunc, ut imperdiet massa. Donec congue risus nec urna laoreet et euismod magna semper. Fusce pharetra porttitor ultrices.</p>','2013-04-30 00:00:00');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisations`
--

DROP TABLE IF EXISTS `organisations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organisations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisations`
--

LOCK TABLES `organisations` WRITE;
/*!40000 ALTER TABLE `organisations` DISABLE KEYS */;
INSERT INTO `organisations` VALUES (1,'My organisation');
/*!40000 ALTER TABLE `organisations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_access`
--

DROP TABLE IF EXISTS `page_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_access` (
  `page_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`page_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `page_access_ibfk_1` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`),
  CONSTRAINT `page_access_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_access`
--

LOCK TABLES `page_access` WRITE;
/*!40000 ALTER TABLE `page_access` DISABLE KEYS */;
INSERT INTO `page_access` VALUES (4,2,1);
/*!40000 ALTER TABLE `page_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(100) NOT NULL,
  `language` varchar(2) NOT NULL,
  `layout` varchar(100) DEFAULT NULL,
  `private` tinyint(1) NOT NULL,
  `style` text,
  `title` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `keywords` varchar(100) NOT NULL,
  `content` mediumtext NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `back` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'/homepage','en',NULL,0,'img.logo {\r\n  float:right;\r\n  margin-left:20px;\r\n}\r\n\r\n@media (max-width:767px) {\r\n  img.logo {\r\n    width:70px;\r\n  }\r\n}','Welcome to Banshee, the secure PHP framework','','','<p>Banshee is a PHP website framework, which aims at to be secure, fast and easy to use. It uses the Model-View-Control architecture with XSLT for the View. Although it was designed to use MySQL as the database, other database applications can be used as well with only little effort. For more information about Banshee, visit the <a href=\"http://www.banshee-php.org/\">Banshee website</a>.</p>\r\n\r\n<img src=\"http://www.banshee-php.org/logo.php\" class=\"logo\" alt=\"Banshee logo\">\r\n\r\n<p>In this default installation, there are two users available: \'admin\' and \'user\'. Both have the password \'banshee\'.</p>\r\n\r\n<p>If security is a high priority for your website, you should take a look at the <a href=\"http://www.hiawatha-webserver.org\">Hiawatha webserver</a>.</p>',1,0),(2,'/modules','en',NULL,0,NULL,'Banshee modules','Modules in Banshee','modules','<ul>\r\n<li><a href=\"/agenda\">Agenda</a></li>\r\n<li><a href=\"/contact\">Contact form</a></li>\r\n<li><a href=\"/dictionary\">Dictionary</a></li>\r\n<li><a href=\"/faq\">F.A.Q.</a></li>\r\n<li><a href=\"/forum\">Forum</a></li>\r\n<li><a href=\"/guestbook\">Guestbook</a></li>\r\n<li><a href=\"/links\">Links</a></li>\r\n<li><a href=\"/mailbox\">Mailbox</a></li>\r\n<li><a href=\"/news\">News</a></li>\r\n<li><a href=\"/newsletter\">Newsletter</a></li>\r\n<li><a href=\"/photo\">Photo album</a></li>\r\n<li><a href=\"/collection\">Photo album collections</a></li>\r\n<li><a href=\"/poll\">Poll</a></li>\r\n<li><a href=\"/profile\">Profile manager</a></li>\r\n<li><a href=\"/search\">Search</a></li>\r\n<li><a href=\"/session\">Session manager</a></li>\r\n<li><a href=\"/weblog\">Weblog</a></li>\r\n</ul>',1,0),(3,'/demos','en',NULL,0,NULL,'Banshee functionality demos','Banshee demos','banshee, demos','<ul>\r\n<li>The <a href=\"/demos/captcha\">captcha</a> library.</li>\r\n<li>This page shows <a href=\"/demos/errors\">errors and messages</a> generated by the framework.</li>\r\n<li>An <a href=\"/demos/invisible\">invisible</a> page, a <a href=\"/demos/private\">private</a> page and a <a href=\"/demos/void\">non-existing</a> page.</li>\r\n<li>The WYSIWYG <a href=\"/demos/ckeditor\">CKEditor</a>.</li>\r\n<li><a href=\"/demos/googlemaps\">GoogleMaps static map</a> demo.</a></li>\r\n<li>A <a href=\"/demos/pagination\">pagination</a> library.</li>\r\n<li>An <a href=\"/demos/alphabetize\">alphabetize</a> library.</li>\r\n<li>The <a href=\"/demos/pdf\">FPDF</a> library.</li>\r\n<li>A <a href=\"/demos/graph\">graph</a> library.</li>\r\n<li>A <a href=\"/demos/poll\">poll</a> module.</li>\r\n<li>The <a href=\"/demos/posting\">posting</a> library.</li>\r\n<li>The <a href=\"/demos/tablemanager\">tablemanager</a> library.</li>\r\n<li>The <a href=\"/demos/splitform\">splitform</a> library.</li>\r\n<li><a href=\"/demos/utf8\">UTF-8</a> character encoding.</li>\r\n<li>A library for <a href=\"/demos/validation\">input validation</a>.</li>\r\n</ul>\r\n',1,0),(4,'/demos/private','en',NULL,1,NULL,'Private page','','','<p>This is a private page.</p>',1,1),(5,'/demos/invisible','en',NULL,0,NULL,'Invisible page','','','<p>This page is invisible to normal users and visitors. Only users with access to the page administration page can view this page.</p>\r\n<p>Page administrators can use this feature to verify a page before making it available to visitors.</p>',0,1),(6,'/demos/utf8','en',NULL,0,NULL,'UTF-8 demo','','','<p>這是一個測試頁，以顯示漢字。</p>',1,1);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_albums` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'Wallpapers','Collection of wallpapers','2010-08-20 22:00:00');
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `photo_album_id` int(10) unsigned NOT NULL,
  `extension` varchar(6) NOT NULL,
  `overview` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `photo_album_id` (`photo_album_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`photo_album_id`) REFERENCES `photo_albums` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,'Hiawatha webserver',1,'png',1);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_answers`
--

DROP TABLE IF EXISTS `poll_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_answers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `poll_id` int(11) unsigned NOT NULL,
  `answer` varchar(100) NOT NULL,
  `votes` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `poll_id` (`poll_id`),
  CONSTRAINT `poll_answers_ibfk_1` FOREIGN KEY (`poll_id`) REFERENCES `polls` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_answers`
--

LOCK TABLES `poll_answers` WRITE;
/*!40000 ALTER TABLE `poll_answers` DISABLE KEYS */;
INSERT INTO `poll_answers` VALUES (1,1,'Lorum',2),(2,1,'Ipsum',4),(3,1,'Dolor',1),(4,2,'Hiawatha',1),(5,2,'Apache',0),(6,2,'Cherokee',0),(7,2,'Nginx',0),(8,2,'Lighttpd',0),(13,3,'Windows',0),(14,3,'MacOS X',0),(15,3,'Linux',1),(16,3,'BSD',0);
/*!40000 ALTER TABLE `poll_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polls`
--

DROP TABLE IF EXISTS `polls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `polls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` varchar(100) NOT NULL,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polls`
--

LOCK TABLES `polls` WRITE;
/*!40000 ALTER TABLE `polls` DISABLE KEYS */;
INSERT INTO `polls` VALUES (1,'Lorum ipsum','2012-01-01','2012-12-31'),(2,'The best webserver','2013-01-01','2029-12-31'),(3,'Best OS','2015-05-26','2015-06-28');
/*!40000 ALTER TABLE `polls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `profile` tinyint(4) DEFAULT '0',
  `mailbox` tinyint(4) DEFAULT '0',
  `session` tinyint(4) DEFAULT '0',
  `demos/tablemanager` tinyint(4) DEFAULT '0',
  `cms` tinyint(4) DEFAULT '0',
  `cms/access` tinyint(4) DEFAULT '0',
  `cms/action` tinyint(4) DEFAULT '0',
  `cms/agenda` tinyint(4) DEFAULT '0',
  `cms/album` tinyint(4) DEFAULT '0',
  `cms/apitest` tinyint(4) DEFAULT '0',
  `cms/collection` tinyint(4) DEFAULT '0',
  `cms/dictionary` tinyint(4) DEFAULT '0',
  `cms/faq` tinyint(4) DEFAULT '0',
  `cms/file` tinyint(4) DEFAULT '0',
  `cms/flag` tinyint(4) DEFAULT '0',
  `cms/forum` tinyint(4) DEFAULT '0',
  `cms/forum/section` tinyint(4) DEFAULT '0',
  `cms/guestbook` tinyint(4) DEFAULT '0',
  `cms/language` tinyint(4) DEFAULT '0',
  `cms/links` tinyint(4) DEFAULT '0',
  `cms/logging` tinyint(4) DEFAULT '0',
  `cms/menu` tinyint(4) DEFAULT '0',
  `cms/news` tinyint(4) DEFAULT '0',
  `cms/newsletter` tinyint(4) DEFAULT '0',
  `cms/organisation` tinyint(4) DEFAULT '0',
  `cms/page` tinyint(4) DEFAULT '0',
  `cms/photo` tinyint(4) DEFAULT '0',
  `cms/poll` tinyint(4) DEFAULT '0',
  `cms/role` tinyint(4) DEFAULT '0',
  `cms/settings` tinyint(4) DEFAULT '0',
  `cms/subscriptions` tinyint(4) DEFAULT '0',
  `cms/switch` tinyint(4) DEFAULT '0',
  `cms/user` tinyint(4) DEFAULT '0',
  `cms/weblog` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrator',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),(2,'User',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(100) NOT NULL,
  `content` text,
  `expire` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `name` tinytext,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(32) NOT NULL,
  `type` varchar(8) NOT NULL,
  `value` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'admin_page_size','integer','25'),(31,'photo_page_size','integer','10'),(5,'default_language','string','en'),(32,'photo_thumbnail_height','integer','100'),(9,'start_page','string','homepage'),(10,'webmaster_email','string','void@banshee-php.org'),(30,'forum_page_size','string','25'),(12,'forum_maintainers','string','Moderator'),(13,'guestbook_page_size','integer','10'),(14,'guestbook_maintainers','string','Publisher'),(15,'news_page_size','integer','5'),(16,'news_rss_page_size','string','30'),(17,'newsletter_bcc_size','integer','100'),(18,'newsletter_code_timeout','string','15 minutes'),(19,'newsletter_email','string','void@banshee-php.org'),(20,'newsletter_name','string','Hugo Leisink'),(36,'contact_email','string','void@banshee-php.org'),(22,'poll_max_answers','integer','10'),(44,'poll_bans','string\n',''),(24,'weblog_page_size','string','5'),(25,'weblog_rss_page_size','integer','30'),(26,'head_title','string','Banshee'),(27,'head_description','string','Secure PHP framework'),(28,'head_keywords','string','banshee, secure, php, framework'),(33,'photo_image_height','integer','450'),(35,'secret_website_code','string','CHANGE_ME_INTO_A_RANDOM_STRING'),(37,'photo_thumbnail_width','integer','100'),(38,'photo_image_width','integer','700'),(39,'hiawatha_cache_default_time','integer','3600'),(40,'photo_album_size','integer','18'),(41,'hiawatha_cache_enabled','boolean','false'),(42,'session_timeout','integer','600'),(43,'session_persistent','boolean','false');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_address` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` VALUES (1,'hugo@banshee-php.org');
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  KEY `role_id` (`role_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (2,2),(1,1);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `organisation_id` int(10) unsigned NOT NULL,
  `username` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `password` varchar(128) NOT NULL,
  `one_time_key` varchar(128) DEFAULT NULL,
  `cert_serial` int(10) unsigned DEFAULT NULL,
  `status` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `fullname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `organisation_id` (`organisation_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`organisation_id`) REFERENCES `organisations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'admin','c10b391ff5e75af6ee8469539e6a5428f09eff7e693d6a8c4de0e5525cd9b287',NULL,NULL,1,'Administrator','admin@banshee-php.org'),(2,1,'user','b4f6b1c67ef4f9c3dc67aae05c5d09411fa927e360063f7fd983710dc882cb3c',NULL,NULL,1,'Normal user','user@banshee-php.org');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weblog_comments`
--

DROP TABLE IF EXISTS `weblog_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weblog_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `weblog_id` int(10) unsigned NOT NULL,
  `author` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `weblog_id` (`weblog_id`),
  CONSTRAINT `weblog_comments_ibfk_1` FOREIGN KEY (`weblog_id`) REFERENCES `weblogs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weblog_tagged`
--

DROP TABLE IF EXISTS `weblog_tagged`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weblog_tagged` (
  `weblog_id` int(10) unsigned NOT NULL,
  `weblog_tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`weblog_id`,`weblog_tag_id`),
  KEY `weblog_tag_id` (`weblog_tag_id`),
  CONSTRAINT `weblog_tagged_ibfk_1` FOREIGN KEY (`weblog_id`) REFERENCES `weblogs` (`id`),
  CONSTRAINT `weblog_tagged_ibfk_2` FOREIGN KEY (`weblog_tag_id`) REFERENCES `weblog_tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weblog_tagged`
--

LOCK TABLES `weblog_tagged` WRITE;
/*!40000 ALTER TABLE `weblog_tagged` DISABLE KEYS */;
INSERT INTO `weblog_tagged` VALUES (1,1);
/*!40000 ALTER TABLE `weblog_tagged` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weblog_tags`
--

DROP TABLE IF EXISTS `weblog_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weblog_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weblog_tags`
--

LOCK TABLES `weblog_tags` WRITE;
/*!40000 ALTER TABLE `weblog_tags` DISABLE KEYS */;
INSERT INTO `weblog_tags` VALUES (1,'lorum ipsum');
/*!40000 ALTER TABLE `weblog_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weblogs`
--

DROP TABLE IF EXISTS `weblogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weblogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `visible` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `weblogs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weblogs`
--

LOCK TABLES `weblogs` WRITE;
/*!40000 ALTER TABLE `weblogs` DISABLE KEYS */;
INSERT INTO `weblogs` VALUES (1,1,'Lorum ipsum','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ac elit quam. Nullam aliquam justo et nisi dictum pretium interdum tellus hendrerit. Aenean tristique posuere dictum. Maecenas nec sapien ut magna suscipit euismod quis ut metus. Aenean sit amet metus a turpis iaculis mollis. Nam faucibus mauris vel ligula ultricies dapibus. Nullam quis orci ac sem convallis malesuada nec id nisi. Praesent quis tellus nec sapien viverra blandit at ut erat. Curabitur bibendum malesuada erat, in suscipit leo porta et. Cras quis arcu sit amet nibh molestie mollis eu eget nulla. Vivamus sed enim fringilla elit pretium feugiat. Nullam elementum fermentum nunc in sodales.</p>\r\n\r\n<p>Mauris nec nunc quis enim porttitor consectetur at et lorem. Vivamus ac rutrum sapien. Nullam metus lectus, lobortis sit amet vulputate sit amet, fermentum sed velit. Phasellus ac libero urna. Maecenas tellus massa, ultrices sed pretium non, faucibus ut lorem. Donec aliquam vehicula ante, eu sodales felis ullamcorper at. Sed sed odio ipsum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam laoreet tristique est in molestie. Sed lacinia euismod porttitor. Praesent ullamcorper fringilla arcu sit amet viverra. Aliquam erat volutpat.</p>\r\n\r\n<p>Nulla vel eros quam. Nam nec turpis ac turpis pulvinar facilisis non non nunc. Nam bibendum nunc in velit cursus rutrum. Integer at ultricies orci. Suspendisse vitae sodales dui. Integer malesuada hendrerit dui, a ullamcorper mauris aliquam sit amet. Nulla dignissim tortor accumsan velit laoreet non eleifend massa aliquet. Quisque luctus dapibus viverra. Aliquam sed lorem diam. Phasellus condimentum lectus vitae ipsum molestie a vestibulum risus malesuada. Duis posuere urna a arcu facilisis sit amet blandit lacus tempus. Vestibulum vel arcu nunc, ut imperdiet massa. Donec congue risus nec urna laoreet et euismod magna semper. Fusce pharetra porttitor ultrices.</p>','2013-04-30 08:20:07',1);
/*!40000 ALTER TABLE `weblogs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-01 21:42:00
