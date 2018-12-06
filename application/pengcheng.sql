-- phpMyAdmin SQL Dump
-- version 3.5.8.1
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2018 �?11 �?06 �?13:21
-- 服务器版本: 5.6.14
-- PHP 版本: 5.6.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `pengcheng`
--

-- --------------------------------------------------------

--
-- 表的结构 `app_banner`
--

CREATE TABLE IF NOT EXISTS `app_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `filename` varchar(255) NOT NULL COMMENT '图片url',
  `sort` int(11) DEFAULT '100' COMMENT '排序',
  `type` tinyint(1) DEFAULT NULL COMMENT '所属分类：1主页，2订房',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `app_banner`
--

INSERT INTO `app_banner` (`id`, `title`, `filename`, `sort`, `type`) VALUES
(2, '1', 'http://wx.p-city.cn/static/upload/201811/4d736e3747411b0f0f0e58872c1a0b6c.jpg', 100, 2),
(5, '测试', 'http://wx.p-city.cn/static/upload/201811/49eacdc43e461eb00885827288107dce.jpg', 100, 2);

-- --------------------------------------------------------

--
-- 表的结构 `app_coupon`
--

CREATE TABLE IF NOT EXISTS `app_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '标题',
  `cut_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠金额',
  `deadline_date` date NOT NULL COMMENT '失效日期',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `app_coupon`
--

INSERT INTO `app_coupon` (`id`, `title`, `cut_price`, `deadline_date`, `created_time`) VALUES
(1, '鹏城酒店专享', '30.00', '2018-09-05', '2018-09-01 06:17:04'),
(2, '鹏程酒店专享', '40.00', '2018-09-14', '2018-09-01 11:20:04'),
(4, '鹏城酒店专享', '70.00', '2018-09-21', '2018-09-11 06:17:04'),
(5, '鹏城酒店专享', '10.00', '2018-09-05', '2018-09-13 06:17:04'),
(6, '鹏城酒店专享', '88.00', '2018-09-20', '2018-09-14 06:17:04'),
(7, '鹏城酒店专享', '99.00', '2018-09-30', '2018-09-23 06:17:04');

-- --------------------------------------------------------

--
-- 表的结构 `app_goods`
--

CREATE TABLE IF NOT EXISTS `app_goods` (
  `id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT '' COMMENT '名称',
  `is_show` tinyint(1) DEFAULT '0' COMMENT '1开放，0关闭',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '价格',
  `thumb` varchar(255) DEFAULT '' COMMENT '缩略图',
  `detail_img` text COMMENT '详情页顶图',
  `intro` text COMMENT '详情介绍',
  `sort` mediumint(11) unsigned DEFAULT '100' COMMENT '排序',
  `type_id` smallint(11) unsigned DEFAULT '0' COMMENT '类型',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否推荐',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=137 ;

--
-- 转存表中的数据 `app_goods`
--

