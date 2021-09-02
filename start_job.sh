#!/bin/bash

#颜色 35紫色
ECHO_COLOR=35


# 打印颜色
function diyecho(){
	echo -e "\033[0;$2m$1 \033[0m"
}


function usage(){
    case $1 in
        mysql)
            diyecho "用法:\n mysql-install [端口号]\n"  $ECHO_COLOR
            diyecho " mysql-uninstall [端口号]\n"  $ECHO_COLOR
            diyecho "例子:\n start_job.sh  mysql mysql-install 3306"  $ECHO_COLOR
            diyecho "例子:\n start_job.sh  mysql mysql-uninstall 3306"  $ECHO_COLOR
        ;;
        postgresql)
            diyecho "用法:\n postgresql-install \n"  $ECHO_COLOR
            diyecho "例子:\n start_job.sh postgresql postgresql-install"  $ECHO_COLOR   
        ;;
        rabbitmq)
            diyecho "用法:\n start_job.sh rabbitmq rabbitmq-install"  $ECHO_COLOR
            diyecho "用法:\n start_job.sh rabbitmq rabbitmq-uninstall"  $ECHO_COLOR
            diyecho "用法:\n start_job.sh rabbitmq rabbitmq-check_status"  $ECHO_COLOR   
        ;; 
        mongodb)
            diyecho "安装用法:\n start_job.sh mongodb mongodb-install"  $ECHO_COLOR 
            diyecho "卸载用法:\n start_job.sh mongodb mongodb-uninstall"  $ECHO_COLOR 
        ;; 
        zookeeper)
            diyecho "用法:\n start_job.sh zookeeper zookeeper-install"  $ECHO_COLOR
            diyecho "用法:\n start_job.sh zookeeper zookeeper-uninstall"  $ECHO_COLOR 
        ;;
        kafka)
            diyecho "用法:\n start_job.sh kafka kafka-install"  $ECHO_COLOR
        ;;
        elasticsearch)
            diyecho "用法:\n start_job.sh elasticsearch elasticsearch-install"  $ECHO_COLOR
            diyecho "用法:\n start_job.sh elasticsearch elasticsearch-uninstall"  $ECHO_COLOR
        ;; 
        redis-cluster)
            diyecho "用法:\n start_job.sh redis-cluster redis-cluster-install"  $ECHO_COLOR
        ;; 
        fastdfs)
            diyecho "用法:\n start_job.sh fastdfs fastdfs-install"  $ECHO_COLOR
            diyecho "用法:\n start_job.sh fastdfs fastdfs-check_status"  $ECHO_COLOR
        ;;       
        nginx)
            diyecho "用法:\n start_job.sh nginx nginx-install"  $ECHO_COLOR
            diyecho "用法:\n start_job.sh nginx nginx-uninstall"  $ECHO_COLOR
            diyecho "用法:\n start_job.sh nginx nginx-check_status"  $ECHO_COLOR 
        ;; 
        *)
            diyecho "作用:\n 初始化服务器及部署指定middleware\n"  $ECHO_COLOR
            diyecho "用法:\n start_job.sh  [选项] ... [参数] ...\n\n选项列表:"  $ECHO_COLOR
            diyecho "mysql          -- mysql工具"  $ECHO_COLOR
            diyecho "postgresql     -- postgresql工具"  $ECHO_COLOR
            diyecho "rabbitmq       -- rabbitmq工具"  $ECHO_COLOR
            diyecho "mongodb        -- mongodb工具"  $ECHO_COLOR
            diyecho "redis-cluster  -- redis工具"  $ECHO_COLOR
            diyecho "nginx          -- nginx 工具"  $ECHO_COLOR
            diyecho "zookeeper      -- zookeeper 工具"  $ECHO_COLOR
            diyecho "kafka          -- kafka 工具"  $ECHO_COLOR
            diyecho "elasticsearch  -- elasticsearch 工具"  $ECHO_COLOR
            diyecho "fastdfs        -- fastdfs 工具"  $ECHO_COLOR
        esac
}


