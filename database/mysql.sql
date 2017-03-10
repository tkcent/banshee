-- MySQL dump 10.15  Distrib 10.0.29-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: localhost
-- ------------------------------------------------------
-- Server version	10.0.28-MariaDB-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
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
-- Dumping data for table `agenda`
--

LOCK TABLES `agenda` WRITE;
/*!40000 ALTER TABLE `agenda` DISABLE KEYS */;
INSERT INTO `agenda` VALUES (1,'2016-06-13','2016-06-13','Test','This is a test.');
/*!40000 ALTER TABLE `agenda` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Table structure for table `color_type`
--

DROP TABLE IF EXISTS `color_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `color_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color_type`
--

LOCK TABLES `color_type` WRITE;
/*!40000 ALTER TABLE `color_type` DISABLE KEYS */;
INSERT INTO `color_type` VALUES (1,'Red'),(2,'Yellow'),(3,'Orange'),(4,'Blue'),(5,'Green');
/*!40000 ALTER TABLE `color_type` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `dictionary`
--

LOCK TABLES `dictionary` WRITE;
/*!40000 ALTER TABLE `dictionary` DISABLE KEYS */;
INSERT INTO `dictionary` VALUES (1,'Hiawatha','Hiawatha webserver','The secure and advanced Hiawatha webserver. So cool!'),(3,'Banshee','Banshee PHP framework','The secure Banshee PHP framework. Nice!');
/*!40000 ALTER TABLE `dictionary` ENABLE KEYS */;
UNLOCK TABLES;

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
  `timestamp` timestamp NULL DEFAULT NULL,
  `enum` enum('value1','value2','value3') NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `color_type` mediumtext,
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
INSERT INTO `dummy` VALUES (1,72,'hello world','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus erat urna, accumsan at, mattis eu, euismod nec, justo. Integer consectetur. Aliquam erat volutpat. Sed ac ipsum. Maecenas pretium, felis non blandit pellentesque, arcu nulla adipiscing dui, ac sollicitudin ipsum nisl a dolor. Praesent in dolor consequat massa molestie mollis. In viverra eleifend purus. Nunc vel sapien. Etiam risus. Morbi auctor commodo nunc. In hac habitasse platea dictumst. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse posuere lectus non sapien. Mauris congue dolor a magna.\r\n\r\nMauris tristique justo ac sem. Vivamus pharetra quam et nunc. Proin quis erat. Proin pharetra mattis enim. Sed diam. Aliquam tempor eros sed odio aliquam fringilla. Nulla posuere. Phasellus eleifend sem a odio feugiat vehicula. Integer dignissim, est sed consectetur vestibulum, massa arcu ultrices nulla, ac consequat ligula justo at tellus. Etiam interdum est quis felis. Mauris lacinia.',0,'2009-02-18','2015-10-05 19:51:00','value2',NULL,'[\"4\",\"5\"]'),(2,23,'Lorum ipsum','ouifhilduvnxaifs driaurfc iweurnfcisaeurnbc iseruvsieurbviaceurbnfc iscdbn ilzdbv sraerf ase rgc sr cae rgv sfgb vaergcfh seirfc togvcn eufnseirgubc sertcgse riguncs eriuneizrung caieunrfgc iaeurb vsiubre viseurb viauerf ciaseur vciauwe nrisuviaeruniapwuenfc awijf wrtunh gviasuebr vciaubervn isubeviauebrf isbv iauebrf iauebnrv iaunerv iaubf visuubenrv iaeubnrfv aiebviAHWBE FIWY4BTGV9QUHB3 FIAUUBFPIUbi suuebrfiauuwbef istrbv isdbfv aidfvb',1,'2009-01-23','2015-10-01 10:00:00','value3',1,'[\"2\",\"3\"]');
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
-- Dumping data for table `faq_sections`
--

