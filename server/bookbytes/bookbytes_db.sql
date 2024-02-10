-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 10, 2024 at 09:59 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookbytes_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_books`
--

CREATE TABLE `tbl_books` (
  `book_id` int(5) NOT NULL,
  `user_id` varchar(5) NOT NULL,
  `book_isbn` varchar(17) NOT NULL,
  `book_title` varchar(200) NOT NULL,
  `book_desc` varchar(2000) NOT NULL,
  `book_author` varchar(100) NOT NULL,
  `book_price` decimal(6,2) NOT NULL,
  `book_qty` int(5) NOT NULL,
  `book_status` varchar(10) NOT NULL,
  `book_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_books`
--

INSERT INTO `tbl_books` (`book_id`, `user_id`, `book_isbn`, `book_title`, `book_desc`, `book_author`, `book_price`, `book_qty`, `book_status`, `book_date`) VALUES
(1, '3', '978-6-789012-34-5', 'Whirlwind of Wonders', 'An epic fantasy adventure where a diverse group of heroes embarks on a quest to save their world from an impending cataclysm.', 'Seraphina Stormrider', 200.00, 10, 'New', '2023-12-22 06:36:16.000000'),
(2, '6', '978-5-678901-24-5', 'Whispers of the Forgotten', 'Lost secrets stir and forgotten voices whisper in the shadows, beckoning brave souls to uncover the truth in a world shrouded in mystery.', 'Echoes of the Past', 500.00, 0, 'New', '2023-12-22 06:52:06.000000'),
(3, '3', '978-5-678901-25-6', 'Chronicles of the Celestial Kingdom', 'Generations of celestial guardians have protected the heavens, but with a dark power rising, a young heir must claim their destiny and rewrite the chronicles of the stars.', 'Starlight Scribe', 250.00, 1, 'New', '2023-12-22 06:52:06.000000'),
(4, '2', '978-5-678901-26-7', 'Ephemeral Echoes', 'Memories shimmer like fireflies in the twilight, fleeting yet powerful, as a young mage seeks to unravel the secrets of a lost civilization before they fade into oblivion.', 'Whispers of Time', 250.00, 2, 'Used', '2023-12-22 06:59:26.000000'),
(5, '3', '978-5-678901-28-9', 'Beyond the Horizon', 'Uncharted seas beckon with the promise of adventure, but monstrous leviathans and treacherous currents guard the secrets hidden beyond the worlds edge.', 'Captain of Uncharted Waters', 300.00, 3, 'New', '2023-12-22 06:59:26.000000'),
(6, '3', '978-5-678901-29-0', 'Silent Symphony', 'Melodies whisper on the wind, carrying untold stories and forgotten magic, as a gifted musician unravels the secrets woven into the very fabric of existence.', 'Maestro of Moonlight', 250.00, 1, 'Used', '2023-12-22 07:03:34.000000'),
(7, '5', '978-5-678901-30-1', 'The Quantum Paradox', 'Reality splinters and timelines collide as a brilliant physicist confronts the impossible: unraveling the mysteries of the quantum realm and rewriting the laws of the universe.', 'Master of Microworlds', 500.00, 5, 'Used', '2023-12-22 07:03:34.000000'),
(8, '3', '978-5-678901-31-2', 'Lost in Lumina', 'Adrift in a city of pure light, where secrets shimmer in every cobbled street and danger lurks in every shimmering shadow, a lone traveler seeks a haven and uncovers a conspiracy that threatens to extinguish the very essence of the city.', 'Weaver of Starlight', 450.00, 1, 'New', '2023-12-22 07:03:34.000000'),
(10, '3', '978-5-678901-32-3', 'Echoes of Eternity', 'In the echoing halls of a forgotten temple, the whispers of long-dead empires carry forgotten wisdom and forgotten dangers. A brave scholar must decipher their secrets before they fade into the dust of time.', 'Keeper of Ancient Whispers', 350.00, 2, 'New', '2023-12-22 07:13:34.000000'),
(11, '3', '978-5-678901-33-4', 'City of Clockwork Dreams', 'Gears grind and cogs turn in a metropolis driven by steam and invention. But amongst the towering edifices and clockwork wonders, a young inventor must confront a hidden darkness threatening to unravel the very fabric of the city.', 'Master of Mechanisms', 60.00, 1, 'New', '2023-12-22 07:13:34.000000'),
(12, '3', '978-5-678901-34-5', 'The Enchantress Spell', 'Emerald eyes cast a mesmerizing spell and whispers of forbidden magic dance on the wind. A reluctant hero must break the enchantress hold on their kingdom before she consumes it in a web of dark power.', 'Breaker of Bewitchments', 300.00, 2, 'Used', '2023-12-22 07:13:34.000000'),
(13, '3', '978-5-678901-36-7', 'Stars Beyond the Horizon', 'Amongst the constellations, a hidden gateway beckons with the promise of uncharted wonders. A daring voyager must navigate the celestial currents and confront cosmic entities to reach the stars beyond the horizon.', 'Captain of Starlight', 350.00, 1, 'New', '2023-12-22 07:13:34.000000'),
(14, '3', '978-5-678901-37-8', 'Dreamweaver Lullaby', 'Lullabies of silver moonlight weave reality and dreams into an intricate tapestry. A young orphan, gifted with the power to reshape dreams, must face a nightmarish entity threatening to consume the world in an eternal slumber.', 'Weaver of Slumbering Realms', 280.00, 3, 'Used', '2023-12-22 07:13:34.000000'),
(15, '3', '978-5-678901-38-9', 'Shadows of Destiny', 'Whispers of prophecy twist in the wind, casting long shadows on a kingdom poised at the brink of chaos. A reluctant hero must rise from the darkness and confront their fated destiny, or doom the world to an age of shadows.', 'Harbinger of Fate', 400.00, 2, 'Used', '2023-12-22 07:13:34.000000'),
(16, '3', '0-14-194949-5', 'The Maltese Falcon', 'Sam Spade, a private investigator in San Francisco, is hired to find a priceless jeweled falcon, but he soon finds himself entangled in a web of deceit and murder.', 'Dashiell Hammett', 320.00, 1, 'Used', '2023-12-22 12:06:34.096621'),
(17, '3', '0-394-55808-X', 'The Big Sleep', 'Raymond Chandler\'s classic detective novel follows Philip Marlowe, a private investigator, as he investigates the mysterious disappearance of a wealthy man\'s daughter.', 'Raymond Chandler', 350.00, 2, 'New', '2023-12-22 12:06:34.096621'),
(18, '3', '0-316-32223-X', 'In Cold Blood', 'Truman Capote\'s non-fiction novel recounts the real-life murder of a wealthy farm family in Kansas and the subsequent trial and execution of the killers.', 'Truman Capote', 400.00, 1, 'Used', '2023-12-22 12:06:34.096621'),
(20, '3', '0-399-12327-3', 'The Postman Always Rings Twice', 'Frank Chambers, a drifter, falls in love with Cora Knapp, a married diner waitress. Together, they plot to kill Cora\'s husband and collect the insurance money.', 'James M. Cain', 300.00, 3, 'Used', '2023-12-22 12:06:34.096621');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_carts`
--

