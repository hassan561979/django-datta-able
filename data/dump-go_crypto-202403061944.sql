-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: go_crypto
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add buy order',7,'add_buyorder'),(26,'Can change buy order',7,'change_buyorder'),(27,'Can delete buy order',7,'delete_buyorder'),(28,'Can view buy order',7,'view_buyorder'),(29,'Can add coin',8,'add_coin'),(30,'Can change coin',8,'change_coin'),(31,'Can delete coin',8,'delete_coin'),(32,'Can view coin',8,'view_coin'),(33,'Can add product',9,'add_product'),(34,'Can change product',9,'change_product'),(35,'Can delete product',9,'delete_product'),(36,'Can view product',9,'view_product'),(37,'Can add strategy',10,'add_strategy'),(38,'Can change strategy',10,'change_strategy'),(39,'Can delete strategy',10,'delete_strategy'),(40,'Can view strategy',10,'view_strategy'),(41,'Can add strategy time',11,'add_strategytime'),(42,'Can change strategy time',11,'change_strategytime'),(43,'Can delete strategy time',11,'delete_strategytime'),(44,'Can view strategy time',11,'view_strategytime'),(45,'Can add sell order',12,'add_sellorder'),(46,'Can change sell order',12,'change_sellorder'),(47,'Can delete sell order',12,'delete_sellorder'),(48,'Can view sell order',12,'view_sellorder'),(49,'Can add Token',13,'add_token'),(50,'Can change Token',13,'change_token'),(51,'Can delete Token',13,'delete_token'),(52,'Can view Token',13,'view_token'),(53,'Can add token',14,'add_tokenproxy'),(54,'Can change token',14,'change_tokenproxy'),(55,'Can delete token',14,'delete_tokenproxy'),(56,'Can view token',14,'view_tokenproxy'),(57,'Can add log',15,'add_log'),(58,'Can change log',15,'change_log'),(59,'Can delete log',15,'delete_log'),(60,'Can view log',15,'view_log'),(61,'Can add Scheduled task',16,'add_schedule'),(62,'Can change Scheduled task',16,'change_schedule'),(63,'Can delete Scheduled task',16,'delete_schedule'),(64,'Can view Scheduled task',16,'view_schedule'),(65,'Can add task',17,'add_task'),(66,'Can change task',17,'change_task'),(67,'Can delete task',17,'delete_task'),(68,'Can view task',17,'view_task'),(69,'Can add Failed task',18,'add_failure'),(70,'Can change Failed task',18,'change_failure'),(71,'Can delete Failed task',18,'delete_failure'),(72,'Can view Failed task',18,'view_failure'),(73,'Can add Successful task',19,'add_success'),(74,'Can change Successful task',19,'change_success'),(75,'Can delete Successful task',19,'delete_success'),(76,'Can view Successful task',19,'view_success'),(77,'Can add Queued task',20,'add_ormq'),(78,'Can change Queued task',20,'change_ormq'),(79,'Can delete Queued task',20,'delete_ormq'),(80,'Can view Queued task',20,'view_ormq');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$zWfHNp7PJvHMT9voqsyZS2$WS7FaI4MzAHeddqAj8ekhY0PK4C4eUS3ZVRIr7NjuWE=','2024-01-28 23:44:29.030940',1,'root','','','hassan.youssef.dev@gmail.com',1,1,'2024-01-28 23:44:20.000451');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buy_orders`
--

DROP TABLE IF EXISTS `buy_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buy_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `buy_price` double NOT NULL,
  `buy_amount` double NOT NULL,
  `buy_total` double NOT NULL,
  `indicators` varchar(1000) DEFAULT NULL,
  `buy_created_at` datetime(6) NOT NULL,
  `buy_updated_at` datetime(6) NOT NULL,
  `coin_id` int NOT NULL,
  `strategy_id` int NOT NULL,
  `time_frame_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `buy_orders_coin_id_749d43cc_fk_Coin_id` (`coin_id`),
  KEY `buy_orders_strategy_id_724e7921_fk_strategy_id` (`strategy_id`),
  KEY `buy_orders_time_frame_id_077b27a3_fk_strategy_times_id` (`time_frame_id`),
  CONSTRAINT `buy_orders_coin_id_749d43cc_fk_Coin_id` FOREIGN KEY (`coin_id`) REFERENCES `coin` (`id`),
  CONSTRAINT `buy_orders_strategy_id_724e7921_fk_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `strategy` (`id`),
  CONSTRAINT `buy_orders_time_frame_id_077b27a3_fk_strategy_times_id` FOREIGN KEY (`time_frame_id`) REFERENCES `strategy_times` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buy_orders`
--

LOCK TABLES `buy_orders` WRITE;
/*!40000 ALTER TABLE `buy_orders` DISABLE KEYS */;
INSERT INTO `buy_orders` VALUES (35118,6.077,16.439032417311175,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 6.078, \'current_price\': 6.077, \'prev_closed_price\': 6.04, \'bb_upper\': 6.577966343052002, \'bb_lower\': 6.031733656947998, \'signal\': 1}, stoch: {\'close\': 6.077, \'stock_k\': 8.047914818101189, \'stock_d\': 7.051474456581434, \'signal\': 1}\"}','2024-03-05 00:16:36.207522','2024-03-05 00:16:36.207522',3156,5,27),(35119,0.11375,878.2417582417581,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.11386, \'current_price\': 0.11375, \'prev_closed_price\': 0.11363, \'bb_upper\': 0.11809079072373174, \'bb_lower\': 0.11344220927626825, \'signal\': 1}, stoch: {\'close\': 0.11375, \'stock_k\': 4.087216668263675, \'stock_d\': 3.3898587790961137, \'signal\': 1}\"}','2024-03-05 02:46:56.356086','2024-03-05 02:46:56.356086',3136,5,27),(35120,0.023388,4271.421241662391,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.023539, \'current_price\': 0.023388, \'prev_closed_price\': 0.023366, \'bb_upper\': 0.024557076799661896, \'bb_lower\': 0.023379423200338104, \'signal\': 1}, stoch: {\'close\': 0.023388, \'stock_k\': 26.52265483948085, \'stock_d\': 23.744357786806713, \'signal\': 1}\"}','2024-03-05 02:47:31.067112','2024-03-05 02:47:31.067112',3236,5,27),(35121,6.91,14.457308248914616,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 6.91, \'current_price\': 6.91, \'prev_closed_price\': 6.901, \'bb_upper\': 7.189755082503709, \'bb_lower\': 6.910644917496294, \'signal\': 1}, stoch: {\'close\': 6.91, \'stock_k\': 14.071211218098767, \'stock_d\': 13.270027402470866, \'signal\': 1}\"}','2024-03-05 03:40:14.230861','2024-03-05 03:40:14.230861',3242,5,27),(35122,2.7997,35.682394542272384,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 2.8001, \'current_price\': 2.7997, \'prev_closed_price\': 2.7802, \'bb_upper\': 2.8719830483476487, \'bb_lower\': 2.7781569516523508, \'signal\': 1}, stoch: {\'close\': 2.7997, \'stock_k\': 24.798711755233327, \'stock_d\': 23.88849892875638, \'signal\': 1}\"}','2024-03-05 03:40:49.563496','2024-03-05 03:40:49.563496',3343,5,27),(35123,2.046,48.82697947214077,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 2.049, \'current_price\': 2.046, \'prev_closed_price\': 2.045, \'bb_upper\': 2.1774819873118636, \'bb_lower\': 2.039118012688137, \'signal\': 1}, stoch: {\'close\': 2.046, \'stock_k\': 7.779590737115494, \'stock_d\': 7.559089749867668, \'signal\': 1}\"}','2024-03-05 03:43:51.778098','2024-03-05 03:43:51.778098',3028,5,27),(35124,0.4112,242.94747081712063,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.4112, \'current_price\': 0.4112, \'prev_closed_price\': 0.4105, \'bb_upper\': 0.4296722055871388, \'bb_lower\': 0.4105677944128612, \'signal\': 1}, stoch: {\'close\': 0.4112, \'stock_k\': 16.091954022988613, \'stock_d\': 13.869524793445104, \'signal\': 1}\"}','2024-03-05 04:01:04.434818','2024-03-05 04:01:04.434818',3065,5,27),(35125,22.1,4.520361990950226,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 22.12, \'current_price\': 22.1, \'prev_closed_price\': 22.06, \'bb_upper\': 22.851550883066995, \'bb_lower\': 22.097449116933003, \'signal\': 1}, stoch: {\'close\': 22.1, \'stock_k\': 6.07985480943761, \'stock_d\': 5.066209585265944, \'signal\': 1}\"}','2024-03-05 04:05:11.414369','2024-03-05 04:05:11.414369',3188,5,27),(35126,1.014,98.5207100591716,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 1.0146, \'current_price\': 1.014, \'prev_closed_price\': 1.0078, \'bb_upper\': 1.0544525329472034, \'bb_lower\': 1.0074374670527966, \'signal\': 1}, stoch: {\'close\': 1.014, \'stock_k\': 10.225141192078823, \'stock_d\': 8.087973302222819, \'signal\': 1}\"}','2024-03-05 04:08:15.098628','2024-03-05 04:08:15.098628',3329,5,27),(35127,0.06868,1454.5719277810133,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.06868, \'current_price\': 0.06868, \'prev_closed_price\': 0.06832, \'bb_upper\': 0.07080828295760812, \'bb_lower\': 0.06841871704239187, \'signal\': 1}, stoch: {\'close\': 0.06868, \'stock_k\': 16.990476190476393, \'stock_d\': 16.318404950924933, \'signal\': 1}\"}','2024-03-05 04:09:09.150788','2024-03-05 04:09:09.150788',3061,5,27),(35128,0.7983,127.74741029690563,102.08284048050027,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.7984, \'current_price\': 0.7983, \'prev_closed_price\': 0.7955, \'bb_upper\': 0.8201615506366778, \'bb_lower\': 0.7952084493633221, \'signal\': 1}, stoch: {\'close\': 0.7983, \'stock_k\': 15.242165242165276, \'stock_d\': 15.132631057800028, \'signal\': 1}\"}','2024-03-05 04:19:46.595774','2024-03-05 04:19:46.595774',3071,5,27),(35129,0.6172,161.8600129617628,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.6189, \'current_price\': 0.6175, \'prev_closed_price\': 0.6138, \'bb_upper\': 0.681420029784243, \'bb_lower\': 0.612679970215757, \'signal\': 1}, stoch: {\'close\': 0.6175, \'stock_k\': 10.220125786163573, \'stock_d\': 10.16187091496237, \'signal\': 1}\"}','2024-03-05 05:16:19.030289','2024-03-05 05:16:19.030289',3303,5,25),(35130,0.1435,696.1672473867596,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.1437, \'current_price\': 0.1435, \'prev_closed_price\': 0.1434, \'bb_upper\': 0.15177231455013726, \'bb_lower\': 0.1440476854498627, \'signal\': 1}, stoch: {\'close\': 0.1435, \'stock_k\': 31.32433783108442, \'stock_d\': 19.14912913913412, \'signal\': 1}\"}','2024-03-05 05:32:27.616221','2024-03-05 05:32:27.616221',3114,5,25),(35131,2.294,46.43522768423044,106.62904134897362,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 2.295, \'current_price\': 2.294, \'prev_closed_price\': 2.278, \'bb_upper\': 2.4153773380323575, \'bb_lower\': 2.273822661967643, \'signal\': 1}, stoch: {\'close\': 2.294, \'stock_k\': 8.253968253968187, \'stock_d\': 7.973828420256953, \'signal\': 1}\"}','2024-03-05 05:46:21.090927','2024-03-05 05:46:21.090927',3268,5,27),(35132,13.0444,7.658458802244641,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 13.0623, \'current_price\': 13.0444, \'prev_closed_price\': 13.0148, \'bb_upper\': 13.863999234140145, \'bb_lower\': 12.965800765859854, \'signal\': 1}, stoch: {\'close\': 13.0444, \'stock_k\': 2.891964360033416, \'stock_d\': 2.2071571026090324, \'signal\': 1}\"}','2024-03-05 06:07:12.397495','2024-03-05 06:07:12.397495',3346,5,25),(35133,0.02481,4026.602176541717,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.02485, \'current_price\': 0.02481, \'prev_closed_price\': 0.02468, \'bb_upper\': 0.02508395523206319, \'bb_lower\': 0.024681044767936807, \'signal\': 1}, stoch: {\'close\': 0.02481, \'stock_k\': 23.906626699300556, \'stock_d\': 20.425829674241598, \'signal\': 1}\"}','2024-03-05 06:13:00.280975','2024-03-05 06:13:00.280975',3159,5,25),(35134,0.2377,420.27766091712243,100,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.2377, \'current_price\': 0.2377, \'prev_closed_price\': 0.237, \'bb_upper\': 0.24295638564491293, \'bb_lower\': 0.23695361435508708, \'signal\': 1}, stoch: {\'close\': 0.2377, \'stock_k\': 6.832254820869616, \'stock_d\': 6.202052262046684, \'signal\': 1}\"}','2024-03-05 06:25:10.893784','2024-03-05 06:25:10.893784',3224,5,25),(35135,0.04131,2422.6831149020136,100.18122069729948,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.04135, \'current_price\': 0.04135, \'prev_closed_price\': 0.04106, \'bb_upper\': 0.043351551303626557, \'bb_lower\': 0.04097144869637344, \'signal\': 1}, stoch: {\'close\': 0.04135, \'stock_k\': 17.348203221809154, \'stock_d\': 14.726434987332967, \'signal\': 1}\"}','2024-03-05 07:02:38.585602','2024-03-05 07:02:38.585602',3209,5,25),(35136,0.010146,9864.088259077682,100.18122069729948,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.010146, \'current_price\': 0.010146, \'prev_closed_price\': 0.010133, \'bb_upper\': 0.010875714687336984, \'bb_lower\': 0.010099485312663019, \'signal\': 1}, stoch: {\'close\': 0.010146, \'stock_k\': 14.233189478506246, \'stock_d\': 14.104609050718322, \'signal\': 1}\"}','2024-03-05 07:30:21.953718','2024-03-05 07:30:21.953718',3070,5,25),(35137,0.019335,5305.795107519596,102.69023864253393,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.019655, \'current_price\': 0.019335, \'prev_closed_price\': 0.01956, \'bb_upper\': 0.02172737268491706, \'bb_lower\': 0.019609527315082944, \'signal\': 1}, stoch: {\'close\': 0.019337, \'stock_k\': 8.53337366943502, \'stock_d\': 7.882936057124952, \'signal\': 1}\"}','2024-03-05 07:44:02.947916','2024-03-05 07:44:02.947916',3148,5,27),(35138,5.721,17.49362689680164,100.18122069729948,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 5.797, \'current_price\': 5.721, \'prev_closed_price\': 5.787, \'bb_upper\': 6.486512699221709, \'bb_lower\': 5.735687300778292, \'signal\': 1}, stoch: {\'close\': 5.714, \'stock_k\': 10.03380039412986, \'stock_d\': 9.798750230944778, \'signal\': 1}\"}','2024-03-05 08:08:06.087625','2024-03-05 08:08:06.087625',3156,5,25),(35139,3.219,31.09072366467915,100.18122069729948,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 3.22, \'current_price\': 3.219, \'prev_closed_price\': 3.185, \'bb_upper\': 3.3879072142117264, \'bb_lower\': 3.182092785788274, \'signal\': 1}, stoch: {\'close\': 3.219, \'stock_k\': 27.613045881702586, \'stock_d\': 26.000265587024515, \'signal\': 1}\"}','2024-03-05 08:17:56.279610','2024-03-05 08:17:56.279610',3002,5,25),(35140,0.3,333.60346492200733,100.1812206972995,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.3004, \'current_price\': 0.3, \'prev_closed_price\': 0.2964, \'bb_upper\': 0.31635288553658486, \'bb_lower\': 0.29813711446341523, \'signal\': 1}, stoch: {\'close\': 0.2999, \'stock_k\': 21.14098269426577, \'stock_d\': 19.710178297980175, \'signal\': 1}\"}','2024-03-05 08:19:29.334093','2024-03-05 08:19:29.334093',3165,5,25),(35141,111.12,0.9006573027052034,100.1812206972995,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 111.24, \'current_price\': 111.12, \'prev_closed_price\': 109.95, \'bb_upper\': 119.6411941234024, \'bb_lower\': 109.83280587659759, \'signal\': 1}, stoch: {\'close\': 111.19, \'stock_k\': 14.236601924621867, \'stock_d\': 13.804599014475807, \'signal\': 1}\"}','2024-03-05 08:24:56.331454','2024-03-05 08:24:56.331454',3367,5,25),(35142,66882.85,0.0014990576962240528,100.36161265054945,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 66961.5, \'current_price\': 66882.85, \'prev_closed_price\': 66557.89, \'bb_upper\': 68921.64416840578, \'bb_lower\': 66569.6098315942, \'signal\': 1}, stoch: {\'close\': 66882.85, \'stock_k\': 49.362376254624984, \'stock_d\': 44.57476615683794, \'signal\': 1}\"}','2024-03-05 08:56:45.655980','2024-03-05 08:56:45.655980',3312,5,27),(35143,0.3274,315.6165986754726,103.43631071706679,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.3287, \'current_price\': 0.3274, \'prev_closed_price\': 0.3266, \'bb_upper\': 0.34810553705012426, \'bb_lower\': 0.3254544629498757, \'signal\': 1}, stoch: {\'close\': 0.3271, \'stock_k\': 20.734821519773107, \'stock_d\': 18.31121948170085, \'signal\': 1}\"}','2024-03-05 15:00:29.706854','2024-03-05 15:00:29.706854',3055,5,25),(35144,10.406,9.782840562962633,101.9021410392284,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 10.42, \'current_price\': 10.406, \'prev_closed_price\': 10.384, \'bb_upper\': 10.747904275539296, \'bb_lower\': 10.385495724460705, \'signal\': 1}, stoch: {\'close\': 10.406, \'stock_k\': 6.785674304855985, \'stock_d\': 5.474561854215264, \'signal\': 1}\"}','2024-03-05 15:32:22.432212','2024-03-05 15:32:22.432212',3098,5,27),(35145,16.56,6.147357421388236,101.90214103922841,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 16.63, \'current_price\': 16.57, \'prev_closed_price\': 16.42, \'bb_upper\': 17.23087510988443, \'bb_lower\': 16.41512489011557, \'signal\': 1}, stoch: {\'close\': 16.57, \'stock_k\': 21.67277167277176, \'stock_d\': 19.77076132005708, \'signal\': 1}\"}','2024-03-05 15:56:48.430865','2024-03-05 15:56:48.430865',3334,5,27),(35146,0.5488,183.62959432533648,100.87679816390857,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.5502, \'current_price\': 0.5488, \'prev_closed_price\': 0.548, \'bb_upper\': 0.5815810787228636, \'bb_lower\': 0.5459189212771364, \'signal\': 1}, stoch: {\'close\': 0.5488, \'stock_k\': 10.715249662618097, \'stock_d\': 10.329657729038546, \'signal\': 1}\"}','2024-03-05 17:04:59.628641','2024-03-05 17:04:59.628641',3376,5,27),(35147,0.505,199.55627993216766,100.87679816390857,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.5052, \'current_price\': 0.505, \'prev_closed_price\': 0.5035, \'bb_upper\': 0.5190509466641234, \'bb_lower\': 0.5046990533358767, \'signal\': 1}, stoch: {\'close\': 0.505, \'stock_k\': 19.744204636291, \'stock_d\': 19.048917381414167, \'signal\': 1}\"}','2024-03-05 17:15:31.066217','2024-03-05 17:15:31.066217',3255,5,27),(35148,3.395,29.683629268260578,100.87679816390857,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 3.396, \'current_price\': 3.395, \'prev_closed_price\': 3.387, \'bb_upper\': 3.478870877129324, \'bb_lower\': 3.3841291228706756, \'signal\': 1}, stoch: {\'close\': 3.396, \'stock_k\': 21.130441008018128, \'stock_d\': 18.102813646198385, \'signal\': 1}\"}','2024-03-05 17:15:38.498875','2024-03-05 17:15:38.498875',3277,5,27),(35149,2.969,33.9427151787621,100.87679816390857,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 2.972, \'current_price\': 2.969, \'prev_closed_price\': 2.965, \'bb_upper\': 3.1280398545765014, \'bb_lower\': 2.966660145423498, \'signal\': 1}, stoch: {\'close\': 2.969, \'stock_k\': 7.33918128654959, \'stock_d\': 6.812797339113085, \'signal\': 1}\"}','2024-03-05 17:16:08.746189','2024-03-05 17:16:08.746189',3350,5,27),(35150,2150,0.046872521565462635,100.87679816390857,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 2150.0, \'current_price\': 2150.0, \'prev_closed_price\': 2146.0, \'bb_upper\': 2193.6672626360755, \'bb_lower\': 2147.0327373639243, \'signal\': 1}, stoch: {\'close\': 2150.0, \'stock_k\': 16.222222222222225, \'stock_d\': 16.110249784668383, \'signal\': 1}\"}','2024-03-05 17:17:32.367591','2024-03-05 17:17:32.367591',3082,5,27),(35151,0.6798,148.2434853865029,100.87679816390857,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.6799, \'current_price\': 0.6798, \'prev_closed_price\': 0.6742, \'bb_upper\': 0.705771176943682, \'bb_lower\': 0.675158823056318, \'signal\': 1}, stoch: {\'close\': 0.6798, \'stock_k\': 10.363883381067774, \'stock_d\': 9.321303076827318, \'signal\': 1}\"}','2024-03-05 17:17:35.383752','2024-03-05 17:17:35.383752',3086,5,27),(35152,36.06,2.794673360114938,100.87679816390857,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 36.14, \'current_price\': 36.06, \'prev_closed_price\': 35.9, \'bb_upper\': 37.57697444927319, \'bb_lower\': 35.94402555072681, \'signal\': 1}, stoch: {\'close\': 36.06, \'stock_k\': 12.244291656056399, \'stock_d\': 11.490268363891653, \'signal\': 1}\"}','2024-03-05 17:17:42.091874','2024-03-05 17:17:42.091874',3097,5,27),(35153,85.272,1.2042162949801416,102.7887206261728,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 85.353, \'current_price\': 85.275, \'prev_closed_price\': 83.841, \'bb_upper\': 87.94860971097246, \'bb_lower\': 83.98969028902754, \'signal\': 1}, stoch: {\'close\': 85.288, \'stock_k\': 37.71737644356895, \'stock_d\': 34.63820956616374, \'signal\': 1}\"}','2024-03-05 17:47:56.276537','2024-03-05 17:47:56.276537',3336,5,25),(35154,3.597,28.547659690171432,102.78872062617282,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 3.599, \'current_price\': 3.597, \'prev_closed_price\': 3.583, \'bb_upper\': 3.747698650773438, \'bb_lower\': 3.5745013492265616, \'signal\': 1}, stoch: {\'close\': 3.597, \'stock_k\': 12.977099236641342, \'stock_d\': 11.821066189174836, \'signal\': 1}\"}','2024-03-05 18:00:48.449747','2024-03-05 18:00:48.449747',3184,5,25),(35155,1.054,97.42498283258695,102.78872062617282,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 1.0543, \'current_price\': 1.054, \'prev_closed_price\': 1.048, \'bb_upper\': 1.1029106001241544, \'bb_lower\': 1.0481493998758458, \'signal\': 1}, stoch: {\'close\': 1.054, \'stock_k\': 16.631871955463073, \'stock_d\': 16.253370211326168, \'signal\': 1}\"}','2024-03-05 18:02:19.740023','2024-03-05 18:02:19.740023',3320,5,25),(35156,10.022,10.246051876426527,102.78872062617283,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 10.049, \'current_price\': 10.022, \'prev_closed_price\': 9.942, \'bb_upper\': 10.392437144523791, \'bb_lower\': 9.993162855476209, \'signal\': 1}, stoch: {\'close\': 10.022, \'stock_k\': 32.380063292018455, \'stock_d\': 30.564974845779588, \'signal\': 1}\"}','2024-03-05 18:04:46.302063','2024-03-05 18:04:46.302063',3124,5,25),(35157,4.303,23.86380011748702,102.78872062617282,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 4.334, \'current_price\': 4.303, \'prev_closed_price\': 4.282, \'bb_upper\': 4.573013031685057, \'bb_lower\': 4.278686968314942, \'signal\': 1}, stoch: {\'close\': 4.303, \'stock_k\': 15.545579896986832, \'stock_d\': 13.846306755588506, \'signal\': 1}\"}','2024-03-05 18:10:58.103924','2024-03-05 18:10:58.103924',3279,5,25),(35158,0.3252,313.6080465341314,102.08742415705659,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.3256, \'current_price\': 0.3252, \'prev_closed_price\': 0.3251, \'bb_upper\': 0.33628378407910264, \'bb_lower\': 0.3250362159208974, \'signal\': 1}, stoch: {\'close\': 0.3252, \'stock_k\': 19.88748974767213, \'stock_d\': 17.26479640438208, \'signal\': 1}\"}','2024-03-05 18:15:48.912982','2024-03-05 18:15:48.912982',2998,5,27),(35159,1.184,86.72798302833331,102.78872062617282,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 1.185, \'current_price\': 1.184, \'prev_closed_price\': 1.17, \'bb_upper\': 1.2216073735873583, \'bb_lower\': 1.170992626412642, \'signal\': 1}, stoch: {\'close\': 1.184, \'stock_k\': 14.174154899443657, \'stock_d\': 13.711646404389716, \'signal\': 1}\"}','2024-03-05 18:17:14.773987','2024-03-05 18:17:14.773987',3014,5,25),(35160,113.74,0.9606844575019107,109.3776278240914,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 113.79, \'current_price\': 113.74, \'prev_closed_price\': 113.82, \'bb_upper\': 119.46747275334846, \'bb_lower\': 113.79852724665153, \'signal\': 1}, stoch: {\'close\': 113.74, \'stock_k\': 36.94389517033128, \'stock_d\': 33.123074610954255, \'signal\': 1}\"}','2024-03-05 19:30:16.394490','2024-03-05 19:30:16.394490',3122,5,25),(35161,0.0326,3256.001560411947,106.25190277220166,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.03272, \'current_price\': 0.0326, \'prev_closed_price\': 0.03251, \'bb_upper\': 0.03525594853419951, \'bb_lower\': 0.03241405146580048, \'signal\': 1}, stoch: {\'close\': 0.0326, \'stock_k\': 29.73222530009224, \'stock_d\': 21.169392071009398, \'signal\': 1}\"}','2024-03-05 19:43:25.880741','2024-03-05 19:43:25.880741',3020,5,27),(35162,1.0745,80.48582049401081,86.56858270351813,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 1.0833, \'current_price\': 1.0717, \'prev_closed_price\': 1.0402, \'bb_upper\': 1.4316553891343433, \'bb_lower\': 1.0582046108656564, \'signal\': 1}, stoch: {\'close\': 1.079, \'stock_k\': 31.434078750866167, \'stock_d\': 22.32067896794148, \'signal\': 1}\"}','2024-03-05 23:00:48.820730','2024-03-05 23:00:48.820730',3360,5,27),(35163,1.0755,80.41098477063191,86.56858270351813,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 1.0791, \'current_price\': 1.08, \'prev_closed_price\': 1.0395, \'bb_upper\': 1.4270441588592513, \'bb_lower\': 1.0556258411407484, \'signal\': 1}, stoch: {\'close\': 1.0745, \'stock_k\': 29.48203097851017, \'stock_d\': 21.010912080684488, \'signal\': 1}\"}','2024-03-05 23:02:07.136795','2024-03-05 23:02:07.136795',3099,5,27),(35164,0.6372,135.721930509753,86.56858270351813,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.6389, \'current_price\': 0.6386, \'prev_closed_price\': 0.6073, \'bb_upper\': 0.7178720574157441, \'bb_lower\': 0.6288179425842558, \'signal\': 1}, stoch: {\'close\': 0.6389, \'stock_k\': 22.84685845872119, \'stock_d\': 18.74703142216145, \'signal\': 1}\"}','2024-03-05 23:02:31.390744','2024-03-05 23:02:31.390744',3167,5,27),(35165,2.544,43.39663819142954,110.51155911811486,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 2.634, \'current_price\': 2.544, \'prev_closed_price\': 2.609, \'bb_upper\': 3.2126792257062204, \'bb_lower\': 2.59972077429378, \'signal\': 1}, stoch: {\'close\': 2.544, \'stock_k\': 39.13551401869157, \'stock_d\': 30.957297067925214, \'signal\': 1}\"}','2024-03-05 23:48:47.827629','2024-03-05 23:48:47.827629',3015,5,25),(35166,30.224,3.039483504672923,91.95730675198642,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 30.344, \'current_price\': 30.224, \'prev_closed_price\': 29.623, \'bb_upper\': 31.413094128620383, \'bb_lower\': 29.816505871379622, \'signal\': 1}, stoch: {\'close\': 30.256, \'stock_k\': 16.802671166617213, \'stock_d\': 16.626107465463342, \'signal\': 1}\"}','2024-03-06 06:19:36.380954','2024-03-06 06:19:36.380954',3176,5,27),(35167,1.1899,79.19356551176584,94.32675035280297,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 1.1902, \'current_price\': 1.1899, \'prev_closed_price\': 1.1809, \'bb_upper\': 1.2479415896043202, \'bb_lower\': 1.18347841039568, \'signal\': 1}, stoch: {\'close\': 1.1899, \'stock_k\': 9.982023626091388, \'stock_d\': 8.612588992635757, \'signal\': 1}\"}','2024-03-06 13:01:41.019161','2024-03-06 13:01:41.019161',3195,5,27),(35168,0.5215,180.69496376308763,94.32675035280299,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.5218, \'current_price\': 0.5215, \'prev_closed_price\': 0.5166, \'bb_upper\': 0.5479801279869577, \'bb_lower\': 0.5157398720130423, \'signal\': 1}, stoch: {\'close\': 0.5215, \'stock_k\': 7.820764247934832, \'stock_d\': 6.943700531747031, \'signal\': 1}\"}','2024-03-06 13:01:55.402415','2024-03-06 13:01:55.402415',3243,5,27),(35169,0.02732,3449.2102343502997,94.32675035280299,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.02736, \'current_price\': 0.02732, \'prev_closed_price\': 0.02724, \'bb_upper\': 0.029132379769746284, \'bb_lower\': 0.02720462023025372, \'signal\': 1}, stoch: {\'close\': 0.02732, \'stock_k\': 25.289287047405733, \'stock_d\': 25.280037187112143, \'signal\': 1}\"}','2024-03-06 14:35:35.207613','2024-03-06 14:35:35.207613',3159,5,27),(35170,13.2427,7.115801430406956,94.32675035280299,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 13.3155, \'current_price\': 13.2636, \'prev_closed_price\': 13.276, \'bb_upper\': 14.379777961357108, \'bb_lower\': 13.284162038642888, \'signal\': 1}, stoch: {\'close\': 13.2519, \'stock_k\': 8.62060937220412, \'stock_d\': 7.134776343589799, \'signal\': 1}\"}','2024-03-06 15:49:03.529358','2024-03-06 15:49:03.529358',3285,5,27),(35171,4.61,20.44087279879614,94.326750352803,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 4.611, \'current_price\': 4.61, \'prev_closed_price\': 4.564, \'bb_upper\': 4.833583879393229, \'bb_lower\': 4.564216120606771, \'signal\': 1}, stoch: {\'close\': 4.61, \'stock_k\': 19.79402529311793, \'stock_d\': 18.89760255458992, \'signal\': 1}\"}','2024-03-06 15:52:50.670511','2024-03-06 15:52:50.670511',3279,5,27),(35172,0.020313,4639.020509154247,94.326750352803,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 0.020315, \'current_price\': 0.020313, \'prev_closed_price\': 0.020032, \'bb_upper\': 0.02166815091321287, \'bb_lower\': 0.020142449086787126, \'signal\': 1}, stoch: {\'close\': 0.020313, \'stock_k\': 12.140894180096884, \'stock_d\': 11.517648421910039, \'signal\': 1}\"}','2024-03-06 15:54:12.009989','2024-03-06 15:54:12.009989',3148,5,27),(35173,1.1376,82.83440893323683,94.326750352803,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 1.1406, \'current_price\': 1.1362, \'prev_closed_price\': 1.1278, \'bb_upper\': 1.3173974668603419, \'bb_lower\': 1.131392533139658, \'signal\': 1}, stoch: {\'close\': 1.1369, \'stock_k\': 28.92277967187785, \'stock_d\': 24.019046352591733, \'signal\': 1}\"}','2024-03-06 16:01:10.608202','2024-03-06 16:01:10.608202',3360,5,27),(35174,1.143,82.44306526898531,94.326750352803,'{\'signal\': 1, \'log\': \"bb: {\'high_price\': 1.145, \'current_price\': 1.143, \'prev_closed_price\': 1.1265, \'bb_upper\': 1.3141795146646467, \'bb_lower\': 1.1313004853353537, \'signal\': 1}, stoch: {\'close\': 1.1424, \'stock_k\': 26.73578583361981, \'stock_d\': 22.419015728053633, \'signal\': 1}\"}','2024-03-06 16:01:56.300148','2024-03-06 16:01:56.300148',3099,5,27);
/*!40000 ALTER TABLE `buy_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coin`
--

DROP TABLE IF EXISTS `coin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `symbol` varchar(30) NOT NULL,
  `price` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `available` double DEFAULT NULL,
  `periority` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `strategy_profit` json DEFAULT NULL,
  `market_cap` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3383 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coin`
--

LOCK TABLES `coin` WRITE;
/*!40000 ALTER TABLE `coin` DISABLE KEYS */;
INSERT INTO `coin` VALUES (2983,'BTCUSDT','BTCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2984,'ETHUSDT','ETHUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2985,'BNBUSDT','BNBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2986,'NEOUSDT','NEOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2987,'LTCUSDT','LTCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2988,'QTUMUSDT','QTUMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2989,'ADAUSDT','ADAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2990,'XRP/USDT','XRPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2991,'EOSUSDT','EOSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2992,'TUSDUSDT','TUSDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2993,'IOTAUSDT','IOTAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2994,'XLMUSDT','XLMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2995,'ONTUSDT','ONTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2996,'TRXUSDT','TRXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2997,'ETCUSDT','ETCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2998,'ICXUSDT','ICXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(2999,'NULSUSDT','NULSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3000,'VETUSDT','VETUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3001,'LINKUSDT','LINKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3002,'WAVESUSDT','WAVESUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3003,'ONGUSDT','ONGUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3004,'HOTUSDT','HOTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3005,'ZILUSDT','ZILUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3006,'ZRXUSDT','ZRXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3007,'FETUSDT','FETUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3008,'BATUSDT','BATUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3009,'XMRUSDT','XMRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3010,'ZECUSDT','ZECUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3011,'IOSTUSDT','IOSTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3012,'CELRUSDT','CELRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3013,'DASHUSDT','DASHUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3014,'OMGUSDT','OMGUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3015,'THETAUSDT','THETAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3016,'ENJUSDT','ENJUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3017,'MATICUSDT','MATICUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3018,'ATOMUSDT','ATOMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3019,'TFUELUSDT','TFUELUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3020,'ONEUSDT','ONEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3021,'FTMUSDT','FTMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3022,'ALGOUSDT','ALGOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3023,'DOGEUSDT','DOGEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3024,'DUSKUSDT','DUSKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3025,'ANKRUSDT','ANKRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3026,'WINUSDT','WINUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3027,'COSUSDT','COSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3028,'MTLUSDT','MTLUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3029,'DENTUSDT','DENTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3030,'KEYUSDT','KEYUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3031,'DOCKUSDT','DOCKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3032,'WANUSDT','WANUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3033,'FUNUSDT','FUNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3034,'CVCUSDT','CVCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3035,'CHZUSDT','CHZUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3036,'BANDUSDT','BANDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3037,'XTZUSDT','XTZUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3038,'RENUSDT','RENUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3039,'RVNUSDT','RVNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3040,'HBARUSDT','HBARUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3041,'NKNUSDT','NKNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3042,'STXUSDT','STXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3043,'KAVAUSDT','KAVAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3044,'ARPAUSDT','ARPAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3045,'IOTXUSDT','IOTXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3046,'RLCUSDT','RLCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3047,'CTXCUSDT','CTXCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3048,'BCHUSDT','BCHUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3049,'TROYUSDT','TROYUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3050,'VITEUSDT','VITEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3051,'FTTUSDT','FTTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3052,'EURUSDT','EURUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3053,'OGNUSDT','OGNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3054,'DREPUSDT','DREPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3055,'WRXUSDT','WRXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3056,'LSKUSDT','LSKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3057,'BNTUSDT','BNTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3058,'LTOUSDT','LTOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3059,'MBLUSDT','MBLUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3060,'COTIUSDT','COTIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3061,'STPTUSDT','STPTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3062,'DATAUSDT','DATAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3063,'SOLUSDT','SOLUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3064,'CTSIUSDT','CTSIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3065,'HIVEUSDT','HIVEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3066,'CHRUSDT','CHRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3067,'BTCDOWNUSDT','BTCDOWNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3068,'ARDRUSDT','ARDRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3069,'MDTUSDT','MDTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3070,'STMXUSDT','STMXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3071,'KNCUSDT','KNCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3072,'LRCUSDT','LRCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3073,'PNTUSDT','PNTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3074,'COMPUSDT','COMPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3075,'SCUSDT','SCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3076,'ZENUSDT','ZENUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3077,'SNXUSDT','SNXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3078,'ETHDOWNUSDT','ETHDOWNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3079,'VTHOUSDT','VTHOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3080,'DGBUSDT','DGBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3081,'SXPUSDT','SXPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3082,'MKRUSDT','MKRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3083,'DCRUSDT','DCRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3084,'STORJUSDT','STORJUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3085,'BNBDOWNUSDT','BNBDOWNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3086,'MANAUSDT','MANAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3087,'YFIUSDT','YFIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3088,'BALUSDT','BALUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3089,'BLZUSDT','BLZUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3090,'IRISUSDT','IRISUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3091,'KMDUSDT','KMDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3092,'JSTUSDT','JSTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3093,'ANTUSDT','ANTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3094,'CRVUSDT','CRVUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3095,'SANDUSDT','SANDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3096,'OCEANUSDT','OCEANUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3097,'NMRUSDT','NMRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3098,'DOTUSDT','DOTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3099,'LUNAUSDT','LUNAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3100,'RSRUSDT','RSRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3101,'PAXGUSDT','PAXGUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3102,'WNXMUSDT','WNXMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3103,'TRBUSDT','TRBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3104,'SUSHIUSDT','SUSHIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3105,'KSMUSDT','KSMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3106,'EGLDUSDT','EGLDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3107,'DIAUSDT','DIAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3108,'RUNEUSDT','RUNEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3109,'FIOUSDT','FIOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3110,'UMAUSDT','UMAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3111,'BELUSDT','BELUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3112,'WINGUSDT','WINGUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3113,'UNIUSDT','UNIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3114,'OXTUSDT','OXTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3115,'SUNUSDT','SUNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3116,'AVAXUSDT','AVAXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3117,'FLMUSDT','FLMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3118,'ORNUSDT','ORNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3119,'UTKUSDT','UTKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3120,'XVSUSDT','XVSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3121,'ALPHAUSDT','ALPHAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3122,'AAVEUSDT','AAVEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3123,'NEARUSDT','NEARUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3124,'FILUSDT','FILUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3125,'INJUSDT','INJUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3126,'AUDIOUSDT','AUDIOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3127,'CTKUSDT','CTKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3128,'AKROUSDT','AKROUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3129,'AXSUSDT','AXSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3130,'HARDUSDT','HARDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3131,'STRAXUSDT','STRAXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3132,'UNFIUSDT','UNFIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3133,'ROSEUSDT','ROSEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3134,'AVAUSDT','AVAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3135,'XEMUSDT','XEMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3136,'SKLUSDT','SKLUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3137,'GRTUSDT','GRTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3138,'JUVUSDT','JUVUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3139,'PSGUSDT','PSGUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3140,'1INCHUSDT','1INCHUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3141,'REEFUSDT','REEFUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3142,'OGUSDT','OGUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3143,'ATMUSDT','ATMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3144,'ASRUSDT','ASRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3145,'CELOUSDT','CELOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3146,'RIFUSDT','RIFUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3147,'TRUUSDT','TRUUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3148,'CKBUSDT','CKBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3149,'TWTUSDT','TWTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3150,'FIROUSDT','FIROUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3151,'LITUSDT','LITUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3152,'SFPUSDT','SFPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3153,'DODOUSDT','DODOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3154,'CAKEUSDT','CAKEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3155,'ACMUSDT','ACMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3156,'BADGERUSDT','BADGERUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3157,'FISUSDT','FISUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3158,'OMUSDT','OMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3159,'PONDUSDT','PONDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3160,'DEGOUSDT','DEGOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3161,'ALICEUSDT','ALICEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3162,'LINAUSDT','LINAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3163,'PERPUSDT','PERPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3164,'SUPERUSDT','SUPERUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3165,'CFXUSDT','CFXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3166,'TKOUSDT','TKOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3167,'PUNDIXUSDT','PUNDIXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3168,'TLMUSDT','TLMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3169,'BARUSDT','BARUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3170,'FORTHUSDT','FORTHUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3171,'BAKEUSDT','BAKEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3172,'BURGERUSDT','BURGERUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3173,'SLPUSDT','SLPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3174,'SHIBUSDT','SHIBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3175,'ICPUSDT','ICPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3176,'ARUSDT','ARUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3177,'POLSUSDT','POLSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3178,'MDXUSDT','MDXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3179,'MASKUSDT','MASKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3180,'LPTUSDT','LPTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3181,'XVGUSDT','XVGUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3182,'ATAUSDT','ATAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3183,'GTCUSDT','GTCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3184,'ERNUSDT','ERNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3185,'KLAYUSDT','KLAYUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3186,'PHAUSDT','PHAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3187,'BONDUSDT','BONDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3188,'MLNUSDT','MLNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3189,'DEXEUSDT','DEXEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3190,'C98USDT','C98USDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3191,'CLVUSDT','CLVUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3192,'QNTUSDT','QNTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3193,'FLOWUSDT','FLOWUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3194,'MINAUSDT','MINAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3195,'RAYUSDT','RAYUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3196,'FARMUSDT','FARMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3197,'ALPACAUSDT','ALPACAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3198,'QUICKUSDT','QUICKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3199,'MBOXUSDT','MBOXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3200,'FORUSDT','FORUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3201,'REQUSDT','REQUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3202,'GHSTUSDT','GHSTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3203,'WAXPUSDT','WAXPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3204,'GNOUSDT','GNOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3205,'XECUSDT','XECUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3206,'ELFUSDT','ELFUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3207,'DYDXUSDT','DYDXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3208,'IDEXUSDT','IDEXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3209,'VIDTUSDT','VIDTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3210,'GALAUSDT','GALAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3211,'ILVUSDT','ILVUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3212,'YGGUSDT','YGGUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3213,'SYSUSDT','SYSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3214,'DFUSDT','DFUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3215,'FIDAUSDT','FIDAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3216,'FRONTUSDT','FRONTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3217,'CVPUSDT','CVPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3218,'AGLDUSDT','AGLDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3219,'RADUSDT','RADUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3220,'BETAUSDT','BETAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3221,'RAREUSDT','RAREUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3222,'LAZIOUSDT','LAZIOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3223,'CHESSUSDT','CHESSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3224,'ADXUSDT','ADXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3225,'AUCTIONUSDT','AUCTIONUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3226,'DARUSDT','DARUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3227,'BNXUSDT','BNXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3228,'MOVRUSDT','MOVRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3229,'CITYUSDT','CITYUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3230,'ENSUSDT','ENSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3231,'KP3RUSDT','KP3RUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3232,'QIUSDT','QIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3233,'PORTOUSDT','PORTOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3234,'POWRUSDT','POWRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3235,'VGXUSDT','VGXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3236,'JASMYUSDT','JASMYUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3237,'AMPUSDT','AMPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3238,'PLAUSDT','PLAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3239,'PYRUSDT','PYRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3240,'RNDRUSDT','RNDRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3241,'ALCXUSDT','ALCXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3242,'SANTOSUSDT','SANTOSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3243,'BICOUSDT','BICOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3244,'FLUXUSDT','FLUXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3245,'FXSUSDT','FXSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3246,'VOXELUSDT','VOXELUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3247,'HIGHUSDT','HIGHUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3248,'CVXUSDT','CVXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3249,'PEOPLEUSDT','PEOPLEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3250,'OOKIUSDT','OOKIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3251,'SPELLUSDT','SPELLUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3252,'JOEUSDT','JOEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3253,'ACHUSDT','ACHUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3254,'IMXUSDT','IMXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3255,'GLMRUSDT','GLMRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3256,'LOKAUSDT','LOKAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3257,'SCRTUSDT','SCRTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3258,'API3USDT','API3USDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3259,'BTTCUSDT','BTTCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3260,'ACAUSDT','ACAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3261,'XNOUSDT','XNOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3262,'WOOUSDT','WOOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3263,'ALPINEUSDT','ALPINEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3264,'TUSDT','TUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3265,'ASTRUSDT','ASTRUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3266,'GMTUSDT','GMTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3267,'KDAUSDT','KDAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3268,'APEUSDT','APEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3269,'BSWUSDT','BSWUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3270,'BIFIUSDT','BIFIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3271,'MULTIUSDT','MULTIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3272,'STEEMUSDT','STEEMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3273,'MOBUSDT','MOBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3274,'NEXOUSDT','NEXOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3275,'REIUSDT','REIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3276,'GALUSDT','GALUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3277,'LDOUSDT','LDOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3278,'EPXUSDT','EPXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3279,'OPUSDT','OPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3280,'LEVERUSDT','LEVERUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3281,'STGUSDT','STGUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3282,'LUNCUSDT','LUNCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3283,'GMXUSDT','GMXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3284,'POLYXUSDT','POLYXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3285,'APTUSDT','APTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3286,'OSMOUSDT','OSMOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3287,'HFTUSDT','HFTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3288,'PHBUSDT','PHBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3289,'HOOKUSDT','HOOKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3290,'MAGICUSDT','MAGICUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3291,'HIFIUSDT','HIFIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3292,'RPLUSDT','RPLUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3293,'PROSUSDT','PROSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3294,'AGIXUSDT','AGIXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3295,'GNSUSDT','GNSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3296,'SYNUSDT','SYNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3297,'VIBUSDT','VIBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3298,'SSVUSDT','SSVUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3299,'LQTYUSDT','LQTYUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3300,'AMBUSDT','AMBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3301,'USTCUSDT','USTCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3302,'GASUSDT','GASUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3303,'GLMUSDT','GLMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3304,'PROMUSDT','PROMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3305,'QKCUSDT','QKCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3306,'UFTUSDT','UFTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3307,'IDUSDT','IDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3308,'ARBUSDT','ARBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3309,'LOOMUSDT','LOOMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3310,'OAXUSDT','OAXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3311,'RDNTUSDT','RDNTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3312,'WBTCUSDT','WBTCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3313,'EDUUSDT','EDUUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3314,'SUIUSDT','SUIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3315,'AERGOUSDT','AERGOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3316,'PEPEUSDT','PEPEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3317,'FLOKIUSDT','FLOKIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3318,'ASTUSDT','ASTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3319,'SNTUSDT','SNTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3320,'COMBOUSDT','COMBOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3321,'MAVUSDT','MAVUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3322,'PENDLEUSDT','PENDLEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3323,'ARKMUSDT','ARKMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3324,'WBETHUSDT','WBETHUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3325,'WLDUSDT','WLDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3326,'FDUSDUSDT','FDUSDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3327,'SEIUSDT','SEIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3328,'CYBERUSDT','CYBERUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3329,'ARKUSDT','ARKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3330,'CREAMUSDT','CREAMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3331,'GFTUSDT','GFTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3332,'IQUSDT','IQUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3333,'NTRNUSDT','NTRNUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3334,'TIAUSDT','TIAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3335,'MEMEUSDT','MEMEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3336,'ORDIUSDT','ORDIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3337,'BEAMXUSDT','BEAMXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3338,'PIVXUSDT','PIVXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3339,'VICUSDT','VICUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3340,'BLURUSDT','BLURUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3341,'VANRYUSDT','VANRYUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3342,'AEURUSDT','AEURUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3343,'JTOUSDT','JTOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3344,'1000SATSUSDT','1000SATSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3345,'BONKUSDT','BONKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3346,'ACEUSDT','ACEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3347,'NFPUSDT','NFPUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3348,'AIUSDT','AIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3349,'XAIUSDT','XAIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3350,'MANTAUSDT','MANTAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3351,'ALTUSDT','ALTUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3352,'PYTHUSDT','PYTHUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3353,'RONINUSDT','RONINUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3354,'DYMUSDT','DYMUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3355,'DEFIUSDT','DEFIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3356,'1000SHIBUSDT','1000SHIBUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3357,'1000XECUSDT','1000XECUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3358,'FOOTBALLUSDT','FOOTBALLUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3359,'1000LUNCUSDT','1000LUNCUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3360,'LUNA2USDT','LUNA2USDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3361,'BLUEBIRDUSDT','BLUEBIRDUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3362,'1000PEPEUSDT','1000PEPEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3363,'1000FLOKIUSDT','1000FLOKIUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3364,'DODOXUSDT','DODOXUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3365,'BIGTIMEUSDT','BIGTIMEUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3366,'ORBSUSDT','ORBSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3367,'BSVUSDT','BSVUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3368,'TOKENUSDT','TOKENUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3369,'KASUSDT','KASUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3370,'1000BONKUSDT','1000BONKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3371,'ETHWUSDT','ETHWUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3372,'1000RATSUSDT','1000RATSUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3373,'WIFUSDT','WIFUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3374,'ONDOUSDT','ONDOUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3375,'ZETAUSDT','ZETAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-15 22:22:53.582483','2024-02-15 22:22:53.582483',NULL,NULL),(3376,'PIXELUSDT','PIXELUSDT',NULL,NULL,NULL,NULL,1,'2024-02-23 22:15:19.451837','2024-02-23 22:15:19.451837',NULL,NULL),(3377,'STRKUSDT','STRKUSDT',NULL,NULL,NULL,NULL,1,'2024-02-23 22:15:19.451837','2024-02-23 22:15:19.451837',NULL,NULL),(3378,'MAVIAUSDT','MAVIAUSDT',NULL,NULL,NULL,NULL,1,'2024-02-23 22:15:19.451837','2024-02-23 22:15:19.451837',NULL,NULL),(3379,'PORTALUSDT','PORTALUSDT',NULL,NULL,NULL,NULL,1,'2024-03-04 21:04:33.782046','2024-03-04 21:04:33.782046',NULL,NULL),(3380,'PDAUSDT','PDAUSDT',NULL,NULL,NULL,NULL,1,'2024-03-04 21:04:33.782046','2024-03-04 21:04:33.782046',NULL,NULL),(3381,'AXLUSDT','AXLUSDT',NULL,NULL,NULL,NULL,1,'2024-03-04 21:04:33.782046','2024-03-04 21:04:33.782046',NULL,NULL),(3382,'TONUSDT','TONUSDT',NULL,NULL,NULL,NULL,1,'2024-03-04 21:04:33.782046','2024-03-04 21:04:33.782046',NULL,NULL);
/*!40000 ALTER TABLE `coin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(13,'authtoken','token'),(14,'authtoken','tokenproxy'),(5,'contenttypes','contenttype'),(18,'django_q','failure'),(20,'django_q','ormq'),(16,'django_q','schedule'),(19,'django_q','success'),(17,'django_q','task'),(7,'home','buyorder'),(8,'home','coin'),(15,'home','log'),(9,'home','product'),(12,'home','sellorder'),(10,'home','strategy'),(11,'home','strategytime'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-01-06 13:38:02.229322'),(2,'auth','0001_initial','2024-01-06 13:38:03.107132'),(3,'admin','0001_initial','2024-01-06 13:38:03.331133'),(4,'admin','0002_logentry_remove_auto_add','2024-01-06 13:38:03.341454'),(5,'admin','0003_logentry_add_action_flag_choices','2024-01-06 13:38:03.353455'),(6,'contenttypes','0002_remove_content_type_name','2024-01-06 13:38:03.467661'),(7,'auth','0002_alter_permission_name_max_length','2024-01-06 13:38:03.599978'),(8,'auth','0003_alter_user_email_max_length','2024-01-06 13:38:03.628977'),(9,'auth','0004_alter_user_username_opts','2024-01-06 13:38:03.642977'),(10,'auth','0005_alter_user_last_login_null','2024-01-06 13:38:03.733980'),(11,'auth','0006_require_contenttypes_0002','2024-01-06 13:38:03.738978'),(12,'auth','0007_alter_validators_add_error_messages','2024-01-06 13:38:03.749979'),(13,'auth','0008_alter_user_username_max_length','2024-01-06 13:38:03.836785'),(14,'auth','0009_alter_user_last_name_max_length','2024-01-06 13:38:03.937320'),(15,'auth','0010_alter_group_name_max_length','2024-01-06 13:38:03.969668'),(16,'auth','0011_update_proxy_permissions','2024-01-06 13:38:03.984904'),(17,'auth','0012_alter_user_first_name_max_length','2024-01-06 13:38:04.079633'),(18,'authtoken','0001_initial','2024-01-06 13:38:04.204396'),(19,'authtoken','0002_auto_20160226_1747','2024-01-06 13:38:04.238396'),(20,'authtoken','0003_tokenproxy','2024-01-06 13:38:04.244683'),(21,'home','0001_initial','2024-01-06 13:38:05.112771'),(22,'sessions','0001_initial','2024-01-06 13:38:05.158090'),(23,'home','0002_strategytime_balance_alter_buyorder_buy_created_at_and_more','2024-01-06 13:40:27.188279'),(24,'home','0003_log_strategy_notes_strategytime_amount_per_order_and_more','2024-01-09 13:40:27.188279'),(25,'home','0004_strategytime_stop_loss_percent_and_more','2024-01-09 19:54:43.553095'),(26,'home','0005_alter_buyorder_buy_created_at_and_more','2024-01-13 23:46:15.600385'),(27,'django_q','0001_initial','2024-01-14 15:22:47.915372'),(28,'django_q','0002_auto_20150630_1624','2024-01-14 15:22:48.042890'),(29,'django_q','0003_auto_20150708_1326','2024-01-14 15:22:48.158889'),(30,'django_q','0004_auto_20150710_1043','2024-01-14 15:22:48.169890'),(31,'django_q','0005_auto_20150718_1506','2024-01-14 15:22:48.221356'),(32,'django_q','0006_auto_20150805_1817','2024-01-14 15:22:48.295879'),(33,'django_q','0007_ormq','2024-01-14 15:22:48.319878'),(34,'django_q','0008_auto_20160224_1026','2024-01-14 15:22:48.328877'),(35,'django_q','0009_auto_20171009_0915','2024-01-14 15:22:48.418229'),(36,'django_q','0010_auto_20200610_0856','2024-01-14 15:22:48.433230'),(37,'django_q','0011_auto_20200628_1055','2024-01-14 15:22:48.466127'),(38,'django_q','0012_auto_20200702_1608','2024-01-14 15:22:48.473115'),(39,'django_q','0013_task_attempt_count','2024-01-14 15:22:48.520113'),(40,'django_q','0014_schedule_cluster','2024-01-14 15:22:48.551114'),(41,'home','0006_strategy_is_running_alter_buyorder_buy_created_at_and_more','2024-01-29 00:42:31.808122'),(42,'home','0007_strategy_strategy_profit_and_more','2024-02-02 00:01:37.760015'),(43,'home','0008_alter_buyorder_buy_created_at_and_more','2024-02-02 00:14:01.447685'),(44,'home','0009_remove_strategy_strategy_profit_coin_strategy_profit_and_more','2024-02-02 00:14:39.378615'),(45,'home','0010_coin_market_cap_alter_buyorder_buy_created_at_and_more','2024-02-15 22:06:21.779501'),(46,'home','0011_alter_buyorder_buy_created_at_and_more','2024-02-23 22:59:16.115373');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_q_ormq`
--

DROP TABLE IF EXISTS `django_q_ormq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_q_ormq` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(100) NOT NULL,
  `payload` longtext NOT NULL,
  `lock` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_q_ormq`
--

LOCK TABLES `django_q_ormq` WRITE;
/*!40000 ALTER TABLE `django_q_ormq` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_q_ormq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_q_schedule`
--

DROP TABLE IF EXISTS `django_q_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_q_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `func` varchar(256) NOT NULL,
  `hook` varchar(256) DEFAULT NULL,
  `args` longtext,
  `kwargs` longtext,
  `schedule_type` varchar(1) NOT NULL,
  `repeats` int NOT NULL,
  `next_run` datetime(6) DEFAULT NULL,
  `task` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `minutes` smallint unsigned DEFAULT NULL,
  `cron` varchar(100) DEFAULT NULL,
  `cluster` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `django_q_schedule_chk_1` CHECK ((`minutes` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_q_schedule`
--

LOCK TABLES `django_q_schedule` WRITE;
/*!40000 ALTER TABLE `django_q_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_q_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_q_task`
--

DROP TABLE IF EXISTS `django_q_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_q_task` (
  `name` varchar(100) NOT NULL,
  `func` varchar(256) NOT NULL,
  `hook` varchar(256) DEFAULT NULL,
  `args` longtext,
  `kwargs` longtext,
  `result` longtext,
  `started` datetime(6) NOT NULL,
  `stopped` datetime(6) NOT NULL,
  `success` tinyint(1) NOT NULL,
  `id` varchar(32) NOT NULL,
  `group` varchar(100) DEFAULT NULL,
  `attempt_count` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_q_task`
--

LOCK TABLES `django_q_task` WRITE;
/*!40000 ALTER TABLE `django_q_task` DISABLE KEYS */;
INSERT INTO `django_q_task` VALUES ('blossom-lion-cat-comet','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:16:13.070424','2024-01-14 16:16:18.237750',1,'04d66da8505241399958668484c2e08d',NULL,1),('xray-mountain-fifteen-ten','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:15:53.743256','2024-01-14 16:16:58.932530',1,'06209a47d4bf41bea16df27df40a0d29',NULL,2),('comet-white-oxygen-beryllium','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 15:48:08.347870','2024-01-14 15:50:13.497137',1,'073c776741a2465182a3901b46975e9a',NULL,3),('sweet-steak-purple-india','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 15:49:05.280195','2024-01-14 15:49:10.386297',1,'28f1626c146c4de1aa71553a0ce0d758',NULL,1),('asparagus-jig-bulldog-stream','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:14:50.245304','2024-01-14 16:14:55.404136',1,'30a76ff37a6a4238acbee1e88b8f11c0',NULL,1),('march-wisconsin-white-social','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 15:44:30.872119','2024-01-14 15:44:36.048794',1,'3177884df4c24b8584bbc80361dd5424',NULL,1),('cat-beer-ten-uncle','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 15:48:08.326868','2024-01-14 15:48:13.437372',1,'3d7e50308aae4275808eb4605358c729',NULL,1),('mockingbird-west-floor-freddie','home.tasks.background_task',NULL,'gAUpLg==','gAV9lC4=',NULL,'2024-01-14 15:23:05.289847','2024-01-14 15:23:39.041792',1,'3e31dc4358f941129c2598681bf12f8a',NULL,1),('oscar-lamp-apart-four','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:17:26.209224','2024-01-14 16:17:31.438336',1,'4813b142520d476eae8638164957a4f6',NULL,1),('magazine-pip-colorado-winner','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:17:19.432963','2024-01-14 16:18:24.543352',1,'5310764a4ba74e0dadc2a5e059fca3f0',NULL,2),('pizza-zebra-fourteen-florida','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 15:45:37.861270','2024-01-14 15:45:43.016352',1,'537147d5482c4dd78cc3d6d490c5706f',NULL,1),('oxygen-table-indigo-sink','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 15:43:46.290348','2024-01-14 15:45:51.394786',1,'544352ef54a84561ac7440fcc02ea78e',NULL,3),('winner-wisconsin-arizona-timing','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 15:43:46.279311','2024-01-14 15:43:51.304030',1,'55d52751e233476e81d87322764e1ac2',NULL,1),('twelve-music-monkey-minnesota','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:15:46.156841','2024-01-14 16:18:51.532390',1,'579ab19e4b304fa29f57a9f0d2580b0a',NULL,4),('december-mexico-glucose-alanine','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 15:44:30.893116','2024-01-14 15:44:36.057753',1,'587faabd066c42a0a6562480235e99e6',NULL,1),('east-asparagus-stairway-solar','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 15:46:12.650072','2024-01-14 15:47:17.919635',1,'58f08919e6bb47119b2cc5a191dfce4e',NULL,2),('oxygen-glucose-ink-sink','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:14:50.225302','2024-01-14 16:15:55.518443',1,'5ce9fbe4fdf4421f800a40afc6af1fb1',NULL,2),('hydrogen-sierra-nitrogen-happy','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:16:05.671824','2024-01-14 16:16:10.864385',1,'60dce03ca00d4e26a5aebe281b41b0b3',NULL,1),('river-single-skylark-ohio','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:22:46.265184','2024-01-14 16:24:51.824913',1,'6407f923144743d68b1aecb7433016c7',NULL,3),('victor-monkey-oxygen-batman','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:17:26.230484','2024-01-14 16:17:31.447361',1,'68ba2619bd644008a99664f1cdc4948f',NULL,1),('oscar-thirteen-texas-comet','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:22:55.160262','2024-01-14 16:23:00.259385',1,'6ee6b09093084d08a4a308d28d458b68',NULL,1),('missouri-uncle-glucose-bravo','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 15:45:37.843198','2024-01-14 15:45:43.006352',1,'96f87e9e617e4eb4b39cb9c284a2734f',NULL,1),('eighteen-october-december-triple','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 15:49:05.260053','2024-01-14 15:49:10.377212',1,'97f1fda78348452f9f9f2d1de7e8da34',NULL,1),('burger-johnny-florida-washington','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:22:46.244153','2024-01-14 16:22:51.469353',1,'9a00810759fa448cad69c24c5899bb8b',NULL,1),('whiskey-venus-ohio-lamp','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:16:13.081425','2024-01-14 16:16:18.246711',1,'b4cd23a9dca54edcb6676417d236e072',NULL,1),('enemy-pizza-green-michigan','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:15:03.971147','2024-01-14 16:15:09.089238',1,'c3d83511e7204d3abac5fbd21bdbf8b1',NULL,1),('network-harry-california-timing','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:15:46.176920','2024-01-14 16:15:51.208635',1,'d1a0a74f989a471fbd82a3821690781e',NULL,1),('potato-black-crazy-south','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:16:05.690426','2024-01-14 16:17:10.989932',1,'e13caac50eb444e889858daca2c1af03',NULL,2),('emma-cat-montana-salami','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 15:46:12.670117','2024-01-14 15:46:17.727966',1,'e38e99ca7e6b4b7dae09d9ec5348df7b',NULL,1),('zebra-georgia-nevada-paris','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:17:19.415069','2024-01-14 16:17:24.470423',1,'e43c0d2b3a804ca5bf5ea0db2d9d564a',NULL,1),('queen-whiskey-bluebird-ceiling','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:15:03.987150','2024-01-14 16:15:09.099740',1,'e953d3df77514b9eaea94c5258ae2bf9',NULL,1),('iowa-one-eleven-five','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 16:15:53.717242','2024-01-14 16:15:58.798313',1,'ece4c2ac34064bdd9d4536d39ca4e798',NULL,1),('early-nuts-failed-seventeen','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATGUhZQu','gAV9lC4=',NULL,'2024-01-14 15:40:21.178112','2024-01-14 15:40:26.240255',1,'efe7794780884fe7b1b284c62247a701',NULL,1),('oscar-six-eight-river','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 16:22:55.178107','2024-01-14 16:23:00.268089',1,'f36c4a7d9dc941ddb450d50a25cf5201',NULL,1),('delta-alanine-alaska-crazy','home.tasks.background_task',NULL,'gAWVBwAAAAAAAACMATKUhZQu','gAV9lC4=',NULL,'2024-01-14 15:40:21.197380','2024-01-14 15:40:26.250211',1,'fe0db879ccbe4737b6e71d4fb2ce93c2',NULL,1);
/*!40000 ALTER TABLE `django_q_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('00bon9fo0htpe8ij9o5xx8wkg795bwgu','.eJxVjDsKwzAQRO-iOgjv2vqQMn3OILTadeQkSGDZlcndY4OLBKaa92Y2FeK65LA2mcPE6qpAXX47iukl5QD8jOVRdaplmSfSh6JP2vS9srxvp_t3kGPL-9qjWGOA-g4QyDEZTMkOfUI_chIWdHYkKx4w8h62TqgDj8w4MHj1-QLmQzhO:1rUC0z:GGuUR2oDPz7_TvAr187ftdQl0Ozr2MLtKidBvhO-Egc','2024-02-11 23:44:29.034189');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `home_log`
--

DROP TABLE IF EXISTS `home_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `home_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `log` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `home_log`
--

LOCK TABLES `home_log` WRITE;
/*!40000 ALTER TABLE `home_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `home_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `home_product`
--

DROP TABLE IF EXISTS `home_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `home_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `info` varchar(100) NOT NULL,
  `price` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `home_product`
--

LOCK TABLES `home_product` WRITE;
/*!40000 ALTER TABLE `home_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `home_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sell_orders`
--

DROP TABLE IF EXISTS `sell_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sell_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sell_price` double NOT NULL,
  `sell_amount` double NOT NULL,
  `sell_total` double NOT NULL,
  `profit` double NOT NULL,
  `indicators` varchar(1000) DEFAULT NULL,
  `sell_created_at` datetime(6) NOT NULL,
  `sell_updated_at` datetime(6) NOT NULL,
  `buy_order_id` int NOT NULL,
  `coin_id` int NOT NULL,
  `strategy_id` int NOT NULL,
  `time_frame_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `buy_order_id` (`buy_order_id`),
  KEY `sell_orders_coin_id_89c7bd72_fk_Coin_id` (`coin_id`),
  KEY `sell_orders_strategy_id_515f681f_fk_strategy_id` (`strategy_id`),
  KEY `sell_orders_time_frame_id_58c9dc04_fk_strategy_times_id` (`time_frame_id`),
  CONSTRAINT `sell_orders_buy_order_id_faad0886_fk_buy_orders_id` FOREIGN KEY (`buy_order_id`) REFERENCES `buy_orders` (`id`),
  CONSTRAINT `sell_orders_coin_id_89c7bd72_fk_Coin_id` FOREIGN KEY (`coin_id`) REFERENCES `coin` (`id`),
  CONSTRAINT `sell_orders_strategy_id_515f681f_fk_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `strategy` (`id`),
  CONSTRAINT `sell_orders_time_frame_id_58c9dc04_fk_strategy_times_id` FOREIGN KEY (`time_frame_id`) REFERENCES `strategy_times` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26624 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sell_orders`
--

LOCK TABLES `sell_orders` WRITE;
/*!40000 ALTER TABLE `sell_orders` DISABLE KEYS */;
INSERT INTO `sell_orders` VALUES (26575,6.216,16.439032417311175,102.08284048050027,2.0828404805002663,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 6.26, \'current_price\': 6.216, \'prev_closed_price\': 6.181, \'bb_upper\': 6.259405170051152, \'bb_lower\': 6.032994829948849, \'signal\': -1}\"}','2024-03-05 04:12:10.218471','2024-03-05 04:12:10.218471',35118,3156,5,27),(26576,2.186,48.82697947214077,106.62904134897362,6.629041348973615,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 2.186, \'current_price\': 2.186, \'prev_closed_price\': 2.17, \'bb_upper\': 2.1859262397614696, \'bb_lower\': 2.0106737602385296, \'signal\': -1}\"}','2024-03-05 05:33:46.432509','2024-03-05 05:33:46.432509',35123,3028,5,27),(26577,0.02513,4026.602176541717,101.08732418379685,1.0873241837968521,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.02519, \'current_price\': 0.02513, \'prev_closed_price\': 0.02488, \'bb_upper\': 0.025125396266033655, \'bb_lower\': 0.024676603733966344, \'signal\': -1}\"}','2024-03-05 06:41:04.018700','2024-03-05 06:41:04.018700',35133,3159,5,25),(26578,22.74,4.520361990950226,102.69023864253393,2.6902386425339273,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 22.7, \'current_price\': 22.74, \'prev_closed_price\': 22.61, \'bb_upper\': 22.707784375547803, \'bb_lower\': 21.411215624452197, \'signal\': -1}\"}','2024-03-05 07:37:27.779164','2024-03-05 07:37:27.779164',35125,3188,5,27),(26579,0.11439,878.2417582417581,100.36161265054945,0.36161265054944636,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.11439, \'current_price\': 0.11439, \'prev_closed_price\': 0.1128, \'bb_upper\': 0.11437932056509442, \'bb_lower\': 0.10766367943490557, \'signal\': -1}\"}','2024-03-05 08:56:17.286921','2024-03-05 08:56:17.286921',35119,3136,5,27),(26580,2.34,46.43522768423044,108.54977434831812,1.9207329993445086,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 2.347, \'current_price\': 2.341, \'prev_closed_price\': 2.32, \'bb_upper\': 2.3467041165903586, \'bb_lower\': 2.2705958834096416, \'signal\': -1}\"}','2024-03-05 09:25:22.481503','2024-03-05 09:25:22.481503',35131,3268,5,27),(26581,0.806,127.74741029690563,102.86144828660663,0.7786078061063648,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.8061, \'current_price\': 0.806, \'prev_closed_price\': 0.8007, \'bb_upper\': 0.8060572145406663, \'bb_lower\': 0.778102785459334, \'signal\': -1}\"}','2024-03-05 09:49:07.231100','2024-03-05 09:49:07.231100',35128,3071,5,27),(26582,3.379,31.09072366467915,104.9504997076879,4.769279010388416,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 3.39, \'current_price\': 3.378, \'prev_closed_price\': 3.314, \'bb_upper\': 3.3898058593481277, \'bb_lower\': 3.1823941406518728, \'signal\': -1}\"}','2024-03-05 10:26:12.662952','2024-03-05 10:26:12.662952',35139,3002,5,25),(26583,1.0219,98.5207100591716,100.577635295858,0.577635295858002,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 1.022, \'current_price\': 1.0219, \'prev_closed_price\': 1.0121, \'bb_upper\': 1.021933527561212, \'bb_lower\': 0.9845864724387879, \'signal\': -1}\"}','2024-03-05 11:56:05.276181','2024-03-05 11:56:05.276181',35126,3329,5,27),(26584,0.414,242.94747081712063,100.47967266536965,0.47967266536964814,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.4143, \'current_price\': 0.414, \'prev_closed_price\': 0.4119, \'bb_upper\': 0.4138257343314174, \'bb_lower\': 0.40522426566858266, \'signal\': -1}\"}','2024-03-05 12:07:30.236549','2024-03-05 12:07:30.236549',35124,3065,5,27),(26585,6.873,14.457308248914616,99.26571451519537,-0.7342854848046301,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 6.899, \'current_price\': 6.873, \'prev_closed_price\': 6.843, \'bb_upper\': 6.872560535023015, \'bb_lower\': 6.688839464976986, \'signal\': -1}\"}','2024-03-05 12:39:43.254261','2024-03-05 12:39:43.254261',35121,3242,5,27),(26586,0.6253,161.8600129617628,101.10985503888529,1.1098550388852857,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.6256, \'current_price\': 0.6253, \'prev_closed_price\': 0.6119, \'bb_upper\': 0.6255821874570979, \'bb_lower\': 0.602247812542902, \'signal\': -1}\"}','2024-03-05 13:13:31.987112','2024-03-05 13:13:31.987112',35129,3303,5,25),(26587,67100.79,0.0014990576962240528,100.48736771654174,0.12575506599229413,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 67570.1, \'current_price\': 67100.79, \'prev_closed_price\': 66930.09, \'bb_upper\': 67497.81111453324, \'bb_lower\': 66189.69588546675, \'signal\': -1}\"}','2024-03-05 13:32:12.674048','2024-03-05 13:32:12.674048',35142,3312,5,27),(26588,0.010689,9864.088259077682,105.33180216188006,5.150581464580583,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.010699, \'current_price\': 0.0107, \'prev_closed_price\': 0.01055, \'bb_upper\': 0.010683180004236497, \'bb_lower\': 0.009982419995763502, \'signal\': -1}\"}','2024-03-05 13:33:25.019749','2024-03-05 13:33:25.019749',35136,3070,5,25),(26589,13.6241,7.658458802244641,104.23526895909356,4.23526895909356,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 13.71, \'current_price\': 13.627, \'prev_closed_price\': 13.3568, \'bb_upper\': 13.69332423312136, \'bb_lower\': 12.977375766878641, \'signal\': -1}\"}','2024-03-05 13:33:49.745655','2024-03-05 13:33:49.745655',35132,3346,5,25),(26590,0.06957,1454.5719277810133,101.09337444670938,1.093374446709376,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.06965, \'current_price\': 0.06957, \'prev_closed_price\': 0.06922, \'bb_upper\': 0.06964261544561608, \'bb_lower\': 0.06654238455438392, \'signal\': -1}\"}','2024-03-05 14:20:24.039191','2024-03-05 14:20:24.039191',35127,3061,5,27),(26591,0.04196,2422.6831149020136,101.5541277177872,1.372907020487716,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.04217, \'current_price\': 0.04196, \'prev_closed_price\': 0.04184, \'bb_upper\': 0.04206497415433833, \'bb_lower\': 0.04072302584566167, \'signal\': -1}\"}','2024-03-05 14:56:53.876560','2024-03-05 14:56:53.876560',35135,3209,5,25),(26592,0.2415,420.27766091712243,101.39555805637359,1.3955580563735879,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.2414, \'current_price\': 0.2415, \'prev_closed_price\': 0.2403, \'bb_upper\': 0.2414836051618841, \'bb_lower\': 0.2378663948381159, \'signal\': -1}\"}','2024-03-05 16:15:52.162057','2024-03-05 16:15:52.162057',35134,3224,5,25),(26593,2.7364,35.682394542272384,97.54366312104868,-2.456336878951319,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 2.7378, \'current_price\': 2.7364, \'prev_closed_price\': 2.7254, \'bb_upper\': 2.735057956487322, \'bb_lower\': 2.6828820435126777, \'signal\': -1}\"}','2024-03-05 16:21:35.555799','2024-03-05 16:21:35.555799',35122,3343,5,27),(26594,112.91,0.9006573027052034,101.59152283239607,1.4103021350965719,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 113.35, \'current_price\': 112.91, \'prev_closed_price\': 111.18, \'bb_upper\': 113.33517744057261, \'bb_lower\': 108.4168225594274, \'signal\': -1}\"}','2024-03-05 16:24:56.453698','2024-03-05 16:24:56.453698',35141,3367,5,25),(26595,0.02322,4271.421241662391,99.08321883016933,-0.9167811698306707,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.023238, \'current_price\': 0.02322, \'prev_closed_price\': 0.02299, \'bb_upper\': 0.023235472459008057, \'bb_lower\': 0.02274132754099194, \'signal\': -1}\"}','2024-03-05 16:25:24.870613','2024-03-05 16:25:24.870613',35120,3236,5,27),(26596,0.01926,5305.795107519596,102.08742415705659,-0.6028144854773387,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.019259, \'current_price\': 0.01926, \'prev_closed_price\': 0.019187, \'bb_upper\': 0.019258196455406055, \'bb_lower\': 0.018572203544593945, \'signal\': -1}\"}','2024-03-05 18:15:27.604538','2024-03-05 18:15:27.604538',35137,3148,5,27),(26597,4.588,23.86380011748702,109.37762782409142,6.588907197918601,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 4.587, \'current_price\': 4.588, \'prev_closed_price\': 4.449, \'bb_upper\': 4.586497845635367, \'bb_lower\': 4.277702154364634, \'signal\': -1}\"}','2024-03-05 19:29:13.229581','2024-03-05 19:29:13.229581',35157,3279,5,25),(26598,0.5792,183.62959432533648,106.25190277220166,5.375104608293086,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.5833, \'current_price\': 0.5793, \'prev_closed_price\': 0.5442, \'bb_upper\': 0.5828408298039435, \'bb_lower\': 0.5205091701960566, \'signal\': -1}\"}','2024-03-05 19:42:41.833771','2024-03-05 19:42:41.833771',35146,3376,5,27),(26599,17.05,6.147357421388236,104.70763159063476,2.8054905514063506,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 17.06, \'current_price\': 17.05, \'prev_closed_price\': 16.92, \'bb_upper\': 17.05692140511345, \'bb_lower\': 15.768078594886553, \'signal\': -1}\"}','2024-03-05 21:17:39.481554','2024-03-05 21:17:39.481554',35145,3334,5,27),(26600,0.4033,199.55627993216766,80.40056664894658,-20.476231514961995,'Stop loss = 0.40085880903029913','2024-03-05 22:56:30.738211','2024-03-05 22:56:30.738211',35147,3255,5,27),(26601,1869,0.046872521565462635,87.51713806304382,-13.359660100864758,'Stop loss = 1865.0971975267082','2024-03-05 22:56:43.799540','2024-03-05 22:56:43.799540',35150,3082,5,27),(26602,8.262,9.782840562962633,80.74500290246608,-21.157138136762313,'Stop loss = 8.271203954111087','2024-03-05 22:57:08.495018','2024-03-05 22:57:08.495018',35144,3098,5,27),(26603,2.68,29.683629268260578,79.47257431249942,-21.404223851409157,'Stop loss = 2.668770670028941','2024-03-05 22:57:30.615215','2024-03-05 22:57:30.615215',35148,3277,5,27),(26604,3.875,28.547659690171432,110.51155911811487,7.722838491942056,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 3.875, \'current_price\': 3.875, \'prev_closed_price\': 3.596, \'bb_upper\': 3.8683511138447844, \'bb_lower\': 3.2441488861552155, \'signal\': -1}\"}','2024-03-05 23:47:52.051624','2024-03-05 23:47:52.051624',35154,3184,5,25),(26605,0.3213,313.6080465341314,100.661503086065,-1.425921070991592,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.3167, \'current_price\': 0.3167, \'prev_closed_price\': 0.2954, \'bb_upper\': 0.3099530016328102, \'bb_lower\': 0.2716269983671898, \'signal\': -1}\"}','2024-03-06 03:00:07.119307','2024-03-06 03:00:07.119307',35158,2998,5,27),(26606,2.921,33.9427151787621,99.04752436612692,-1.8292737977816529,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 2.922, \'current_price\': 2.921, \'prev_closed_price\': 2.89, \'bb_upper\': 2.921932984589916, \'bb_lower\': 2.576667015410085, \'signal\': -1}\"}','2024-03-06 03:39:09.479460','2024-03-06 03:39:09.479460',35149,3350,5,27),(26607,0.597,148.2434853865029,88.41285941496649,-12.463938748942084,'Stop loss = 0.6012457845199131','2024-03-06 04:45:01.573977','2024-03-06 04:45:01.573977',35151,3086,5,27),(26608,32.41,2.794673360114938,90.48478823772379,-10.392009926184784,'Stop loss = 32.412842051742324','2024-03-06 05:01:14.455637','2024-03-06 05:01:14.455637',35152,3097,5,27),(26609,1.2115,80.41098477063191,97.32049014157094,10.751907438052811,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 1.22, \'current_price\': 1.2118, \'prev_closed_price\': 1.157, \'bb_upper\': 1.2198850431375403, \'bb_lower\': 1.0801849568624595, \'signal\': -1}\"}','2024-03-06 07:40:15.657413','2024-03-06 07:40:15.657413',35163,3099,5,27),(26610,1.2087,80.48582049401081,97.18592801987975,10.617345316361622,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 1.22, \'current_price\': 1.2091, \'prev_closed_price\': 1.1583, \'bb_upper\': 1.2197171789895662, \'bb_lower\': 1.082712821010434, \'signal\': -1}\"}','2024-03-06 07:40:49.973125','2024-03-06 07:40:49.973125',35162,3360,5,27),(26611,108.78,0.9606844575019107,104.39875203177078,-4.978875792320622,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 108.78, \'current_price\': 108.78, \'prev_closed_price\': 108.08, \'bb_upper\': 108.77200661007177, \'bb_lower\': 99.0499933899282, \'signal\': -1}\"}','2024-03-06 08:07:36.447355','2024-03-06 08:07:36.447355',35160,3122,5,25),(26612,9.049,10.246051876426527,92.62380690635385,-10.164913719818983,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 9.058, \'current_price\': 9.049, \'prev_closed_price\': 8.943, \'bb_upper\': 9.057756039648531, \'bb_lower\': 8.377943960351473, \'signal\': -1}\"}','2024-03-06 08:09:22.211183','2024-03-06 08:09:22.211183',35156,3124,5,25),(26613,0.2825,333.60346492200733,94.14873586162659,-6.0324848356729035,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.2828, \'current_price\': 0.2825, \'prev_closed_price\': 0.2811, \'bb_upper\': 0.28277279279964335, \'bb_lower\': 0.25852720720035666, \'signal\': -1}\"}','2024-03-06 08:14:10.252659','2024-03-06 08:14:10.252659',35140,3165,5,25),(26614,1.067,86.72798302833331,92.4462191333404,-10.342501492832412,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 1.068, \'current_price\': 1.067, \'prev_closed_price\': 1.057, \'bb_upper\': 1.0679661249737151, \'bb_lower\': 0.9871338750262848, \'signal\': -1}\"}','2024-03-06 08:14:34.819685','2024-03-06 08:14:34.819685',35159,3014,5,25),(26615,0.309,315.6165986754726,97.42800346173031,-6.008307255336476,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.309, \'current_price\': 0.309, \'prev_closed_price\': 0.3078, \'bb_upper\': 0.3089586309796774, \'bb_lower\': 0.28695136902032253, \'signal\': -1}\"}','2024-03-06 08:14:49.595326','2024-03-06 08:14:49.595326',35143,3055,5,25),(26616,78,1.2042162949801416,93.8349421374426,-8.953778488730208,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 78.076, \'current_price\': 77.98, \'prev_closed_price\': 76.637, \'bb_upper\': 78.07403646379825, \'bb_lower\': 70.71946353620174, \'signal\': -1}\"}','2024-03-06 08:15:09.763035','2024-03-06 08:15:09.763035',35153,3336,5,25),(26617,0.03135,3256.001560411947,101.97357326999564,-4.27832950220602,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.03139, \'current_price\': 0.03135, \'prev_closed_price\': 0.03123, \'bb_upper\': 0.03137328488205178, \'bb_lower\': 0.029314715117948222, \'signal\': -1}\"}','2024-03-06 08:21:29.235481','2024-03-06 08:21:29.235481',35161,3020,5,27),(26618,0.1404,696.1672473867596,97.64413965156795,-2.3558603484320457,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.1412, \'current_price\': 0.1404, \'prev_closed_price\': 0.1395, \'bb_upper\': 0.1411804348323509, \'bb_lower\': 0.12772956516764913, \'signal\': -1}\"}','2024-03-06 08:22:08.205014','2024-03-06 08:22:08.205014',35130,3114,5,25),(26619,5.325,17.49362689680164,93.06040966224326,-7.120811035056221,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 5.343, \'current_price\': 5.325, \'prev_closed_price\': 5.295, \'bb_upper\': 5.342813921617193, \'bb_lower\': 4.944886078382806, \'signal\': -1}\"}','2024-03-06 08:27:32.370313','2024-03-06 08:27:32.370313',35138,3156,5,25),(26620,2.815,43.39663819142954,122.03937497236528,11.52781585425042,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 2.857, \'current_price\': 2.815, \'prev_closed_price\': 2.811, \'bb_upper\': 2.8568977428505398, \'bb_lower\': 2.5424022571494596, \'signal\': -1}\"}','2024-03-06 08:34:37.933497','2024-03-06 08:34:37.933497',35165,3015,5,25),(26621,0.6771,135.721930509753,91.80542182900561,5.236839125487478,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 0.6738, \'current_price\': 0.6771, \'prev_closed_price\': 0.6549, \'bb_upper\': 0.6766982812840509, \'bb_lower\': 0.5944017187159493, \'signal\': -1}\"}','2024-03-06 09:14:56.281854','2024-03-06 09:14:56.281854',35164,3167,5,27),(26622,31.351,3.039483504672923,95.1955565076458,3.238249755659382,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 31.32, \'current_price\': 31.371, \'prev_closed_price\': 30.691, \'bb_upper\': 31.368909301694092, \'bb_lower\': 29.36659069830591, \'signal\': -1}\"}','2024-03-06 09:36:21.786909','2024-03-06 09:36:21.786909',35166,3176,5,27),(26623,1.19,79.19356551176584,94.14610261604234,-0.1806477367606334,'{\'signal\': -1, \'log\': \"bb: {\'high_price\': 1.2025, \'current_price\': 1.1902, \'prev_closed_price\': 1.2, \'bb_upper\': 1.2024904608607345, \'bb_lower\': 1.1539395391392655, \'signal\': -1}\"}','2024-03-06 19:34:22.811384','2024-03-06 19:34:22.811384',35167,3195,5,27);
/*!40000 ALTER TABLE `sell_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strategy`
--

DROP TABLE IF EXISTS `strategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `strategy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `function_name` varchar(255) NOT NULL,
  `balance` double DEFAULT NULL,
  `periority` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `notes` text,
  `is_running` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `strategy_name_function_name_9da360a6_uniq` (`name`,`function_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strategy`
--

LOCK TABLES `strategy` WRITE;
/*!40000 ALTER TABLE `strategy` DISABLE KEYS */;
INSERT INTO `strategy` VALUES (1,'AwesomeStochBbSar','AwesomeStochBbSar',NULL,1,0,'2024-01-06 16:38:43.520000','2024-01-06 16:38:43.520000',NULL,0),(2,'AwesomeStochBbSarEma200','AwesomeStochBbSarEma200',NULL,1,0,'2024-01-10 23:18:49.351000','2024-01-10 23:18:49.351000',NULL,0),(3,'AwesomeStochBbSarEma200_2','AwesomeStochBbSarEma200_2',NULL,1,0,'2024-01-12 20:51:45.440000','2024-01-12 20:51:45.442000',NULL,0),(4,'AwesomeStochBbSarEma200_3','AwesomeStochBbSarEma200_3',NULL,1,0,'2024-01-28 17:06:30.061000','2024-01-28 17:06:30.061000',NULL,0),(5,'S10','S10',NULL,1,1,'2024-02-24 00:04:34.138000','2024-02-24 00:04:34.139000',NULL,0);
/*!40000 ALTER TABLE `strategy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `strategy_times`
--

DROP TABLE IF EXISTS `strategy_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `strategy_times` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_frame` varchar(10) NOT NULL,
  `periority` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `strategy_id` int NOT NULL,
  `balance` double DEFAULT NULL,
  `amount_per_order` double DEFAULT NULL,
  `notes` text,
  `stop_loss_percent` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `strategy_times_time_frame_strategy_id_66af3057_uniq` (`time_frame`,`strategy_id`),
  KEY `strategy_times_strategy_id_dc48505a_fk_strategy_id` (`strategy_id`),
  CONSTRAINT `strategy_times_strategy_id_dc48505a_fk_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `strategy` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `strategy_times`
--

LOCK TABLES `strategy_times` WRITE;
/*!40000 ALTER TABLE `strategy_times` DISABLE KEYS */;
INSERT INTO `strategy_times` VALUES (1,'1m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',1,1000,100,NULL,1),(2,'3m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',1,1000,100,NULL,1.5),(3,'5m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',1,1000,100,NULL,2),(4,'15m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',1,1000,100,NULL,3),(5,'30m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',1,1000,100,NULL,5),(6,'1h',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',1,1000,100,NULL,5),(7,'1m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',2,1000,100,NULL,1),(8,'3m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',2,1000,100,NULL,1.5),(9,'5m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',2,1000,100,NULL,2),(10,'15m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',2,1000,100,NULL,3),(11,'30m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',2,1000,100,NULL,5),(12,'1h',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',2,1000,100,NULL,5),(13,'1m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',3,1000,100,NULL,1),(14,'3m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',3,1000,100,NULL,1.5),(15,'5m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',3,1000,100,NULL,2),(16,'15m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',3,1000,100,NULL,4),(17,'30m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',3,1000,100,NULL,5),(18,'1h',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',3,1000,100,NULL,6),(19,'1m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',4,1000,100,NULL,1),(20,'3m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',4,1000,100,NULL,1.5),(21,'5m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',4,1000,100,NULL,2),(22,'15m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',4,1000,100,NULL,4),(23,'30m',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',4,1000,100,NULL,5),(24,'1h',1,1,'2024-01-06 16:39:18.255000','2024-01-06 16:39:18.255000',4,1000,100,NULL,6),(25,'30m',1,1,'2024-02-24 00:05:12.862000','2024-02-24 00:05:12.862000',5,907.624383818441,100,NULL,8),(26,'1m',1,0,'2024-02-24 00:05:12.862000','2024-02-24 00:05:12.862000',5,1020,100,NULL,12),(27,'15m',1,1,'2024-02-24 00:05:12.862000','2024-02-24 00:05:12.862000',5,302.79960332164836,100,NULL,8),(28,'5m',1,0,'2024-02-24 00:05:12.862000','2024-02-24 00:05:12.862000',5,1020,100,NULL,12);
/*!40000 ALTER TABLE `strategy_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'go_crypto'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-06 19:45:00