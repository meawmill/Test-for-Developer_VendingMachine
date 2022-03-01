-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2022 at 05:27 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `drinking_vending_machine`
--

-- --------------------------------------------------------

--
-- Table structure for table `machinestocks`
--

CREATE TABLE `machinestocks` (
  `id` int(11) NOT NULL,
  `vm_code` varchar(255) DEFAULT NULL,
  `channel` varchar(255) DEFAULT NULL,
  `prod_id` int(11) DEFAULT NULL,
  `maxqty` int(11) DEFAULT NULL,
  `restqty` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `machinestocks`
--

INSERT INTO `machinestocks` (`id`, `vm_code`, `channel`, `prod_id`, `maxqty`, `restqty`, `createdAt`, `updatedAt`) VALUES
(1, 'M1', '1', 1, 25, 23, '2022-02-28 07:47:34', '2022-03-01 10:09:02'),
(2, 'M1', '2', 2, 25, 25, '2022-02-28 07:51:29', '2022-03-01 03:55:27'),
(3, 'M1', '3', 3, 20, 8, '2022-02-28 07:51:43', '2022-03-01 09:17:16'),
(4, 'M1', '4', 4, 15, 15, '2022-02-28 07:52:07', '2022-03-01 03:55:38'),
(5, 'M2', '1', 1, 25, 24, '2022-02-28 07:52:18', '2022-03-01 07:28:53'),
(6, 'M2', '2', 2, 25, 25, '2022-02-28 07:52:29', '2022-03-01 03:55:06'),
(7, 'M2', '3', 3, 20, 20, '2022-02-28 07:52:43', '2022-03-01 03:55:13'),
(8, 'M2', '4', 4, 15, 9, '2022-02-28 07:52:58', '2022-03-01 07:22:55');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `eanCode` varchar(255) DEFAULT NULL,
  `prodName` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `eanCode`, `prodName`, `price`, `createdAt`, `updatedAt`) VALUES
(1, '8850999016863', 'สิงห์ เครื่องดื่มมะนาวโซดา 330 มล.', 16, '2022-02-28 07:28:01', '2022-02-28 08:07:12'),
(2, '8858998581047', 'เป๊ปซี่ เครื่องดื่มอัดลม 550 มล.', 17, '2022-02-28 07:50:30', '2022-02-28 08:07:57'),
(3, '8850228001615', 'เรดดี้ เครื่องดื่มผสมคาเฟอีน 150 มล.', 15, '2022-02-28 07:50:43', '2022-02-28 08:08:33'),
(4, '8888196173423', 'พอคคา เครื่องดื่มชาเขียว กลิ่นมะลิ', 70, '2022-02-28 07:51:04', '2022-02-28 08:09:12');

-- --------------------------------------------------------

--
-- Table structure for table `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('20220225153513-create-products.js'),
('20220225153814-create-machine-stock.js'),
('20220225153816-create-vending-machine.js');

-- --------------------------------------------------------

--
-- Table structure for table `vendingmachines`
--

CREATE TABLE `vendingmachines` (
  `id` int(11) NOT NULL,
  `vm_code` varchar(255) DEFAULT NULL,
  `location` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vendingmachines`
--

INSERT INTO `vendingmachines` (`id`, `vm_code`, `location`, `createdAt`, `updatedAt`) VALUES
(4, 'M1', 'https://goo.gl/maps/1gCAjGFqZgFE26TS7', '2022-02-28 07:42:50', '2022-02-28 07:42:50'),
(6, 'M2', 'https://goo.gl/maps/ACYu5DJktoeYsucy9', '2022-02-28 07:50:15', '2022-02-28 07:50:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `machinestocks`
--
ALTER TABLE `machinestocks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `vendingmachines`
--
ALTER TABLE `vendingmachines`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `machinestocks`
--
ALTER TABLE `machinestocks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vendingmachines`
--
ALTER TABLE `vendingmachines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
