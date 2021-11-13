select * from cities ;
alter table profiles add foreign key(city_id) references cities(profiles_id);
alter table profiles drop foreign key profiles_ibfk_2;

# Индекс на ФИО для быстрого поиска
create index first_name_last_name_idx on users(first_name,last_name); 
# Представления
create or replace view orders_id as select orders.id as orders,users.id as users,last_name as last_names from orders join users on users.id = orders.id; # Представление
create or replace view first_name_city as select users.id as users,cities.id as city,name as names from users join cities on users.id = cities.id; # Представление

# Триггер, если пользователь вводит город, в котором нет компании, то выводить сообещния, либо надо таблицу city изначально с городами присутствия.

delimiter //
create trigger before insert on cities
for each row begin 
	if new.name is null or new.name in ('Предполагаю, что здесь список городов,где есть компания')then 
	signal sql '45000'
	set message text= ' К сожалению, компании Спортмастер нет в вашем городе' ;
	end if;
end//

delimiter //
create trigger before update on cities
for each row begin 
	if new.name is null or new.name in ('Предполагаю, что здесь список городов,где есть компания')then 
	signal sql '45000'
	set message text= ' К сожалению, компании Спортмастер нет в вашем городе' ;
	end if;
end//

# Join

select concat(first_name,' ', last_name) as user, name as city,birthday as birthday,gender as gender, ROW_NUMBER() OVER() AS row_numbers
from users 
left join cities on users.id = cities.id
left join profiles on users.id = profiles.user_id
order by row_numbers;


select concat(first_name,' ', last_name) as user,name as city,reason_name as reason_name,order_id as order_id
from users
left join return_orders on users.id = return_orders.id and return_orders.reason_name like 'Ош%'
left join cities on users.id = cities.id order by reason_name desc limit 10;

select 
max(profiles.birthday) over() as youngest_user,
min(profiles.birthday) over() as oldest_user
from profiles limit 1;