LOCK TABLES `faq_sections` WRITE;
/*!40000 ALTER TABLE `faq_sections` DISABLE KEYS */;
INSERT INTO `faq_sections` VALUES (1,'Location'),(2,'Person');
/*!40000 ALTER TABLE `faq_sections` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES (1,1,'Where is it?','It is here!'),(2,2,'Who are you?','I am me!'),(3,2,'Who is that?','That is him.');
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `forum_last_view`
--

LOCK TABLES `forum_last_view` WRITE;
/*!40000 ALTER TABLE `forum_last_view` DISABLE KEYS */;
INSERT INTO `forum_last_view` VALUES (1,'2017-02-02 15:55:36');
/*!40000 ALTER TABLE `forum_last_view` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'*','test','Test','Test');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_categories`
--

DROP TABLE IF EXISTS `link_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_categories`
--

LOCK TABLES `link_categories` WRITE;
/*!40000 ALTER TABLE `link_categories` DISABLE KEYS */;
INSERT INTO `link_categories` VALUES (1,'Websites');
/*!40000 ALTER TABLE `link_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `text` varchar(100) NOT NULL,
  `link` tinytext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `links_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `link_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `links`
--

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` VALUES (1,1,'Hiawatha webserver','https://www.hiawatha-webserver.org/'),(2,1,'Banshee PHP framework','https://www.banshee-php.org/');
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
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `mailbox_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `mailbox_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
INSERT INTO `news` VALUES (1,'Lorum ipsum','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ac elit quam. Nullam aliquam justo et nisi dictum pretium interdum tellus hendrerit. Aenean tristique posuere dictum. Maecenas nec sapien ut magna suscipit euismod quis ut metus. Aenean sit amet metus a turpis iaculis mollis. Nam faucibus mauris vel ligula ultricies dapibus. Nullam quis orci ac sem convallis malesuada nec id nisi. Praesent quis tellus nec sapien viverra blandit at ut erat. Curabitur bibendum malesuada erat, in suscipit leo porta et. Cras quis arcu sit amet nibh molestie mollis eu eget nulla. Vivamus sed enim fringilla elit pretium feugiat. Nullam elementum fermentum nunc in sodales.</p>\r\n\r\n<p>Mauris nec nunc quis enim porttitor consectetur at et lorem. Vivamus ac rutrum sapien. Nullam metus lectus, lobortis sit amet vulputate sit amet, fermentum sed velit. Phasellus ac libero urna. Maecenas tellus massa, ultrices sed pretium non, faucibus ut lorem. Donec aliquam vehicula ante, eu sodales felis ullamcorper at. Sed sed odio ipsum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nullam laoreet tristique est in molestie. Sed lacinia euismod porttitor. Praesent ullamcorper fringilla arcu sit amet viverra. Aliquam erat volutpat.</p>\r\n\r\n<p>Nulla vel eros quam. Nam nec turpis ac turpis pulvinar facilisis non non nunc. Nam bibendum nunc in velit cursus rutrum. Integer at ultricies orci. Suspendisse vitae sodales dui. Integer malesuada hendrerit dui, a ullamcorper mauris aliquam sit amet. Nulla dignissim tortor accumsan velit laoreet non eleifend massa aliquet. Quisque luctus dapibus viverra. Aliquam sed lorem diam. Phasellus condimentum lectus vitae ipsum molestie a vestibulum risus malesuada. Duis posuere urna a arcu facilisis sit amet blandit lacus tempus. Vestibulum vel arcu nunc, ut imperdiet massa. Donec congue risus nec urna laoreet et euismod magna semper. Fusce pharetra porttitor ultrices.</p>','2015-07-29 11:17:00');
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
  `content` text NOT NULL,
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
INSERT INTO `pages` VALUES (1,'/homepage','en',NULL,0,'img.logo {\r\n  float:right;\r\n  margin-left:20px;\r\n}\r\n\r\n@media (max-width:767px) {\r\n  img.logo {\r\n    width:70px;\r\n  }\r\n}','Welcome to Banshee, the secure PHP framework','','','<p>Banshee is a PHP website framework, which aims at to be secure, fast and easy to use. It uses the Model-View-Control architecture with XSLT for the View. Although it was designed to use MySQL as the database, other database applications can be used as well with only little effort. For more information about Banshee, visit the <a href=\"http://www.banshee-php.org/\">Banshee website</a>.</p>\r\n\r\n<img src=\"https://www.banshee-php.org/logo.php\" class=\"logo\" alt=\"Banshee logo\">\r\n\r\n<p>In this default installation, there are two users available: \'admin\' and \'user\'. Both have the password \'banshee\'.</p>\r\n\r\n<p>If security is a high priority for your website, you should take a look at the <a href=\"http://www.hiawatha-webserver.org\">Hiawatha webserver</a>.</p>',1,0),(2,'/modules','en',NULL,0,NULL,'Banshee modules','Modules in Banshee','modules','<ul>\r\n<li><a href=\"/agenda\">Agenda</a></li>\r\n<li><a href=\"/contact\">Contact form</a></li>\r\n<li><a href=\"/dictionary\">Dictionary</a></li>\r\n<li><a href=\"/faq\">F.A.Q.</a></li>\r\n<li><a href=\"/forum\">Forum</a></li>\r\n<li><a href=\"/guestbook\">Guestbook</a></li>\r\n<li><a href=\"/links\">Links</a></li>\r\n<li><a href=\"/mailbox\">Mailbox</a></li>\r\n<li><a href=\"/news\">News</a></li>\r\n<li><a href=\"/newsletter\">Newsletter</a></li>\r\n<li><a href=\"/photo\">Photo album</a></li>\r\n<li><a href=\"/collection\">Photo album collections</a></li>\r\n<li><a href=\"/poll\">Poll</a></li>\r\n<li><a href=\"/profile\">Profile manager</a></li>\r\n<li><a href=\"/search\">Search</a></li>\r\n<li><a href=\"/session\">Session manager</a></li>\r\n<li><a href=\"/weblog\">Weblog</a></li>\r\n<li><a href=\"/webshop\">Webshop</a></li>\r\n</ul>',1,0),(3,'/demos','en',NULL,0,NULL,'Banshee functionality demos','Banshee demos','banshee, demos','<ul>\r\n<li>The <a href=\"/demos/captcha\">captcha</a> library.</li>\r\n<li>This page shows <a href=\"/demos/errors\">errors and messages</a> generated by the framework.</li>\r\n<li>An <a href=\"/demos/invisible\">invisible</a> page, a <a href=\"/demos/private\">private</a> page and a <a href=\"/demos/void\">non-existing</a> page.</li>\r\n<li>The WYSIWYG <a href=\"/demos/ckeditor\">CKEditor</a>.</li>\r\n<li><a href=\"/demos/googlemaps\">GoogleMaps static map</a> demo.</a></li>\r\n<li>A <a href=\"/demos/pagination\">pagination</a> library.</li>\r\n<li>An <a href=\"/demos/alphabetize\">alphabetize</a> library.</li>\r\n<li>A <a href=\"/demos/pdf\">PDF</a> library.</li>\r\n<li>A <a href=\"/demos/graph\">graph</a> library.</li>\r\n<li>A <a href=\"/demos/poll\">poll</a> module.</li>\r\n<li>The <a href=\"/demos/posting\">posting</a> library.</li>\r\n<li>The <a href=\"/demos/tablemanager\">tablemanager</a> library.</li>\r\n<li>The <a href=\"/demos/splitform\">splitform</a> library.</li>\r\n<li><a href=\"/demos/utf8\">UTF-8</a> character encoding.</li>\r\n<li>A library for <a href=\"/demos/validation\">input validation</a>.</li>\r\n<li>Page with a <a href=\"/demos/help\">help</a> pop-up.</li>\r\n</ul>\r\n',1,0),(4,'/demos/private','en',NULL,1,NULL,'Private page','','','<p>This is a private page.</p>',1,1),(5,'/demos/invisible','en',NULL,0,NULL,'Invisible page','','','<p>This page is invisible to normal users and visitors. Only users with access to the page administration page can view this page.</p>\r\n<p>Page administrators can use this feature to verify a page before making it available to visitors.</p>',0,1),(6,'/demos/utf8','en',NULL,0,NULL,'UTF-8 demo','','','<p>這是一個測試頁，以顯示漢字。</p>',1,1);
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
  `timestamp` date NOT NULL,
  `listed` tinyint(1) NOT NULL,
  `private` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'Star Wars wallpapers','Collection of wallpapers from the Star Wars movies.','2010-08-21',1,0);
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
  `thumbnail_mode` tinyint(3) unsigned NOT NULL,
  `order` int(11) NOT NULL,
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
INSERT INTO `photos` VALUES (1,'Snowspeeder',1,'jpg',1,0,0),(2,'Death Star',1,'jpg',0,0,1),(3,'X-Wing',1,'jpg',0,0,2);
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
INSERT INTO `poll_answers` VALUES (4,2,'Hiawatha',1),(5,2,'Apache',0),(6,2,'Cherokee',0),(7,2,'Nginx',0),(8,2,'Lighttpd',0),(13,3,'Windows',0),(14,3,'MacOS X',0),(15,3,'Linux',3),(16,3,'BSD',0);
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
INSERT INTO `polls` VALUES (2,'The best webserver','2017-01-01','2020-12-31'),(3,'Best OS','2015-05-26','2015-06-28');
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
  `non_admins` smallint(6) NOT NULL,
  `profile` tinyint(4) DEFAULT '0',
  `mailbox` tinyint(4) DEFAULT '0',
  `session` tinyint(4) DEFAULT '0',
  `demos/tablemanager` tinyint(4) DEFAULT '0',
  `cms` tinyint(4) DEFAULT '0',
  `cms/access` tinyint(4) DEFAULT '0',
  `cms/action` tinyint(4) DEFAULT '0',
  `cms/agenda` tinyint(4) DEFAULT '0',
  `cms/analytics` tinyint(4) DEFAULT '0',
  `cms/apitest` tinyint(4) DEFAULT '0',
  `cms/collection` tinyint(4) DEFAULT '0',
  `cms/dictionary` tinyint(4) DEFAULT '0',
  `cms/faq` tinyint(4) DEFAULT '0',
  `cms/file` tinyint(4) DEFAULT '0',
  `cms/flag` tinyint(4) DEFAULT '0',
  `cms/forum` tinyint(4) DEFAULT '0',
  `cms/forum/section` tinyint(4) DEFAULT '0',
  `cms/guestbook` tinyint(4) DEFAULT '0',
  `cms/menu` tinyint(4) DEFAULT '0',
  `cms/news` tinyint(4) DEFAULT '0',
  `cms/newsletter` tinyint(4) DEFAULT '0',
  `cms/organisation` tinyint(4) DEFAULT '0',
  `cms/page` tinyint(4) DEFAULT '0',
  `cms/poll` tinyint(4) DEFAULT '0',
  `cms/role` tinyint(4) DEFAULT '0',
  `cms/settings` tinyint(4) DEFAULT '0',
  `cms/subscriptions` tinyint(4) DEFAULT '0',
  `cms/switch` tinyint(4) DEFAULT '0',
  `cms/user` tinyint(4) DEFAULT '0',
  `cms/weblog` tinyint(4) DEFAULT '0',
  `cms/album` tinyint(4) DEFAULT '0',
  `cms/language` tinyint(4) DEFAULT '0',
  `cms/photo` tinyint(4) DEFAULT '0',
  `cms/weblog/comment` tinyint(4) DEFAULT '0',
  `cms/webshop/article` tinyint(4) DEFAULT '0',
  `webshop/checkout` tinyint(4) DEFAULT '0',
  `webshop/orders` tinyint(4) DEFAULT '0',
  `cms/webshop/order` tinyint(4) DEFAULT '0',
  `cms/webshop/category` tinyint(4) DEFAULT '0',
  `cms/link` tinyint(4) DEFAULT '0',
  `cms/link/category` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrator',0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),(2,'User',1,1,1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,1,0,0,0,0);
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
  `session_id` varchar(128) NOT NULL,
  `login_id` varchar(128) DEFAULT NULL,
  `content` text,
  `expire` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(50) NOT NULL,
  `bind_to_ip` tinyint(1) NOT NULL,
  `name` tinytext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`),
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
INSERT INTO `settings` VALUES (1,'admin_page_size','integer','25'),(2,'photo_page_size','integer','10'),(3,'default_language','string','en'),(4,'photo_thumbnail_height','integer','100'),(5,'start_page','string','homepage'),(6,'webmaster_email','string','void@banshee-php.org'),(7,'forum_page_size','string','25'),(8,'forum_maintainers','string','Moderator'),(9,'guestbook_page_size','integer','10'),(10,'guestbook_maintainers','string','Publisher'),(11,'news_page_size','integer','5'),(12,'news_rss_page_size','string','30'),(13,'newsletter_bcc_size','integer','100'),(14,'newsletter_code_timeout','string','15 minutes'),(15,'newsletter_email','string','void@banshee-php.org'),(16,'newsletter_name','string','Hugo Leisink'),(17,'contact_email','string','void@banshee-php.org'),(18,'poll_max_answers','integer','10'),(19,'poll_bans','string\n',''),(20,'weblog_page_size','string','5'),(21,'weblog_rss_page_size','integer','30'),(22,'head_title','string','Banshee'),(23,'head_description','string','Secure PHP framework'),(24,'head_keywords','string','banshee, secure, php, framework'),(25,'photo_image_height','integer','450'),(26,'secret_website_code','string',''),(27,'photo_thumbnail_width','integer','100'),(28,'photo_image_width','integer','700'),(29,'hiawatha_cache_default_time','integer','3600'),(30,'photo_album_size','integer','18'),(31,'hiawatha_cache_enabled','boolean','false'),(32,'session_timeout','integer','1000'),(33,'session_persistent','boolean','false'),(34,'database_version','integer','1'),(35,'webshop_page_size','integer','15'),(36,'webshop_order_page_size','integer','5');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_articles`
--

DROP TABLE IF EXISTS `shop_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_articles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shop_category_id` int(10) unsigned NOT NULL,
  `article_nr` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `short_description` tinytext NOT NULL,
  `long_description` text NOT NULL,
  `image` tinytext NOT NULL,
  `price` decimal(7,2) unsigned NOT NULL,
  `visible` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `shop_category_id` (`shop_category_id`),
  CONSTRAINT `shop_articles_ibfk_1` FOREIGN KEY (`shop_category_id`) REFERENCES `shop_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_articles`
--

LOCK TABLES `shop_articles` WRITE;
/*!40000 ALTER TABLE `shop_articles` DISABLE KEYS */;
INSERT INTO `shop_articles` VALUES (1,1,'00000001','Smart TV','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. ','http://www.mundodigital.net/wp-content/uploads/SmartTV1.jpg',239.50,1),(2,2,'00000003','Game Computer','Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem.','Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc, quis gravida magna mi a libero. Fusce vulputate eleifend sapien. Vestibulum purus quam, scelerisque ut, mollis sed, nonummy id, metus. Nullam accumsan lorem in dui. Cras ultricies mi eu turpis hendrerit fringilla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In ac dui quis mi consectetuer lacinia. ','https://www.computer-bestel.nl/images/game-pc-epic-preview.png',799.95,1),(8,1,'00000002','Crappy item','Nam pretium turpis et arcu. Duis arcu tortor, suscipit eget, imperdiet nec, imperdiet iaculis, ipsum. Sed aliquam ultrices mauris. Integer ante arcu, accumsan a, consectetuer eget, posuere ut, mauris.','Nam pretium turpis et arcu. Duis arcu tortor, suscipit eget, imperdiet nec, imperdiet iaculis, ipsum. Sed aliquam ultrices mauris. Integer ante arcu, accumsan a, consectetuer eget, posuere ut, mauris. Praesent adipiscing. Phasellus ullamcorper ipsum rutrum nunc. Nunc nonummy metus. Vestibulum volutpat pretium libero. Cras id dui. Aenean ut eros et nisl sagittis vestibulum. Nullam nulla eros, ultricies sit amet, nonummy id, imperdiet feugiat, pede. Sed lectus. Donec mollis hendrerit risus. Phasellus nec sem in justo pellentesque facilisis. Etiam imperdiet imperdiet orci. Nunc nec neque. Phasellus leo dolor, tempus non, auctor et, hendrerit quis, nisi. ','http://us.123rf.com/450wm/rjfiskness/rjfiskness1501/rjfiskness150100010/35070423-remains-of-old-tractor-in-a-junk-and-salvage-yard.jpg',128.50,0);
/*!40000 ALTER TABLE `shop_articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_categories`
--

DROP TABLE IF EXISTS `shop_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_categories`
--

LOCK TABLES `shop_categories` WRITE;
/*!40000 ALTER TABLE `shop_categories` DISABLE KEYS */;
INSERT INTO `shop_categories` VALUES (1,'Electronics'),(2,'Computers');
/*!40000 ALTER TABLE `shop_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_order_article`
--

DROP TABLE IF EXISTS `shop_order_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_order_article` (
  `shop_article_id` int(10) unsigned NOT NULL,
  `shop_order_id` int(10) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  `article_price` decimal(7,2) NOT NULL,
  KEY `shop_article_id` (`shop_article_id`),
  KEY `shop_order_id` (`shop_order_id`),
  CONSTRAINT `shop_order_article_ibfk_1` FOREIGN KEY (`shop_article_id`) REFERENCES `shop_articles` (`id`),
  CONSTRAINT `shop_order_article_ibfk_2` FOREIGN KEY (`shop_order_id`) REFERENCES `shop_orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shop_orders`
--

DROP TABLE IF EXISTS `shop_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `zipcode` varchar(7) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `closed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `shop_orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
INSERT INTO `user_role` VALUES (1,1);
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
  `authenticator_secret` varchar(16) DEFAULT NULL,
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
INSERT INTO `users` VALUES (1,1,'admin','none',NULL,NULL,2,NULL,'Administrator','root@localhost');
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
-- Dumping data for table `weblog_comments`
--

LOCK TABLES `weblog_comments` WRITE;
/*!40000 ALTER TABLE `weblog_comments` DISABLE KEYS */;
INSERT INTO `weblog_comments` VALUES (1,1,'Hugo','Test comment','2015-06-02 17:20:36','84.106.86.135'),(2,1,'Hugo','Another test comment.','2015-06-02 17:21:07','84.106.86.135');
/*!40000 ALTER TABLE `weblog_comments` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `weblog_tagged` VALUES (1,1),(1,4);
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
INSERT INTO `weblog_tags` VALUES (4,'Dolor sit'),(1,'lorum ipsum');
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

-- Dump completed on 2017-02-02 20:12:57