CREATE TABLE `tbl_carts` (
  `cart_id` int(5) NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `seller_id` varchar(5) NOT NULL,
  `book_id` varchar(5) NOT NULL,
  `cart_qty` int(5) NOT NULL,
  `cart_status` varchar(10) NOT NULL,
  `cart_date` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_carts`
--

INSERT INTO `tbl_carts` (`cart_id`, `buyer_id`, `seller_id`, `book_id`, `cart_qty`, `cart_status`, `cart_date`) VALUES
(67, '12', '3', '1', 2, 'Delivered', '2024-02-02 03:02:50.053895'),
(68, '12', '3', '1', 1, 'Delivered', '2024-02-02 03:10:48.504041'),
(69, '12', '3', '1', 1, 'Delivered', '2024-02-02 03:10:52.433437'),
(70, '12', '3', '1', 2, 'Delivered', '2024-02-09 02:32:49.789948'),
(71, '12', '3', '1', 1, 'Delivered', '2024-02-10 06:38:34.056513'),
(72, '12', '3', '1', 1, 'Delivered', '2024-02-10 13:59:59.674943'),
(73, '12', '3', '1', 2, 'Delivered', '2024-02-10 14:38:57.946330'),
(74, '12', '2', '4', 1, 'Delivered', '2024-02-10 14:58:08.941422'),
(75, '12', '3', '1', 1, 'Delivered', '2024-02-10 14:58:16.648347'),
(76, '12', '3', '1', 1, 'Delivered', '2024-02-10 15:18:52.741578'),
(77, '12', '2', '4', 1, 'Delivered', '2024-02-10 15:18:59.118034'),
(78, '12', '3', '1', 1, 'Delivered', '2024-02-10 15:20:43.110753'),
(79, '12', '3', '6', 1, 'Delivered', '2024-02-10 16:18:07.123945');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orders`
--

CREATE TABLE `tbl_orders` (
  `order_id` int(5) NOT NULL,
  `buyer_id` varchar(5) NOT NULL,
  `refNum` int(15) NOT NULL,
  `order_total` decimal(5,2) NOT NULL,
  `order_date` varchar(15) NOT NULL,
  `order_status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_orders`
--

INSERT INTO `tbl_orders` (`order_id`, `buyer_id`, `refNum`, `order_total`, `order_date`, `order_status`) VALUES
(23, '12', 158975, 410.00, '01/02/2024', 'SUCCESS'),
(24, '12', 103518, 410.00, '01/02/2024', 'SUCCESS'),
(25, '12', 654057, 410.00, '09/02/2024', 'SUCCESS'),
(26, '12', 514703, 210.00, '09/02/2024', 'SUCCESS'),
(27, '12', 316771, 210.00, '10/02/2024', 'SUCCESS'),
(28, '12', 972877, 470.00, '10/02/2024', 'SUCCESS'),
(29, '12', 545045, 210.00, '10/02/2024', 'FAILURE'),
(30, '12', 882910, 260.00, '10/02/2024', 'SUCCESS');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `user_id` int(11) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_phone` varchar(12) NOT NULL,
  `user_password` varchar(40) NOT NULL,
  `user_datereg` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`user_id`, `user_email`, `user_name`, `user_phone`, `user_password`, `user_datereg`) VALUES
(12, 'yoganraj70@gmail.com', 'Yogan', '0134568578', 'a94006eef3e9e6ff80eb2a20de0b2ff728b57622', '2023-12-10 03:20:20.175724'),
(13, 'Testing@gmail.com', 'Test', '0148569585', '99c884b90f6d2c6086075661a84f11798d0bddf6', '2023-12-10 04:18:48.086122'),
(14, 'Ravi@gmail.com', 'Ravi', '0124785869', '5e0535956c5284c59aec80489d64380a1b30eb40', '2024-02-10 02:47:59.087223');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_books`
--
ALTER TABLE `tbl_books`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `book_isbn` (`book_isbn`);

--
-- Indexes for table `tbl_carts`
--
ALTER TABLE `tbl_carts`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indexes for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_books`
--
ALTER TABLE `tbl_books`
  MODIFY `book_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tbl_carts`
--
ALTER TABLE `tbl_carts`
  MODIFY `cart_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  MODIFY `order_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
