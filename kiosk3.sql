-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: kiosk
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.20.04.2

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `user_id` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` varchar(100) NOT NULL,
  `store_id` varchar(100) DEFAULT NULL,
  `customer_name` varchar(150) DEFAULT NULL,
  `customer_number` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_verification`
--

DROP TABLE IF EXISTS `email_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_verification` (
  `user_id` varchar(100) DEFAULT NULL,
  `token` varchar(6) NOT NULL,
  PRIMARY KEY (`token`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `email_verification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_verification`
--

LOCK TABLES `email_verification` WRITE;
/*!40000 ALTER TABLE `email_verification` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_verification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_history`
--

DROP TABLE IF EXISTS `login_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_history` (
  `user_id` varchar(100) DEFAULT NULL,
  `login_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `user_id` (`user_id`),
  CONSTRAINT `login_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_history`
--

LOCK TABLES `login_history` WRITE;
/*!40000 ALTER TABLE `login_history` DISABLE KEYS */;
INSERT INTO `login_history` VALUES ('024582395e8429238871dbacb88221bc','2023-02-09 14:44:01'),('024582395e8429238871dbacb88221bc','2023-02-09 14:44:45'),('024582395e8429238871dbacb88221bc','2023-02-09 14:45:45'),('024582395e8429238871dbacb88221bc','2023-02-09 14:49:53'),('024582395e8429238871dbacb88221bc','2023-02-09 14:50:04'),('024582395e8429238871dbacb88221bc','2023-02-09 14:50:12'),('024582395e8429238871dbacb88221bc','2023-02-09 14:51:08'),('024582395e8429238871dbacb88221bc','2023-02-09 17:03:32'),('024582395e8429238871dbacb88221bc','2023-02-09 17:05:35'),('024582395e8429238871dbacb88221bc','2023-02-09 17:09:52'),('024582395e8429238871dbacb88221bc','2023-02-09 17:10:58'),('024582395e8429238871dbacb88221bc','2023-02-09 17:11:35'),('024582395e8429238871dbacb88221bc','2023-02-09 17:14:01'),('024582395e8429238871dbacb88221bc','2023-02-09 17:18:08'),('024582395e8429238871dbacb88221bc','2023-02-09 17:18:13'),('024582395e8429238871dbacb88221bc','2023-02-09 17:20:25'),('024582395e8429238871dbacb88221bc','2023-02-09 17:21:07'),('024582395e8429238871dbacb88221bc','2023-02-09 17:23:20'),('024582395e8429238871dbacb88221bc','2023-02-09 17:24:11'),('024582395e8429238871dbacb88221bc','2023-02-09 17:25:40'),('024582395e8429238871dbacb88221bc','2023-02-09 17:28:08'),('024582395e8429238871dbacb88221bc','2023-02-09 18:06:32'),('024582395e8429238871dbacb88221bc','2023-02-09 18:07:34'),('024582395e8429238871dbacb88221bc','2023-02-09 18:14:03'),('024582395e8429238871dbacb88221bc','2023-02-09 18:16:33'),('024582395e8429238871dbacb88221bc','2023-02-09 18:17:15'),('024582395e8429238871dbacb88221bc','2023-02-09 18:24:50'),('024582395e8429238871dbacb88221bc','2023-02-09 18:25:11'),('024582395e8429238871dbacb88221bc','2023-02-10 16:41:20'),('024582395e8429238871dbacb88221bc','2023-02-10 16:42:38'),('024582395e8429238871dbacb88221bc','2023-02-12 01:11:44'),('024582395e8429238871dbacb88221bc','2023-02-14 02:39:42'),('024582395e8429238871dbacb88221bc','2023-02-14 19:04:16'),('024582395e8429238871dbacb88221bc','2023-02-14 19:16:35'),('024582395e8429238871dbacb88221bc','2023-02-14 19:17:54'),('024582395e8429238871dbacb88221bc','2023-02-14 19:22:24'),('024582395e8429238871dbacb88221bc','2023-02-14 19:24:25'),('024582395e8429238871dbacb88221bc','2023-02-14 19:26:30'),('024582395e8429238871dbacb88221bc','2023-02-18 03:14:26'),('024582395e8429238871dbacb88221bc','2023-02-18 03:22:28'),('024582395e8429238871dbacb88221bc','2023-02-18 03:26:42'),('024582395e8429238871dbacb88221bc','2023-02-18 03:30:26'),('024582395e8429238871dbacb88221bc','2023-02-18 03:31:21'),('024582395e8429238871dbacb88221bc','2023-02-18 03:33:12'),('024582395e8429238871dbacb88221bc','2023-02-18 03:38:29'),('024582395e8429238871dbacb88221bc','2023-02-18 03:56:30'),('024582395e8429238871dbacb88221bc','2023-02-18 04:05:00'),('024582395e8429238871dbacb88221bc','2023-02-18 04:34:52'),('024582395e8429238871dbacb88221bc','2023-02-18 04:36:17'),('024582395e8429238871dbacb88221bc','2023-02-18 11:03:17'),('024582395e8429238871dbacb88221bc','2023-02-18 11:08:00'),('024582395e8429238871dbacb88221bc','2023-02-18 11:09:26'),('024582395e8429238871dbacb88221bc','2023-02-18 11:16:20'),('024582395e8429238871dbacb88221bc','2023-02-18 11:20:10'),('024582395e8429238871dbacb88221bc','2023-02-19 00:25:12'),('024582395e8429238871dbacb88221bc','2023-02-19 00:31:59'),('024582395e8429238871dbacb88221bc','2023-02-19 00:47:09'),('024582395e8429238871dbacb88221bc','2023-02-19 00:49:52'),('024582395e8429238871dbacb88221bc','2023-02-19 00:56:54'),('024582395e8429238871dbacb88221bc','2023-02-19 00:58:55'),('024582395e8429238871dbacb88221bc','2023-02-19 01:01:48');
/*!40000 ALTER TABLE `login_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `media_id` varchar(100) NOT NULL,
  `location` varchar(250) DEFAULT NULL,
  `uploader_id` varchar(100) DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `media_type` enum('picture','video','document') DEFAULT 'picture',
  PRIMARY KEY (`media_id`),
  KEY `uploader_id` (`uploader_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`uploader_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_transactions`
--

DROP TABLE IF EXISTS `order_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_transactions` (
  `transaction_id` varchar(100) NOT NULL,
  `order_id` varchar(100) NOT NULL,
  PRIMARY KEY (`transaction_id`,`order_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_transactions_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`),
  CONSTRAINT `order_transactions_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_transactions`
--

LOCK TABLES `order_transactions` WRITE;
/*!40000 ALTER TABLE `order_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` varchar(100) NOT NULL,
  `customer_id` varchar(100) DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_tokens`
--

DROP TABLE IF EXISTS `password_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_tokens` (
  `user_id` varchar(100) DEFAULT NULL,
  `token` varchar(150) NOT NULL,
  PRIMARY KEY (`token`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `password_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_tokens`
--

LOCK TABLES `password_tokens` WRITE;
/*!40000 ALTER TABLE `password_tokens` DISABLE KEYS */;
INSERT INTO `password_tokens` VALUES ('024582395e8429238871dbacb88221bc','bc4b1dc372aa6d8795447aa656b828b1');
/*!40000 ALTER TABLE `password_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_verification`
--

DROP TABLE IF EXISTS `phone_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phone_verification` (
  `user_id` varchar(100) DEFAULT NULL,
  `token` varchar(6) NOT NULL,
  PRIMARY KEY (`token`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `phone_verification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_verification`
--

LOCK TABLES `phone_verification` WRITE;
/*!40000 ALTER TABLE `phone_verification` DISABLE KEYS */;
INSERT INTO `phone_verification` VALUES ('024582395e8429238871dbacb88221bc','851e95');
/*!40000 ALTER TABLE `phone_verification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_crediential`
--

DROP TABLE IF EXISTS `post_crediential`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_crediential` (
  `post_id` varchar(100) NOT NULL,
  `credential` varchar(100) NOT NULL,
  PRIMARY KEY (`post_id`,`credential`),
  KEY `credential` (`credential`),
  CONSTRAINT `post_crediential_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `scheduled_posts` (`post_id`),
  CONSTRAINT `post_crediential_ibfk_2` FOREIGN KEY (`credential`) REFERENCES `social_media_credentials` (`api_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_crediential`
--

LOCK TABLES `post_crediential` WRITE;
/*!40000 ALTER TABLE `post_crediential` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_crediential` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_media`
--

DROP TABLE IF EXISTS `post_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_media` (
  `post_id` varchar(100) NOT NULL,
  `media_id` varchar(100) NOT NULL,
  PRIMARY KEY (`post_id`,`media_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `post_media_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `scheduled_posts` (`post_id`),
  CONSTRAINT `post_media_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_media`
--

LOCK TABLES `post_media` WRITE;
/*!40000 ALTER TABLE `post_media` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_media`
--

DROP TABLE IF EXISTS `product_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_media` (
  `product_id` varchar(100) NOT NULL,
  `media_id` varchar(100) NOT NULL,
  PRIMARY KEY (`product_id`,`media_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `product_media_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `product_media_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_media`
--

LOCK TABLES `product_media` WRITE;
/*!40000 ALTER TABLE `product_media` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` varchar(100) NOT NULL,
  `store_id` varchar(100) DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `product_description` tinytext,
  `quantity` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `currency` enum('GHS','USD') DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('01920d05bb7b74992287637f6be552bd','be53953f6d9a979d34a265547f962448','Test three','some description',NULL,NULL,NULL),('16fda0be7dbe61a5613550d67bae9dbd','be53953f6d9a979d34a265547f962448','Test three','some description',NULL,NULL,NULL),('2fd44acf86239815b0f5ed63e8ffb317','be53953f6d9a979d34a265547f962448','Test three','some description',NULL,NULL,NULL),('3ee7360fbead0f11dd48e742994d24bd','be53953f6d9a979d34a265547f962448','Test one','',NULL,NULL,NULL),('626d070276f280658efb6d4127a84611','be53953f6d9a979d34a265547f962448','test 9','coold',NULL,NULL,NULL),('67d8dfb40e6481aafb31e5407b07af38','be53953f6d9a979d34a265547f962448','Test 8','cool good',NULL,NULL,NULL),('6de5cefaef77bc06e09be26570e75e51','be53953f6d9a979d34a265547f962448','Test 7','test',NULL,NULL,NULL),('96b8e020f5540b97a5b683dc3d03166c','be53953f6d9a979d34a265547f962448','Test 8','cool good',NULL,NULL,NULL),('9946842b9fb6bf7c30ac1a4d7fa3fae6','be53953f6d9a979d34a265547f962448','Test three','some description',NULL,NULL,NULL),('9b85fa47545d2eb7e25fc84e78ff5dd4','be53953f6d9a979d34a265547f962448','Test three','some description',NULL,NULL,NULL),('aafcf294baf223274b151d9d1aa7e0eb','be53953f6d9a979d34a265547f962448','Test three','some description',NULL,NULL,NULL),('d9abd757ac400bb602c5e6ef8c0475a5','be53953f6d9a979d34a265547f962448','Test two','',NULL,NULL,NULL),('e5583255a3a3cec10bb7f53f6698c757','be53953f6d9a979d34a265547f962448','Test10','asd',NULL,NULL,NULL),('e8ec2bb8898851652b8eaa8924f4a287','be53953f6d9a979d34a265547f962448','Test three','some description',NULL,NULL,NULL),('eb07f38f08f7dd002974f06d3cf3fb18','be53953f6d9a979d34a265547f962448','Test three','some description',NULL,NULL,NULL),('f81c7b4d13764648d89b40da9e2bdec1','be53953f6d9a979d34a265547f962448','test11','asd',NULL,NULL,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reminders` (
  `reminder_id` varchar(100) NOT NULL,
  PRIMARY KEY (`reminder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminders`
--

LOCK TABLES `reminders` WRITE;
/*!40000 ALTER TABLE `reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_posts`
--

DROP TABLE IF EXISTS `scheduled_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_posts` (
  `post_id` varchar(100) NOT NULL,
  `caption` tinytext,
  `time_to_post` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_posts`
--

LOCK TABLES `scheduled_posts` WRITE;
/*!40000 ALTER TABLE `scheduled_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduled_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_media_credentials`
--

DROP TABLE IF EXISTS `social_media_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `social_media_credentials` (
  `api_key` varchar(150) NOT NULL,
  `store_id` varchar(100) DEFAULT NULL,
  `platform` enum('whatsapp','instagram') DEFAULT 'whatsapp',
  `bearer_token` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`api_key`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `social_media_credentials_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_media_credentials`
--

LOCK TABLES `social_media_credentials` WRITE;
/*!40000 ALTER TABLE `social_media_credentials` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_media_credentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_manager_invite`
--

DROP TABLE IF EXISTS `store_manager_invite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_manager_invite` (
  `invite_token` varchar(150) NOT NULL,
  `store_id` varchar(100) DEFAULT NULL,
  `expiry_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`invite_token`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `store_manager_invite_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_manager_invite`
--

LOCK TABLES `store_manager_invite` WRITE;
/*!40000 ALTER TABLE `store_manager_invite` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_manager_invite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_managers`
--

DROP TABLE IF EXISTS `store_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_managers` (
  `user_id` varchar(100) NOT NULL,
  `store_id` varchar(100) NOT NULL,
  `privilege` enum('all','view','edit') DEFAULT 'all',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`store_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `store_managers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `store_managers_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_managers`
--

LOCK TABLES `store_managers` WRITE;
/*!40000 ALTER TABLE `store_managers` DISABLE KEYS */;
INSERT INTO `store_managers` VALUES ('024582395e8429238871dbacb88221bc','be53953f6d9a979d34a265547f962448','all','2023-02-09 14:43:33');
/*!40000 ALTER TABLE `store_managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_wallets`
--

DROP TABLE IF EXISTS `store_wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_wallets` (
  `store_id` varchar(100) NOT NULL,
  `wallet_name` varchar(100) DEFAULT NULL,
  `wallet_number` varchar(16) NOT NULL,
  `provider` enum('MTN','AirtelTigo','Vodafone') DEFAULT NULL,
  PRIMARY KEY (`store_id`,`wallet_number`),
  CONSTRAINT `store_wallets_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_wallets`
--

LOCK TABLES `store_wallets` WRITE;
/*!40000 ALTER TABLE `store_wallets` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_wallets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores` (
  `store_id` varchar(100) NOT NULL,
  `store_name` varchar(70) NOT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `profile_image` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `account_balance` double NOT NULL DEFAULT '0',
  `store_status` enum('active','suspended') DEFAULT 'active',
  PRIMARY KEY (`store_id`),
  KEY `profile_image` (`profile_image`),
  CONSTRAINT `stores_ibfk_1` FOREIGN KEY (`profile_image`) REFERENCES `media` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES ('be53953f6d9a979d34a265547f962448','Amelia',0,NULL,'Ghana',0,'active');
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` varchar(100) NOT NULL,
  `amount` double DEFAULT NULL,
  `currency` enum('GHS','USD') DEFAULT 'GHS',
  `transaction_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `two_factor_tokens`
--

DROP TABLE IF EXISTS `two_factor_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `two_factor_tokens` (
  `user_id` varchar(100) DEFAULT NULL,
  `token` varchar(150) NOT NULL,
  PRIMARY KEY (`token`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `two_factor_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `two_factor_tokens`
--

LOCK TABLES `two_factor_tokens` WRITE;
/*!40000 ALTER TABLE `two_factor_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `two_factor_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` varchar(100) NOT NULL,
  `user_name` varchar(150) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(16) DEFAULT NULL,
  `password` varchar(150) DEFAULT NULL,
  `signup_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id_front` varchar(100) DEFAULT NULL,
  `user_id_back` varchar(100) DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT '0',
  `number_verified` tinyint(1) DEFAULT '0',
  `two_factor_enabled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_id`),
  KEY `user_id_front` (`user_id_front`),
  KEY `user_id_back` (`user_id_back`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_id_front`) REFERENCES `media` (`media_id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`user_id_back`) REFERENCES `media` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('024582395e8429238871dbacb88221bc','kweku acquaye','kweku.acquaye@ashesi.edu.gh','0559582518','882481400bd3a0b36106b7b50314b41b','2023-02-18 03:53:16',NULL,NULL,1,0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdrawal_transactions`
--

DROP TABLE IF EXISTS `withdrawal_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdrawal_transactions` (
  `transaction_id` varchar(100) NOT NULL,
  `store_id` varchar(100) NOT NULL,
  PRIMARY KEY (`transaction_id`,`store_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `withdrawal_transactions_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`),
  CONSTRAINT `withdrawal_transactions_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdrawal_transactions`
--

LOCK TABLES `withdrawal_transactions` WRITE;
/*!40000 ALTER TABLE `withdrawal_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `withdrawal_transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-21  5:25:24
