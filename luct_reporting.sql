-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 02, 2025 at 08:37 PM
-- Server version: 8.0.41
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `luct_reporting`
--

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` int NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `course_id` int DEFAULT NULL,
  `lecturer_id` int NOT NULL,
  `venue` varchar(100) NOT NULL,
  `scheduled_time` time NOT NULL,
  `total_registered_students` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`id`, `class_name`, `course_id`, `lecturer_id`, `venue`, `scheduled_time`, `total_registered_students`) VALUES
(5, 'Web Development', 1, 18, 'MM4', '08:00:00', 30),
(6, 'Java Programming', 2, 2, 'MM3', '10:00:00', 25),
(7, 'Data Communications', 3, 3, 'LH3', '12:00:00', 20);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int NOT NULL,
  `faculty_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(20) NOT NULL,
  `semester` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `faculty_id`, `name`, `code`, `semester`) VALUES
(1, 1, 'Diploma in Information Technology', 'DIT', 1),
(2, 1, 'Diploma in Business Information Technology', 'DBIT', 1),
(3, 1, 'Bsc Degree in Business Information Technology', 'BScBIT', 1);

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `id` int NOT NULL,
  `student_id` int NOT NULL,
  `class_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`id`, `student_id`, `class_id`) VALUES
(1, 13, 5);

-- --------------------------------------------------------

--
-- Table structure for table `faculties`
--

CREATE TABLE `faculties` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `faculties`
--

INSERT INTO `faculties` (`id`, `name`) VALUES
(1, 'Faculty of Information Communication Technology');

-- --------------------------------------------------------

--
-- Table structure for table `lecture_reports`
--

CREATE TABLE `lecture_reports` (
  `id` int NOT NULL,
  `class_id` int NOT NULL,
  `week_of_reporting` int NOT NULL,
  `date_of_lecture` date NOT NULL,
  `actual_students_present` int NOT NULL,
  `topic_taught` text NOT NULL,
  `learning_outcomes` text NOT NULL,
  `recommendations` text,
  `prl_feedback` text,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `pl_feedback` text,
  `lecturer_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `lecture_reports`
--

INSERT INTO `lecture_reports` (`id`, `class_id`, `week_of_reporting`, `date_of_lecture`, `actual_students_present`, `topic_taught`, `learning_outcomes`, `recommendations`, `prl_feedback`, `status`, `pl_feedback`, `lecturer_id`) VALUES
(18, 7, 4, '2025-08-30', 50, 'Routing', 'Basic Syntax & Concepts\n\nUnderstand variables, data types, and operators.\n\nUse control structures like if-else, switch, loops (for, while).', 'Practice Regularly\n\nBuild small projects like a to-do list or a calculator.\n\nPractice coding challenges on platforms like HackerRank or LeetCode.', NULL, 'pending', 'good performance', 18),
(19, 6, 4, '2025-09-09', 50, 'OOP concepts', 'Basic Syntax & Concepts\n\nUnderstand variables, data types, and operators.\n\nUse control structures like if-else, switch, loops (for, while).', 'Practice Regularly\n\nBuild small projects like a to-do list or a calculator.\n\nPractice coding challenges on platforms like HackerRank or LeetCode.', NULL, 'pending', 'Great', 18),
(20, 5, 4, '2025-09-28', 54, 'Routing', 'Basic Syntax & Concepts\n\n', 'Practice Regularly\n\n', NULL, 'pending', NULL, 18),
(21, 5, 8, '2025-10-12', 60, 'javascript', 'basics', 'practice regularly', NULL, 'pending', NULL, 18),
(22, 5, 8, '2025-10-12', 60, 'javascript', 'basics', 'practice regularly', NULL, 'pending', NULL, 18),
(23, 5, 8, '2025-10-12', 60, 'javascript', 'basics', 'practice regularly', NULL, 'pending', 'y', 18);

-- --------------------------------------------------------

--
-- Table structure for table `monitoring_logs`
--

