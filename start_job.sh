#!/bin/bash

#颜色 35紫色
ECHO_COLOR=35


# 打印眼熟
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
        *)
            diyecho "作用:\n 初始化服务器及部署指定middleware\n"  $ECHO_COLOR
            diyecho "用法:\n start_job.sh  [选项] ... [参数] ...\n\n选项列表:"  $ECHO_COLOR
            diyecho "mysql       -- mysql工具"  $ECHO_COLOR
            diyecho "postgresql  -- postgresql工具"  $ECHO_COLOR
        esac
}


case $1 in

  mysql)
     case $2 in
      mysql-install)
          ansible-playbook --tags mysql-install   -v   -e "MYSQL_PORT=$3" -i inventory/hosts.ini main.yaml
      ;;
      mysql-uninstall)
          ansible-playbook --tags mysql-uninstall -v -e "MYSQL_PORT=$3" -i inventory/hosts.ini main.yaml
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
          ansible-playbook --tags=postgresql-install -i inventory/hosts.ini main.yaml
      ;;
     *)
       usage postgresql
       exit 1
     ;;
     esac
  ;;
  mongodb)
      case $2 in
      mongodb-bak)
          ansible-playbook --tags=mongodb-bak -e "ENV=$3"  -i hosts main.yaml
      ;;
      *)
      echo "Usage: ./start_job.sh mongodb [ mongodb-bak C0519[ENV] ] "
      exit 1
     ;;
     esac
  ;;
  *) 
    usage
    exit 1
  ;; 
esac