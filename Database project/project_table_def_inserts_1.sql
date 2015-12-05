-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 10, 2015 at 05:37 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `meetup`
--

-- --------------------------------------------------------

--
-- Table structure for table `about`
--

CREATE TABLE IF NOT EXISTS `about` (
  `intr_name` varchar(20) NOT NULL,
  `g_id` int(5) NOT NULL,
  KEY `intr_name` (`intr_name`),
  KEY `g_id` (`g_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `about`
--

INSERT INTO `about` (`intr_name`, `g_id`) VALUES
('learningmysql', 123),
('computerscience', 321);

-- --------------------------------------------------------

--
-- Table structure for table `attend`
--

CREATE TABLE IF NOT EXISTS `attend` (
  `username` varchar(20) NOT NULL,
  `e_id` int(5) NOT NULL,
  KEY `username` (`username`),
  KEY `e_id` (`e_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attend`
--

INSERT INTO `attend` (`username`, `e_id`) VALUES
('alextan', 111),
('alextan', 222);

-- --------------------------------------------------------

--
-- Table structure for table `belong`
--

CREATE TABLE IF NOT EXISTS `belong` (
  `username` varchar(20) NOT NULL,
  `g_id` int(5) NOT NULL,
  KEY `username` (`username`),
  KEY `g_id` (`g_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `belong`
--

INSERT INTO `belong` (`username`, `g_id`) VALUES
('alextan', 123),
('alextan', 321);

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE IF NOT EXISTS `event` (
  `e_id` int(5) NOT NULL,
  `title` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `start_time` int(5) DEFAULT NULL,
  `end_time` int(5) DEFAULT NULL,
  `e_date` int(7) DEFAULT NULL,
  `lname` varchar(20) NOT NULL,
  `zip` int(5) NOT NULL,
  `g_id` int(5) NOT NULL,
  PRIMARY KEY (`e_id`),
  KEY `lname` (`lname`),
  KEY `zip` (`zip`),
  KEY `g_id` (`g_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`e_id`, `title`, `description`, `start_time`, `end_time`, `e_date`, `lname`, `zip`, `g_id`) VALUES
(111, 'testevent', 'testing event', 1100, 1200, 11915, 'poly', 22222, 123),
(222, 'cooking', 'cooking event', 1000, 1300, 111015, 'steinhardt', 33333, 321);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `g_id` int(5) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `creator` varchar(20) NOT NULL,
  PRIMARY KEY (`g_id`),
  KEY `creator` (`creator`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`g_id`, `name`, `description`, `creator`) VALUES
(123, 'database', 'Having fun with mysql', 'alextan'),
(321, 'testgroup', 'testing group', 'alextan');

-- --------------------------------------------------------

--
-- Table structure for table `interest`
--

CREATE TABLE IF NOT EXISTS `interest` (
  `intr_name` varchar(20) NOT NULL,
  PRIMARY KEY (`intr_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interest`
--

INSERT INTO `interest` (`intr_name`) VALUES
('computerscience'),
('learningmysql');

-- --------------------------------------------------------

--
-- Table structure for table `interest_in`
--

CREATE TABLE IF NOT EXISTS `interest_in` (
  `username` varchar(20) NOT NULL,
  `intr_name` varchar(20) NOT NULL,
  KEY `username` (`username`),
  KEY `intr_name` (`intr_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `interest_in`
--

INSERT INTO `interest_in` (`username`, `intr_name`) VALUES
('alextan', 'learningmysql'),
('alextan', 'computerscience');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE IF NOT EXISTS `location` (
  `lname` varchar(20) NOT NULL,
  `zip` int(5) NOT NULL,
  `street` int(5) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `latitude` int(5) DEFAULT NULL,
  `longitude` int(5) DEFAULT NULL,
  `description` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`lname`),
  UNIQUE KEY `zip` (`zip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`lname`, `zip`, `street`, `city`, `latitude`, `longitude`, `description`) VALUES
('poly', 22222, 1, 'NYC', 1, 1, 'NYU poly'),
('steinhardt', 33333, 2, 'NYC', 2, 2, 'NYU steinhardt');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE IF NOT EXISTS `member` (
  `username` varchar(20) NOT NULL,
  `password` char(32) DEFAULT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `zipcode` int(5) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`username`, `password`, `first_name`, `last_name`, `zipcode`) VALUES
('alextan', 'password', 'alex', 'tan', 12345),
('darylD', 'password', 'daryl', 'dalman', 12345);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `about`
--
ALTER TABLE `about`
  ADD CONSTRAINT `about_ibfk_1` FOREIGN KEY (`intr_name`) REFERENCES `interest_in` (`intr_name`),
  ADD CONSTRAINT `about_ibfk_2` FOREIGN KEY (`g_id`) REFERENCES `groups` (`g_id`);

--
-- Constraints for table `attend`
--
ALTER TABLE `attend`
  ADD CONSTRAINT `attend_ibfk_1` FOREIGN KEY (`username`) REFERENCES `member` (`username`),
  ADD CONSTRAINT `attend_ibfk_2` FOREIGN KEY (`e_id`) REFERENCES `event` (`e_id`);

--
-- Constraints for table `belong`
--
ALTER TABLE `belong`
  ADD CONSTRAINT `belong_ibfk_1` FOREIGN KEY (`username`) REFERENCES `member` (`username`),
  ADD CONSTRAINT `belong_ibfk_2` FOREIGN KEY (`g_id`) REFERENCES `groups` (`g_id`);

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `event_ibfk_1` FOREIGN KEY (`lname`) REFERENCES `location` (`lname`),
  ADD CONSTRAINT `event_ibfk_2` FOREIGN KEY (`zip`) REFERENCES `location` (`zip`),
  ADD CONSTRAINT `event_ibfk_3` FOREIGN KEY (`g_id`) REFERENCES `groups` (`g_id`);

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `member` (`username`);

--
-- Constraints for table `interest_in`
--
ALTER TABLE `interest_in`
  ADD CONSTRAINT `interest_in_ibfk_1` FOREIGN KEY (`username`) REFERENCES `member` (`username`),
  ADD CONSTRAINT `interest_in_ibfk_2` FOREIGN KEY (`intr_name`) REFERENCES `interest` (`intr_name`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
