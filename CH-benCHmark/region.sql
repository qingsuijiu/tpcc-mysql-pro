-- MySQL dump 10.13  Distrib 8.0.20-11, for Linux (x86_64)
--
-- Host: localhost    Database: tpcc_100
-- ------------------------------------------------------
-- Server version	8.0.20-11

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
/*!50717 SELECT COUNT(*) INTO @rocksdb_has_p_s_session_variables FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME = 'session_variables' */;
/*!50717 SET @rocksdb_get_is_supported = IF (@rocksdb_has_p_s_session_variables, 'SELECT COUNT(*) INTO @rocksdb_is_supported FROM performance_schema.session_variables WHERE VARIABLE_NAME=\'rocksdb_bulk_load\'', 'SELECT 0') */;
/*!50717 PREPARE s FROM @rocksdb_get_is_supported */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;
/*!50717 SET @rocksdb_enable_bulk_load = IF (@rocksdb_is_supported, 'SET SESSION rocksdb_bulk_load = 1', 'SET @rocksdb_dummy_bulk_load = 0') */;
/*!50717 PREPARE s FROM @rocksdb_enable_bulk_load */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup
-- (origin: @@global.gtid_executed)
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `r_regionkey` bigint NOT NULL,
  `r_name` char(25) COLLATE utf8mb4_general_ci NOT NULL,
  `r_comment` varchar(152) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`r_regionkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='partition by key(`r_regionkey`) partitions 17';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (1,'Africa','bIKaGP4VDy4kV8z5GsyCvoC2SFL8BBb9lI5hJx284oWL2fhPNqV3XeRTJM2U2IhodH4wID9cDCr5wQSZJ0RQ0qP3bx99bR4L7QC13dYq0kWwmfTa5NMA'),(2,'America','NmdHQaMgd9G4OopGEQ5mQGp6o79hI8NL0BobmVWEu29MuJpQVLQrUhvLi0JQhyY0Lkt0KYDbx1S8FAKcMJLF0eDQPenevRCAj5Z'),(3,'Asia','bIDtqrZXraFtliGTl7NIz2RtLBavLE2cEVgW9iPEZi3WL59LEBXNk4pScy96SYU7Ti0SYSi7oebrakOD5tuUUdLkbztPU8GpD8pYvZ889eGLWu0mYi3XD4iCw0M'),(4,'Australia','6pRd6jAeKGj2vWYQqHtpPUupR5Sc1SkQGVDg2ZGueffAZaCufbx7YKUohHsPyz7pMfL4fEOS1wsOjGwDlamI8cZDvNOdQn4m9J2NKOHBMZ1tTuDplR0nKu8d1V2lB1Pw4elmyE3NJqtMWthf36R2pk'),(5,'Europe','1oi2r0Es7qYdGyYVTaRJlxzbcghww6cbQ2eTXilhXo5P5cjWwAzZnsE4I5XTIExBXnHnMQLcIMaHJjdOS0uOOFW24djaeT4918wiulgjyv0wiKOO3ci0Who7CsOOASLeBG');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!50112 SET @disable_bulk_load = IF (@is_rocksdb_supported, 'SET SESSION rocksdb_bulk_load = @old_rocksdb_bulk_load', 'SET @dummy_rocksdb_bulk_load = 0') */;
/*!50112 PREPARE s FROM @disable_bulk_load */;
/*!50112 EXECUTE s */;
/*!50112 DEALLOCATE PREPARE s */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-03 16:26:45