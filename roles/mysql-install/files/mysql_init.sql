alter user root@'localhost' identified by 'yonbip2021!';

CREATE USER 'rw_all_db'@'%' IDENTIFIED BY 'yonbip2021root!';
CREATE USER 'ro_all_db'@'%' IDENTIFIED BY 'yonbip2021user!';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, PROCESS, REFERENCES, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER ON *.* TO 'rw_all_db'@'%';

GRANT SELECT ON *.* TO 'ro_all_db'@'%';

CREATE USER 'root'@'%';
GRANT ALL PRIVILEGES ON *.*  TO 'root'@'%';
alter user root@'%' identified by 'yonbip2021!';

flush privileges;