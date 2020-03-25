-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Мар 25 2020 г., 23:09
-- Версия сервера: 5.7.19
-- Версия PHP: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `exam`
--
CREATE DATABASE IF NOT EXISTS `exam` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `exam`;

-- --------------------------------------------------------

--
-- Структура таблицы `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `permissions` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `groups`
--

INSERT INTO `groups` (`id`, `name`, `permissions`) VALUES
(1, 'Standard user', ''),
(2, 'Administrator', '{\"admin\":1}');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `status`, `email`, `date`, `group_id`, `password`) VALUES
(10, 'vano', 'Статус vano', 'vano@mail.ru', '2020-03-23 19:46:39', 2, '$2y$10$dba5SsaUf/HVcNExLvP.3OzgtTOAc/5w6zEe4APUaKgEelJ0bv4A6'),
(12, 'vasek', 'Статус vasek', 'vasek@mail.ru', '2020-03-23 19:59:34', 1, '$2y$10$hMHuyONTEilAVdMWAHeRzeeVKi4Qbc9NSEd2MCWjETeW8wnkLSb1W'),
(13, 'petr', 'Статус pedro', 'petr@mail.ru', '2020-03-23 20:06:36', 1, '$2y$10$8GZ238ge8y9QB7tT8zCLPOBv14p39ZJdVIA5hZQXksZ9wUzEeFXy6'),
(14, 'vlad', 'Статус vlad', 'vlad@mail.ru', '2020-03-23 20:13:30', 2, '$2y$10$hE0NAJtQ8zAlM/ZiU3qV/eajJLl84zM2KcsqjmD6SbVd5YTASQTxy'),
(15, 'pshava', 'Супер конь', 'pshava@mail.ru', '2020-03-25 20:06:10', 1, '$2y$10$geCujW1heBAFUnHqNOWsDuI7rP91Xa5H3BpFOfNJjBCoItzD5lmy6');

-- --------------------------------------------------------

--
-- Структура таблицы `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `user_sessions`
--

INSERT INTO `user_sessions` (`id`, `user_id`, `hash`) VALUES
(10, 14, '019278a40a6d4f8fadceb9746644ebf599782a5babaf45b8f1589f3eda37b08b');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT для таблицы `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
