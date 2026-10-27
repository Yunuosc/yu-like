-- 演示数据：首次启动时由 MySQL 容器自动执行
-- 登录方式：前端输入用户 ID（1~6），无需密码
SET NAMES utf8mb4;
USE thumb_db;

INSERT INTO `user` (id, username) VALUES
    (1, '鱼皮'),
    (2, '松柏'),
    (3, 'yes'),
    (4, '程序员小灰'),
    (5, '阿伟'),
    (6, '小钰')
ON DUPLICATE KEY UPDATE username = VALUES(username);

INSERT INTO `blog` (id, userId, title, coverImg, content, thumbCount, createTime, updateTime) VALUES
    (1, 1, 'Redis 缓存穿透、击穿、雪崩的完整解决方案',
     '/images/image%20(1).png',
     '缓存穿透是查询根本不存在的数据，请求绕过缓存直击数据库；击穿是热点 Key 过期瞬间大量并发涌入；雪崩则是大批 Key 同时失效。本文结合点赞系统，分别给出空值缓存、互斥锁、逻辑过期、过期时间打散等落地手段，并给出选型建议。',
     12, '2026-10-01 09:30:00', '2026-10-01 09:30:00'),
    (2, 2, 'Pulsar 消息队列在点赞系统中的实践',
     '/images/image%20(2).png',
     '点赞写多读少的特性非常适合异步化。本文介绍如何用 Pulsar 承接点赞事件，通过批量消费把数据库写入从每条一次压缩到每批一次，并配置 ACK 超时、负确认与死信队列，保证消息不丢不重。',
     8, '2026-10-02 10:15:00', '2026-10-02 10:15:00'),
    (3, 3, 'HeavyKeeper 热点 Key 探测与本地缓存',
     '/images/image%20(3).png',
     '热点数据会集中打到单个 Redis 分片。HeavyKeeper 通过概率衰减的计数桶，用极小内存找出 TopK 热点 Key，再配合 Caffeine 做本地缓存，把单机热点读请求拦在 JVM 内。',
     5, '2026-10-03 14:20:00', '2026-10-03 14:20:00'),
    (4, 1, 'Spring Boot 3 + Java 21 虚拟线程实战',
     '/images/image%20(4).png',
     'Java 21 的虚拟线程让阻塞式代码也能获得高吞吐。本文演示在 Spring Boot 3 中开启虚拟线程，把同步 IO 任务交给虚拟线程执行，并对比平台线程池的吞吐与内存占用。',
     21, '2026-10-04 08:45:00', '2026-10-04 08:45:00'),
    (5, 4, 'Nginx 反向代理与前端同源部署',
     '/images/image%20(5).png',
     '前后端分离项目常见的 404、跨域、Cookie 丢失，多数源于代理路径与请求头配置。本文给出 Nginx 托管 Vue 静态资源、原样转发 /api 前缀、透传 Cookie 的标准配置。',
     3, '2026-10-05 16:00:00', '2026-10-05 16:00:00'),
    (6, 5, '用 Lua 脚本保证 Redis 多命令原子性',
     '/images/image%20(6).png',
     '点赞需要同时判断是否已点赞、写入用户点赞集合、累加计数。多条命令分开执行会出现并发覆盖，Lua 脚本在 Redis 单线程内一次执行，既保证原子性又减少网络往返。',
     9, '2026-10-06 11:10:00', '2026-10-06 11:10:00'),
    (7, 6, 'MySQL 批量写入优化：从逐条到批量',
     '/images/image%20(7).png',
     '逐条 insert 在高并发下会被网络与事务开销拖垮。本文对比单条插入、JDBC batch、MyBatis-Plus saveBatch 三种方式，并说明批量大小、事务边界与主键冲突处理。',
     6, '2026-10-07 19:25:00', '2026-10-07 19:25:00'),
    (8, 2, 'Docker Compose 编排本地中间件',
     '/images/image%20(8).png',
     '把 MySQL、Redis、Pulsar 写进一份 compose，用 healthcheck 控制启动顺序，用命名卷保留数据，用服务名互相访问。本文整理了一份可直接复用的本地开发编排模板与常见排错清单。',
     15, '2026-10-08 13:40:00', '2026-10-08 13:40:00')
ON DUPLICATE KEY UPDATE title = VALUES(title);
