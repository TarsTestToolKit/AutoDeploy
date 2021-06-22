/*
 Navicat Premium Data Transfer
 
 Source Server         : tars
 Source Server Type    : MySQL
 Source Server Version : 50650
 Source Host           : localhost:3307
 Source Schema         : db_test_tool_kit
 
 Target Server Type    : MySQL
 Target Server Version : 50650
 File Encoding         : 65001
 
 Date: 12/04/2021 11:49:04
 */
DROP DATABASE IF EXISTS `db_test_tool_kit`;
CREATE DATABASE `db_test_tool_kit` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use `db_test_tool_kit`;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
-- ----------------------------
-- Table structure for tbl_cpu_stats
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cpu_stats`;
CREATE TABLE `tbl_cpu_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `test_id` int(10) unsigned NOT NULL COMMENT 'test id',
  `total` bigint(20) unsigned NOT NULL COMMENT 'total time of cpu stats',
  `idle` bigint(20) unsigned NOT NULL COMMENT 'cpu idle time',
  `used` bigint(20) unsigned NOT NULL COMMENT 'cpu used time',
  `create_time` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_test_id_ts` (`test_id`, `create_time`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- ----------------------------
-- Table structure for tbl_mem_stats
-- ----------------------------
DROP TABLE IF EXISTS `tbl_mem_stats`;
CREATE TABLE `tbl_mem_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `test_id` int(10) unsigned NOT NULL COMMENT 'test id',
  `total` bigint(20) unsigned NOT NULL,
  `used` bigint(20) unsigned NOT NULL,
  `cached` bigint(20) unsigned NOT NULL,
  `free` bigint(20) unsigned NOT NULL,
  `active` bigint(20) unsigned NOT NULL,
  `inactive` bigint(20) unsigned NOT NULL,
  `swap_total` bigint(20) unsigned NOT NULL,
  `swap_used` bigint(20) unsigned NOT NULL,
  `swap_free` bigint(20) unsigned NOT NULL,
  `create_time` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_test_id_ts` (`test_id`, `create_time`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- ----------------------------
-- Table structure for tbl_perf_test_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbl_perf_test_detail`;
CREATE TABLE `tbl_perf_test_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `test_id` int(10) unsigned NOT NULL COMMENT '测试ID',
  `qps` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'QPS',
  `total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总请求量',
  `succ` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '成功请求量',
  `failed` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '失败请求量',
  `succ_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '成功率（放大一万倍），10000代表100%',
  `cost_max` float unsigned NOT NULL DEFAULT '0' COMMENT '最大耗时(ms)',
  `cost_min` float unsigned NOT NULL DEFAULT '0' COMMENT '最小耗时(ms)',
  `cost_avg` float unsigned NOT NULL DEFAULT '0' COMMENT '平均耗时(ms)',
  `p90` float unsigned NOT NULL DEFAULT '0' COMMENT 'P90（百分之90的请求在多长时间内完成）',
  `p99` float unsigned NOT NULL DEFAULT '0' COMMENT 'P99（百分之99的请求在多长时间内完成）',
  `p999` float unsigned NOT NULL DEFAULT '0' COMMENT 'P999（百分之999的请求在多长时间内完成）',
  `send` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发送字节数',
  `recv` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '接收字节数',
  `cost_map` text COLLATE utf8mb4_unicode_ci COMMENT '响应耗时和耗时计数的map关系，0~10ms:10, 10~30ms:20',
  `ret_map` text COLLATE utf8mb4_unicode_ci COMMENT '响应code和code次数的map关系, 0:1000, 400:50',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '采集时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_test` (`test_id`, `create_time`) USING BTREE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- ----------------------------
-- Table structure for tbl_perf_tests
-- ----------------------------
DROP TABLE IF EXISTS `tbl_perf_tests`;
CREATE TABLE `tbl_perf_tests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `serv_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '服务器类型',
  `lang` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '被测语言',
  `serv_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被测服务名称：TestUnits.cpp.TestObj',
  `fn_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '被测接口',
  `cores` int(10) unsigned DEFAULT NULL COMMENT '服务器核数',
  `threads` int(10) unsigned DEFAULT NULL COMMENT '线程数',
  `conn_cnt` int(10) unsigned DEFAULT NULL COMMENT '每个节点的连接数',
  `frequency` int(10) unsigned DEFAULT NULL COMMENT '每个节点的请求速率',
  `keep_alive` int(10) unsigned DEFAULT NULL COMMENT '测试时长',
  `pkg_len` int(10) unsigned DEFAULT NULL COMMENT '压测包大小：0K,1K...',
  `start_time` int(10) unsigned NOT NULL COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL COMMENT '结束时间',
  `finished` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '是否压测完成',
  `memo` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `warm_up` int(10) unsigned NOT NULL DEFAULT 0 COMMENT '预热时间(s)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_serv_type` (`serv_type`(64)),
  KEY `idx_time` (`start_time`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
SET FOREIGN_KEY_CHECKS = 1;