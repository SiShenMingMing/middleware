#!/bin/bash


case $1 in

  mysql)
     case $2 in
      mysql-install)
          ansible-playbook --tags=mysql-install -e "MYSQL_PORT=$3" -i inventory/hosts.ini /all.yaml
      ;;
     *)
      echo "Usage: ./start_job.sh mysql [ mysql-install 3306 | mysql-uninstall 3306 | mysql-bak C0519 ] "
      exit 1
     ;;
     esac
  ;;  
  postgresql)
      case $2 in
      postgresql-install)
          ansible-playbook --tags=postgresql-install -i hosts main.yaml
      ;;
      postgresql-bak)
          ansible-playbook --tags=postgresql-bak -e "ENV=$3"  -i hosts main.yaml
      ;;
     *)
      echo "Usage: ./start_job.sh postgresql [postgresql-install | postgresql-bak C0519[ENV] ] "
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
    echo "Usage: ./start_job.sh [ azq | mysql | postgresql | mongodb ] "
    exit 1
  ;; 
esac