select * from return_orders;
select * from users;
select * from profiles;
select * from orders;
select * from cities;
drop table if exists users;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Имя пользователя',
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Фамилия пользователя',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Почта',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Телефон',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# TABLE STRUCTURE FOR: users
#

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (1, 'Irma', 'Borer', 'reilly30@example.org', '(196)156-5478', '2016-10-22 09:34:25', '2018-01-02 03:19:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (2, 'Roman', 'Blick', 'bartoletti.jamir@example.org', '417.163.8439', '2014-04-13 06:26:00', '2021-03-01 09:57:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (3, 'Cathrine', 'Ritchie', 'johnson.emiliano@example.org', '1-338-613-8622', '2014-11-02 22:46:42', '2021-03-16 09:18:26');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (4, 'Ephraim', 'Kulas', 'quentin74@example.com', '1-280-219-4585', '2017-09-12 23:04:37', '2012-04-17 23:33:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (5, 'Eva', 'Luettgen', 'dorthy69@example.net', '728-392-5988', '2018-12-19 07:46:47', '2015-04-21 17:06:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (6, 'Orland', 'Bosco', 'walter.mitchell@example.net', '(206)963-4645x55470', '2019-08-11 05:31:13', '2012-06-11 21:15:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (7, 'Kyleigh', 'Gottlieb', 'letitia.bradtke@example.org', '718-262-7528x41284', '2020-06-30 16:56:58', '2021-02-28 22:24:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (8, 'Joanie', 'Gusikowski', 'reanna.sauer@example.net', '(360)898-3946', '2011-10-09 18:29:25', '2014-04-06 03:15:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (9, 'Marcelo', 'Paucek', 'margarita.grimes@example.net', '462-393-5751', '2015-02-23 03:18:49', '2019-11-05 23:53:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (10, 'Alexandro', 'Murphy', 'ffahey@example.com', '(932)534-8579x6283', '2018-05-30 16:01:13', '2013-08-24 01:25:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (11, 'Alycia', 'Windler', 'hickle.daisha@example.com', '(461)737-2732x5697', '2020-01-05 05:36:01', '2019-01-27 08:47:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (12, 'Dedric', 'Labadie', 'rkozey@example.com', '+87(7)2307831580', '2016-08-08 05:41:53', '2017-12-12 00:44:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (13, 'Alexandrea', 'Prosacco', 'kreichel@example.org', '725.951.9066x288', '2014-09-21 06:24:06', '2016-07-12 12:59:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (14, 'Loy', 'Hartmann', 'vweissnat@example.org', '729-462-4352', '2017-02-08 03:12:57', '2013-05-11 04:28:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (15, 'Constance', 'Willms', 'kling.fermin@example.net', '1-211-984-1074x0360', '2017-02-07 04:46:34', '2013-09-02 10:54:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (16, 'Rosario', 'Conroy', 'wdietrich@example.org', '008.071.5857x881', '2016-04-25 15:48:47', '2014-05-04 04:02:23');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (17, 'Rodrick', 'Stanton', 'nkulas@example.net', '06002366539', '2016-02-18 14:20:44', '2017-07-22 06:04:21');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (18, 'Jacques', 'Runolfsson', 'ppouros@example.com', '(685)892-4892', '2017-09-23 21:21:29', '2018-11-11 00:08:36');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (19, 'Mustafa', 'Green', 'powlowski.kristina@example.com', '1-847-057-5596', '2012-03-01 00:01:35', '2018-06-25 04:11:41');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (20, 'Milan', 'Heaney', 'mireille93@example.net', '+38(3)6251756423', '2019-04-09 08:10:58', '2021-04-25 20:06:41');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (21, 'Drew', 'Farrell', 'funk.sam@example.com', '(300)304-1181', '2013-10-14 14:32:46', '2015-01-13 16:39:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (22, 'Anthony', 'Weimann', 'bayer.mozelle@example.org', '(807)241-6524', '2021-02-12 06:06:36', '2018-10-22 03:05:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (23, 'Ariane', 'Kassulke', 'jo98@example.org', '645-754-8206', '2013-11-06 00:41:13', '2019-10-24 01:53:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (24, 'Lyda', 'Swaniawski', 'beatrice.mcglynn@example.org', '585-237-9120', '2016-05-06 08:25:50', '2016-05-27 21:20:36');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (25, 'Karli', 'Ankunding', 'joanne03@example.com', '505-864-7059x35207', '2014-02-15 15:25:09', '2020-01-30 18:47:21');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (26, 'Claudia', 'Kihn', 'chance.nader@example.net', '464-981-1940', '2017-04-13 08:25:33', '2012-08-02 11:04:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (27, 'Abigayle', 'Balistreri', 'emurray@example.net', '1-512-149-5216x1799', '2019-12-04 18:18:09', '2019-08-06 03:26:41');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (28, 'Hipolito', 'Crona', 'o\'kon.alayna@example.net', '957-428-2838', '2018-12-26 06:13:40', '2013-06-22 14:12:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (29, 'Joannie', 'Zulauf', 'wemard@example.org', '1-765-808-3469x4582', '2020-06-08 21:10:09', '2019-08-18 11:24:29');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (30, 'Larry', 'Satterfield', 'reichert.mireille@example.net', '346.499.3715x03170', '2015-12-28 00:27:51', '2019-11-02 11:15:45');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (31, 'Sean', 'Gottlieb', 'major.volkman@example.org', '08531211436', '2017-11-26 07:34:27', '2020-09-06 23:33:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (32, 'Justine', 'Crooks', 'ngibson@example.net', '(595)755-7514x48953', '2020-06-29 18:35:14', '2017-05-01 04:48:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (33, 'Chloe', 'Erdman', 'sfeeney@example.com', '05367465038', '2019-01-23 01:43:21', '2017-05-22 06:13:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (34, 'Claudia', 'Goldner', 'hanna37@example.com', '857.778.8208x58321', '2013-02-05 04:28:34', '2019-09-18 08:45:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (35, 'Ryann', 'Abernathy', 'rcrooks@example.com', '792-382-1956x4528', '2015-01-02 20:49:58', '2012-02-02 04:06:04');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (36, 'Carrie', 'Gibson', 'alexanne12@example.net', '(760)241-0644', '2014-10-21 10:09:21', '2014-10-09 08:52:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (37, 'Santos', 'Wilkinson', 'ssporer@example.com', '(326)099-4430x09923', '2013-03-22 08:22:04', '2021-05-04 19:48:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (38, 'Augusta', 'Kozey', 'josefina63@example.com', '062-314-0256x746', '2016-06-27 22:30:24', '2013-12-22 06:10:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (39, 'Corrine', 'O\'Keefe', 'kuhn.alene@example.com', '+06(6)1753972169', '2018-12-17 07:22:18', '2015-10-21 06:32:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (40, 'Raven', 'Homenick', 'hintz.lavina@example.net', '1-294-337-0550x5826', '2017-12-26 18:19:44', '2020-12-06 03:16:04');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (41, 'Laney', 'Monahan', 'okuneva.domenick@example.com', '02007741596', '2012-12-11 01:27:33', '2017-11-30 15:04:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (42, 'Turner', 'Hintz', 'will.weber@example.net', '870.757.9912', '2013-02-09 01:42:42', '2020-10-01 12:49:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (43, 'Savannah', 'Osinski', 'aidan61@example.org', '+00(9)0330241048', '2016-07-15 06:41:12', '2018-11-12 17:40:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (44, 'Caleigh', 'Murazik', 'zander37@example.net', '1-732-545-8421x45106', '2015-10-04 13:11:50', '2017-12-11 18:48:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (45, 'Gayle', 'Hand', 'roma.schinner@example.org', '490-792-6263x08130', '2014-05-01 21:48:14', '2015-07-05 22:34:45');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (46, 'Eliezer', 'Howell', 'oswaniawski@example.com', '+60(0)2355854999', '2017-03-19 01:01:25', '2018-05-26 16:26:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (47, 'Constantin', 'Gutmann', 'paxton51@example.com', '+82(2)6602288471', '2016-06-17 03:32:56', '2019-02-19 16:45:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (48, 'Eleanora', 'Kiehn', 'habbott@example.net', '554.575.4656x80467', '2020-03-12 12:35:58', '2018-10-27 23:09:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (49, 'Johathan', 'Hickle', 'rdicki@example.org', '(246)797-4354', '2015-11-16 14:52:32', '2019-12-12 13:02:21');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (50, 'Lavada', 'Romaguera', 'constance76@example.net', '1-271-144-0070', '2019-03-13 00:50:58', '2019-12-02 08:32:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (51, 'Demarco', 'Schowalter', 'maurine.nolan@example.com', '+00(2)1243888088', '2014-06-27 19:13:59', '2016-06-11 23:22:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (52, 'Oleta', 'Spinka', 'kenneth.glover@example.com', '890.407.2700x2993', '2013-01-13 19:21:34', '2014-08-15 01:29:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (53, 'Mireille', 'Walter', 'johnston.adella@example.net', '213.197.9223x690', '2013-02-01 14:07:21', '2013-03-29 09:30:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (54, 'Vicenta', 'Schamberger', 'jadon71@example.com', '(692)461-9956', '2017-08-06 10:52:42', '2013-06-13 11:49:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (55, 'Alva', 'Kshlerin', 'leonor55@example.org', '00230320856', '2015-12-10 12:01:25', '2012-07-21 03:20:19');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (56, 'Shaniya', 'Gerhold', 'maxine.johnston@example.org', '904-920-6513', '2015-10-24 07:06:49', '2020-05-27 19:01:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (57, 'Destiney', 'Armstrong', 'auer.abigail@example.net', '1-381-088-1870x3236', '2019-11-26 01:46:39', '2011-07-09 12:57:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (58, 'Kameron', 'Pagac', 'wilhelmine.abshire@example.org', '328-892-4989x5820', '2020-05-24 15:19:06', '2012-03-04 21:27:08');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (59, 'Orin', 'Terry', 'barrows.nash@example.com', '581.498.5711x12102', '2017-05-02 01:39:44', '2018-02-27 16:55:57');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (60, 'Malinda', 'Leuschke', 'jadyn.king@example.com', '1-522-143-6731x788', '2013-04-26 13:34:29', '2013-06-09 06:05:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (61, 'Orpha', 'Rippin', 'zwalsh@example.net', '(917)936-9147x37003', '2012-03-23 07:53:05', '2020-03-26 21:38:41');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (62, 'Andreane', 'Block', 'hamill.d\'angelo@example.net', '124-448-9600', '2015-05-05 10:21:37', '2015-10-12 09:54:45');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (63, 'Lauriane', 'Boyer', 'tia.gaylord@example.org', '(993)615-6928x771', '2012-02-20 22:24:34', '2020-08-26 03:24:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (64, 'Janis', 'Turner', 'noe.klocko@example.org', '(530)266-4168x182', '2015-01-19 16:37:13', '2015-10-20 10:48:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (65, 'Aniya', 'Daniel', 'kristina44@example.org', '(889)717-1830', '2020-05-03 15:29:04', '2013-11-15 08:36:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (66, 'Amari', 'Jacobson', 'acrona@example.net', '215.973.2793', '2020-12-27 15:00:57', '2013-08-12 10:09:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (67, 'Mossie', 'Leannon', 'taryn.prosacco@example.org', '1-996-066-6724x51897', '2020-10-26 04:38:21', '2012-11-24 20:26:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (68, 'Isabel', 'Gerhold', 'lori.turcotte@example.com', '(343)452-6042x459', '2017-07-17 14:59:10', '2018-08-25 19:41:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (69, 'Amelie', 'Baumbach', 'fbecker@example.org', '1-541-951-5756x20852', '2017-03-30 02:14:36', '2020-07-10 21:53:40');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (70, 'Alfredo', 'Blick', 'friesen.elsa@example.org', '686.250.6774x715', '2011-12-28 01:27:04', '2021-02-25 04:43:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (71, 'Carlee', 'Goyette', 'simeon67@example.com', '1-035-548-8602x346', '2013-11-05 17:29:15', '2019-11-28 09:22:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (72, 'Lulu', 'Herzog', 'adrienne.moore@example.org', '(443)857-5294x71805', '2011-10-21 06:03:27', '2012-09-20 22:51:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (73, 'Guadalupe', 'Larson', 'lakin.lonny@example.com', '879.068.6819x83551', '2011-09-23 18:30:59', '2019-12-02 10:23:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (74, 'Chelsey', 'Mohr', 'zieme.terrence@example.com', '1-659-114-2553x8034', '2012-10-31 22:53:47', '2014-01-03 15:24:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (75, 'Mauricio', 'Schowalter', 'gottlieb.kattie@example.com', '+69(4)7625368349', '2011-10-21 12:56:07', '2014-03-10 05:32:15');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (76, 'Xzavier', 'Mitchell', 'hmuller@example.org', '+63(8)3453090323', '2017-05-01 12:28:03', '2019-01-19 07:57:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (77, 'Bailey', 'Balistreri', 'mdickinson@example.com', '08273547087', '2020-05-13 08:12:23', '2018-09-21 23:53:04');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (78, 'Helga', 'Blick', 'bogisich.jaeden@example.com', '01561171826', '2016-09-27 11:56:02', '2019-03-07 00:03:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (79, 'Gerhard', 'Sanford', 'walsh.augustus@example.net', '063.683.6614x94047', '2020-03-21 04:59:31', '2019-08-25 19:35:02');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (80, 'Reta', 'Rau', 'kara60@example.com', '(489)289-4427x7166', '2017-08-20 04:41:50', '2011-05-24 19:34:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (81, 'Louisa', 'Crooks', 'arvid.kutch@example.com', '1-768-792-0921x12348', '2015-05-05 06:32:59', '2013-05-02 11:29:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (82, 'Leda', 'Toy', 'vyost@example.net', '394.608.0534x36189', '2015-04-19 03:44:02', '2012-08-02 15:49:53');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (83, 'Isaac', 'Marks', 'cortez.wiegand@example.org', '169-540-2926x59739', '2015-04-22 11:43:43', '2019-02-24 14:15:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (84, 'Curt', 'Rippin', 'teresa.turcotte@example.net', '938.621.0167x676', '2017-03-17 22:45:06', '2015-01-23 15:14:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (85, 'Natalie', 'Roberts', 'ztillman@example.com', '210-951-6639x4958', '2012-01-31 13:01:13', '2015-05-04 15:11:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (86, 'Lucius', 'Maggio', 'macejkovic.elvis@example.org', '+31(0)0558889425', '2013-11-17 22:05:56', '2018-01-06 17:09:38');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (87, 'Jermey', 'McClure', 'retha54@example.com', '(866)178-1690x3570', '2021-02-24 17:16:42', '2016-08-26 12:42:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (88, 'Stanton', 'Rath', 'walsh.rocky@example.org', '454.021.5194', '2016-10-01 00:04:07', '2013-01-23 16:53:08');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (89, 'Allison', 'McKenzie', 'xnitzsche@example.org', '+77(8)7662115178', '2016-04-06 00:22:15', '2016-08-20 04:39:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (90, 'Eliane', 'Heidenreich', 'tnienow@example.net', '(265)576-0322', '2017-12-03 18:50:47', '2013-08-16 04:10:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (91, 'Adriana', 'Anderson', 'vaughn.parisian@example.org', '392.354.1270', '2018-05-23 08:31:14', '2019-09-25 15:55:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (92, 'Donato', 'Fadel', 'stracke.jillian@example.com', '620.824.9086', '2016-12-27 02:03:57', '2016-11-26 11:44:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (93, 'Ewell', 'Schowalter', 'lang.bianka@example.org', '195.343.1596x62314', '2018-07-16 09:25:38', '2020-12-08 11:03:03');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (94, 'Arlo', 'Braun', 'weber.rosella@example.net', '281.379.0091', '2014-10-31 15:11:23', '2018-10-13 18:21:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (95, 'Jules', 'Blanda', 'schmitt.shakira@example.com', '+07(0)5936046769', '2014-03-22 16:35:03', '2012-04-01 12:01:53');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (96, 'Robin', 'Stanton', 'brown.dickens@example.com', '840.795.5400', '2019-12-16 05:34:45', '2018-03-17 01:50:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (97, 'Reyna', 'Mills', 'hudson.jaime@example.org', '365-215-1891x2908', '2012-06-18 12:23:49', '2013-03-04 22:52:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (98, 'Wilford', 'Paucek', 'triston09@example.org', '540-617-5699x194', '2013-06-16 03:06:20', '2012-04-26 01:13:23');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (99, 'Julio', 'Hilll', 'nikita.barrows@example.org', '1-875-361-4113x69677', '2014-03-04 14:32:42', '2019-06-25 07:00:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (100, 'Bernie', 'Lehner', 'anabel.wuckert@example.com', '02901819337', '2015-12-25 05:10:37', '2016-06-06 20:24:02');

#
# TABLE STRUCTURE FOR: profiles
#

DROP TABLE IF EXISTS `profiles`;
select * from profiles;
CREATE TABLE `profiles` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на пользователя',
  `gender` enum('M','F') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Пол',
  `birthday` date NOT NULL COMMENT 'Дата рождения',
  `city_id` int(11) NOT NULL COMMENT 'Ссылка на город пользователя',
  `last_login` datetime DEFAULT NULL COMMENT 'Последний вход в систему',
  `personal_discount` enum('30 %') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Скидка у покупателя, const=30%',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (1, 'M', '2013-07-16', 1, '2014-10-04 14:18:12', '30 %', '2018-09-08 02:34:39', '2014-02-08 20:04:05');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (2, 'M', '2015-07-07', 2, '2015-10-01 18:29:11', '30 %', '2020-05-27 08:43:14', '2021-01-03 00:17:54');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (3, 'M', '2017-07-19', 3, '2017-07-24 19:48:13', '30 %', '2011-06-20 12:28:41', '2020-12-28 21:35:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (4, 'M', '2012-05-12', 4, '2011-11-20 00:18:43', '30 %', '2011-09-07 06:24:29', '2016-12-03 10:20:56');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (5, 'F', '2017-07-21', 5, '2017-12-23 15:18:17', '30 %', '2019-11-11 18:55:43', '2013-11-10 15:15:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (6, 'M', '2017-08-04', 6, '2016-03-18 22:12:10', '30 %', '2013-08-21 04:51:40', '2014-03-05 18:52:16');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (7, 'M', '2018-06-18', 7, '2012-08-06 15:19:23', '30 %', '2019-05-24 08:53:21', '2017-07-16 17:14:49');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (8, 'F', '2015-04-27', 8, '2014-02-02 13:15:34', '30 %', '2017-09-11 20:48:12', '2021-02-25 07:53:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (9, 'F', '2017-10-06', 9, '2017-09-01 20:19:31', '30 %', '2014-12-22 15:56:38', '2017-01-26 18:03:24');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (10, 'M', '2012-02-04', 10, '2016-11-04 19:38:20', '30 %', '2014-05-12 20:05:32', '2017-11-15 03:23:50');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (11, 'M', '2017-12-04', 11, '2017-02-27 19:35:36', '30 %', '2017-04-16 13:18:43', '2018-11-23 12:00:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (12, 'M', '2017-02-20', 12, '2013-01-25 11:07:50', '30 %', '2018-12-11 15:50:11', '2015-09-10 10:55:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (13, 'F', '2015-07-17', 13, '2016-11-02 23:07:57', '30 %', '2016-02-25 22:38:15', '2016-08-08 19:02:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (14, 'M', '2020-09-01', 14, '2017-06-27 03:06:56', '30 %', '2020-07-12 12:43:44', '2018-05-08 22:29:03');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (15, 'F', '2018-05-10', 15, '2016-11-28 04:55:22', '30 %', '2012-07-14 08:48:12', '2020-06-22 15:45:18');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (16, 'F', '2016-10-05', 16, '2021-05-12 09:18:15', '30 %', '2013-11-25 10:25:07', '2016-06-01 10:20:03');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (17, 'M', '2020-05-30', 17, '2013-03-13 05:18:19', '30 %', '2012-02-22 12:28:39', '2012-04-28 17:10:04');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (18, 'M', '2019-06-16', 18, '2020-02-24 16:14:19', '30 %', '2012-09-12 07:56:23', '2012-05-16 23:48:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (19, 'M', '2016-03-07', 19, '2018-02-23 17:11:30', '30 %', '2018-05-28 11:07:14', '2013-01-30 16:14:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (20, 'M', '2012-06-19', 20, '2018-04-21 19:50:22', '30 %', '2012-12-06 05:10:25', '2018-10-05 12:34:54');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (21, 'F', '2015-11-06', 21, '2014-08-18 19:52:42', '30 %', '2019-08-01 17:56:52', '2016-09-03 14:38:20');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (22, 'M', '2021-01-25', 22, '2013-04-07 23:38:07', '30 %', '2013-11-26 10:29:58', '2019-07-07 23:39:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (23, 'F', '2015-06-04', 23, '2021-01-03 22:12:49', '30 %', '2015-08-30 13:22:06', '2013-11-21 04:06:12');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (24, 'F', '2021-01-09', 24, '2018-01-07 23:09:32', '30 %', '2016-09-27 00:41:44', '2014-08-18 15:15:20');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (25, 'M', '2012-08-03', 25, '2019-03-23 01:53:24', '30 %', '2012-10-02 21:47:35', '2017-05-18 07:49:19');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (26, 'M', '2013-08-23', 26, '2018-04-09 20:24:25', '30 %', '2012-08-23 09:43:19', '2013-11-13 12:49:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (27, 'M', '2012-09-01', 27, '2013-05-22 06:01:44', '30 %', '2011-07-06 02:59:27', '2012-09-27 04:25:00');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (28, 'M', '2012-12-27', 28, '2019-12-04 16:22:46', '30 %', '2018-11-26 14:51:51', '2019-04-16 15:46:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (29, 'M', '2014-01-30', 29, '2020-08-12 12:50:59', '30 %', '2015-02-19 11:52:01', '2020-10-29 18:51:23');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (30, 'F', '2011-09-15', 30, '2012-11-19 13:48:53', '30 %', '2013-07-22 07:52:51', '2013-04-28 15:11:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (31, 'F', '2015-07-06', 31, '2011-07-18 21:36:15', '30 %', '2011-10-28 06:59:04', '2012-08-15 11:50:26');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (32, 'F', '2018-04-07', 32, '2015-01-13 17:32:45', '30 %', '2016-08-21 07:11:06', '2015-02-06 09:28:44');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (33, 'M', '2016-02-18', 33, '2016-09-22 10:41:18', '30 %', '2013-04-06 19:22:25', '2014-09-03 14:43:15');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (34, 'F', '2015-09-18', 34, '2015-07-26 18:44:42', '30 %', '2020-04-07 15:38:42', '2016-09-05 15:01:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (35, 'M', '2020-05-19', 35, '2015-07-11 10:25:13', '30 %', '2014-02-15 22:21:59', '2020-11-26 21:07:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (36, 'F', '2021-04-03', 36, '2011-12-04 05:35:35', '30 %', '2019-08-21 20:17:54', '2021-03-07 20:00:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (37, 'M', '2019-02-14', 37, '2018-05-25 00:46:29', '30 %', '2020-12-18 17:06:12', '2013-02-01 01:06:31');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (38, 'F', '2012-07-26', 38, '2018-12-28 01:49:15', '30 %', '2012-01-20 16:33:08', '2013-07-15 15:21:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (39, 'F', '2017-01-12', 39, '2019-11-26 19:26:38', '30 %', '2018-10-16 03:01:28', '2011-08-06 02:30:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (40, 'M', '2014-07-30', 40, '2011-09-18 05:06:27', '30 %', '2014-11-08 00:38:35', '2016-12-09 06:04:31');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (41, 'F', '2011-11-07', 41, '2019-02-05 20:50:33', '30 %', '2013-07-15 14:13:54', '2011-09-21 10:54:53');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (42, 'F', '2012-03-02', 42, '2017-05-06 12:04:57', '30 %', '2020-09-04 02:36:25', '2015-08-05 13:32:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (43, 'M', '2019-04-20', 43, '2019-04-22 21:44:43', '30 %', '2013-01-05 22:54:06', '2020-11-03 16:40:33');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (44, 'F', '2014-10-12', 44, '2012-09-17 10:39:41', '30 %', '2015-04-29 12:43:07', '2017-09-29 03:52:05');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (45, 'F', '2011-11-05', 45, '2013-12-31 02:44:00', '30 %', '2016-01-13 17:41:42', '2018-01-25 11:01:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (46, 'M', '2020-02-29', 46, '2019-07-01 15:01:14', '30 %', '2014-07-13 10:26:30', '2017-11-26 17:34:48');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (47, 'F', '2016-01-24', 47, '2014-02-20 21:36:08', '30 %', '2019-04-09 04:32:21', '2020-12-21 04:23:38');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (48, 'M', '2013-12-08', 48, '2016-12-16 20:31:50', '30 %', '2011-09-26 10:32:27', '2011-11-16 11:12:36');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (49, 'F', '2013-08-01', 49, '2020-06-26 01:35:58', '30 %', '2013-12-20 12:35:36', '2011-07-07 19:12:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (50, 'F', '2011-12-18', 50, '2016-07-09 01:07:08', '30 %', '2020-07-26 19:14:43', '2018-05-07 04:12:01');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (51, 'M', '2015-04-04', 51, '2014-07-18 16:16:02', '30 %', '2013-03-30 10:35:09', '2018-10-01 22:38:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (52, 'F', '2011-10-08', 52, '2019-10-19 06:07:36', '30 %', '2012-12-15 10:43:02', '2012-07-03 14:19:36');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (53, 'F', '2018-10-26', 53, '2014-04-05 12:46:07', '30 %', '2012-06-19 10:16:09', '2012-04-09 19:12:09');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (54, 'F', '2015-12-06', 54, '2012-02-04 06:31:53', '30 %', '2015-02-15 10:46:34', '2013-07-12 11:24:10');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (55, 'M', '2018-07-14', 55, '2015-02-18 07:07:03', '30 %', '2018-11-11 07:06:30', '2014-10-22 20:37:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (56, 'M', '2017-01-06', 56, '2020-10-06 04:58:35', '30 %', '2018-10-01 10:33:33', '2014-10-18 08:26:04');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (57, 'M', '2014-08-26', 57, '2013-08-23 06:43:28', '30 %', '2013-05-12 22:44:52', '2020-09-16 16:04:26');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (58, 'F', '2015-03-17', 58, '2012-10-23 18:59:34', '30 %', '2019-12-20 21:44:15', '2020-03-08 10:16:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (59, 'F', '2019-05-04', 59, '2012-12-21 13:27:54', '30 %', '2012-03-08 06:50:00', '2017-04-21 00:10:31');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (60, 'F', '2017-02-22', 60, '2014-04-06 01:35:53', '30 %', '2011-12-26 14:32:37', '2013-12-25 04:07:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (61, 'F', '2011-08-07', 61, '2016-02-16 14:19:55', '30 %', '2014-11-19 09:30:16', '2016-02-02 14:07:48');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (62, 'F', '2014-10-18', 62, '2011-08-17 05:27:03', '30 %', '2018-05-24 08:52:17', '2020-04-10 16:22:08');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (63, 'M', '2020-10-19', 63, '2015-02-10 13:28:46', '30 %', '2012-11-29 08:47:31', '2015-12-06 15:50:26');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (64, 'F', '2017-03-28', 64, '2016-08-05 06:28:49', '30 %', '2015-12-07 20:46:35', '2021-05-24 06:22:12');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (65, 'F', '2013-02-26', 65, '2016-02-24 03:33:42', '30 %', '2013-07-21 13:36:44', '2014-07-12 03:07:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (66, 'F', '2016-02-08', 66, '2019-09-02 10:37:12', '30 %', '2018-01-21 15:07:00', '2015-02-26 05:59:24');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (67, 'F', '2013-06-06', 67, '2021-05-17 22:02:19', '30 %', '2018-09-08 03:37:16', '2016-10-24 10:24:58');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (68, 'F', '2015-05-09', 68, '2019-07-16 05:12:33', '30 %', '2021-01-18 00:39:38', '2014-03-04 13:04:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (69, 'F', '2020-12-31', 69, '2013-03-30 02:48:11', '30 %', '2019-01-05 03:18:10', '2018-12-31 11:27:57');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (70, 'F', '2019-03-18', 70, '2019-09-15 22:06:35', '30 %', '2012-10-07 01:50:19', '2014-03-24 19:37:38');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (71, 'M', '2020-08-17', 71, '2012-07-27 03:37:20', '30 %', '2013-01-13 20:27:30', '2021-01-24 08:08:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (72, 'M', '2015-05-31', 72, '2013-05-30 10:56:23', '30 %', '2020-10-07 15:01:04', '2020-08-15 12:29:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (73, 'M', '2016-11-07', 73, '2018-08-08 23:23:53', '30 %', '2015-08-17 04:03:36', '2013-06-04 15:46:58');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (74, 'M', '2014-01-11', 74, '2013-02-08 13:06:23', '30 %', '2011-10-30 01:07:26', '2012-02-10 21:17:13');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (75, 'F', '2015-09-13', 75, '2015-06-22 17:35:49', '30 %', '2013-02-23 00:17:20', '2015-03-06 08:44:36');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (76, 'M', '2015-12-13', 76, '2020-12-19 22:47:45', '30 %', '2011-10-03 23:17:36', '2019-11-05 16:34:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (77, 'F', '2021-04-21', 77, '2019-11-22 10:06:06', '30 %', '2021-02-13 22:12:58', '2016-01-24 20:12:01');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (78, 'F', '2020-12-25', 78, '2011-09-11 14:15:25', '30 %', '2019-01-27 10:51:49', '2015-03-02 16:38:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (79, 'F', '2019-03-19', 79, '2015-10-11 22:59:28', '30 %', '2015-01-22 20:42:08', '2011-12-05 09:41:18');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (80, 'M', '2011-06-12', 80, '2018-12-05 11:03:05', '30 %', '2017-10-31 19:31:32', '2019-06-15 16:39:30');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (81, 'F', '2015-12-10', 81, '2017-06-03 16:56:37', '30 %', '2012-01-07 07:40:46', '2013-12-17 04:59:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (82, 'M', '2020-07-19', 82, '2011-08-23 20:59:39', '30 %', '2019-02-09 07:44:29', '2011-10-02 23:06:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (83, 'M', '2018-06-08', 83, '2017-12-04 23:16:06', '30 %', '2018-01-16 10:09:56', '2017-03-15 11:46:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (84, 'F', '2016-02-25', 84, '2012-04-29 09:19:03', '30 %', '2018-02-21 18:17:34', '2016-05-25 10:15:58');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (85, 'M', '2015-02-05', 85, '2018-03-21 04:02:08', '30 %', '2017-11-04 18:06:54', '2018-04-25 17:44:54');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (86, 'F', '2013-12-21', 86, '2016-12-11 14:04:08', '30 %', '2012-03-05 17:00:08', '2017-07-20 01:59:56');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (87, 'F', '2019-01-15', 87, '2020-06-23 21:04:04', '30 %', '2012-04-21 14:40:53', '2017-07-06 05:23:16');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (88, 'M', '2012-07-23', 88, '2011-06-21 04:40:24', '30 %', '2018-05-27 17:27:53', '2012-01-27 13:01:07');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (89, 'F', '2012-10-05', 89, '2016-05-14 05:11:17', '30 %', '2020-02-02 05:14:36', '2019-11-10 02:37:49');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (90, 'F', '2013-12-24', 90, '2013-03-11 22:07:42', '30 %', '2013-04-11 14:46:50', '2015-04-08 13:08:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (91, 'F', '2012-07-25', 91, '2011-07-20 11:37:37', '30 %', '2019-10-26 17:21:15', '2013-12-10 04:38:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (92, 'M', '2015-01-07', 92, '2018-08-09 08:33:15', '30 %', '2012-10-09 08:44:43', '2018-08-22 19:39:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (93, 'M', '2016-01-02', 93, '2017-10-27 01:03:22', '30 %', '2013-11-08 10:09:21', '2014-08-31 02:17:49');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (94, 'F', '2016-05-15', 94, '2016-01-20 16:54:42', '30 %', '2016-08-25 10:03:40', '2021-05-15 17:51:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (95, 'F', '2013-04-21', 95, '2015-02-16 23:34:05', '30 %', '2021-01-01 06:57:58', '2012-05-07 18:57:09');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (96, 'F', '2019-12-20', 96, '2014-06-21 15:25:28', '30 %', '2012-04-01 01:01:23', '2017-01-15 04:40:14');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (97, 'F', '2011-10-26', 97, '2014-02-08 14:14:17', '30 %', '2013-11-21 23:01:38', '2012-12-09 03:52:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (98, 'M', '2018-04-24', 98, '2016-07-15 21:30:17', '30 %', '2011-05-25 06:32:29', '2013-06-23 02:39:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (99, 'F', '2012-10-05', 99, '2012-02-11 01:00:02', '30 %', '2017-12-27 20:47:38', '2015-03-29 19:54:30');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `city_id`, `last_login`, `personal_discount`, `created_at`, `updated_at`) VALUES (100, 'M', '2019-10-26', 100, '2012-10-16 12:39:09', '30 %', '2011-08-08 05:18:59', '2016-10-28 11:44:52');

DROP TABLE IF EXISTS `cities`;
select * from cities;
CREATE TABLE `cities` (
  `id` int(10) unsigned NOT NULL  COMMENT 'Идентификатор города',
  `profiles_id` int(11) not null COMMENT 'Ссылка на пользователя',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название города',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  PRIMARY KEY (`profiles_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (1,1, 'Utah', '2018-04-11 23:47:54');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) values (2,2, 'Oklahoma', '2021-02-11 15:26:24');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (3,3, 'NorthCarolina', '2011-10-30 19:33:11');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) values (4,4, 'California', '2019-04-22 04:15:48');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) values (5,5, 'Illinois', '2021-05-05 20:39:30');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) values (6,6, 'Mississippi', '2020-06-21 09:52:35');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) values (7,7, 'WestVirginia', '2012-07-10 10:25:48');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) values (8,8, 'NorthCarolina', '2011-09-09 19:57:36');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) values (9,9, 'Wisconsin', '2018-11-06 05:34:03');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (10,10, 'Michigan', '2020-10-24 22:57:56');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (11,11, 'Connecticut', '2021-01-17 13:59:50');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (12,12, 'NorthCarolina', '2020-03-03 19:18:00');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (13,13, 'Nebraska', '2020-10-02 08:20:10');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (14,14, 'SouthDakota', '2013-09-22 11:40:56');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (15,15, 'Kansas', '2018-06-19 13:37:21');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (16,16, 'Alaska', '2020-11-01 14:49:39');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (17,17, 'Texas', '2020-03-31 21:29:01');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (18,18, 'Illinois', '2018-11-03 04:45:19');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (19,19, 'NewJersey', '2017-07-13 09:24:33');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (20,20, 'Ohio', '2017-02-19 21:55:34');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (21,21, 'Delaware', '2017-01-18 19:43:25');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (22,22, 'Washington', '2020-10-18 12:37:47');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (23,23, 'Utah', '2014-03-11 02:44:07');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (24,24, 'NewJersey', '2015-03-31 02:15:47');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (25, 25,'Texas', '2012-09-16 10:43:03');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) values (26,26, 'Maryland', '2013-09-06 01:55:16');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (27,27, 'NewHampshire', '2019-03-11 16:14:18');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (28,28, 'Wyoming', '2018-11-11 14:23:26');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (29,29, 'Virginia', '2011-09-30 19:28:09');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (30,30, 'California', '2015-02-21 17:38:52');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (31,31, 'NorthCarolina', '2019-06-18 23:31:18');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (32,32, 'Pennsylvania', '2018-08-21 21:08:56');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (33,33, 'Alaska', '2020-10-25 12:26:31');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (34,34, 'Colorado', '2015-06-26 21:54:39');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (35,35, 'NewYork', '2018-02-07 11:18:15');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (36,36, 'Arkansas', '2018-03-30 17:24:08');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (37,37, 'Louisiana', '2014-11-11 22:57:09');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (38, 38,'Mississippi', '2016-03-05 21:44:55');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (39,39, 'Washington', '2015-06-21 08:14:19');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (40,40, 'Massachusetts', '2015-07-12 13:12:46');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (41,41, 'Georgia', '2019-09-30 11:14:07');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (42,42, 'District of Columbia', '2015-07-28 04:38:14');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (43,43, 'Ohio', '2014-10-01 08:24:14');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (44,44, 'Maryland', '2016-07-08 20:38:10');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (45,45, 'Florida', '2021-03-22 09:23:07');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (46, 46,'Maryland', '2013-08-06 03:54:09');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (47,47, 'Wisconsin', '2019-01-12 06:18:27');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (48,48, 'Arizona', '2011-07-08 03:58:14');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (49, 49,'Montana', '2018-03-04 09:02:18');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (50, 50,'Minnesota', '2013-08-20 06:52:15');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (51,51, 'Pennsylvania', '2016-05-16 16:13:02');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (52,52, 'Massachusetts', '2015-09-30 00:59:15');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (53,53,  'NewHampshire', '2016-11-13 13:45:13');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (54,54, 'Idaho', '2021-01-31 13:44:01');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (55,55, 'Montana', '2018-04-14 02:17:27');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (56,56, 'Nebraska', '2014-03-21 21:58:54');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (57,57, 'NorthDakota', '2015-01-23 17:06:51');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (58,58, 'NewYork', '2017-04-15 13:58:25');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (59,59, 'Michigan', '2012-02-07 18:40:48');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) values (60,60, 'Washington', '2012-11-09 22:40:25');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (61,61, 'Missouri', '2019-04-16 22:08:04');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (62,62, 'Colorado', '2017-05-06 05:04:44');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (63,63, 'Georgia', '2020-08-30 09:56:55');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (64,64, 'Maryland', '2014-11-07 12:16:20');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (65,65, 'Massachusetts', '2017-04-08 22:49:55');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (66,66, 'NewHampshire', '2015-09-26 03:01:26');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (67,67, 'District of Columbia', '2016-07-22 11:40:01');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (68,68, 'WestVirginia', '2014-01-02 04:50:22');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (69,69,  'Utah', '2012-01-13 23:21:44');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (70,70, 'Colorado', '2019-02-12 08:12:06');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (71,71, 'Michigan', '2018-02-10 16:57:49');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (72,72, 'Oklahoma', '2021-03-29 06:30:03');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (73,73, 'SouthCarolina', '2016-12-24 04:08:37');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (74,74, 'Maine', '2012-05-11 16:58:07');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (75,75, 'Florida', '2019-01-02 01:40:05');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (76,76, 'Utah', '2015-04-03 23:59:21');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (77,77, 'NewYork', '2017-11-12 11:46:55');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (78, 78,'NewMexico', '2017-02-26 16:55:34');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (79,79, 'Maryland', '2015-03-08 06:08:24');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (80,80, 'Alaska', '2015-03-21 17:45:18');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (81,81,  'Michigan', '2013-12-11 22:05:33');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (82,82, 'Wyoming', '2017-01-16 00:12:08');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (83,83, 'Massachusetts', '2017-02-22 20:52:01');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (84,84, 'Utah', '2015-04-18 06:26:34');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (85,85, 'Oregon', '2019-04-04 00:10:05');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (86,86, 'California', '2013-01-20 12:23:12');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (87,87,  'NewYork', '2016-09-17 02:07:06');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (88, 88,'California', '2012-05-15 19:51:38');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (89,89, 'Kentucky', '2017-02-19 14:13:21');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (90,90, 'Pennsylvania', '2020-09-30 10:55:18');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (91,91, 'Connecticut', '2017-12-03 14:31:35');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (92,92, 'Oklahoma', '2020-11-03 19:21:21');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (93,93, 'Kansas', '2018-04-23 23:33:26');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (94,94, 'Colorado', '2012-08-30 01:40:33');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (95, 95,'Indiana', '2018-04-30 11:36:05');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (96,96, 'Hawaii', '2015-01-29 08:54:57');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (97, 97,'RhodeIsland', '2017-08-14 13:44:05');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (98, 98,'Tennessee', '2020-02-19 08:58:11');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (99,99, 'Michigan', '2017-04-17 13:20:04');
INSERT INTO `cities` (`id`,`profiles_id`, `name`, `created_at`) VALUES (100, 100,'Montana', '2013-06-23 17:52:29');

drop table `categories` if exists;

CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `option` enum('Одежда для активного отдыха','Обувь для спорта','Тренажёры','Велоспорт','Аксессуары','Всё для детей','Активные виды спорта') COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender_option` enum('M','F','Unisex') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Разделы товаров',
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Описание товара',
  `price` int(10) unsigned NOT NULL COMMENT 'Цена',
  `warehouse_quantity` int(10) unsigned NOT NULL COMMENT 'Остаток на складе',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `option` (`option`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `option`, `gender_option`, `description`, `price`, `warehouse_quantity`, `created_at`, `updated_at`) VALUES (1, 'Активные виды спорта', 'Unisex', 'Quia nesciunt voluptatem omnis aut rerum veniam. Id ducimus hic illum. Corporis fugiat praesentium non iste autem ut.', 5, 9, '2018-12-07 01:13:04', '2017-04-10 18:04:22');
INSERT INTO `categories` (`id`, `option`, `gender_option`, `description`, `price`, `warehouse_quantity`, `created_at`, `updated_at`) VALUES (2, 'Одежда для активного отдыха', 'F', 'Tempore modi distinctio iste enim consectetur vel. Asperiores deserunt delectus minima beatae. Est et ad odit.', 33420, 3, '2015-02-06 13:22:18', '2016-01-16 19:37:28');
INSERT INTO `categories` (`id`, `option`, `gender_option`, `description`, `price`, `warehouse_quantity`, `created_at`, `updated_at`) VALUES (3, 'Обувь для спорта', 'Unisex', 'Id magni suscipit ratione laboriosam. Et officia et nemo saepe quo. Commodi et doloremque necessitatibus ut qui. Et dolores perferendis qui expedita placeat sed ea.', 164, 6, '2016-08-05 10:33:41', '2012-06-13 12:27:49');
INSERT INTO `categories` (`id`, `option`, `gender_option`, `description`, `price`, `warehouse_quantity`, `created_at`, `updated_at`) VALUES (4, 'Велоспорт', 'F', 'Enim et eveniet optio at cumque eaque sit. Et error et dicta expedita error. In iure iure quos hic.', 11, 8, '2014-08-03 01:19:35', '2012-04-10 06:40:07');
INSERT INTO `categories` (`id`, `option`, `gender_option`, `description`, `price`, `warehouse_quantity`, `created_at`, `updated_at`) VALUES (5, 'Всё для детей', 'M', 'Sed possimus ratione blanditiis laboriosam sunt molestiae quidem sit. Officia consequatur quia ipsum. Tempora dolore repudiandae omnis earum fugit. Veritatis reiciendis et nam rem eum.', 8, 1, '2012-11-24 08:58:09', '2019-09-23 09:20:06');
INSERT INTO `categories` (`id`, `option`, `gender_option`, `description`, `price`, `warehouse_quantity`, `created_at`, `updated_at`) VALUES (6, 'Тренажёры', 'M', 'Natus neque esse minima beatae culpa. Voluptatem non corporis quam quidem tenetur. Nulla ea error ea quo numquam consequatur nesciunt voluptatem.', 46, 3, '2011-10-27 01:04:29', '2019-07-30 14:18:09');
INSERT INTO `categories` (`id`, `option`, `gender_option`, `description`, `price`, `warehouse_quantity`, `created_at`, `updated_at`) VALUES (7, 'Аксессуары', 'M', 'Aut qui aut molestiae et illum. Vel rerum asperiores quod qui et. Explicabo totam magni voluptas molestiae vel officiis velit eum. Dolorem quis aliquam nisi rerum quia.', 18843, 6, '2015-05-05 04:36:28', '2013-04-30 02:50:55');

#
# TABLE STRUCTURE FOR: orders
#

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Cсылка на пользователя',
  `category_id` int(10) unsigned NOT NULL COMMENT 'Всё о товаре',
  `status` enum('Оплачен','Ожидает оплаты','Отменен') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Статус заказа',
  `city_id` int(11) NOT NULL COMMENT 'Город заказа',
  `discount_on_bonus_card` enum('30%') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Скидка на товар, она всегда 30%, в зависимости от остатка бонусов у человека',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT orders_ibfk_1 FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (1, 1, 1, 'Ожидает оплаты', 1, '30%', '2012-04-16 05:27:39', '2013-03-29 03:10:35');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (2, 2, 2, 'Отменен', 2, '30%', '2019-10-21 06:05:36', '2020-08-11 03:54:38');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (3, 3, 3, 'Отменен', 3, '30%', '2018-05-13 00:59:22', '2019-04-30 23:55:48');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (4, 4, 4, 'Ожидает оплаты', 4, '30%', '2014-04-15 06:14:28', '2020-11-06 21:50:10');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (5, 5, 5, 'Отменен', 5, '30%', '2020-02-21 14:12:33', '2015-08-07 10:02:12');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (6, 6, 6, 'Оплачен', 6, '30%', '2014-03-03 17:27:58', '2018-07-18 22:43:23');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (7, 7, 7, 'Оплачен', 7, '30%', '2013-12-09 20:20:22', '2020-08-05 08:05:49');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (8, 8, 1, 'Ожидает оплаты', 8, '30%', '2012-04-14 21:07:18', '2012-04-14 11:46:07');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (9, 9, 2, 'Оплачен', 9, '30%', '2015-04-13 18:24:42', '2013-01-17 15:29:06');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (10, 10, 3, 'Оплачен', 10, '30%', '2013-12-06 13:55:12', '2018-08-15 22:55:44');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (11, 11, 4, 'Отменен', 11, '30%', '2020-03-12 16:01:15', '2020-08-04 08:56:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (12, 12, 5, 'Отменен', 12, '30%', '2013-07-07 06:03:06', '2012-05-11 05:15:19');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (13, 13, 6, 'Оплачен', 13, '30%', '2021-03-08 06:17:11', '2013-02-26 00:28:10');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (14, 14, 7, 'Ожидает оплаты', 14, '30%', '2013-03-06 19:12:36', '2013-08-08 20:03:22');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (15, 15, 1, 'Ожидает оплаты', 15, '30%', '2020-11-18 07:12:34', '2021-04-30 09:21:32');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (16, 16, 2, 'Отменен', 16, '30%', '2011-11-11 20:57:36', '2012-11-13 17:18:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (17, 17, 3, 'Отменен', 17, '30%', '2014-05-23 00:16:39', '2015-08-30 06:15:27');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (18, 18, 4, 'Оплачен', 18, '30%', '2020-02-18 04:04:34', '2015-01-14 10:59:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (19, 19, 5, 'Отменен', 19, '30%', '2019-12-28 01:34:36', '2014-05-07 06:41:36');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (20, 20, 6, 'Ожидает оплаты', 20, '30%', '2016-12-23 07:18:28', '2013-03-23 02:32:19');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (21, 21, 7, 'Оплачен', 21, '30%', '2017-11-01 18:08:01', '2014-06-20 07:41:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (22, 22, 1, 'Ожидает оплаты', 22, '30%', '2017-03-21 11:49:05', '2015-04-05 16:12:58');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (23, 23, 2, 'Оплачен', 23, '30%', '2016-09-16 18:29:55', '2014-07-25 05:25:16');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (24, 24, 3, 'Отменен', 24, '30%', '2017-10-29 22:37:30', '2013-06-28 03:52:52');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (25, 25, 4, 'Отменен', 25, '30%', '2012-11-06 23:41:41', '2014-02-18 09:45:30');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (26, 26, 5, 'Отменен', 26, '30%', '2014-07-14 01:10:29', '2013-08-09 02:06:49');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (27, 27, 6, 'Отменен', 27, '30%', '2020-02-15 05:46:06', '2015-04-03 02:42:00');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (28, 28, 7, 'Оплачен', 28, '30%', '2019-03-21 15:02:12', '2019-05-29 11:57:13');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (29, 29, 1, 'Отменен', 29, '30%', '2019-05-09 04:45:06', '2011-11-06 14:46:34');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (30, 30, 2, 'Отменен', 30, '30%', '2012-07-31 02:58:43', '2012-01-30 23:44:20');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (31, 31, 3, 'Оплачен', 31, '30%', '2014-09-14 01:30:26', '2018-12-09 00:53:40');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (32, 32, 4, 'Ожидает оплаты', 32, '30%', '2020-11-21 07:45:55', '2019-02-23 21:47:03');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (33, 33, 5, 'Оплачен', 33, '30%', '2011-10-19 12:27:11', '2011-12-23 02:38:52');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (34, 34, 6, 'Ожидает оплаты', 34, '30%', '2014-08-07 02:16:18', '2014-04-26 05:23:12');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (35, 35, 7, 'Ожидает оплаты', 35, '30%', '2013-12-17 10:22:02', '2018-12-21 01:57:13');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (36, 36, 1, 'Ожидает оплаты', 36, '30%', '2013-04-21 16:41:36', '2014-10-16 18:08:40');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (37, 37, 2, 'Отменен', 37, '30%', '2020-12-09 08:59:02', '2017-05-11 07:35:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (38, 38, 3, 'Отменен', 38, '30%', '2011-07-25 07:30:54', '2013-10-01 15:11:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (39, 39, 4, 'Ожидает оплаты', 39, '30%', '2019-02-12 05:40:06', '2019-05-14 22:15:05');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (40, 40, 5, 'Ожидает оплаты', 40, '30%', '2020-04-18 03:47:57', '2011-06-09 16:19:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (41, 41, 6, 'Оплачен', 41, '30%', '2018-07-01 11:42:24', '2017-11-04 03:17:38');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (42, 42, 7, 'Ожидает оплаты', 42, '30%', '2011-10-07 21:15:47', '2020-11-23 16:23:19');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (43, 43, 1, 'Отменен', 43, '30%', '2012-09-07 18:39:53', '2011-10-06 23:40:38');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (44, 44, 2, 'Отменен', 44, '30%', '2019-01-02 02:40:52', '2017-01-31 02:39:17');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (45, 45, 3, 'Отменен', 45, '30%', '2017-09-21 08:58:45', '2016-07-07 09:18:24');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (46, 46, 4, 'Оплачен', 46, '30%', '2014-10-27 19:39:02', '2015-05-03 23:56:16');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (47, 47, 5, 'Отменен', 47, '30%', '2016-01-29 02:30:15', '2015-06-03 10:43:45');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (48, 48, 6, 'Отменен', 48, '30%', '2017-07-26 04:29:41', '2012-01-09 15:57:12');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (49, 49, 7, 'Ожидает оплаты', 49, '30%', '2014-03-13 11:13:42', '2013-12-18 09:50:35');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (50, 50, 1, 'Ожидает оплаты', 50, '30%', '2017-03-11 14:58:26', '2020-09-04 07:08:02');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (51, 51, 2, 'Оплачен', 51, '30%', '2012-09-11 09:17:03', '2018-02-27 05:57:51');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (52, 52, 3, 'Оплачен', 52, '30%', '2015-07-07 11:32:37', '2014-07-23 11:20:24');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (53, 53, 4, 'Ожидает оплаты', 53, '30%', '2017-07-17 23:49:10', '2019-11-04 15:32:15');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (54, 54, 5, 'Отменен', 54, '30%', '2017-03-12 01:06:26', '2014-12-17 07:55:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (55, 55, 6, 'Оплачен', 55, '30%', '2015-06-09 18:24:00', '2013-07-16 05:40:29');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (56, 56, 7, 'Оплачен', 56, '30%', '2015-12-11 02:33:53', '2018-05-10 10:56:14');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (57, 57, 1, 'Отменен', 57, '30%', '2014-02-19 16:16:47', '2019-07-02 17:14:35');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (58, 58, 2, 'Отменен', 58, '30%', '2021-05-24 08:56:38', '2011-07-09 15:29:14');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (59, 59, 3, 'Ожидает оплаты', 59, '30%', '2014-04-30 21:01:54', '2014-11-18 09:55:51');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (60, 60, 4, 'Оплачен', 60, '30%', '2011-07-29 11:29:04', '2016-07-10 23:42:56');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (61, 61, 5, 'Отменен', 61, '30%', '2017-12-02 13:36:55', '2016-01-11 14:10:39');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (62, 62, 6, 'Отменен', 62, '30%', '2019-10-21 01:31:03', '2012-01-06 00:46:11');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (63, 63, 7, 'Отменен', 63, '30%', '2018-03-11 15:21:32', '2015-10-28 16:29:02');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (64, 64, 1, 'Оплачен', 64, '30%', '2020-04-17 13:10:28', '2020-09-01 08:21:27');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (65, 65, 2, 'Оплачен', 65, '30%', '2013-09-15 08:31:54', '2014-10-19 17:50:57');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (66, 66, 3, 'Ожидает оплаты', 66, '30%', '2020-07-04 13:12:52', '2015-07-25 01:05:41');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (67, 67, 4, 'Отменен', 67, '30%', '2018-05-16 16:00:08', '2018-11-04 20:02:32');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (68, 68, 5, 'Ожидает оплаты', 68, '30%', '2015-10-03 02:54:47', '2012-02-13 20:29:58');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (69, 69, 6, 'Оплачен', 69, '30%', '2019-08-20 13:57:32', '2018-12-26 20:07:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (70, 70, 7, 'Оплачен', 70, '30%', '2016-05-26 10:42:18', '2012-05-20 19:30:23');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (71, 71, 1, 'Оплачен', 71, '30%', '2017-02-15 04:23:19', '2020-03-17 23:03:09');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (72, 72, 2, 'Ожидает оплаты', 72, '30%', '2017-05-08 05:02:49', '2013-02-20 11:21:35');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (73, 73, 3, 'Оплачен', 73, '30%', '2015-07-17 09:33:54', '2015-08-08 18:56:46');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (74, 74, 4, 'Отменен', 74, '30%', '2015-02-20 07:24:15', '2020-11-10 09:26:47');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (75, 75, 5, 'Отменен', 75, '30%', '2013-08-12 09:09:29', '2014-06-22 22:34:22');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (76, 76, 6, 'Отменен', 76, '30%', '2013-03-11 09:03:06', '2014-05-25 20:51:00');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (77, 77, 7, 'Ожидает оплаты', 77, '30%', '2020-11-07 13:42:12', '2019-12-10 02:47:59');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (78, 78, 1, 'Отменен', 78, '30%', '2017-04-04 22:56:40', '2016-11-27 12:04:28');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (79, 79, 2, 'Отменен', 79, '30%', '2013-09-15 06:50:01', '2014-05-04 21:38:42');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (80, 80, 3, 'Оплачен', 80, '30%', '2021-01-01 13:00:08', '2013-05-20 22:36:09');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (81, 81, 4, 'Ожидает оплаты', 81, '30%', '2017-03-27 08:55:47', '2018-04-25 22:05:18');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (82, 82, 5, 'Отменен', 82, '30%', '2019-04-15 11:27:40', '2016-02-09 00:16:06');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (83, 83, 6, 'Отменен', 83, '30%', '2019-06-28 21:56:17', '2015-12-13 08:58:45');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (84, 84, 7, 'Ожидает оплаты', 84, '30%', '2017-10-27 05:43:34', '2016-07-25 21:22:55');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (85, 85, 1, 'Ожидает оплаты', 85, '30%', '2021-03-17 18:06:02', '2021-04-25 07:06:26');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (86, 86, 2, 'Отменен', 86, '30%', '2011-09-19 19:46:48', '2014-07-28 12:07:28');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (87, 87, 3, 'Оплачен', 87, '30%', '2014-01-19 03:18:02', '2015-12-11 14:29:17');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (88, 88, 4, 'Оплачен', 88, '30%', '2021-04-19 19:13:58', '2018-01-02 11:45:34');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (89, 89, 5, 'Ожидает оплаты', 89, '30%', '2014-09-16 08:15:30', '2017-03-11 13:51:43');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (90, 90, 6, 'Оплачен', 90, '30%', '2016-05-09 21:07:10', '2019-04-24 13:20:00');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (91, 91, 7, 'Оплачен', 91, '30%', '2012-08-17 08:07:16', '2017-12-25 22:30:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (92, 92, 1, 'Отменен', 92, '30%', '2015-12-21 04:43:59', '2013-12-06 22:03:08');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (93, 93, 2, 'Оплачен', 93, '30%', '2019-01-15 18:38:08', '2013-02-01 18:18:01');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (94, 94, 3, 'Ожидает оплаты', 94, '30%', '2019-03-15 17:04:07', '2014-08-21 21:57:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (95, 95, 4, 'Оплачен', 95, '30%', '2020-07-24 13:45:04', '2016-02-23 00:55:50');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (96, 96, 5, 'Оплачен', 96, '30%', '2021-04-04 05:37:07', '2015-01-17 21:24:03');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (97, 97, 6, 'Отменен', 97, '30%', '2011-10-20 16:47:42', '2017-01-13 07:43:47');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (98, 98, 7, 'Оплачен', 98, '30%', '2013-11-25 07:55:02', '2020-01-07 01:44:34');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (99, 99, 1, 'Оплачен', 99, '30%', '2020-05-19 10:08:23', '2013-01-11 23:09:47');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (100, 100, 2, 'Оплачен', 100, '30%', '2014-01-10 17:42:29', '2014-10-08 16:29:50');



#
# TABLE STRUCTURE FOR: colors
#

DROP TABLE IF EXISTS `colors`;

CREATE TABLE `colors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на заказ',
  `color` tinytext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Цветовая сетка хотел делать enum, но цветов очень много',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `colors_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (1, 1, 'lime', '2021-04-10 03:38:40');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (2, 2, 'white', '2017-10-08 00:26:41');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (3, 3, 'olive', '2017-05-10 09:15:32');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (4, 4, 'aqua', '2020-12-28 11:49:56');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (5, 5, 'lime', '2011-10-27 09:37:36');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (6, 6, 'aqua', '2020-04-06 05:22:56');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (7, 7, 'white', '2020-12-17 12:19:18');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (8, 8, 'white', '2015-12-02 16:55:19');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (9, 9, 'gray', '2013-09-21 11:00:59');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (10, 10, 'black', '2017-02-26 08:49:04');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (11, 11, 'teal', '2020-09-25 04:07:37');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (12, 12, 'yellow', '2021-05-21 17:14:16');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (13, 13, 'purple', '2012-01-24 23:27:16');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (14, 14, 'aqua', '2019-06-11 11:53:52');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (15, 15, 'silver', '2020-10-18 09:16:49');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (16, 16, 'green', '2019-04-13 12:15:21');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (17, 17, 'lime', '2020-01-24 09:42:01');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (18, 18, 'white', '2014-08-16 13:54:23');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (19, 19, 'yellow', '2020-03-22 22:27:45');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (20, 20, 'lime', '2015-02-26 06:20:39');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (21, 21, 'teal', '2019-05-10 16:55:59');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (22, 22, 'maroon', '2014-05-17 19:32:02');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (23, 23, 'maroon', '2020-11-22 07:04:40');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (24, 24, 'olive', '2013-09-22 03:21:58');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (25, 25, 'olive', '2019-02-27 00:38:07');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (26, 26, 'black', '2021-01-25 14:33:55');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (27, 27, 'teal', '2020-09-30 12:23:23');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (28, 28, 'maroon', '2012-09-10 07:25:46');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (29, 29, 'maroon', '2019-03-27 03:13:20');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (30, 30, 'gray', '2014-11-17 22:13:51');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (31, 31, 'yellow', '2018-10-13 18:16:05');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (32, 32, 'green', '2020-10-17 14:10:13');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (33, 33, 'aqua', '2020-12-04 15:08:13');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (34, 34, 'purple', '2020-09-20 18:13:46');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (35, 35, 'silver', '2020-11-18 03:31:23');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (36, 36, 'green', '2013-07-21 05:58:12');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (37, 37, 'olive', '2013-02-03 06:04:06');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (38, 38, 'white', '2012-04-25 23:04:54');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (39, 39, 'maroon', '2012-07-12 08:17:57');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (40, 40, 'yellow', '2019-11-06 00:45:06');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (41, 41, 'maroon', '2020-03-27 14:39:33');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (42, 42, 'maroon', '2014-07-08 16:11:11');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (43, 43, 'green', '2018-10-22 21:47:37');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (44, 44, 'yellow', '2016-10-21 05:39:41');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (45, 45, 'yellow', '2011-06-30 11:01:23');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (46, 46, 'blue', '2017-11-28 22:26:25');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (47, 47, 'silver', '2012-08-13 04:36:13');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (48, 48, 'gray', '2020-03-12 06:10:54');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (49, 49, 'lime', '2016-12-04 22:27:55');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (50, 50, 'fuchsia', '2019-05-04 09:36:18');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (51, 51, 'blue', '2019-03-02 07:13:54');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (52, 52, 'green', '2014-04-15 17:29:40');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (53, 53, 'aqua', '2019-12-23 10:08:38');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (54, 54, 'teal', '2018-01-25 21:24:32');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (55, 55, 'teal', '2017-02-10 01:38:01');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (56, 56, 'purple', '2014-03-06 15:08:28');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (57, 57, 'silver', '2015-01-31 18:45:10');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (58, 58, 'blue', '2011-12-21 13:34:53');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (59, 59, 'maroon', '2012-02-01 03:32:07');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (60, 60, 'purple', '2014-04-27 12:48:24');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (61, 61, 'purple', '2012-03-03 16:56:45');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (62, 62, 'olive', '2017-10-16 14:33:41');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (63, 63, 'green', '2014-10-17 05:29:43');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (64, 64, 'fuchsia', '2015-03-29 09:25:31');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (65, 65, 'blue', '2020-08-31 12:34:06');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (66, 66, 'black', '2015-08-25 20:42:23');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (67, 67, 'yellow', '2021-05-13 08:00:55');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (68, 68, 'navy', '2017-07-07 16:33:57');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (69, 69, 'white', '2020-10-11 19:09:35');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (70, 70, 'aqua', '2018-04-21 09:08:16');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (71, 71, 'navy', '2012-02-14 03:11:02');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (72, 72, 'gray', '2017-03-27 15:24:28');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (73, 73, 'maroon', '2017-08-15 08:43:35');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (74, 74, 'silver', '2012-03-12 00:50:23');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (75, 75, 'lime', '2014-04-26 13:16:51');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (76, 76, 'yellow', '2016-09-29 23:14:50');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (77, 77, 'fuchsia', '2020-07-23 08:35:48');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (78, 78, 'blue', '2013-06-27 00:03:18');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (79, 79, 'lime', '2020-03-26 11:48:42');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (80, 80, 'fuchsia', '2019-07-19 08:33:39');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (81, 81, 'aqua', '2014-08-29 05:59:14');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (82, 82, 'blue', '2015-09-07 05:21:26');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (83, 83, 'maroon', '2018-11-07 12:52:30');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (84, 84, 'black', '2020-11-25 18:17:45');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (85, 85, 'yellow', '2021-02-16 05:18:22');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (86, 86, 'fuchsia', '2012-04-18 10:53:58');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (87, 87, 'white', '2020-03-21 09:50:11');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (88, 88, 'blue', '2015-12-14 13:17:31');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (89, 89, 'blue', '2014-12-02 09:06:55');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (90, 90, 'aqua', '2019-07-19 21:30:44');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (91, 91, 'teal', '2014-04-23 01:24:23');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (92, 92, 'blue', '2013-05-12 20:41:00');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (93, 93, 'white', '2020-10-10 13:35:18');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (94, 94, 'white', '2017-12-01 06:39:14');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (95, 95, 'purple', '2016-05-03 00:19:33');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (96, 96, 'silver', '2017-04-10 13:22:59');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (97, 97, 'teal', '2014-01-29 21:23:55');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (98, 98, 'olive', '2013-03-09 16:52:51');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (99, 99, 'yellow', '2013-09-16 21:38:19');
INSERT INTO `colors` (`id`, `order_id`, `color`, `created_at`) VALUES (100, 100, 'maroon', '2011-11-28 07:31:05');


#
# TABLE STRUCTURE FOR: orders
#

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Cсылка на пользователя',
  `category_id` int(10) unsigned NOT NULL COMMENT 'Всё о товаре',
  `status` enum('Оплачен','Ожидает оплаты','Отменен') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Статус заказа',
  `city_id` int(11) NOT NULL COMMENT 'Город заказа',
  `discount_on_bonus_card` enum('30%') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Скидка на товар, она всегда 30%, в зависимости от остатка бонусов у человека',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (1, 1, 1, 'Ожидает оплаты', 1, '30%', '2012-04-16 05:27:39', '2013-03-29 03:10:35');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (2, 2, 2, 'Отменен', 2, '30%', '2019-10-21 06:05:36', '2020-08-11 03:54:38');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (3, 3, 3, 'Отменен', 3, '30%', '2018-05-13 00:59:22', '2019-04-30 23:55:48');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (4, 4, 4, 'Ожидает оплаты', 4, '30%', '2014-04-15 06:14:28', '2020-11-06 21:50:10');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (5, 5, 5, 'Отменен', 5, '30%', '2020-02-21 14:12:33', '2015-08-07 10:02:12');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (6, 6, 6, 'Оплачен', 6, '30%', '2014-03-03 17:27:58', '2018-07-18 22:43:23');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (7, 7, 7, 'Оплачен', 7, '30%', '2013-12-09 20:20:22', '2020-08-05 08:05:49');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (8, 8, 1, 'Ожидает оплаты', 8, '30%', '2012-04-14 21:07:18', '2012-04-14 11:46:07');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (9, 9, 2, 'Оплачен', 9, '30%', '2015-04-13 18:24:42', '2013-01-17 15:29:06');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (10, 10, 3, 'Оплачен', 10, '30%', '2013-12-06 13:55:12', '2018-08-15 22:55:44');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (11, 11, 4, 'Отменен', 11, '30%', '2020-03-12 16:01:15', '2020-08-04 08:56:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (12, 12, 5, 'Отменен', 12, '30%', '2013-07-07 06:03:06', '2012-05-11 05:15:19');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (13, 13, 6, 'Оплачен', 13, '30%', '2021-03-08 06:17:11', '2013-02-26 00:28:10');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (14, 14, 7, 'Ожидает оплаты', 14, '30%', '2013-03-06 19:12:36', '2013-08-08 20:03:22');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (15, 15, 1, 'Ожидает оплаты', 15, '30%', '2020-11-18 07:12:34', '2021-04-30 09:21:32');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (16, 16, 2, 'Отменен', 16, '30%', '2011-11-11 20:57:36', '2012-11-13 17:18:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (17, 17, 3, 'Отменен', 17, '30%', '2014-05-23 00:16:39', '2015-08-30 06:15:27');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (18, 18, 4, 'Оплачен', 18, '30%', '2020-02-18 04:04:34', '2015-01-14 10:59:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (19, 19, 5, 'Отменен', 19, '30%', '2019-12-28 01:34:36', '2014-05-07 06:41:36');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (20, 20, 6, 'Ожидает оплаты', 20, '30%', '2016-12-23 07:18:28', '2013-03-23 02:32:19');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (21, 21, 7, 'Оплачен', 21, '30%', '2017-11-01 18:08:01', '2014-06-20 07:41:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (22, 22, 1, 'Ожидает оплаты', 22, '30%', '2017-03-21 11:49:05', '2015-04-05 16:12:58');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (23, 23, 2, 'Оплачен', 23, '30%', '2016-09-16 18:29:55', '2014-07-25 05:25:16');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (24, 24, 3, 'Отменен', 24, '30%', '2017-10-29 22:37:30', '2013-06-28 03:52:52');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (25, 25, 4, 'Отменен', 25, '30%', '2012-11-06 23:41:41', '2014-02-18 09:45:30');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (26, 26, 5, 'Отменен', 26, '30%', '2014-07-14 01:10:29', '2013-08-09 02:06:49');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (27, 27, 6, 'Отменен', 27, '30%', '2020-02-15 05:46:06', '2015-04-03 02:42:00');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (28, 28, 7, 'Оплачен', 28, '30%', '2019-03-21 15:02:12', '2019-05-29 11:57:13');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (29, 29, 1, 'Отменен', 29, '30%', '2019-05-09 04:45:06', '2011-11-06 14:46:34');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (30, 30, 2, 'Отменен', 30, '30%', '2012-07-31 02:58:43', '2012-01-30 23:44:20');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (31, 31, 3, 'Оплачен', 31, '30%', '2014-09-14 01:30:26', '2018-12-09 00:53:40');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (32, 32, 4, 'Ожидает оплаты', 32, '30%', '2020-11-21 07:45:55', '2019-02-23 21:47:03');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (33, 33, 5, 'Оплачен', 33, '30%', '2011-10-19 12:27:11', '2011-12-23 02:38:52');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (34, 34, 6, 'Ожидает оплаты', 34, '30%', '2014-08-07 02:16:18', '2014-04-26 05:23:12');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (35, 35, 7, 'Ожидает оплаты', 35, '30%', '2013-12-17 10:22:02', '2018-12-21 01:57:13');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (36, 36, 1, 'Ожидает оплаты', 36, '30%', '2013-04-21 16:41:36', '2014-10-16 18:08:40');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (37, 37, 2, 'Отменен', 37, '30%', '2020-12-09 08:59:02', '2017-05-11 07:35:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (38, 38, 3, 'Отменен', 38, '30%', '2011-07-25 07:30:54', '2013-10-01 15:11:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (39, 39, 4, 'Ожидает оплаты', 39, '30%', '2019-02-12 05:40:06', '2019-05-14 22:15:05');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (40, 40, 5, 'Ожидает оплаты', 40, '30%', '2020-04-18 03:47:57', '2011-06-09 16:19:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (41, 41, 6, 'Оплачен', 41, '30%', '2018-07-01 11:42:24', '2017-11-04 03:17:38');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (42, 42, 7, 'Ожидает оплаты', 42, '30%', '2011-10-07 21:15:47', '2020-11-23 16:23:19');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (43, 43, 1, 'Отменен', 43, '30%', '2012-09-07 18:39:53', '2011-10-06 23:40:38');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (44, 44, 2, 'Отменен', 44, '30%', '2019-01-02 02:40:52', '2017-01-31 02:39:17');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (45, 45, 3, 'Отменен', 45, '30%', '2017-09-21 08:58:45', '2016-07-07 09:18:24');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (46, 46, 4, 'Оплачен', 46, '30%', '2014-10-27 19:39:02', '2015-05-03 23:56:16');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (47, 47, 5, 'Отменен', 47, '30%', '2016-01-29 02:30:15', '2015-06-03 10:43:45');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (48, 48, 6, 'Отменен', 48, '30%', '2017-07-26 04:29:41', '2012-01-09 15:57:12');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (49, 49, 7, 'Ожидает оплаты', 49, '30%', '2014-03-13 11:13:42', '2013-12-18 09:50:35');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (50, 50, 1, 'Ожидает оплаты', 50, '30%', '2017-03-11 14:58:26', '2020-09-04 07:08:02');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (51, 51, 2, 'Оплачен', 51, '30%', '2012-09-11 09:17:03', '2018-02-27 05:57:51');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (52, 52, 3, 'Оплачен', 52, '30%', '2015-07-07 11:32:37', '2014-07-23 11:20:24');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (53, 53, 4, 'Ожидает оплаты', 53, '30%', '2017-07-17 23:49:10', '2019-11-04 15:32:15');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (54, 54, 5, 'Отменен', 54, '30%', '2017-03-12 01:06:26', '2014-12-17 07:55:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (55, 55, 6, 'Оплачен', 55, '30%', '2015-06-09 18:24:00', '2013-07-16 05:40:29');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (56, 56, 7, 'Оплачен', 56, '30%', '2015-12-11 02:33:53', '2018-05-10 10:56:14');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (57, 57, 1, 'Отменен', 57, '30%', '2014-02-19 16:16:47', '2019-07-02 17:14:35');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (58, 58, 2, 'Отменен', 58, '30%', '2021-05-24 08:56:38', '2011-07-09 15:29:14');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (59, 59, 3, 'Ожидает оплаты', 59, '30%', '2014-04-30 21:01:54', '2014-11-18 09:55:51');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (60, 60, 4, 'Оплачен', 60, '30%', '2011-07-29 11:29:04', '2016-07-10 23:42:56');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (61, 61, 5, 'Отменен', 61, '30%', '2017-12-02 13:36:55', '2016-01-11 14:10:39');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (62, 62, 6, 'Отменен', 62, '30%', '2019-10-21 01:31:03', '2012-01-06 00:46:11');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (63, 63, 7, 'Отменен', 63, '30%', '2018-03-11 15:21:32', '2015-10-28 16:29:02');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (64, 64, 1, 'Оплачен', 64, '30%', '2020-04-17 13:10:28', '2020-09-01 08:21:27');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (65, 65, 2, 'Оплачен', 65, '30%', '2013-09-15 08:31:54', '2014-10-19 17:50:57');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (66, 66, 3, 'Ожидает оплаты', 66, '30%', '2020-07-04 13:12:52', '2015-07-25 01:05:41');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (67, 67, 4, 'Отменен', 67, '30%', '2018-05-16 16:00:08', '2018-11-04 20:02:32');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (68, 68, 5, 'Ожидает оплаты', 68, '30%', '2015-10-03 02:54:47', '2012-02-13 20:29:58');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (69, 69, 6, 'Оплачен', 69, '30%', '2019-08-20 13:57:32', '2018-12-26 20:07:04');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (70, 70, 7, 'Оплачен', 70, '30%', '2016-05-26 10:42:18', '2012-05-20 19:30:23');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (71, 71, 1, 'Оплачен', 71, '30%', '2017-02-15 04:23:19', '2020-03-17 23:03:09');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (72, 72, 2, 'Ожидает оплаты', 72, '30%', '2017-05-08 05:02:49', '2013-02-20 11:21:35');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (73, 73, 3, 'Оплачен', 73, '30%', '2015-07-17 09:33:54', '2015-08-08 18:56:46');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (74, 74, 4, 'Отменен', 74, '30%', '2015-02-20 07:24:15', '2020-11-10 09:26:47');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (75, 75, 5, 'Отменен', 75, '30%', '2013-08-12 09:09:29', '2014-06-22 22:34:22');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (76, 76, 6, 'Отменен', 76, '30%', '2013-03-11 09:03:06', '2014-05-25 20:51:00');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (77, 77, 7, 'Ожидает оплаты', 77, '30%', '2020-11-07 13:42:12', '2019-12-10 02:47:59');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (78, 78, 1, 'Отменен', 78, '30%', '2017-04-04 22:56:40', '2016-11-27 12:04:28');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (79, 79, 2, 'Отменен', 79, '30%', '2013-09-15 06:50:01', '2014-05-04 21:38:42');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (80, 80, 3, 'Оплачен', 80, '30%', '2021-01-01 13:00:08', '2013-05-20 22:36:09');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (81, 81, 4, 'Ожидает оплаты', 81, '30%', '2017-03-27 08:55:47', '2018-04-25 22:05:18');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (82, 82, 5, 'Отменен', 82, '30%', '2019-04-15 11:27:40', '2016-02-09 00:16:06');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (83, 83, 6, 'Отменен', 83, '30%', '2019-06-28 21:56:17', '2015-12-13 08:58:45');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (84, 84, 7, 'Ожидает оплаты', 84, '30%', '2017-10-27 05:43:34', '2016-07-25 21:22:55');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (85, 85, 1, 'Ожидает оплаты', 85, '30%', '2021-03-17 18:06:02', '2021-04-25 07:06:26');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (86, 86, 2, 'Отменен', 86, '30%', '2011-09-19 19:46:48', '2014-07-28 12:07:28');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (87, 87, 3, 'Оплачен', 87, '30%', '2014-01-19 03:18:02', '2015-12-11 14:29:17');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (88, 88, 4, 'Оплачен', 88, '30%', '2021-04-19 19:13:58', '2018-01-02 11:45:34');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (89, 89, 5, 'Ожидает оплаты', 89, '30%', '2014-09-16 08:15:30', '2017-03-11 13:51:43');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (90, 90, 6, 'Оплачен', 90, '30%', '2016-05-09 21:07:10', '2019-04-24 13:20:00');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (91, 91, 7, 'Оплачен', 91, '30%', '2012-08-17 08:07:16', '2017-12-25 22:30:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (92, 92, 1, 'Отменен', 92, '30%', '2015-12-21 04:43:59', '2013-12-06 22:03:08');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (93, 93, 2, 'Оплачен', 93, '30%', '2019-01-15 18:38:08', '2013-02-01 18:18:01');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (94, 94, 3, 'Ожидает оплаты', 94, '30%', '2019-03-15 17:04:07', '2014-08-21 21:57:33');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (95, 95, 4, 'Оплачен', 95, '30%', '2020-07-24 13:45:04', '2016-02-23 00:55:50');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (96, 96, 5, 'Оплачен', 96, '30%', '2021-04-04 05:37:07', '2015-01-17 21:24:03');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (97, 97, 6, 'Отменен', 97, '30%', '2011-10-20 16:47:42', '2017-01-13 07:43:47');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (98, 98, 7, 'Оплачен', 98, '30%', '2013-11-25 07:55:02', '2020-01-07 01:44:34');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (99, 99, 1, 'Оплачен', 99, '30%', '2020-05-19 10:08:23', '2013-01-11 23:09:47');
INSERT INTO `orders` (`id`, `user_id`, `category_id`, `status`, `city_id`, `discount_on_bonus_card`, `created_at`, `updated_at`) VALUES (100, 100, 2, 'Оплачен', 100, '30%', '2014-01-10 17:42:29', '2014-10-08 16:29:50');


#
# TABLE STRUCTURE FOR: return_orders
#

DROP TABLE IF EXISTS `return_orders`;

CREATE TABLE `return_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Cсылка на пользователя',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на возвращаемый товар',
  `reason_name` enum('Брак','Не подошел товар','Ошибка в заказе') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Причины возврата',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `return_orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `return_orders_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (1, 1, 1, 'Не подошел товар', '2017-05-22 03:15:23', '2011-11-19 08:04:24');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (2, 2, 2, 'Ошибка в заказе', '2015-05-18 04:17:23', '2014-03-18 11:11:14');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (3, 3, 3, 'Не подошел товар', '2016-01-17 02:45:19', '2015-04-19 02:30:04');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (4, 4, 4, 'Не подошел товар', '2012-05-18 00:41:42', '2013-09-26 04:09:36');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (5, 5, 5, 'Ошибка в заказе', '2017-08-05 21:03:07', '2017-10-22 09:33:18');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (6, 6, 6, 'Ошибка в заказе', '2011-10-14 04:17:05', '2020-02-13 14:45:27');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (7, 7, 7, 'Не подошел товар', '2014-09-26 11:30:01', '2012-01-28 03:15:55');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (8, 8, 8, 'Ошибка в заказе', '2017-03-08 13:13:31', '2018-06-03 20:57:41');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (9, 9, 9, 'Не подошел товар', '2017-05-06 13:32:24', '2017-10-17 00:53:48');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (10, 10, 10, 'Ошибка в заказе', '2020-05-15 18:23:28', '2012-09-07 19:05:16');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (11, 11, 11, 'Ошибка в заказе', '2019-09-15 10:57:37', '2012-11-21 17:19:31');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (12, 12, 12, 'Ошибка в заказе', '2014-12-26 06:27:01', '2019-03-31 21:47:00');
INSERT INTO `return_orders` (`id`, `user_id`, `order_id`, `reason_name`, `created_at`, `updated_at`) VALUES (13, 13, 13, 'Брак', '2011-12-11 14:10:57', '2020-11-11 18:13:20');


#
# TABLE STRUCTURE FOR: size
#

DROP TABLE IF EXISTS `size`;

CREATE TABLE `size` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на заказ',
  `size` tinytext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Размерная сетка',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `size_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (1, 1, 's', '2018-08-27 10:22:11');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (2, 2, 'Xs', '2017-11-13 19:56:13');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (3, 3, 'xxs', '2018-02-11 15:24:01');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (4, 4, 'xxl', '2012-02-05 05:35:16');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (5, 5, 'Sm', '2017-02-19 11:03:32');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (6, 6, 'xxs', '2015-03-16 07:15:57');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (7, 7, 'xl', '2015-12-13 04:46:59');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (8, 8, 'xxl', '2011-10-23 00:57:51');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (9, 9, 'Sm', '2019-05-22 01:11:49');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (10, 10, 'Sm', '2021-04-15 22:57:18');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (11, 11, 'XXL', '2014-10-15 14:46:41');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (12, 12, 'LXL', '2012-11-18 19:59:20');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (13, 13, 'LXL', '2013-05-27 03:08:47');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (14, 14, 'xxl', '2016-07-08 21:18:53');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (15, 15, 'LXL', '2021-04-02 12:15:02');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (16, 16, 'Xs', '2019-08-24 03:46:16');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (17, 17, 'LXL', '2018-07-07 06:41:14');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (18, 18, 'LXL', '2015-07-06 19:48:21');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (19, 19, 'm', '2017-08-22 21:35:09');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (20, 20, 'xxl', '2014-05-07 04:14:32');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (21, 21, 'm', '2016-09-05 15:43:43');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (22, 22, 's', '2020-09-03 13:13:13');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (23, 23, 'm', '2020-08-26 01:43:09');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (24, 24, 'm', '2011-06-07 13:21:57');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (25, 25, 'l', '2017-05-09 16:58:11');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (26, 26, 'LXL', '2013-09-06 23:17:32');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (27, 27, 'l', '2018-01-11 09:11:39');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (28, 28, 'l', '2012-10-09 06:10:05');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (29, 29, 'xl', '2016-11-19 10:39:00');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (30, 30, 'xxs', '2014-12-15 07:47:50');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (31, 31, 's', '2018-02-09 02:43:17');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (32, 32, 'LXL', '2016-12-26 01:39:47');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (33, 33, 'xxs', '2015-07-31 16:05:27');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (34, 34, 'xxl', '2016-06-05 23:56:41');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (35, 35, 'XXL', '2015-10-21 11:45:44');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (36, 36, 'm', '2020-08-14 17:57:31');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (37, 37, 'Xs', '2021-05-21 12:33:38');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (38, 38, 'm', '2014-04-03 15:11:30');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (39, 39, 'Xs', '2016-09-10 20:41:21');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (40, 40, 'l', '2020-09-06 01:00:21');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (41, 41, 'xxs', '2013-09-25 20:24:34');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (42, 42, 'l', '2011-11-06 05:48:55');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (43, 43, 'm', '2012-10-19 02:55:04');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (44, 44, 'l', '2012-12-07 11:02:35');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (45, 45, 'XXL', '2017-08-09 11:57:21');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (46, 46, 'Xs', '2019-03-07 04:18:09');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (47, 47, 'xl', '2019-12-27 08:04:31');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (48, 48, 'xl', '2019-09-19 19:31:05');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (49, 49, 'Sm', '2018-04-16 17:28:35');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (50, 50, 'xxs', '2014-12-11 03:53:01');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (51, 51, 'Sm', '2019-07-07 11:09:03');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (52, 52, 's', '2019-11-26 08:49:52');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (53, 53, 'l', '2012-04-28 15:49:53');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (54, 54, 'm', '2014-06-03 05:24:57');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (55, 55, 'Sm', '2011-06-01 15:39:43');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (56, 56, 'XXL', '2013-07-31 15:46:53');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (57, 57, 'xxs', '2014-08-05 08:47:46');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (58, 58, 'Sm', '2019-04-16 00:25:29');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (59, 59, 'LXL', '2019-09-20 14:47:24');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (60, 60, 'xxs', '2020-06-13 03:23:59');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (61, 61, 'Sm', '2012-09-16 09:27:10');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (62, 62, 'xxs', '2019-08-04 11:56:32');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (63, 63, 'm', '2012-10-09 11:56:45');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (64, 64, 's', '2015-01-21 13:36:36');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (65, 65, 'xl', '2012-06-27 05:36:31');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (66, 66, 'xxs', '2014-09-17 09:34:37');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (67, 67, 'LXL', '2016-07-07 03:15:50');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (68, 68, 'xxs', '2018-12-08 12:14:58');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (69, 69, 'LXL', '2019-01-15 11:41:09');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (70, 70, 'XXL', '2020-11-22 03:21:41');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (71, 71, 'xxs', '2017-12-18 01:22:57');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (72, 72, 'xxl', '2020-12-16 05:50:17');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (73, 73, 'xl', '2015-01-18 15:41:36');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (74, 74, 'Sm', '2017-07-14 19:26:21');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (75, 75, 'xxl', '2016-10-18 10:53:32');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (76, 76, 'xxl', '2020-11-20 05:38:50');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (77, 77, 'Xs', '2017-04-30 05:51:01');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (78, 78, 'xxl', '2014-01-21 22:50:02');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (79, 79, 'xl', '2018-12-15 06:42:36');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (80, 80, 'xl', '2011-06-23 00:38:17');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (81, 81, 'XXL', '2016-11-01 21:52:23');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (82, 82, 'xxs', '2013-09-28 12:43:46');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (83, 83, 'LXL', '2021-01-28 22:34:20');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (84, 84, 'Sm', '2016-02-08 04:06:01');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (85, 85, 'xl', '2012-07-31 00:21:15');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (86, 86, 'LXL', '2015-02-05 21:44:34');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (87, 87, 'xxl', '2011-11-12 20:57:26');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (88, 88, 'xl', '2013-09-04 08:50:09');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (89, 89, 'LXL', '2018-04-18 11:38:22');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (90, 90, 'm', '2021-05-12 03:52:21');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (91, 91, 'XXL', '2017-10-14 13:50:35');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (92, 92, 'LXL', '2018-12-19 06:31:41');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (93, 93, 'Xs', '2017-10-09 19:29:59');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (94, 94, 'm', '2018-02-09 09:46:38');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (95, 95, 'xl', '2015-10-29 17:29:06');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (96, 96, 'm', '2019-12-19 11:27:33');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (97, 97, 'xxl', '2017-09-03 16:42:57');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (98, 98, 's', '2018-06-24 13:26:19');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (99, 99, 'xxl', '2013-02-23 21:41:36');
INSERT INTO `size` (`id`, `order_id`, `size`, `created_at`) VALUES (100, 100, 'XXL', '2011-12-12 01:02:00');



