## 项目说明

yonbip 数据库中间件部署和运维管理


## 清单

数据库

    mysql         [ok]
    postgresql    [ok]
    mongodb       [ok]
中间件

    nginx         [ok]
    elasticSearch [ok]
    kafka         [ok]
    fastdfs       [ok]
    rabbitmq      [ok]
    zookeeper     [ok]
    redis         [ok]
    influxdb      []
    bind          []

其他

    mysql备份     []
    pg备份        []


## 目录结构


    ├── group_vars       变量

    ├── inventory        主机清单模板
       
    ├── packages         工具包源码包等

    ├── README.md        说明文档

    ├── tasks            任务yaml文件入口

        └── roles        角色文件


## 使用步骤

1)  规划中间件的结构和服务器资源

2)  在inventory目录下修改对应中间件的ini主机清单文件

3)  执行start_job.sh

        chmod +x start_job.sh
        bash start_job.sh

        输出如下：

        作用:
         初始化服务器及部署指定middleware

        用法:
         start_job.sh  [选项] ... [参数] ...

        选项列表: 
        mysql          -- mysql工具 
        postgresql     -- postgresql工具 
        rabbitmq       -- rabbitmq工具 
        mongodb        -- mongodb工具 
        redis-cluster  -- redis工具 
        nginx          -- nginx 工具 
        zookeeper      -- zookeeper 工具 
        kafka          -- kafka 工具 
        elasticsearch  -- elasticsearch 工具 
        fastdfs        -- fastdfs 工具 