case $1 in

  mysql)
     case $2 in
      mysql-install)
          ansible-playbook --tags=mysql-install   -v   -e "MYSQL_PORT=$3" -i inventory/mysql.ini tasks/mysql.yaml
      ;;
      mysql-uninstall)
          ansible-playbook --tags=mysql-uninstall -v   -e "MYSQL_PORT=$3" -i inventory/mysql.ini tasks/mysql.yaml
      ;;
      *)
        usage mysql
        exit 1
     ;;
     esac
  ;;  
  postgresql)
      case $2 in
      postgresql-install)
          ansible-playbook --tags=postgresql-install -i inventory/postgresql.ini tasks/postgresql.yaml
      ;;
     *)
       usage postgresql
       exit 1
     ;;
     esac
  ;;
  rabbitmq)
      case $2 in
      rabbitmq-install)
          ansible-playbook --tags=rabbitmq-install -i inventory/rabbitmq.ini  tasks/rabbitmq.yaml
      ;;
      rabbitmq-uninstall)
          ansible-playbook --tags=rabbitmq-uninstall -i inventory/rabbitmq.ini tasks/rabbitmq.yaml
      ;;
      rabbitmq-check_status)
          ansible-playbook --tags=rabbitmq-check_status -i inventory/rabbitmq.ini tasks/rabbitmq.yaml
      ;;   
     *)
       usage rabbitmq
       exit 1
     ;;
     esac
  ;;
  nginx)
     case $2 in
      nginx-install)
          ansible-playbook --tags=nginx-install  -i inventory/nginx.ini  tasks/nginx.yaml
      ;;
      nginx-uninstall)
          ansible-playbook --tags=nginx-uninstall  -i inventory/nginx.ini  tasks/nginx.yaml
      ;;
      nginx-check_status)
          ansible-playbook --tags=nginx-check_status  -i inventory/nginx.ini  tasks/nginx.yaml       
      ;;
      *)
        usage nginx
        exit 1
     ;;
     esac
 ;;
 zookeeper)
      case $2 in
      zookeeper-install)
          ansible-playbook --tags=zookeeper-install -i inventory/zookeeper.ini tasks/zookeeper.yaml
      ;;
      zookeeper-uninstall)
          ansible-playbook --tags=zookeeper-uninstall -i inventory/zookeeper.ini tasks/zookeeper.yaml
      ;;  
      *)
        usage zookeeper
        exit 1
     ;;
     esac
  ;;
  kafka)
      case $2 in
      kafka-install)
          ansible-playbook --tags=zookeeper-install -i inventory/kafka.ini  tasks/zookeeper.yaml
          ansible-playbook --e "run_mode=Deploy" -i inventory/kafka.ini  tasks/kafka.yaml
      ;;
      *)
        usage kafka
        exit 1
     ;;
     esac
  ;; 
  elasticsearch)
      case $2 in
      elasticsearch-install)
          ansible-playbook --tags=elasticsearch-install -i inventory/elasticsearch.ini  tasks/elasticsearch.yaml
      ;;
      elasticsearch-uninstall)
          ansible-playbook --tags=elasticsearch-uninstall -i inventory/elasticsearch.ini  tasks/elasticsearch.yaml
      ;;
      *)
        usage elasticsearch
        exit 1
     ;;
     esac
  ;; 
  redis-cluster)
      case $2 in
      redis-cluster-install)
          ansible-playbook  -i inventory/redis-cluster.ini  tasks/redis-cluster.yaml
      ;;
      *)
        usage redis-cluster
        exit 1
     ;;
     esac
  ;;
  fastdfs)
      case $2 in
      fastdfs-install)
          ansible-playbook --tags=install -i inventory/fastdfs.ini  tasks/fastdfs.yaml
      ;;
      fastdfs-check_status)
          ansible-playbook --tags=check_status -i inventory/fastdfs.ini  tasks/fastdfs.yaml
      ;;
      *)
        usage fastdfs
        exit 1
     ;;
     esac
  ;;  
  mongodb)
      case $2 in
      mongodb-install)
          ansible-playbook  -i inventory/mongodb.ini  -e "action=install"   tasks/mongodb.yaml
      ;;
      mongodb-uninstall)
          ansible-playbook  -i inventory/mongodb.ini  -e "action=uninstall"  tasks/mongodb.yaml
      ;; 
      *)
        usage mongodb
        exit 1
     ;;
     esac
  ;;
  *) 
    usage
    exit 1
  ;; 
esac