INSERT INTO `app_goods` (`id`, `title`, `is_show`, `price`, `thumb`, `detail_img`, `intro`, `sort`, `type_id`, `is_recommend`, `created_time`) VALUES
(49, '豉汁凉瓜蒸排骨', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/8d17a566436166dc7560009e44a1c274.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:41:00'),
(50, '客家酿豆腐', 1, '32.00', 'http://wx.p-city.cn/static/upload/201811/f77d7d96a9e713fa97df25b99b552e0e.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:42:02'),
(44, '香芋蒸腊肉', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/f8cc1ea685901b4ba8aba5e0f60678c9.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:37:53'),
(45, '清蒸鲈鱼', 1, '68.00', 'http://wx.p-city.cn/static/upload/201811/86895a3b025115160670cb41cc29ddc2.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:38:36'),
(46, '清蒸丁桂鱼', 1, '68.00', 'http://wx.p-city.cn/static/upload/201811/ff737a45895f6052f083c27d4c65eced.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:39:06'),
(47, '虫草花蒸牛肉', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/a3a60385e0c67a9568f2318394293d0e.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:39:38'),
(48, '古法蒸草鱼', 1, '68.00', 'http://wx.p-city.cn/static/upload/201811/c7b34dc1fd99d5eeb152996f39fa513c.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:40:07'),
(33, '黑蒜炖猪展肉汤', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/ca5357cb1affc5b577bcc5880b46d4db.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:20:52'),
(34, '麦冬丁心玉竹龙骨汤', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/33c3537c29fa04f25d22df98efc58b31.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:23:06'),
(35, '枇杷花水鸭汤', 1, '68.00', 'http://wx.p-city.cn/static/upload/201811/5be86907b6aa9607ea8a0f03b54615c3.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:23:38'),
(36, '剁椒蒸鱼头', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/59035b1d055a14a3fdaf6f411b1ed5c6.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:24:46'),
(37, '虾仁粉丝蒸胜瓜', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/f62dd3e18071bc8deb4a77cb8b33b9b8.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:29:59'),
(32, '五叶神炖龙骨', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/911a5983abb80c1ce2a21fe7bec19529.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:18:55'),
(38, '梅菜蒸肉饼', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/479d16bf970c85e2e218ee99a51c1e4b.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:34:25'),
(39, '榄菜肉茸蒸娃娃菜', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/55838626b0593ca246f61623d619b975.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:35:21'),
(40, '酸汤牛肉', 1, '68.00', 'http://wx.p-city.cn/static/upload/201811/89f34b9ea196a94b99598c34135dd113.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:35:48'),
(41, '鲜虾仁蒸水蛋', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/fae02c0dbd1a8ba6ea0821b27e947f0c.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:36:25'),
(42, '荷叶五香粉蒸肉', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/4d7aa08e6ecb36fd151bf7a8ec696e73.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:36:52'),
(43, '荷香蒸滑鸡', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/227adef7f9ab4016024989f66adb3b99.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:37:21'),
(51, '梅菜扣肉', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/53fc4fc56273429372d0ab2627fd2722.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:42:25'),
(52, '客家蛋角煲', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/2befc679e983b54fb7369ef6c99c81f1.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:43:14'),
(53, '客家酿三宝', 1, '32.00', 'http://wx.p-city.cn/static/upload/201811/e4c1125cf8150929fafb70b337eb6779.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:43:39'),
(54, '子姜炒牛肉', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/295aa8aab91c3e7b0ac2fe1519f436c1.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:44:03'),
(55, '盐焗猪手', 1, '46.00', 'http://wx.p-city.cn/static/upload/201811/6e4493465b91ef13ff88406bbf63275e.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:44:33'),
(56, '铁板脆生肠', 1, '46.00', 'http://wx.p-city.cn/static/upload/201811/dc107e77fe60e5449a00897a1de118a2.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:44:57'),
(57, '田园三剑客', 1, '28.00', 'http://wx.p-city.cn/static/upload/201811/6ea814179d02de5af3f50a3a7f3f71ef.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:45:25'),
(58, '脆瓜皮炒猪肚', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/8e6c506c38dfc1c342a3064c7a2e6ad9.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:45:55'),
(59, '客家苦笋煲', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/3bdc92ce3909d33fe0aaae815d0fc392.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:46:28'),
(60, '铁板牛肉', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/0dd7d0a7b936a3adb91cbe99a2537f87.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:46:58'),
(61, '铁板豆豉鸡', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/e8ba0bda0b61242fa26499dd4fb90d9f.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:47:36'),
(62, '铁板水晶粉', 1, '28.00', 'http://wx.p-city.cn/static/upload/201811/6b6bde609495a2f78f585a43bc2f7d47.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:47:56'),
(63, '铁板土豆片', 1, '28.00', 'http://wx.p-city.cn/static/upload/201811/ffa72beefc234ee275f5ae0243b60aaf.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:48:31'),
(64, '铁板菌皇', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/176b252a7f763d6dddb56571d256f8fd.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:48:55'),
(65, '铁板鹌鹑金蛋', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/435a75c4038bd8174a2296eb17b53e93.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:49:25'),
(66, '铁板浇汁酿茄子', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/a3d4a452e8a0ef05df68a8205d48fd5e.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:49:59'),
(67, '铁板牛仔骨', 1, '68.00', 'http://wx.p-city.cn/static/upload/201811/f28fde0639480fa138527eb43ea3781b.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:50:28'),
(68, '铁板鲜鱿', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/539e9fee2b33e226ff8ab6f937c0d828.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:50:54'),
(69, '一品啤酒鸭', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/760963649c1eba5ee62f0340c855df75.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:51:24'),
(70, '芥菜排骨煲', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/6d796170e22c9dfb9ddbdfdfe88fd614.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:51:53'),
(71, '沙煲大鱼头', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/6050a93c20463a0886ba847ce6898f2a.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:52:23'),
(72, '鱼香茄子煲', 1, '28.00', 'http://wx.p-city.cn/static/upload/201811/18b68a3b7d5654828804a59a668f4268.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:52:54'),
(73, '福果支竹猪肚煲', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/19e26e1ab55b8462c47cf78250b6cd92.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:53:41'),
(74, '杂菌粉丝煲', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/c31bbc6faa162c38e598fc2a5da5fa3c.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:54:20'),
(75, '胜瓜支竹蛋角煲', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/5c71494d08a13b25f71fccefeaf70db5.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:54:49'),
(76, '牛肉粒红腰豆煲', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/5321be51505afd7b6bad6d954b360bd3.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:55:21'),
(77, '鲜虾焗靓鸡煲', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/4c2e32d137f1f60499799cc18e92a1a9.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:55:55'),
(78, '萝卜牛腩煲', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/5528a3b5d69071294dff5f89f3c67eb8.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:56:26'),
(79, '自制古法叉烧', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/845e9ee6c85ce0a077dee286fb1fad12.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:57:07'),
(80, '湛江白切鸡', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/3d2f31bb0dbfaeede10c57f613c55ec4.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:57:35'),
(81, '姜蓉鸡', 1, '62.00', 'http://wx.p-city.cn/static/upload/201811/63ee003b1129a9abd9662777aef80728.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:58:08'),
(82, '葱油鸡', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/7ace514f83f540443a1a3d7e54d24771.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:58:30'),
(83, '脆皮炸大肠', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/db7913fda5dd4887fe6d83a67764d3f9.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 03:58:53'),
(84, '碳烧羊排', 1, '78.00', 'http://wx.p-city.cn/static/upload/201811/cd1200a3a15df1e20c885d5836cad3a2.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:09:28'),
(85, '美极鸭下巴', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/186f9d98f8c335d296ac3d867804f06f.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:09:55'),
(86, '香煎杂鱼', 1, '48.00', 'http://wx.p-city.cn/static/upload/201811/cf2a6f9ad9ba20b0fa31c53c094bc0cb.JPG', NULL, NULL, 100, 0, 1, '2018-11-02 06:10:32'),
(87, '醇香南极鱼', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/474781240d69378ff3c807295ad058c4.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:11:04'),
(88, '蒜香金兰寸骨', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/5153bdefdd6ca8a33538b206e080f2a2.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:12:17'),
(89, '沙姜猪手', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/36bda18e5c1b72738d40b740f74c245b.JPG', NULL, NULL, 100, 0, 1, '2018-11-02 06:12:39'),
(90, '方块牚中宝', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/06d7bf2ab0ce7bc5b36441afdbb469fa.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:13:02'),
(91, '三葱爆炒大海虾', 1, '68.00', 'http://wx.p-city.cn/static/upload/201811/4524a41e1fa5249ce7799e5347315052.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:14:14'),
(92, '红烧乳鸽', 1, '36.00', 'http://wx.p-city.cn/static/upload/201811/37a7fcc244b3484e527b45bad8a15ffb.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:14:41'),
(93, '酸辣藕尖炒鸭肾', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/e08d9801149ca432f92e644ac3f9ddd9.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:15:19'),
(94, '干锅肥肠', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/3c2c0a0ffd703111df85dec8e51faa60.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:15:46'),
(95, '农家小炒肉', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/85c202aa05080cad8e6e17e5c0989142.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:16:12'),
(96, '攸县小炒香干', 1, '32.00', 'http://wx.p-city.cn/static/upload/201811/e50e817620cc443dbb26bc19aa04b390.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:16:41'),
(97, '自家毛血旺', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/139156089a355c9b7bdf6523ae1e2f9b.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:17:08'),
(98, '筒盘长豆角', 1, '28.00', 'http://wx.p-city.cn/static/upload/201811/96a39cf50a9e1351e905f7c830eb4269.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:17:34'),
(99, '干锅有机花菜', 1, '28.00', 'http://wx.p-city.cn/static/upload/201811/2dea95f0142359ea9e716f9874666129.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:18:10'),
(100, '鱼香肉丝', 1, '36.00', 'http://wx.p-city.cn/static/upload/201811/c4a8a08e55e6195e34ecc0854e6ac9c7.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:18:37'),
(101, '指天椒小炒荷包牛肉', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/96ace99f8238019b38921c82ca24d8cd.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:19:23'),
(102, '手撕包菜', 1, '28.00', 'http://wx.p-city.cn/static/upload/201811/4c32e9c5f626d6ee48afcdd55c9f1db3.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:19:55'),
(103, '虎皮尖椒', 1, '28.00', 'http://wx.p-city.cn/static/upload/201811/47ea3cfdb5da8f9cc159cbade08f5655.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:20:21'),
(104, '酸菜鱼', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/1deb55e8115d01beb246d47959e99a42.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:20:45'),
(105, '酸辣土豆丝', 1, '28.00', 'http://wx.p-city.cn/static/upload/201811/6c4c5751ba5a31ac5593b67f27e9e7a2.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:21:09'),
(106, '莴笋辣炒腊肉', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/08ecbcf928bc4f818f2bd81af2979af3.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:21:50'),
(107, '香辣大海虾', 1, '68.00', 'http://wx.p-city.cn/static/upload/201811/f7b06bf3ea894ccd36722a75558dbc11.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:22:20'),
(108, '干锅茶树菇', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/a9b114c08cf1ddb7e362669f9553fe02.png', NULL, NULL, 100, 0, 1, '2018-11-02 06:26:43'),
(109, '乡村一窝香猪菜', 1, '42.00', 'http://wx.p-city.cn/static/upload/201811/273ada89a6eab1ceafe4cc92ae98b920.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:27:33'),
(110, '醋拌白菜丝', 1, '18.00', 'http://wx.p-city.cn/static/upload/201811/176e4f4fc24b189403762474414d7e4b.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:28:19'),
(111, '醋泡花生米', 1, '12.00', 'http://wx.p-city.cn/static/upload/201811/67e8c4eb8f1375b883674a5033e98eae.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:28:42'),
(112, '青龙点酱', 1, '18.00', 'http://wx.p-city.cn/static/upload/201811/bc8b944c474bd5b9ee4f9ad53a023f69.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:29:07'),
(113, '开胃爽口萝卜拌脆皮瓜', 1, '18.00', 'http://wx.p-city.cn/static/upload/201811/29df424cd5baa22f1c5d1bdfbb826221.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:29:38'),
(114, '凉拌木耳', 1, '18.00', 'http://wx.p-city.cn/static/upload/201811/59621ec82bff47e586746fa21e586686.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:30:01'),
(115, '特色蟹火文靓鸡', 1, '88.00', 'http://wx.p-city.cn/static/upload/201811/3da4c413eaf77909896c4d92318af4da.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:31:24'),
(116, '招牌酥香炸粿肉', 1, '45.00', 'http://wx.p-city.cn/static/upload/201811/6e0c0126e703fe7f7971eeac27c00677.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:32:13'),
(117, '紫苏凉瓜炒腩肉', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/42a89a7cfd470bd4a7e2c8fd51c98f6e.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:32:54'),
(118, '咖哩杂菜', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/61b3fe78a342c0d20f688665a02aeafc.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:33:19'),
(119, '花胶杞子浸菜心', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/2dab8a8e265f9916e582c7dcc675cac9.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:33:49'),
(120, '酸辣藕尖炒脆瓜皮', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/8b9289d23f1f4e02b6d95fba36f365e2.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:34:22'),
(121, '田园小炒', 1, '38.00', 'http://wx.p-city.cn/static/upload/201811/4b4bf44396d7f6212ffdf16447f33f20.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:34:45'),
(122, '紫苏酸辣（焗）靓鸭', 1, '78.00', 'http://wx.p-city.cn/static/upload/201811/37b51cfc29b1569d5c6e3e28fa47de9c.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:35:17'),
(123, '姜葱爆炒自发海参', 1, '138.00', 'http://wx.p-city.cn/static/upload/201811/ee6fae0a3e25674c5ebcda8a218924e8.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:35:55'),
(124, '花菜番茄炒牛肉', 1, '58.00', 'http://wx.p-city.cn/static/upload/201811/52e0be1ecdf04ce8ba124c1090b7f8cd.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:36:23'),
(125, '瑶柱蛋白炒饭', 1, '25.00', 'http://wx.p-city.cn/static/upload/201811/e41c31687aebaeefd817730413dde875.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:36:55'),
(126, '鸡蛋包菜炒米粉', 1, '25.00', 'http://wx.p-city.cn/static/upload/201811/a2359a0e75a67e85816809c3901d450b.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:37:24'),
(127, '炒面', 1, '25.00', 'http://wx.p-city.cn/static/upload/201811/b80f33360eb007e3737cf226f4964e17.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:37:42'),
(128, '干炒牛河', 1, '25.00', 'http://wx.p-city.cn/static/upload/201811/b948ef3f3760853632e0ce0b1ac22edb.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:38:02'),
(129, '麦香花生包', 1, '22.00', 'http://wx.p-city.cn/static/upload/201811/218d2d631135eec661b3c7e6f7251073.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:38:31'),
(130, '双色馒头', 1, '22.00', 'http://wx.p-city.cn/static/upload/201811/e852bb4654ce4a74c931a8e85d26434d.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:38:51'),
(131, '清炒菜心', 1, '25.00', 'http://wx.p-city.cn/static/upload/201811/d118a8258d8d9816938a966870804877.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:39:30'),
(132, '芥兰', 1, '25.00', 'http://wx.p-city.cn/static/upload/201811/eb12f2260491524bcfd1acb77f0ee75f.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:39:52'),
(133, '上汤娃娃菜', 1, '25.00', 'http://wx.p-city.cn/static/upload/201811/2a8d2408c84cbb19f99c0b42040b0117.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:40:12'),
(134, '生菜', 1, '25.00', 'http://wx.p-city.cn/static/upload/201811/a62193ad7d6ce6496a8da6be3a2d14fc.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:40:29'),
(135, '油麦菜', 1, '25.00', 'http://wx.p-city.cn/static/upload/201811/af0f5771e6854ba13c15b0078578a36e.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:40:55'),
(136, '鲜芦笋', 1, '32.00', 'http://wx.p-city.cn/static/upload/201811/b63bb00809eb44a16d8dd79adbe11de5.jpg', NULL, NULL, 100, 0, 1, '2018-11-02 06:41:20');

-- --------------------------------------------------------

--
-- 表的结构 `app_goods_cart`
--

CREATE TABLE IF NOT EXISTS `app_goods_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) DEFAULT NULL COMMENT '商品id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `num` int(11) DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=149 ;

--
-- 转存表中的数据 `app_goods_cart`
--

INSERT INTO `app_goods_cart` (`id`, `goods_id`, `user_id`, `num`) VALUES
(93, 21, 1, 1),
(95, 23, 1, 1),
(97, 18, 1, 4),
(99, 19, 1, 1),
(100, 22, 7, 1),
(101, 23, 7, 1),
(113, 18, 5, 2),
(132, 23, 5, 1),
(141, 26, 10, 1),
(142, 28, 16, 1),
(143, 45, 16, 5),
(144, 44, 16, 6),
(145, 50, 16, 7),
(146, 49, 16, 9),
(147, 46, 16, 3),
(148, 48, 16, 2);

-- --------------------------------------------------------

--
-- 表的结构 `app_goods_order`
--

CREATE TABLE IF NOT EXISTS `app_goods_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(30) NOT NULL DEFAULT '' COMMENT '订单编号',
  `out_trade_no` varchar(32) DEFAULT NULL COMMENT '交易编号',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '联系人',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `meal_date` date NOT NULL COMMENT '用餐日期',
  `meal_time` time NOT NULL COMMENT '用餐时间点',
  `meal_people` int(11) NOT NULL DEFAULT '1' COMMENT '用餐人数',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注信息',
  `openid` char(28) NOT NULL COMMENT '用户openid',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '订单总额',
  `pay_money` decimal(10,2) DEFAULT NULL COMMENT '实付价格',
  `is_coupon` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用优惠券',
  `coupon_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠金额',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '-1取消，0待支付，1待用餐，2，已完成',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '伪删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `out_trade_no` (`out_trade_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='订单' AUTO_INCREMENT=25 ;

--
-- 转存表中的数据 `app_goods_order`
--

INSERT INTO `app_goods_order` (`id`, `order_no`, `out_trade_no`, `name`, `phone`, `meal_date`, `meal_time`, `meal_people`, `remark`, `openid`, `amount`, `pay_money`, `is_coupon`, `coupon_price`, `created_time`, `pay_time`, `status`, `deleted`) VALUES
(9, '20181008184252888598', '4200000167201810102007158850', 'gtfrfrtbgf', '15889653851', '2018-10-08', '06:41:00', 1, '', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '2200.00', '0.01', 0, '0.00', '2018-10-08 10:42:52', '2018-10-10 10:33:23', 1, 0),
(10, '20181008184400527423', '4200000162201810109228513892', '静静', '15889653851', '2018-10-08', '06:44:00', 1, '', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '8880.00', '0.01', 0, '0.00', '2018-10-08 10:44:00', '2018-10-10 10:35:19', 1, 0),
(11, '20181008184602114447', '4200000170201810105202712157', '静静', '15889653851', '2018-10-03', '06:46:00', 1, '', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '2550.00', '0.01', 0, '0.00', '2018-10-08 10:46:02', '2018-10-10 10:25:20', 1, 0),
(12, '20181008184720706088', '4200000187201810080434441963', 'fdv', '15889653851', '2018-10-08', '06:47:00', 1, '', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '8880.00', '0.01', 0, '0.00', '2018-10-08 10:47:20', '2018-10-08 10:51:28', 1, 0),
(13, '20181008184918533465', NULL, '米伟', '15889653851', '2018-10-08', '06:49:00', 1, '', 'otuUIuBm6U9TB9SUWRxMZwv8sMAU', '8880.00', NULL, 0, '0.00', '2018-10-08 10:49:18', NULL, 0, 0),
(14, '20181008185150413714', '4200000186201810082028951901', '小惜', '15889653851', '2018-10-03', '06:51:00', 1, '不要辣！！！', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '8880.00', '0.01', 0, '0.00', '2018-10-08 10:51:50', '2018-10-08 10:52:20', 1, 0),
(15, '20181008185348528494', '4200000175201810084699377355', '心昔', '15889653851', '2018-10-03', '06:53:00', 2, '不要辣哦嘻嘻', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '2200.00', '0.01', 0, '0.00', '2018-10-08 10:53:48', '2018-10-08 10:54:18', 1, 0),
(16, '20181011085633928094', '4200000175201810118836612884', '小惜', '15889653851', '2018-10-04', '09:56:00', 1, '不要辣', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '11080.00', '0.01', 0, '0.00', '2018-10-11 00:56:33', '2018-10-11 00:57:08', 1, 0),
(17, '20181011090110465158', '4200000168201810113316774003', '沁沁', '15889653851', '2018-10-11', '01:00:00', 2, '不要辣哦，要热的哦，去冰少糖加布丁', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '8880.00', '0.01', 0, '0.00', '2018-10-11 01:01:10', '2018-10-11 01:01:44', 1, 0),
(18, '20181011090255205523', '4200000178201810117066523754', '小惜', '15889653851', '2018-10-04', '10:02:00', 1, '去冰少糖+布丁', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '9230.00', '0.01', 0, '0.00', '2018-10-11 01:02:55', '2018-10-11 01:03:28', 1, 0),
(19, '20181011090816872970', '4200000165201810119987856864', '李明', '15622891795', '2018-10-12', '10:08:00', 3, '', 'otuUIuGiRO_FHWR42oy88BcnbiwI', '18110.00', '0.01', 0, '0.00', '2018-10-11 01:08:16', '2018-10-11 01:08:47', 1, 0),
(20, '20181011091050987557', '4200000162201810116843850733', '小惜', '15889653851', '2018-10-04', '10:10:00', 1, '不要辣', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '9230.00', '0.01', 0, '0.00', '2018-10-11 01:10:50', '2018-10-11 01:11:26', 1, 0),
(21, '20181011091808839627', '4200000174201810119250244023', '沁沁', '15889653851', '2018-10-04', '10:18:00', 1, '不要辣', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '4750.00', '0.01', 0, '0.00', '2018-10-11 01:18:08', '2018-10-11 01:18:42', 1, 0),
(22, '20181011093237178579', '4200000172201810115565673657', '李明', '15622891795', '2018-10-11', '10:32:00', 2, '', 'otuUIuGiRO_FHWR42oy88BcnbiwI', '6680.00', '0.01', 0, '0.00', '2018-10-11 01:32:37', '2018-10-11 01:33:09', 1, 0),
(23, '20181015093313414895', '4200000174201810151550295707', '静静', '15022228888', '2018-10-01', '10:33:00', 1, '不要辣', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '11430.00', '0.01', 0, '0.00', '2018-10-15 01:33:13', '2018-10-15 01:33:52', 1, 0),
(24, '20181102104158573181', '4200000226201811024479453543', '小惜', '15889653851', '2018-11-01', '11:42:00', 1, '', 'otuUIuA7qA9FFwjBc4wid98ioLq4', '14760.00', '0.01', 0, '0.00', '2018-11-02 02:41:58', '2018-11-02 02:42:46', 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `app_goods_type`
--

CREATE TABLE IF NOT EXISTS `app_goods_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '类型',
  `sort` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  `is_show` tinyint(1) DEFAULT '1' COMMENT '1显示，0隐藏',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `app_goods_type`
--

INSERT INTO `app_goods_type` (`id`, `type`, `sort`, `is_show`) VALUES
(7, '粤菜', 100, 0),
(8, '滋补炖汤', 60, 0),
(10, '超值套餐', 100, 0),
(11, '早餐主食', 100, 0),
(13, '小吃', 100, 0),
(14, '饮料', 100, 0);

-- --------------------------------------------------------

--
-- 表的结构 `app_member_card`
--

CREATE TABLE IF NOT EXISTS `app_member_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `call_id` int(11) NOT NULL COMMENT '调用ID',
  `sort` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `app_member_card`
--

INSERT INTO `app_member_card` (`id`, `title`, `content`, `call_id`, `sort`) VALUES
(1, '金卡会员', '&lt;p&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; &amp;nbsp;1、系统筛选，前12个月日均金融资产10万以上，称之为金卡客户; &amp;nbsp;前12个月日均金融资产100万以上，称之为白金卡客户; &amp;nbsp;前12个月日均金融资产500万以上，称之为钻石卡客户。&lt;br/&gt;&lt;br/&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;2、对营销客户月日均金融资产或购买投资性金融产品达到10万，100万，500万的可以直接签约成贵宾客户。但6个月内必须达到（一）条规定的相应贵宾客户准入标准。否则系统将自动扣收服务费。&lt;/p&gt;', 1, 100),
(2, '银卡会员', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px; font-family: arial, &amp;quot;pingfang sc&amp;quot;, stheiti, simsun, sans-serif; text-indent: 2em; line-height: 25px; color: rgb(51, 51, 51); font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;金卡（Preferred Card/ Gold Card）又称金属贵宾卡、电泳金卡，通常也称为贵宾卡或者VIP卡，多是黄色的。此种金卡系选用高级进口铜材，采用领先新工艺技术，经过设计、线割制模、冲压、腐蚀、印刷、抛光、电镀、填色、包装等流水作业程序精工制成 。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px; font-family: arial, &amp;quot;pingfang sc&amp;quot;, stheiti, simsun, sans-serif; text-indent: 2em; line-height: 25px; color: rgb(51, 51, 51); font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;常用规格有85mm×54mm、80mm×50mm、76mm×44mm三种，也可根据客户要求制作其它形状大小的异形卡片。根据材质分为纯金金卡、塑胶合成金卡、合金卡、PVC金卡。根据用途分为商务用途、银行用途、赠品用途、保值增值用途。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 2, 100),
(3, '普通会员', '&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 0px; font-family: arial, &amp;quot;pingfang sc&amp;quot;, stheiti, simsun, sans-serif; text-indent: 2em; line-height: 25px; color: rgb(51, 51, 51); font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&amp;nbsp;1、系统筛选，前12个月日均金融资产10万以上，称之为金卡客户; &amp;nbsp;前12个月日均金融资产100万以上，称之为白金卡客户; &amp;nbsp;前12个月日均金融资产500万以上，称之为钻石卡客户。&lt;br style=&quot;white-space: normal;&quot;/&gt;&lt;br style=&quot;white-space: normal;&quot;/&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;2、对营销客户月日均金融资产或购买投资性金融产品达到10万，100万，500万的可以直接签约成贵宾客户。但6个月内必须达到（一）条规定的相应贵宾客户准入标准。否则系统将自动扣收服务费。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 3, 100);

-- --------------------------------------------------------

--
-- 表的结构 `app_order_goods`
--

CREATE TABLE IF NOT EXISTS `app_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL COMMENT '标题',
  `thumb` varchar(255) NOT NULL COMMENT '缩略图',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单价',
  `num` int(11) NOT NULL DEFAULT '1' COMMENT '数量',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='购物车课程关系表' AUTO_INCREMENT=34 ;

--
-- 转存表中的数据 `app_order_goods`
--

INSERT INTO `app_order_goods` (`id`, `title`, `thumb`, `price`, `num`, `order_id`, `goods_id`) VALUES
(9, '测试3', '/static/upload/201809/d4b6ff5b8f9d33f2daee42768f0b1f6e.png', '2200.00', 3, 9, 21),
(10, '测试1', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '8880.00', 1, 10, 19),
(11, '测试1', '/static/upload/201809/d4b6ff5b8f9d33f2daee42768f0b1f6e.png', '2550.00', 1, 11, 22),
(12, '测试1', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '8880.00', 1, 12, 19),
(13, '测试1', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '8880.00', 1, 13, 19),
(14, '测试1', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '8880.00', 1, 14, 19),
(15, '测试4', '/static/upload/201809/6194dcecf933cf3810f9b85784d3c7fd.png', '2200.00', 1, 15, 23),
(16, '测试1', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '8880.00', 1, 16, 19),
(17, '测试4', '/static/upload/201809/6194dcecf933cf3810f9b85784d3c7fd.png', '2200.00', 1, 16, 23),
(18, '测试', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '6680.00', 1, 17, 18),
(19, '测试4', '/static/upload/201809/6194dcecf933cf3810f9b85784d3c7fd.png', '2200.00', 1, 17, 23),
(20, '测试', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '6680.00', 1, 18, 18),
(21, '测试1', '/static/upload/201809/d4b6ff5b8f9d33f2daee42768f0b1f6e.png', '2550.00', 1, 18, 22),
(22, '测试', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '6680.00', 1, 19, 18),
(23, '测试1', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '8880.00', 1, 19, 19),
(24, '测试1', '/static/upload/201809/d4b6ff5b8f9d33f2daee42768f0b1f6e.png', '2550.00', 1, 19, 22),
(25, '测试1', '/static/upload/201809/d4b6ff5b8f9d33f2daee42768f0b1f6e.png', '2550.00', 1, 20, 22),
(26, '测试', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '6680.00', 1, 20, 18),
(27, '测试1', '/static/upload/201809/d4b6ff5b8f9d33f2daee42768f0b1f6e.png', '2550.00', 1, 21, 22),
(28, '测试4', '/static/upload/201809/6194dcecf933cf3810f9b85784d3c7fd.png', '2200.00', 1, 21, 23),
(29, '测试', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '6680.00', 1, 22, 18),
(30, '测试1', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '8880.00', 1, 23, 19),
(31, '测试1', '/static/upload/201809/d4b6ff5b8f9d33f2daee42768f0b1f6e.png', '2550.00', 1, 23, 22),
(32, '测试1', '/static/upload/201809/848d628ac0cfdd92cea96347242bc101.png', '8880.00', 1, 24, 19),
(33, '测试2', '/static/upload/201809/408788564ba0fe6dfa321d89aed178c8.png', '5880.00', 2, 24, 20);

-- --------------------------------------------------------

--
-- 表的结构 `app_order_room`
--

CREATE TABLE IF NOT EXISTS `app_order_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL COMMENT '标题',
  `price` decimal(10,2) NOT NULL COMMENT '价格',
  `num` int(11) NOT NULL DEFAULT '1' COMMENT '数量',
  `order_id` int(11) NOT NULL COMMENT '订单id',
  `room_id` int(11) NOT NULL COMMENT '房间id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='购物车课程关系表' AUTO_INCREMENT=18 ;

--
-- 转存表中的数据 `app_order_room`
--

INSERT INTO `app_order_room` (`id`, `title`, `price`, `num`, `order_id`, `room_id`) VALUES
(1, '标准单人房-A楼', '10.00', 1, 1, 18),
(2, '标准单人房-B楼', '99.00', 1, 2, 20),
(3, '标准双人房-A楼', '1.00', 1, 3, 19),
(4, '标准双人房-B楼', '1.00', 1, 4, 22),
(5, '豪华双人房-C楼', '11.36', 1, 5, 20),
(6, '豪华单人房-A楼', '11.36', 1, 6, 21),
(8, '豪华家庭房-C楼', '2200.00', 1, 8, 23),
(9, '标准单人间-A楼', '8880.00', 1, 9, 19),
(10, '标准单人间-A楼', '8880.00', 1, 10, 19),
(11, '豪华单人间-B楼', '5880.00', 1, 11, 20),
(12, '豪华单人间-B楼', '5880.00', 1, 12, 20),
(13, '豪华三人间-B楼', '6680.00', 1, 13, 18),
(14, '豪华三人间-B楼', '6680.00', 1, 14, 18),
(16, '豪华单人房', '777.00', 1, 16, 26),
(17, '标准单人房', '298.00', 1, 17, 27);

-- --------------------------------------------------------

--
-- 表的结构 `app_room`
--

CREATE TABLE IF NOT EXISTS `app_room` (
  `id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) DEFAULT '0' COMMENT '1开放，0关闭',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '价格',
  `thumb` varchar(255) DEFAULT '' COMMENT '缩略图',
  `detail_img` text COMMENT '详情页顶图',
  `intro` text COMMENT '详情介绍',
  `people_type_id` int(11) unsigned DEFAULT '0' COMMENT '按人数分类型',
  `floor_type_id` int(11) DEFAULT '0' COMMENT '按楼层分类型',
  `num` int(11) DEFAULT '0' COMMENT '数量',
  `sort` mediumint(11) unsigned DEFAULT '100' COMMENT '排序',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `type_id` (`people_type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 COMMENT='课程表' AUTO_INCREMENT=31 ;

--
-- 转存表中的数据 `app_room`
--

INSERT INTO `app_room` (`id`, `is_show`, `price`, `thumb`, `detail_img`, `intro`, `people_type_id`, `floor_type_id`, `num`, `sort`, `created_time`) VALUES
(27, 1, '298.00', 'http://wx.p-city.cn/static/upload/201811/ab6f8da5dc7a510b605559a0b981ec7a.jpg', '/static/upload/201811/0e3d3d6fbca2ddfe83317175e4921be3.png', '&lt;p&gt;&lt;img src=&quot;http://wx.p-city.cn/static/upload/201811/ab6f8da5dc7a510b605559a0b981ec7a.jpg&quot;/&gt;&lt;/p&gt;', 8, 0, 26, 100, '2018-11-01 07:09:36'),
(28, 1, '328.00', 'http://wx.p-city.cn/static/upload/201811/bd0dfc8e755be45e06a7993e51b06d09.png', '/static/upload/201811/a4fee2bfcf8ed9549a870a8330c521b9.png', '&lt;p&gt;&lt;img src=&quot;http://wx.p-city.cn/static/upload/201811/bd0dfc8e755be45e06a7993e51b06d09.png&quot;/&gt;&lt;/p&gt;', 7, 0, 10, 100, '2018-11-01 07:10:42'),
(29, 1, '358.00', 'http://wx.p-city.cn/static/upload/201811/62e8c637729cc0ec66fb5d58b57c489c.png', '/static/upload/201811/ff1efdc3aa28606f505be10f1aac865b.png', '&lt;p&gt;&lt;img src=&quot;http://wx.p-city.cn/static/upload/201811/62e8c637729cc0ec66fb5d58b57c489c.png&quot;/&gt;&lt;/p&gt;', 12, 0, 30, 100, '2018-11-01 07:13:09'),
(30, 1, '588.00', 'http://wx.p-city.cn/static/upload/201811/1c1792d5ce18f3a689c747bec5975b1f.png', '/static/upload/201811/945acc18a4cab9a503f3ef9b6fbb3d0f.png', '&lt;p&gt;&lt;img src=&quot;http://wx.p-city.cn/static/upload/201811/1c1792d5ce18f3a689c747bec5975b1f.png&quot;/&gt;&lt;/p&gt;', 13, 0, 5, 100, '2018-11-01 07:14:52');

-- --------------------------------------------------------

--
-- 表的结构 `app_room_floor_type`
--

CREATE TABLE IF NOT EXISTS `app_room_floor_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '类型',
  `sort` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `app_room_floor_type`
--

INSERT INTO `app_room_floor_type` (`id`, `type`, `sort`) VALUES
(7, 'B楼', 100),
(8, 'A楼', 60),
(10, 'C楼', 100),
(11, 'D楼', 100),
(12, 'E楼', 100),
(13, 'F楼', 100);

-- --------------------------------------------------------

--
-- 表的结构 `app_room_order`
--

CREATE TABLE IF NOT EXISTS `app_room_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(30) NOT NULL DEFAULT '' COMMENT '订单编号',
  `out_trade_no` varchar(32) DEFAULT NULL COMMENT '交易编号',
  `name` varchar(10) NOT NULL COMMENT '联系人',
  `phone` varchar(11) NOT NULL COMMENT '手机号',
  `start_date` date NOT NULL COMMENT '入住日期',
  `left_date` date NOT NULL COMMENT '离店日期',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单总额',
  `pay_money` decimal(10,2) DEFAULT NULL COMMENT '实付价格',
  `is_coupon` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用优惠券',
  `coupon_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠券金额',
  `openid` char(28) NOT NULL COMMENT '用户openid',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '-1取消，0待支付，1待入住，2，待离店，3，已完成',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '伪删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `out_trade_no` (`out_trade_no`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='订单' AUTO_INCREMENT=18 ;

--
-- 转存表中的数据 `app_room_order`
--

INSERT INTO `app_room_order` (`id`, `order_no`, `out_trade_no`, `name`, `phone`, `start_date`, `left_date`, `amount`, `pay_money`, `is_coupon`, `coupon_price`, `openid`, `status`, `pay_time`, `created_time`, `deleted`) VALUES
(1, '2018062718272959061203', '20180627182731trade74083351', '小芝', '13422225555', '2018-09-05', '2018-09-08', '0.00', '10.00', 0, '0.00', 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k', 0, NULL, '2018-06-27 10:27:31', 0),
(2, '2018062718293349831863', '20180627182935trade30513114', '露露', '15666668888', '2018-09-06', '2018-09-07', '0.00', '99.00', 0, '0.00', 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k', 3, '2018-06-27 10:29:36', '2018-06-27 10:29:36', 0),
(3, '2018062718303874757922', '20180627183041trade54253676', '小彩旗', '15899996666', '2018-09-06', '2018-09-07', '0.00', '1.00', 0, '0.00', 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k', 1, NULL, '2018-06-27 10:30:41', 0),
(4, '2018062809395815863468', '20180628095114trade43199955', '琪琪', '13944442222', '2018-09-06', '2018-09-07', '0.00', '1.00', 0, '0.00', 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k', 1, '2018-06-28 01:40:02', '2018-06-28 01:40:02', 0),
(5, '2018062810084868526600', '20180628104620trade49438143', '甜馨', '06632216544', '2018-09-06', '2018-09-07', '0.00', '11.36', 0, '0.00', 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k', 2, '2018-06-28 02:46:22', '2018-06-28 02:46:22', 0),
(6, '2018062810084868526600', '20180628104620trade49438148', '甜馨', '06632216544', '2018-09-06', '2018-09-07', '0.00', '11.36', 0, '0.00', 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k', 2, '2018-06-28 02:46:22', '2018-06-28 02:46:22', 0),
(8, '20180905112735812745', NULL, '静静', '15889653851', '2018-09-06', '2018-09-07', '0.00', '0.00', 0, '0.00', 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k', -1, NULL, '2018-09-05 03:27:35', 0),
(9, '20181008160639500204', '4200000170201810106928283208', '静静', '15889653851', '2018-10-08', '2018-10-09', '8880.00', '0.01', 0, '0.00', 'otuUIuA7qA9FFwjBc4wid98ioLq4', 1, '2018-10-10 10:23:32', '2018-10-08 08:06:39', 0),
(10, '20181008170706261389', '4200000174201810089086707686', '米伟', '15889653851', '2018-10-08', '2018-10-09', '8880.00', '0.01', 0, '0.00', 'otuUIuBm6U9TB9SUWRxMZwv8sMAU', 1, '2018-10-08 09:08:15', '2018-10-08 09:07:06', 0),
(11, '20181008171117302917', NULL, '黄鸿', '13544446666', '2018-10-08', '2018-10-09', '5880.00', NULL, 0, '0.00', 'otuUIuCDazys8VUjBL4h2swGahak', 0, NULL, '2018-10-08 09:11:17', 0),
(12, '20181008171122128344', '4200000169201810089862088205', '黄鸿', '13544446666', '2018-10-08', '2018-10-09', '5880.00', '0.01', 0, '0.00', 'otuUIuCDazys8VUjBL4h2swGahak', 1, '2018-10-08 09:12:02', '2018-10-08 09:11:22', 0),
(13, '20181011090726501220', NULL, '李明', '15622891795', '2018-10-12', '2018-10-13', '6680.00', NULL, 0, '0.00', 'otuUIuGiRO_FHWR42oy88BcnbiwI', 0, NULL, '2018-10-11 01:07:26', 0),
(14, '20181011090727630419', '4200000187201810111244302779', '李明', '15622891795', '2018-10-12', '2018-10-13', '6680.00', '0.01', 0, '0.00', 'otuUIuGiRO_FHWR42oy88BcnbiwI', 1, '2018-10-11 01:08:00', '2018-10-11 01:07:27', 0),
(16, '20181101143719155535', '4200000223201811018677876055', '小惜', '15889653851', '2018-11-01', '2018-11-02', '777.00', '0.01', 0, '0.00', 'otuUIuA7qA9FFwjBc4wid98ioLq4', 1, '2018-11-01 06:38:06', '2018-11-01 06:37:19', 0),
(17, '20181105174529459033', NULL, '静静', '15889653851', '2018-11-05', '2018-11-06', '298.00', NULL, 0, '0.00', 'otuUIuA7qA9FFwjBc4wid98ioLq4', 0, NULL, '2018-11-05 09:45:29', 0);

-- --------------------------------------------------------

--
-- 表的结构 `app_room_people_type`
--

CREATE TABLE IF NOT EXISTS `app_room_people_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '类型',
  `sort` int(11) NOT NULL DEFAULT '100' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=14 ;

--
-- 转存表中的数据 `app_room_people_type`
--

INSERT INTO `app_room_people_type` (`id`, `type`, `sort`) VALUES
(7, '豪华单人房', 100),
(8, '标准单人房', 60),
(11, '豪华双人房', 100),
(12, '豪华双人房', 100),
(13, '豪华套房', 100);

-- --------------------------------------------------------

--
-- 表的结构 `app_user`
--

CREATE TABLE IF NOT EXISTS `app_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `openid` char(28) NOT NULL,
  `nickname` varchar(30) DEFAULT '' COMMENT '昵称',
  `avatarurl` varchar(255) DEFAULT NULL COMMENT '头像',
  `name` varchar(10) NOT NULL DEFAULT '' COMMENT '姓名',
  `phone` varchar(11) NOT NULL DEFAULT '' COMMENT '电话',
  `unionid` varchar(32) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='用户表' AUTO_INCREMENT=19 ;

--
-- 转存表中的数据 `app_user`
--

INSERT INTO `app_user` (`id`, `openid`, `nickname`, `avatarurl`, `name`, `phone`, `unionid`, `created_time`) VALUES
(1, 'oRdsI0ZV9g39sUx6gM0Qp-AWFm7k', '天空划过的板砖', 'https://wx.qlogo.cn/mmopen/vi_32/pyeQVEfCQiakYIoyazY9mZje06h0PUsV7flFzFPPqVcylldevozibicHk0FscYv5NPHu8XvEl1jda5ZUSnNvXFViag/132', '春暖花开', '15889653851', '', '2018-04-18 08:07:10'),
(2, 'oRdsI0d5v0QV-oP3oQgmwWBXXnbM', 'Dean', 'https://wx.qlogo.cn/mmopen/vi_32/6mnf9jwSau1ibRNIpKiaYhQVZGdhGTH49buhdpVMibWbqaIUIXrVzcE0aoS8P9dibDbE5YGiaNOjkqP4pQF07ZFX5Ew/132', '无名', '15866662222', '', '2018-04-19 09:27:56'),
(3, 'oRdsI0bYEPic2McblO1D6WJyEsT0', 'Joelon', 'https://wx.qlogo.cn/mmopen/vi_32/K3eJicgicuapDVibh12m7Q77QCOMA2xtA9H2yVd6o2bKcibUEMzxwEl6fdDmlVpGkpuuV2q8Q2jUoiaic8xiaiauDnpNdg/132', '静静', '13655559999', '', '2018-05-12 00:41:12'),
(4, 'otuUIuA7qA9FFwjBc4wid98ioLq4', '惜', 'http://thirdwx.qlogo.cn/mmopen/vi_32/ZWVIZSz4Yib0vRAAFqFuWhO0Bc4YZZaVFxKApmCfMFklvwqshAyJnpD8lQ4fbnzNTRF5qAR2MR4mWVhoN1NGPFw/132', '', '', '', '2018-10-08 07:29:30'),
(5, 'otuUIuNobsriiFK8e0Mhsqeke7N4', 'W ⁶⁶⁶', 'http://thirdwx.qlogo.cn/mmopen/vi_32/HuicibvZfd63ial0nrWdc0L9sYeWzj9KX3rGIcyO7vX3B8zrP5xoMicGs3fuJ5TNVl8SIzpvBPk4Zbh1ichCzPr1q4Q/132', '', '', '', '2018-10-08 07:29:33'),
(6, 'otuUIuBm6U9TB9SUWRxMZwv8sMAU', '天空划过的板砖', 'http://thirdwx.qlogo.cn/mmopen/vi_32/xbatSVehQiaz94jiariapKOicNEH3EMWyrZtVUvQPa0lJVrdZt50onVdZVloVI0ZTaeEmgXKTBH6c8vvVhcLdFAVtw/132', '', '', '', '2018-10-08 09:06:22'),
(7, 'otuUIuCDazys8VUjBL4h2swGahak', '萝卜猪', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Kv7MPoKqC07yvmmm0Rl2dOxAKJICiap6qgqkNNurQl6yQarTic1CRDhFCsgk8Zms6iaicIw9ZYSqwib1ic5MpicQJCb3g/132', '', '', '', '2018-10-08 09:10:47'),
(8, 'otuUIuA0Gy8kyKML75xy2mumT_h8', '流深', 'http://thirdwx.qlogo.cn/mmopen/vi_32/vyPibFiadLiaMGEw8KhiawcGqf6vWl8e8nUqMzmYfiar2yqkxfdoqYMzibG5HwGWNa0342ARPcXurt4L1KxpOJRv5jyA/132', '', '', '', '2018-10-08 09:11:54'),
(9, 'otuUIuN36mNwW9JGpCtuU3uU7-0w', 'Alan', 'http://thirdwx.qlogo.cn/mmopen/vi_32/ibmn7x2BeTFicdckdyE2vwENkcjIaBjGeVoRwk1DwXVzFFTYdp6D9HGFxbKxGWIrTKYOknMRSswZicb13zq3saIbA/132', '', '', '', '2018-10-08 09:18:58'),
(10, 'otuUIuGiRO_FHWR42oy88BcnbiwI', 'A yan', 'http://thirdwx.qlogo.cn/mmopen/vi_32/GzKMh3TdvxTS1geTYYicsDWqLNOcJFeUpnfozgEMjz7GFJ8FAklcnkab0CygSajWzy17ibMdgibpgGOcKtt24Qia3w/132', '', '', '', '2018-10-09 05:47:18'),
(11, 'otuUIuFpW73NViJcV2pFf7yi1R8s', '鹏城酒店', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqpiaYOjOmSZlFpEO4O6qFjiaNh2uUxmwc016eqvoHmNuM2nr6YttYkDlRTiaYyy1mGfDgMw0owaDXcQ/132', '', '', '', '2018-10-10 01:58:16'),
(12, 'otuUIuJgR2wQUaxou_wi1zFasI3A', 'Vincent', 'http://thirdwx.qlogo.cn/mmopen/vi_32/aRneVaen8XRjSelKuVMhTZA0nywHBIZtXYoBmuGzr5sDXmH4PXOD9B8A4KEHFfnRGUt8N0VNrxvkOT5Y1I6sFA/132', '', '', '', '2018-10-10 07:26:04'),
(13, 'otuUIuGxiMh439ADZ4M00mYQpoHA', 'Zhy', 'http://thirdwx.qlogo.cn/mmopen/vi_32/SLCmiagSSc75zxgF2InvaqthCAoiaicxsLVkwiafq0t4EJQvSAnhEIGJmEFpicK5j0ZAcQoHeaVWicqeible76oibjpcibA/132', '', '', '', '2018-10-31 06:04:29'),
(14, 'otuUIuO15Bc-q3brrNS_OweNHWPg', '仰光｀D', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLfysOLphYvmZDIW1j0aUVCgwDNwGxbMZusiboXL8SosSd9nD35Lia3PsJicS47P8JF3qJXYvMN6hYVw/132', '', '', '', '2018-11-02 01:17:32'),
(15, 'otuUIuI9xaBEttcIUHvvR0bTuW5Q', '嗨呀', 'http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83erKQNH0SOlLqq5wlCcp8wunrfZXMUGTaFqmeFCZw5RiciaRSCFldEBpCQ0KrGzQKsGwDrvEIDH76cYQ/132', '', '', '', '2018-11-02 02:19:57'),
(16, 'otuUIuKM76feNh52kq-pLth8t2OI', '未来很美', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI5ue4sdy0cNoAyk4vsf9FfMrZk6SoyRaWa6EI2R65MZ9GY361qgyy4Bqvr6ibN9xt9TvySzR8NN4Q/132', '', '', '', '2018-11-02 03:05:29'),
(17, 'otuUIuHrDhSrUJt_xEHU2-p2LB4c', '千湖之鳄', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL20JTvDS1jtKKQfxCsgsksr1mrkOMZ8VCJkvbFl14QuyhR2J7XaJyeg8EFataB27Q69sw7xXNdBQ/132', '', '', '', '2018-11-05 03:41:41'),
(18, 'otuUIuFYJT6h9-sUpS3puq1ar6bU', '鹏城酒店  李顺方', 'http://thirdwx.qlogo.cn/mmopen/vi_32/bmCSHseDKjgzHPP0P5BAMdLmvKRGH73jaUColCsPSVlD5dy7pSXujDLEHqsCBpObkK5ryr1Yia9gN0BTwticGtIA/132', '', '', '', '2018-11-05 06:23:09');

-- --------------------------------------------------------

--
-- 表的结构 `app_user_coupon`
--

CREATE TABLE IF NOT EXISTS `app_user_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `coupon_id` int(11) DEFAULT NULL COMMENT '优惠券id',
  `is_used` tinyint(1) DEFAULT '0' COMMENT '是否使用',
  `order_id` int(11) DEFAULT '0' COMMENT '订单id',
  `created_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '领取时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `app_user_coupon`
--

INSERT INTO `app_user_coupon` (`id`, `user_id`, `coupon_id`, `is_used`, `order_id`, `created_time`) VALUES
(1, 1, 1, 0, 0, '2018-09-06 18:06:26'),
(2, 1, 2, 0, 0, '2018-09-06 18:07:32'),
(5, 1, 7, 0, 0, '2018-09-19 09:24:24');

-- --------------------------------------------------------

--
-- 表的结构 `system_auth`
--

CREATE TABLE IF NOT EXISTS `system_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL COMMENT '权限名称',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `sort` smallint(6) unsigned DEFAULT '0' COMMENT '排序权重',
  `desc` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `create_by` bigint(11) unsigned DEFAULT '0' COMMENT '创建人',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_system_auth_title` (`title`) USING BTREE,
  KEY `index_system_auth_status` (`status`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统权限表' AUTO_INCREMENT=10001 ;

--
-- 转存表中的数据 `system_auth`
--

INSERT INTO `system_auth` (`id`, `title`, `status`, `sort`, `desc`, `create_by`, `create_at`) VALUES
(10000, '超级用户', 1, 0, '拥有所有权限', 0, '2017-08-07 07:34:48');

-- --------------------------------------------------------

--
-- 表的结构 `system_auth_node`
--

CREATE TABLE IF NOT EXISTS `system_auth_node` (
  `auth` bigint(20) unsigned DEFAULT NULL COMMENT '角色ID',
  `node` varchar(200) DEFAULT NULL COMMENT '节点路径',
  KEY `index_system_auth_auth` (`auth`) USING BTREE,
  KEY `index_system_auth_node` (`node`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与节点关系表';

--
-- 转存表中的数据 `system_auth_node`
--

INSERT INTO `system_auth_node` (`auth`, `node`) VALUES
(10000, 'admin'),
(10000, 'admin/auth'),
(10000, 'admin/auth/index'),
(10000, 'admin/auth/apply'),
(10000, 'admin/auth/add'),
(10000, 'admin/auth/edit'),
(10000, 'admin/auth/forbid'),
(10000, 'admin/auth/resume'),
(10000, 'admin/config'),
(10000, 'admin/config/index'),
(10000, 'admin/config/file'),
(10000, 'admin/log'),
(10000, 'admin/log/index'),
(10000, 'admin/log/del'),
(10000, 'admin/menu'),
(10000, 'admin/menu/add'),
(10000, 'admin/menu/edit'),
(10000, 'admin/menu/del'),
(10000, 'admin/menu/forbid'),
(10000, 'admin/menu/resume'),
(10000, 'admin/node'),
(10000, 'admin/node/index'),
(10000, 'admin/node/save'),
(10000, 'admin/user'),
(10000, 'admin/user/index'),
(10000, 'admin/user/auth'),
(10000, 'admin/user/add'),
(10000, 'admin/user/edit'),
(10000, 'admin/user/pass'),
(10000, 'admin/user/del'),
(10000, 'admin/user/forbid'),
(10000, 'admin/user/resume'),
(10000, 'wechat'),
(10000, 'wechat/config'),
(10000, 'wechat/config/index'),
(10000, 'wechat/config/pay'),
(10000, 'wechat/fans'),
(10000, 'wechat/fans/index'),
(10000, 'wechat/fans/back'),
(10000, 'wechat/fans/backdel'),
(10000, 'wechat/fans/tagadd'),
(10000, 'wechat/fans/tagdel'),
(10000, 'wechat/keys'),
(10000, 'wechat/keys/index'),
(10000, 'wechat/keys/add'),
(10000, 'wechat/keys/edit'),
(10000, 'wechat/keys/del'),
(10000, 'wechat/keys/forbid'),
(10000, 'wechat/keys/resume'),
(10000, 'wechat/keys/subscribe'),
(10000, 'wechat/keys/defaults'),
(10000, 'wechat/menu'),
(10000, 'wechat/menu/index'),
(10000, 'wechat/menu/edit'),
(10000, 'wechat/menu/cancel'),
(10000, 'wechat/news'),
(10000, 'wechat/news/index'),
(10000, 'wechat/news/select'),
(10000, 'wechat/news/image'),
(10000, 'wechat/news/add'),
(10000, 'wechat/news/edit'),
(10000, 'wechat/news/del'),
(10000, 'wechat/news/push'),
(10000, 'wechat/tags'),
(10000, 'wechat/tags/index'),
(10000, 'wechat/tags/add'),
(10000, 'wechat/tags/edit'),
(10000, 'wechat/tags/sync');

-- --------------------------------------------------------

--
-- 表的结构 `system_config`
--

CREATE TABLE IF NOT EXISTS `system_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '配置编码',
  `value` varchar(500) DEFAULT NULL COMMENT '配置值',
  PRIMARY KEY (`id`),
  KEY `index_system_config_name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统参数配置' AUTO_INCREMENT=216 ;

--
-- 转存表中的数据 `system_config`
--

INSERT INTO `system_config` (`id`, `name`, `value`) VALUES
(148, 'site_name', '鹏程酒店'),
(149, 'site_copy', '三牛犇科技'),
(164, 'storage_type', 'local'),
(165, 'storage_qiniu_is_https', '1'),
(166, 'storage_qiniu_bucket', 'static'),
(167, 'storage_qiniu_domain', 'static.ctolog.com'),
(168, 'storage_qiniu_access_key', 'OAFHGzCgZjod2-s4xr-g5ptkXsNbxDO_t2fozIEC'),
(169, 'storage_qiniu_secret_key', 'gy0aYdSFMSayQ4kMkgUeEeJRLThVjLpUJoPFxd-Z'),
(170, 'storage_qiniu_region', '华东'),
(173, 'app_name', 'SNB · CMS'),
(174, 'app_version', 'V1.0.1'),
(176, 'browser_icon', 'http://sanniuben.com/favicon.ico'),
(184, 'wechat_appid', 'wx75e3e6e9c127d509'),
(185, 'wechat_appsecret', '6759cabd64f4657d9abc230e6452951d'),
(186, 'wechat_token', '1CLMgmlEHJ42AALjdfic'),
(187, 'wechat_encodingaeskey', 'wwePhUPzxkbCaltBNRYGDHHDqgvedXHwkjVpdJpIubB'),
(188, 'wechat_mch_id', '1238127002'),
(189, 'wechat_partnerkey', 'YkPza8DzHZIPnIg94tvKIhCPPx8LhuGi'),
(194, 'wechat_cert_key', ''),
(196, 'wechat_cert_cert', ''),
(197, 'tongji_baidu_key', 'aa2f9869e9b578122e4692de2bd9f80f'),
(198, 'tongji_cnzz_key', '1261854404'),
(199, 'storage_oss_bucket', 'think-oss'),
(200, 'storage_oss_keyid', 'WjeX0AYSfgy5VbXQ'),
(201, 'storage_oss_secret', 'hQTENHy6MYVUTgwjcgfOCq5gckm2Lp'),
(202, 'storage_oss_domain', 'think-oss.oss-cn-shanghai.aliyuncs.com'),
(203, 'storage_oss_is_https', '1'),
(204, 'site_keywords', '致力于用数据驱动帮助企业互联网战略决策-深圳市三牛犇科技有限公司，24小时咨询热线：0755-85291626'),
(205, 'site_mobile', ''),
(206, 'site_landline', '075585291626'),
(207, 'site_qq', ''),
(208, 'site_email', 'service@sanniuben.com'),
(209, 'site_beian', '粤ICP备 15008493号-3'),
(211, 'site_description', '深圳市三牛犇科技有限公司是一家专业从事企业服务，大数据服务，互联网+产品孵化的数据驱动型企业，24小时咨询热线：0755-85291626'),
(212, 'video_filename', 'http://ocsial.daoak.com/static/upload/ba7140891a0ea5c6/87db14788005c5e2.mp4'),
(214, 'video_thumb', 'http://47.94.169.211:888/static/upload/020aa5de8769dcd4/e71a37fec09be644.jpg'),
(215, 'banner_file', 'http://www.meixun.com/static/upload/201804/6a32a630a643ee14bb8d70c9e12fe9a1.png|http://www.meixun.com/static/upload/201804/0929a1ca4dd468fcf9ee310a381e77d7.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `system_log`
--

CREATE TABLE IF NOT EXISTS `system_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `node` char(200) NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `action` varchar(200) NOT NULL DEFAULT '' COMMENT '操作行为',
  `content` text NOT NULL COMMENT '操作内容描述',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统操作日志表' AUTO_INCREMENT=224 ;

--
-- 转存表中的数据 `system_log`
--

INSERT INTO `system_log` (`id`, `ip`, `node`, `username`, `action`, `content`, `create_at`) VALUES
(148, '119.137.53.185', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-12 06:40:51'),
(149, '119.137.53.185', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-12 07:31:06'),
(150, '119.137.53.185', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-12 07:41:46'),
(151, '119.137.53.185', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-12 09:32:07'),
(152, '119.137.55.121', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-16 09:24:09'),
(153, '119.137.53.224', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-17 02:56:15'),
(154, '119.137.53.9', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-31 03:07:28'),
(155, '0.0.0.0', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-07-31 03:25:20'),
(156, '0.0.0.0', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-21 01:47:55'),
(157, '0.0.0.0', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-08-21 01:48:10'),
(158, '0.0.0.0', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-21 01:48:29'),
(159, '119.137.52.117', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-30 07:40:07'),
(160, '119.137.52.117', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-08-30 08:44:48'),
(161, '119.137.54.78', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-03 08:14:25'),
(162, '119.137.53.253', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-04 01:00:39'),
(163, '119.137.53.253', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-04 02:09:11'),
(164, '119.137.53.253', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-05 02:34:30'),
(165, '0.0.0.0', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-05 06:45:14'),
(166, '0.0.0.0', 'admin/config/index', 'admin', '系统管理', '修改系统配置参数成功', '2018-09-05 08:52:16'),
(167, '0.0.0.0', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-06 01:00:59'),
(168, '119.137.52.62', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-10 08:46:15'),
(169, '119.137.55.180', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-11 01:37:51'),
(170, '119.137.53.223', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-11 06:01:41'),
(171, '119.137.53.223', 'wechat/config/index', 'admin', '微信管理', '修改微信接口参数成功', '2018-09-11 06:08:48'),
(172, '119.137.53.223', 'wechat/config/index', 'admin', '微信管理', '修改微信接口参数成功', '2018-09-11 06:10:51'),
(173, '119.137.53.223', 'wechat/config/pay', 'admin', '微信管理', '修改微信支付参数成功', '2018-09-11 06:23:56'),
(174, '119.137.53.223', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-11 07:25:29'),
(175, '119.137.55.180', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-12 02:29:57'),
(176, '119.137.55.180', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-12 06:09:43'),
(177, '119.137.54.152', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-13 09:51:00'),
(178, '119.137.54.103', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-18 03:41:05'),
(179, '119.137.54.103', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-18 03:42:52'),
(180, '119.137.55.73', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-18 08:28:39'),
(181, '119.137.54.103', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-19 10:29:53'),
(182, '119.137.55.181', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-20 03:36:43'),
(183, '119.137.55.181', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-20 06:40:36'),
(184, '119.137.53.26', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-25 01:09:54'),
(185, '119.137.53.19', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-25 02:12:14'),
(186, '119.137.53.19', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-25 03:10:28'),
(187, '119.137.53.19', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-25 06:17:25'),
(188, '119.137.54.178', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-27 02:53:03'),
(189, '119.137.53.125', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-09-28 11:43:36'),
(190, '119.137.53.249', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-08 10:54:30'),
(191, '119.137.53.137', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-09 01:22:54'),
(192, '119.137.53.251', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-10 07:29:10'),
(193, '119.137.53.251', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-10 07:30:03'),
(194, '119.137.53.251', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-10 07:30:04'),
(195, '113.89.41.54', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-10 07:30:09'),
(196, '119.137.53.251', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-10-10 07:30:20'),
(197, '119.137.53.251', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-10 07:54:54'),
(198, '119.137.54.184', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-11 00:53:02'),
(199, '112.97.57.163', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-11 01:23:21'),
(200, '119.137.55.41', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-10-31 06:02:36'),
(201, '119.137.55.41', 'wechat/config/index', 'admin', '微信管理', '修改微信接口参数成功', '2018-10-31 06:02:57'),
(202, '113.89.42.152', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-01 02:41:13'),
(203, '119.137.54.139', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-01 02:51:16'),
(204, '113.89.42.152', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-01 03:14:36'),
(205, '113.89.42.152', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-01 06:29:20'),
(206, '113.89.42.152', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-01 06:44:20'),
(207, '119.137.55.28', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-01 06:45:17'),
(208, '113.89.42.152', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-01 06:54:29'),
(209, '119.137.55.28', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-11-01 06:54:50'),
(210, '119.137.55.28', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-01 07:10:44'),
(211, '119.137.55.28', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-01 09:18:07'),
(212, '113.89.40.94', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 01:05:50'),
(213, '113.89.40.94', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 02:27:40'),
(214, '119.137.55.28', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 02:38:34'),
(215, '119.137.55.28', 'admin/login/out', 'admin', '系统管理', '用户退出系统成功', '2018-11-02 03:09:48'),
(216, '119.137.55.28', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 03:09:56'),
(217, '113.89.40.94', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 03:13:57'),
(218, '113.89.40.94', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 03:15:58'),
(219, '119.137.55.28', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 03:16:38'),
(220, '119.137.54.139', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 03:17:03'),
(221, '113.89.40.94', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 03:25:18'),
(222, '113.89.40.94', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 06:08:47'),
(223, '113.89.40.94', 'admin/login/index', 'admin', '系统管理', '用户登录系统成功', '2018-11-02 06:55:37');

-- --------------------------------------------------------

--
-- 表的结构 `system_menu`
--

CREATE TABLE IF NOT EXISTS `system_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父id',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
  `node` varchar(200) NOT NULL DEFAULT '' COMMENT '节点代码',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `url` varchar(400) NOT NULL DEFAULT '' COMMENT '链接',
  `params` varchar(500) DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) NOT NULL DEFAULT '_self' COMMENT '链接打开方式',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '菜单排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `create_by` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index_system_menu_node` (`node`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统菜单表' AUTO_INCREMENT=147 ;

--
-- 转存表中的数据 `system_menu`
--

INSERT INTO `system_menu` (`id`, `pid`, `title`, `node`, `icon`, `url`, `params`, `target`, `sort`, `status`, `create_by`, `create_at`) VALUES
(2, 0, '系统管理', '', '', '#', '', '_self', 999, 1, 0, '2015-11-16 03:15:38'),
(3, 4, '后台首页', '', 'fa fa-fw fa-tachometer', 'admin/index/main', '', '_self', 1, 1, 0, '2015-11-16 21:27:25'),
(4, 2, '系统配置', '', '', '#', '', '_self', 1, 1, 0, '2016-03-14 02:12:55'),
(5, 4, '网站参数', '', 'fa fa-apple', 'admin/config/index', '', '_self', 6, 1, 0, '2016-05-05 22:36:49'),
(6, 4, '文件存储', '', 'fa fa-hdd-o', 'admin/config/file', '', '_self', 3, 0, 0, '2016-05-05 22:39:43'),
(9, 20, '操作日志', '', 'glyphicon glyphicon-console', 'admin/log/index', '', '_self', 50, 1, 0, '2017-03-23 23:49:31'),
(19, 20, '权限管理', '', 'fa fa-user-secret', 'admin/auth/index', '', '_self', 2, 1, 0, '2015-11-16 21:18:12'),
(20, 2, '系统权限', '', '', '#', '', '_self', 20, 1, 0, '2016-03-14 02:11:41'),
(21, 20, '系统菜单', '', 'glyphicon glyphicon-menu-hamburger', 'admin/menu/index', '', '_self', 30, 1, 0, '2015-11-16 03:16:16'),
(22, 20, '节点管理', '', 'fa fa-ellipsis-v', 'admin/node/index', '', '_self', 21, 1, 0, '2015-11-16 03:16:16'),
(29, 20, '系统用户', '', 'fa fa-users', 'admin/user/index', '', '_self', 40, 1, 0, '2016-10-30 22:31:40'),
(62, 2, '微信对接配置', '', '', '#', '', '_self', 22, 1, 0, '2017-03-28 19:03:38'),
(63, 62, '微信接口配置\r\n', '', 'fa fa-usb', 'wechat/config/index', '', '_self', 3, 1, 0, '2017-03-28 19:04:44'),
(64, 62, '微信支付配置', '', 'fa fa-paypal', 'wechat/config/pay', '', '_self', 5, 1, 0, '2017-03-28 19:05:29'),
(87, 0, '应用管理', '', '', '#', '', '_self', 4, 1, 0, '2017-08-07 01:27:13'),
(95, 107, '常态内容', '', 'fa fa-file-powerpoint-o', 'content/index', '', '_self', 100, 1, 0, '2017-08-08 23:05:33'),
(107, 87, '其他', '', '', '#', '', '_self', 1006, 1, 0, '2017-08-30 05:47:07'),
(108, 107, '轮播图', '', 'fa fa-file-photo-o', 'banner/index', '', '_self', 90, 1, 0, '2017-09-06 03:47:58'),
(112, 87, '房间管理', '', '', '#', '', '_self', 80, 1, 0, '2018-04-09 03:43:27'),
(113, 112, '房间列表', '', 'fa fa-square', '/admin/room/index', '', '_self', 100, 1, 0, '2018-04-09 03:45:08'),
(117, 112, '房间分类', '', 'fa fa-database', 'admin/roompeopletype/index', '', '_self', 100, 1, 0, '2018-04-11 02:10:16'),
(132, 87, '用户管理', '', '', '#', '', '_self', 100, 1, 0, '2018-05-08 07:23:48'),
(133, 132, '用户列表', '', 'fa fa-user', '/admin/users/index', '', '_self', 100, 1, 0, '2018-05-08 07:25:28'),
(135, 107, '联系方式', '', 'fa fa-phone', '/admin/contact/index', '', '_self', 100, 1, 0, '2018-05-13 06:33:42'),
(136, 87, '订单管理', '', '', '#', '', '_self', 100, 1, 0, '2018-05-20 07:24:48'),
(137, 136, '订房列表', '', 'fa fa-mars-stroke-v', '/admin/roomorder/index', '', '_self', 100, 1, 0, '2018-05-20 07:26:13'),
(140, 87, '商品管理', '', '', '#', '', '_self', 90, 1, 0, '2018-09-05 08:55:16'),
(141, 140, '商品列表', '', 'fa fa-bars', 'admin/goods/index', '', '_self', 100, 1, 0, '2018-09-05 08:56:13'),
(142, 140, '商品分类', '', 'fa fa-sitemap', 'admin/goodstype/index', '', '_self', 100, 1, 0, '2018-09-05 08:56:43'),
(144, 136, '订餐列表', '', 'fa fa-bars', 'admin/goodsorder/index', '', '_self', 100, 1, 0, '2018-09-06 02:37:39'),
(145, 107, '优惠券设置', '', 'glyphicon glyphicon-credit-card', 'admin/coupon/index', '', '_self', 100, 1, 0, '2018-09-06 06:36:57'),
(146, 107, '会员设置', '', 'glyphicon glyphicon-user', 'admin/membercard/index', '', '_self', 100, 1, 0, '2018-09-07 06:15:24');

-- --------------------------------------------------------

--
-- 表的结构 `system_node`
--

CREATE TABLE IF NOT EXISTS `system_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(100) DEFAULT NULL COMMENT '节点代码',
  `title` varchar(500) DEFAULT NULL COMMENT '节点标题',
  `is_menu` tinyint(1) unsigned DEFAULT '0' COMMENT '是否可设置为菜单',
  `is_auth` tinyint(1) unsigned DEFAULT '1' COMMENT '是启启动RBAC权限控制',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index_system_node_node` (`node`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统节点表' AUTO_INCREMENT=138 ;

--
-- 转存表中的数据 `system_node`
--

INSERT INTO `system_node` (`id`, `node`, `title`, `is_menu`, `is_auth`, `create_at`) VALUES
(3, 'admin', '后台', 0, 1, '2017-03-10 07:31:29'),
(4, 'admin/menu/add', '添加菜单', 1, 1, '2017-03-10 07:32:21'),
(5, 'admin/config', '系统配置', 0, 1, '2017-03-10 07:32:56'),
(6, 'admin/config/index', '网站配置', 1, 1, '2017-03-10 07:32:58'),
(7, 'admin/config/file', '文件配置', 1, 1, '2017-03-10 07:33:02'),
(8, 'admin/config/mail', '邮件配置', 0, 0, '2017-03-10 07:36:42'),
(9, 'admin/config/sms', '短信配置', 0, 0, '2017-03-10 07:36:43'),
(10, 'admin/menu/index', '菜单列表', 1, 0, '2017-03-10 07:36:50'),
(11, 'admin/node/index', '节点列表1', 1, 1, '2017-03-10 07:36:59'),
(12, 'admin/node/save', '节点更新', 1, 1, '2017-03-10 07:36:59'),
(13, 'store/menu/index', '菜单列表', 1, 1, '2017-03-10 07:37:22'),
(14, 'store/menu/add', '添加菜单', 0, 1, '2017-03-10 07:37:23'),
(15, 'store/menu/edit', '编辑菜单', 0, 1, '2017-03-10 07:37:24'),
(16, 'store/menu/del', '删除菜单', 0, 1, '2017-03-10 07:37:24'),
(17, 'admin/index/index', '', 1, 1, '2017-03-10 07:39:23'),
(18, 'admin/index/main', '', 0, 1, '2017-03-14 08:21:54'),
(19, 'admin/index/pass', NULL, 0, 1, '2017-03-14 08:25:56'),
(20, 'admin/index/info', NULL, 0, 1, '2017-03-14 08:25:57'),
(21, 'store/menu/tagmove', '移动标签', 0, 1, '2017-03-14 09:07:12'),
(22, 'store/menu/tagedit', '编辑标签', 0, 1, '2017-03-14 09:07:13'),
(23, 'store/menu/tagdel', '删除标签', 0, 1, '2017-03-14 09:07:13'),
(24, 'store/menu/resume', '启用菜单', 0, 1, '2017-03-14 09:07:14'),
(25, 'store/menu/forbid', '禁用菜单', 0, 1, '2017-03-14 09:07:15'),
(26, 'store/menu/tagadd', '添加标签', 0, 1, '2017-03-14 09:07:15'),
(27, 'store/menu/hot', '设置热卖', 0, 1, '2017-03-14 09:07:18'),
(28, 'admin/index', '', 0, 1, '2017-03-14 09:27:00'),
(29, 'store/order/index', '订单列表', 1, 1, '2017-03-14 09:52:51'),
(30, 'store/index/qrcimg', '店铺二维码', 0, 1, '2017-03-14 09:52:52'),
(31, 'store/index/edit', '编辑店铺', 0, 1, '2017-03-14 09:52:55'),
(32, 'store/index/qrc', '二维码列表', 0, 1, '2017-03-14 09:52:56'),
(33, 'store/index/add', '添加店铺', 0, 1, '2017-03-14 09:52:56'),
(34, 'store/index/index', '我的店铺', 1, 1, '2017-03-14 09:52:57'),
(35, 'store/api/delcache', NULL, 0, 1, '2017-03-14 09:52:59'),
(36, 'store/api/getcache', NULL, 0, 1, '2017-03-14 09:53:00'),
(37, 'store/api/setcache', NULL, 0, 1, '2017-03-14 09:53:01'),
(38, 'store/api/response', NULL, 0, 1, '2017-03-14 09:53:01'),
(39, 'store/api/auth', NULL, 0, 1, '2017-03-14 09:53:02'),
(40, 'admin/user/resume', '启用用户', 1, 1, '2017-03-14 09:53:03'),
(41, 'admin/user/forbid', '禁用用户', 1, 1, '2017-03-14 09:53:03'),
(42, 'admin/user/del', '', 1, 1, '2017-03-14 09:53:04'),
(43, 'admin/user/pass', '密码修改', 1, 1, '2017-03-14 09:53:04'),
(44, 'admin/user/edit', '编辑用户', 1, 1, '2017-03-14 09:53:05'),
(45, 'admin/user/index', '用户列表', 1, 1, '2017-03-14 09:53:07'),
(46, 'admin/user/auth', '用户授权', 1, 1, '2017-03-14 09:53:08'),
(47, 'admin/user/add', '新增用户', 1, 1, '2017-03-14 09:53:09'),
(48, 'admin/plugs/icon', NULL, 0, 1, '2017-03-14 09:53:09'),
(49, 'admin/plugs/upload', NULL, 0, 1, '2017-03-14 09:53:10'),
(50, 'admin/plugs/upfile', NULL, 0, 1, '2017-03-14 09:53:11'),
(51, 'admin/plugs/upstate', NULL, 0, 1, '2017-03-14 09:53:11'),
(52, 'admin/menu/resume', '菜单启用1', 1, 1, '2017-03-14 09:53:14'),
(53, 'admin/menu/forbid', '菜单禁用', 1, 1, '2017-03-14 09:53:15'),
(54, 'admin/login/index', NULL, 0, 1, '2017-03-14 09:53:17'),
(55, 'admin/login/out', '', 0, 1, '2017-03-14 09:53:18'),
(56, 'admin/menu/edit', '编辑菜单', 1, 1, '2017-03-14 09:53:20'),
(57, 'admin/menu/del', '菜单删除', 1, 1, '2017-03-14 09:53:21'),
(58, 'store/menu', '菜谱管理', 0, 1, '2017-03-14 09:57:47'),
(59, 'store/index', '店铺管理', 0, 1, '2017-03-14 09:58:28'),
(60, 'store', '店铺管理', 0, 1, '2017-03-14 09:58:29'),
(61, 'store/order', '订单管理', 0, 1, '2017-03-14 09:58:56'),
(62, 'admin/user', '用户管理', 0, 1, '2017-03-14 09:59:39'),
(63, 'admin/node', '节点管理', 0, 1, '2017-03-14 09:59:53'),
(64, 'admin/menu', '菜单管理', 0, 1, '2017-03-14 10:00:31'),
(65, 'admin/auth', ' fdsf', 0, 1, '2017-03-17 06:37:05'),
(66, 'admin/auth/index', '这是备忘的', 1, 1, '2017-03-17 06:37:14'),
(67, 'admin/auth/apply', '', 1, 1, '2017-03-17 06:37:29'),
(68, 'admin/auth/add', '', 1, 1, '2017-03-17 06:37:32'),
(69, 'admin/auth/edit', '权限编辑', 1, 1, '2017-03-17 06:37:36'),
(70, 'admin/auth/forbid', '禁用权限', 1, 1, '2017-03-17 06:37:38'),
(71, 'admin/auth/resume', '启用权限', 1, 1, '2017-03-17 06:37:41'),
(72, 'admin/auth/del', '删除', 1, 0, '2017-03-17 06:37:47'),
(73, 'admin/log/index', '日志列表', 1, 1, '2017-03-25 01:54:57'),
(74, 'admin/log/del', '删除日志', 1, 1, '2017-03-25 01:54:59'),
(75, 'admin/log', '系统日志1111q.', 0, 1, '2017-03-25 02:56:53'),
(76, 'wechat', '微信管理', 0, 1, '2017-04-05 02:52:31'),
(77, 'wechat/article', '微信文章', 0, 1, '2017-04-05 02:52:47'),
(78, 'wechat/article/index', '文章列表', 1, 1, '2017-04-05 02:52:54'),
(79, 'wechat/config', '微信配置', 0, 1, '2017-04-05 02:53:02'),
(80, 'wechat/config/index', '微信接口配置', 0, 1, '2017-04-05 02:53:16'),
(81, 'wechat/config/pay', '微信支付配置', 0, 1, '2017-04-05 02:53:18'),
(82, 'wechat/fans', '微信粉丝', 0, 1, '2017-04-05 02:53:34'),
(83, 'wechat/fans/index', '粉丝列表', 1, 1, '2017-04-05 02:53:39'),
(84, 'wechat/index', '微信主页', 0, 1, '2017-04-05 02:53:49'),
(85, 'wechat/index/index', '微信主页', 1, 1, '2017-04-05 02:53:49'),
(86, 'wechat/keys', '微信关键字', 0, 1, '2017-04-05 02:54:00'),
(87, 'wechat/keys/index', '关键字列表', 1, 1, '2017-04-05 02:54:14'),
(88, 'wechat/keys/subscribe', '关键自动回复', 0, 1, '2017-04-05 02:54:23'),
(89, 'wechat/keys/defaults', '默认自动回复', 0, 1, '2017-04-05 02:54:29'),
(90, 'wechat/menu', '微信菜单管理', 0, 1, '2017-04-05 02:54:34'),
(91, 'wechat/menu/index', '微信菜单', 0, 1, '2017-04-05 02:54:41'),
(92, 'wechat/news', '微信图文管理', 0, 1, '2017-04-05 02:54:51'),
(93, 'wechat/news/index', '图文列表', 0, 1, '2017-04-05 02:54:59'),
(94, 'wechat/notify/index', '', 0, 0, '2017-04-05 09:59:20'),
(95, 'wechat/api/index', '', 1, 1, '2017-04-06 01:30:28'),
(96, 'wechat/api', '', 0, 1, '2017-04-06 02:11:23'),
(97, 'wechat/notify', '', 0, 1, '2017-04-10 02:37:33'),
(98, 'wechat/fans/sync', '同步粉丝', 0, 0, '2017-04-13 08:30:29'),
(99, 'wechat/menu/edit', '编辑微信菜单', 0, 1, '2017-04-19 15:36:52'),
(100, 'wechat/menu/cancel', '取消微信菜单', 0, 1, '2017-04-19 15:36:54'),
(101, 'wechat/keys/edit', '编辑关键字', 1, 1, '2017-04-21 02:24:09'),
(102, 'wechat/keys/add', '添加关键字', 1, 1, '2017-04-21 02:24:09'),
(103, 'wechat/review/index', NULL, 0, 1, '2017-04-21 02:24:11'),
(104, 'wechat/review', '', 0, 1, '2017-04-21 02:24:18'),
(105, 'wechat/keys/del', '删除关键字', 0, 1, '2017-04-21 06:22:31'),
(106, 'wechat/news/add', '添加图文', 0, 1, '2017-04-22 14:17:29'),
(107, 'wechat/news/select', '图文选择器', 1, 1, '2017-04-22 14:17:31'),
(108, 'wechat/keys/resume', '启用关键字', 0, 1, '2017-04-25 03:03:52'),
(109, 'wechat/news/edit', '编辑', 0, 1, '2017-04-25 08:15:23'),
(110, 'wechat/news/push', '推送图文2', 0, 1, '2017-04-25 14:32:08'),
(111, 'wechat/news/del', '删除图文', 0, 1, '2017-04-26 02:48:24'),
(112, 'wechat/keys/forbid', '禁用关键字', 0, 1, '2017-04-26 02:48:28'),
(113, 'wechat/tags/index', '标签', 1, 1, '2017-05-04 08:03:37'),
(114, 'wechat/tags/add', '添加标签', 1, 1, '2017-05-05 04:48:28'),
(115, 'wechat/tags/edit', '编辑标签', 1, 1, '2017-05-05 04:48:29'),
(116, 'wechat/tags/sync', '同步标签', 0, 1, '2017-05-05 04:48:30'),
(117, 'wechat/tags', '粉丝标签管理', 0, 1, '2017-05-05 05:17:12'),
(118, 'wechat/fans/backdel', '移除粉丝黑名单', 1, 1, '2017-05-05 08:56:23'),
(119, 'wechat/fans/backadd', '移入粉丝黑名单', 1, 0, '2017-05-05 08:56:30'),
(120, 'wechat/fans/back', '粉丝黑名单列表', 1, 1, '2017-05-05 08:56:38'),
(121, 'wechat/fans/tagadd', '添加粉丝标签', 0, 1, '2017-05-08 06:46:13'),
(122, 'wechat/fans/tagdel', '删除粉丝标签', 0, 1, '2017-05-08 06:46:20'),
(123, 'wechat/fans/tagset', '', 1, 0, '2017-05-16 09:59:09'),
(124, 'wechat/news/image', '', 1, 1, '2017-05-22 07:24:41'),
(125, 'admin/article', '', 0, 1, '2017-09-04 08:39:58'),
(126, 'admin/article/index', '', 0, 1, '2017-09-04 08:40:00'),
(127, 'admin/activity/index', NULL, 1, 1, '2018-08-30 08:50:46'),
(128, 'admin/banner/index', NULL, 1, 1, '2018-08-30 08:51:04'),
(129, 'admin/roomfloortype/index', NULL, 1, 0, '2018-09-05 09:45:32'),
(130, 'admin/roompeopletype/index', NULL, 1, 1, '2018-09-05 09:45:38'),
(131, 'admin/coupon/index', NULL, 1, 1, '2018-09-06 06:31:39'),
(132, 'admin/goods/index', NULL, 1, 1, '2018-09-07 06:08:50'),
(133, 'admin/goodsorder/index', NULL, 1, 1, '2018-09-07 06:08:51'),
(134, 'admin/goodstype/index', NULL, 1, 1, '2018-09-07 06:08:52'),
(135, 'admin/membercard/index', NULL, 1, 1, '2018-09-07 06:08:55'),
(136, 'admin/room/index', NULL, 1, 1, '2018-09-07 06:08:59'),
(137, 'admin/roomorder/index', NULL, 1, 1, '2018-09-07 06:09:02');

-- --------------------------------------------------------

--
-- 表的结构 `system_sequence`
--

CREATE TABLE IF NOT EXISTS `system_sequence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL COMMENT '序号类型',
  `sequence` char(50) NOT NULL COMMENT '序号值',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_system_sequence_unique` (`type`,`sequence`) USING BTREE,
  KEY `index_system_sequence_type` (`type`),
  KEY `index_system_sequence_number` (`sequence`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统序号表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `system_sequence`
--

INSERT INTO `system_sequence` (`id`, `type`, `sequence`, `create_at`) VALUES
(1, 'WECHAT-PAY-TEST', '7853974998', '2018-05-17 08:28:27'),
(2, 'WXPAY-OUTER-NO', '428348196603201015', '2018-05-17 08:28:27'),
(3, 'WECHAT-PAY-TEST', '9895028796', '2018-09-11 06:24:00'),
(4, 'WXPAY-OUTER-NO', '557805288800955861', '2018-09-11 06:24:00');

-- --------------------------------------------------------

--
-- 表的结构 `system_sort`
--

CREATE TABLE IF NOT EXISTS `system_sort` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table` varchar(30) NOT NULL COMMENT '表名',
  `sort` varchar(20) NOT NULL DEFAULT 'asc' COMMENT '排序方式',
  PRIMARY KEY (`id`),
  UNIQUE KEY `table` (`table`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `system_sort`
--

INSERT INTO `system_sort` (`id`, `table`, `sort`) VALUES
(1, 'WebProduct', 'desc'),
(5, 'WebArticle', 'desc'),
(6, 'WebConnect', 'asc');

-- --------------------------------------------------------

--
-- 表的结构 `system_user`
--

CREATE TABLE IF NOT EXISTS `system_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户登录名',
  `password` char(64) NOT NULL DEFAULT '' COMMENT '用户登录密码',
  `qq` varchar(16) DEFAULT NULL COMMENT '联系QQ',
  `mail` varchar(32) DEFAULT NULL COMMENT '联系邮箱',
  `phone` varchar(16) DEFAULT NULL COMMENT '联系手机号',
  `desc` varchar(255) DEFAULT '' COMMENT '备注说明',
  `login_num` bigint(20) unsigned DEFAULT '0' COMMENT '登录次数',
  `login_at` datetime DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `authorize` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除状态(1:删除,0:未删)',
  `create_by` bigint(20) unsigned DEFAULT NULL COMMENT '创建人',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_system_user_username` (`username`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统用户表' AUTO_INCREMENT=10002 ;

--
-- 转存表中的数据 `system_user`
--

INSERT INTO `system_user` (`id`, `username`, `password`, `qq`, `mail`, `phone`, `desc`, `login_num`, `login_at`, `status`, `authorize`, `is_deleted`, `create_by`, `create_at`) VALUES
(10000, 'admin', '$2y$10$bKVPDBAiHwjQ2dcLfa2OFeu36bjg8aR7BmzN4uIb2Fsz6u.OxZY1S', '22222222', '330725119@qq.com', '18674554840', '系统超级管理员', 265, '2018-11-02 14:55:37', 1, '10000', 0, NULL, '2015-11-13 07:14:22'),
(10001, 'root', '$2y$10$SqOZ.0N01.wWoEU5cKnaOeKD4K0pMneeE4wZbD9zPrEuEBCFbqypu', NULL, '123.123@123.123', '13612345678', 'root', 1, '2017-09-01 15:30:21', 1, NULL, 0, NULL, '2017-09-01 07:29:33');

-- --------------------------------------------------------

--
-- 表的结构 `web_contact`
--

CREATE TABLE IF NOT EXISTS `web_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(10) NOT NULL COMMENT '联系人',
  `phone` varchar(30) NOT NULL COMMENT '联系电话',
  `call_id` int(11) NOT NULL COMMENT '调用id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='联系方式表' AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `web_contact`
--

INSERT INTO `web_contact` (`id`, `title`, `phone`, `call_id`) VALUES
(1, '联系方式1', '0755-27999666', 1),
(2, '联系方式2', '0755-27999988', 2),
(3, '地址', '深圳市龙华区观澜大道75号', 3),
(4, '传真', '0755-27999666', 4);

-- --------------------------------------------------------

--
-- 表的结构 `web_content`
--

CREATE TABLE IF NOT EXISTS `web_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `call_id` int(11) NOT NULL COMMENT '调用id',
  `title` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `created` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `web_content`
--

INSERT INTO `web_content` (`id`, `call_id`, `title`, `content`, `created`) VALUES
(1, 1, '总经理致辞', '&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;作为服务型企业，我们视宾客为亲人，竭诚为您提供快捷、舒适、专业、标准的服务体验；作为学习型企业，我们视员工为资本，为员工提供系统的培训和施展才华的舞台；作为生命型企业，我们视企业文化为生命，传承和发展置信企业文化，实施“外树品牌，内创口碑”的品牌战略，不断形成可持续的品牌和文化影响力。&lt;br/&gt;&lt;/p&gt;', 1504056256),
(2, 2, '酒店简介', '&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; 鹏城酒店成立于2009年，位于深圳市龙华区观澜大道75号，距离亚洲最大的观澜高尔夫球场仅10分钟车程；距离深圳北站仅15分钟车程；距离深圳宝安国际机场仅20分钟车程；驱车前往机荷高速公路出入口只需3分钟车程，与观澜汽车总站近在咫尺。&lt;/p&gt;&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;&lt;br/&gt;&lt;/p&gt;', 1530949395),
(3, 3, '退订规则', '&lt;p&gt;&lt;span style=&quot;color: rgb(127, 127, 127);&quot;&gt;订单下单成功将不可以取消退订；如未能如约入住，将收取全额的房费作为违约费用&lt;/span&gt;&lt;/p&gt;', 1530949521),
(4, 4, '温馨提示', '&lt;p&gt;&lt;span style=&quot;color: rgb(127, 127, 127);&quot;&gt;订单下单成功将不可以取消退订；如未能如约入住，将收取全额的房费作为违约费用&lt;/span&gt;&lt;br/&gt;&lt;/p&gt;', 1536133085);

-- --------------------------------------------------------

--
-- 表的结构 `wechat_fans`
--

CREATE TABLE IF NOT EXISTS `wechat_fans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '粉丝表ID',
  `appid` varchar(50) DEFAULT NULL COMMENT '公众号Appid',
  `groupid` bigint(20) unsigned DEFAULT NULL COMMENT '分组ID',
  `tagid_list` varchar(100) DEFAULT '' COMMENT '标签id',
  `is_back` tinyint(1) unsigned DEFAULT '0' COMMENT '是否为黑名单用户',
  `subscribe` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户是否订阅该公众号，0：未关注，1：已关注',
  `openid` char(100) NOT NULL DEFAULT '' COMMENT '用户的标识，对当前公众号唯一',
  `spread_openid` char(100) DEFAULT NULL COMMENT '推荐人OPENID',
  `spread_at` datetime DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL COMMENT '用户的昵称',
  `sex` tinyint(1) unsigned DEFAULT NULL COMMENT '用户的性别，值为1时是男性，值为2时是女性，值为0时是未知',
  `country` varchar(50) DEFAULT NULL COMMENT '用户所在国家',
  `province` varchar(50) DEFAULT NULL COMMENT '用户所在省份',
  `city` varchar(50) DEFAULT NULL COMMENT '用户所在城市',
  `language` varchar(50) DEFAULT NULL COMMENT '用户的语言，简体中文为zh_CN',
  `headimgurl` varchar(500) DEFAULT NULL COMMENT '用户头像',
  `subscribe_time` bigint(20) unsigned DEFAULT NULL COMMENT '用户关注时间',
  `subscribe_at` datetime DEFAULT NULL COMMENT '关注时间',
  `unionid` varchar(100) DEFAULT NULL COMMENT 'unionid',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `expires_in` bigint(20) unsigned DEFAULT '0' COMMENT '有效时间',
  `refresh_token` varchar(200) DEFAULT NULL COMMENT '刷新token',
  `access_token` varchar(200) DEFAULT NULL COMMENT '访问token',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index_wechat_fans_spread_openid` (`spread_openid`) USING BTREE,
  KEY `index_wechat_fans_openid` (`openid`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='微信粉丝' AUTO_INCREMENT=10002 ;

--
-- 转存表中的数据 `wechat_fans`
--

INSERT INTO `wechat_fans` (`id`, `appid`, `groupid`, `tagid_list`, `is_back`, `subscribe`, `openid`, `spread_openid`, `spread_at`, `nickname`, `sex`, `country`, `province`, `city`, `language`, `headimgurl`, `subscribe_time`, `subscribe_at`, `unionid`, `remark`, `expires_in`, `refresh_token`, `access_token`, `create_at`) VALUES
(10000, 'wx152298ecf8af4443', 0, '', 0, 1, 'oeU7i0o9ckfZrxKSfa2dr3z6ctG4', NULL, NULL, '木子伟', 1, '阿根廷', '布宜诺斯艾利斯', '', 'zh_CN', 'http://wx.qlogo.cn/mmopen/dXGcRAck3mfQmsexXVs5Qdq6oV6t4ncWoibjVxVIatu6UicBCoB1q5yz2hPAbWeVjsH6lJ5RWQS3bPM1KLe60IribHXxdDo5oXd/0', 1504164749, '2017-08-31 15:32:29', NULL, '', 0, NULL, NULL, '2017-08-31 08:05:42'),
(10001, 'wx152298ecf8af4443', 0, '', 0, 1, 'oeU7i0mbfcixYEfWCIuyUm3BZ30w', NULL, NULL, 'Chris', 2, '中国', '广东', '深圳', 'en', 'http://wx.qlogo.cn/mmopen/O5IB5rptd1rfauKsA3qXrRwmbXt2tCIicbVLkcVaLbibSI5fFwtUqZ3XAM4DMorpMMBSZYRPeLw1GVOGRt9RnjcxLohsV9naJv/0', 1491801108, '2017-04-10 13:11:48', NULL, '', 0, NULL, NULL, '2017-09-03 23:35:21');

-- --------------------------------------------------------

--
-- 表的结构 `wechat_pay_notify`
--

CREATE TABLE IF NOT EXISTS `wechat_pay_notify` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) DEFAULT NULL COMMENT '公众号Appid',
  `bank_type` varchar(50) DEFAULT NULL COMMENT '银行类型',
  `cash_fee` bigint(20) DEFAULT NULL COMMENT '现金价',
  `fee_type` char(20) DEFAULT NULL COMMENT '币种，1人民币',
  `is_subscribe` char(1) DEFAULT 'N' COMMENT '是否关注，Y为关注，N为未关注',
  `mch_id` varchar(50) DEFAULT NULL COMMENT '商户MCH_ID',
  `nonce_str` varchar(32) DEFAULT NULL COMMENT '随机串',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信用户openid',
  `out_trade_no` varchar(50) DEFAULT NULL COMMENT '支付平台退款交易号',
  `sign` varchar(100) DEFAULT NULL COMMENT '签名',
  `time_end` datetime DEFAULT NULL COMMENT '结束时间',
  `result_code` varchar(10) DEFAULT NULL,
  `return_code` varchar(10) DEFAULT NULL,
  `total_fee` varchar(11) DEFAULT NULL COMMENT '支付总金额，单位为分',
  `trade_type` varchar(20) DEFAULT NULL COMMENT '支付方式',
  `transaction_id` varchar(64) DEFAULT NULL COMMENT '订单号',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '本地系统时间',
  PRIMARY KEY (`id`),
  KEY `index_wechat_pay_notify_openid` (`openid`) USING BTREE,
  KEY `index_wechat_pay_notify_out_trade_no` (`out_trade_no`) USING BTREE,
  KEY `index_wechat_pay_notify_transaction_id` (`transaction_id`) USING BTREE
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='支付日志表' AUTO_INCREMENT=10000 ;

-- --------------------------------------------------------

--
-- 表的结构 `wechat_pay_prepayid`
--

CREATE TABLE IF NOT EXISTS `wechat_pay_prepayid` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `appid` char(50) DEFAULT NULL COMMENT '公众号APPID',
  `from` char(32) DEFAULT 'shop' COMMENT '支付来源',
  `fee` bigint(20) unsigned DEFAULT NULL COMMENT '支付费用(分)',
  `trade_type` varchar(20) DEFAULT NULL COMMENT '订单类型',
  `order_no` varchar(50) DEFAULT NULL COMMENT '内部订单号',
  `out_trade_no` varchar(50) DEFAULT NULL COMMENT '外部订单号',
  `prepayid` varchar(500) DEFAULT NULL COMMENT '预支付码',
  `expires_in` bigint(20) unsigned DEFAULT NULL COMMENT '有效时间',
  `transaction_id` varchar(64) DEFAULT NULL COMMENT '微信平台订单号',
  `is_pay` tinyint(1) unsigned DEFAULT '0' COMMENT '1已支付，0未支退款',
  `pay_at` datetime DEFAULT NULL COMMENT '支付时间',
  `is_refund` tinyint(1) unsigned DEFAULT '0' COMMENT '是否退款，退款单号(T+原来订单)',
  `refund_at` datetime DEFAULT NULL COMMENT '退款时间',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '本地系统时间',
  PRIMARY KEY (`id`),
  KEY `index_wechat_pay_prepayid_outer_no` (`out_trade_no`) USING BTREE,
  KEY `index_wechat_pay_prepayid_order_no` (`order_no`) USING BTREE,
  KEY `index_wechat_pay_is_pay` (`is_pay`) USING BTREE,
  KEY `index_wechat_pay_is_refund` (`is_refund`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='支付订单号对应表' AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `wechat_pay_prepayid`
--

INSERT INTO `wechat_pay_prepayid` (`id`, `appid`, `from`, `fee`, `trade_type`, `order_no`, `out_trade_no`, `prepayid`, `expires_in`, `transaction_id`, `is_pay`, `pay_at`, `is_refund`, `refund_at`, `create_at`) VALUES
(1, 'wx321c5e5f299d15ea', 'wechat', 1, 'NATIVE', '7853974998', '428348196603201015', 'weixin://wxpay/bizpayurl?pr=jg4LKXN', 1526551107, NULL, 0, NULL, 0, NULL, '2018-05-17 08:28:27'),
(2, 'wx75e3e6e9c127d509', 'wechat', 1, 'NATIVE', '9895028796', '557805288800955861', 'weixin://wxpay/bizpayurl?pr=Ql38p6N', 1536652442, NULL, 0, NULL, 0, NULL, '2018-09-11 06:24:02');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