CREATE TABLE `monitoring_logs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `action` varchar(255) NOT NULL,
  `target` varchar(100) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `monitoring_logs`
--

INSERT INTO `monitoring_logs` (`id`, `user_id`, `action`, `target`, `timestamp`) VALUES
(2, 13, 'Logged in', 'Student Dashboard', '2025-09-28 13:29:49'),
(3, 14, 'Submitted Lecture Rating', 'Lecture 101', '2025-09-28 13:29:49'),
(4, 18, 'Submitted Report', 'Lecture 101', '2025-09-28 13:29:49'),
(5, 21, 'Reviewed Report', 'Lecture 101', '2025-09-28 13:29:49'),
(6, 22, 'Assigned Course', 'Course: Diploma in Business Information Technology', '2025-09-28 13:29:49'),
(7, 18, 'submitted report', 'report_id:23', '2025-10-01 14:46:11'),
(8, 22, 'submitted PL feedback', 'report_id:23', '2025-10-01 16:53:00');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `rated_entity` varchar(50) NOT NULL,
  `entity_id` int NOT NULL,
  `rating` int NOT NULL,
  `comments` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`id`, `user_id`, `rated_entity`, `entity_id`, `rating`, `comments`, `created_at`) VALUES
(1, 13, 'lecture', 5, 4, 'Good lecture', '2025-09-28 10:03:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','lecturer','prl','pl') NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `faculty_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `name`, `faculty_id`) VALUES
(13, 'ntsoaki', '$2b$10$f4MQALRPfOIkxjxjwCbh7uhoqP4EEwtzbuND9sM0NdjTYjSDjAhKK', 'student', 'Ntsoaki M', 1),
(14, 'mpho', '$2b$10$mmuzAT8Q7WCjRhFqQmo0hu9zBYqtTxXM1cLGAQSijRMBAcRXGU7g2', 'student', 'Mpho M', 1),
(18, 'thato', '$2b$10$XWjc6YyqpU8sWiid6NlBQuhSmqlmqlKT2TZfF.yzhzR7sgbD8XT8G', 'lecturer', 'Thato T', 1),
(21, 'karabo', '$2b$10$/aQhbdE4w.kEzt//mYMDeuoNikoUipfMF5.jnUxB9u/pSVqFaeYjW', 'prl', 'Karabo M', 1),
(22, 'kopano', '$2b$10$AmmgIjP7nsbCrePYxdk3ZO3lTyncPh7eSkwIlT9D6ZrGZY3XQ3UXO', 'pl', 'Kopano M', 1),
(23, 'naleli', '$2b$10$GAEdaE.bgzoGt6N8wpR6R.UoS1waFVGOKTjS98YML6xrwTaKlPam6', 'lecturer', 'Naleli S', NULL),
(24, 'thabo', '$2b$10$XNOxU7gLPG2pESWwwO5Fs.x2cu2OicnpY2xBHQCHtgIuhZqY5d0y6', 'student', 'Thabo p', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_backup`
--

CREATE TABLE `users_backup` (
  `id` int NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','lecturer','prl','pl') NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `faculty_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `users_backup`
--

INSERT INTO `users_backup` (`id`, `username`, `password`, `role`, `name`, `faculty_id`) VALUES
(6, 'bob', '123456', 'lecturer', 'Bob Johnson', NULL),
(7, 'carol', '123456', 'prl', 'Carol Lee', NULL),
(8, 'dave', '123456', 'pl', 'Dave Brown', NULL),
(12, 'ntsoaki', '123456', 'student', 'Ntsoaki Mosebi', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `lecturer_id` (`lecturer_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `faculties`
--
ALTER TABLE `faculties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lecture_reports`
--
ALTER TABLE `lecture_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `monitoring_logs`
--
ALTER TABLE `monitoring_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `faculties`
--
ALTER TABLE `faculties`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lecture_reports`
--
ALTER TABLE `lecture_reports`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `monitoring_logs`
--
ALTER TABLE `monitoring_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`);

--
-- Constraints for table `lecture_reports`
--
ALTER TABLE `lecture_reports`
  ADD CONSTRAINT `lecture_reports_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `monitoring_logs`
--
ALTER TABLE `monitoring_logs`
  ADD CONSTRAINT `monitoring_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
