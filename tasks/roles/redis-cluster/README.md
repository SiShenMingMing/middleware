# ansible-redis（20200220）

| 服务组件 |           默认端口          |
| -------- | --------------------------- |
| redis    | 6379                        |
| sentinel | 26379                       |
| cluster  | 6379服务端口，16379集群通讯 |

## 功能介绍

  1. 部署单点；
  2. 部署主从；
  3. 部署Sentinel集群；
  4. 部署Cluster集群；
  5. 卸载单点、主从、Sentinel集群、Cluster集群。

## 部署功能定义（hosts）

  * 部署单点

``` ini
[redis-master]
10.10.10.21 redis_port=6379

[all:vars]
redis_password=Ufsoft123
```

  * 部署主从

``` ini
[redis-master]
10.10.10.21 redis_port=6379

[redis-slave]
10.10.10.22 redis_port=6379
10.10.10.23 redis_port=6379

[all:vars]
redis_password=Ufsoft123
```

  * 部署Sentinel集群

``` ini
[redis-master]
10.10.10.21 redis_port=6379

[redis-slave]
10.10.10.22 redis_port=6379
10.10.10.23 redis_port=6379

[redis-sentinel]
10.10.10.21 redis_sentinel=True redis_sentinel_port=26379
10.10.10.22 redis_sentinel=True redis_sentinel_port=26379
10.10.10.23 redis_sentinel=True redis_sentinel_port=26379

[all:vars]
cluster_name=mymaster
redis_password=Ufsoft123
redis_sentinel_password=Ufsoft123
```

  * 部署Cluster集群

``` ini
[redis-cluster]
10.10.10.21 redis_master_port=6379 redis_slave_port=6380
10.10.10.22 redis_master_port=6379 redis_slave_port=6380
10.10.10.23 redis_master_port=6379 redis_slave_port=6380

[redis-cluster:vars]
redis_cluster_password=Ufsoft123
```

## 卸载功能定义（hosts）

  * 卸载单点

``` ini
[redis-cluster-uninstall]
10.10.10.21 redis_port=6379
```

  * 卸载主从
``` ini
[redis-cluster-uninstall]
10.10.10.21 redis_port=6379
10.10.10.22 redis_port=6379
10.10.10.23 redis_port=6379
```

  * 卸载Sentinel集群

``` ini
[redis-cluster-uninstall]
10.10.10.21 redis_port=6379 redis_sentinel_port=26379
10.10.10.22 redis_port=6379 redis_sentinel_port=26379
10.10.10.23 redis_port=6379 redis_sentinel_port=26379
```

  * 卸载Cluster集群

``` ini
[redis-cluster-uninstall]
10.10.10.21 redis_master_port=6379 redis_slave_port=6380
10.10.10.22 redis_master_port=6379 redis_slave_port=6380
10.10.10.23 redis_master_port=6379 redis_slave_port=6380
```

## playbook（redis_cluster.yml）

``` yml
- name: configure the master redis server
  hosts: redis-master
  vars:
    - used_redis_config: true
  roles:
    - middleware/redis-cluster

- name: configure redis slaves
  hosts: redis-slave
  vars:
    - used_redis_config: true
    - redis_slaveof: "{{ groups['redis-master'][0] }} {{ hostvars[groups['redis-master'][0]]['redis_port'] }}"
  roles:
    - middleware/redis-cluster

- name: configure redis sentinel nodes
  hosts: redis-sentinel
  vars:
    - redis_sentinel_monitors:
      - name: "{{ hostvars[groups['redis-sentinel'][0]]['cluster_name'] }}"
        host: "{{ groups['redis-master'][0] }}"
        port: "{{ hostvars[groups['redis-master'][0]]['redis_port'] }}"
  roles:
    - middleware/redis-cluster

- name: configure the cluster redis server
  hosts: redis-cluster
  gather_facts: True
  roles:
    - role: middleware/redis-cluster

- name: uninstall the cluster server
  hosts: redis-cluster-uninstall
  tasks:
    - import_role:
        name: middleware/redis-cluster
        tasks_from: uninstall.yml
```

## 部署

``` bash
# ansible-playbook -i hosts redis_cluster.yml
```

## 部署逻辑

``` text
1. 单机步骤：single，传递redis包 -> 解压redis包 -> 创建用户 -> 生成redis目录 -> 放置bin命令 -> 生成data目录 -> 生成服务控制 -> 生成配置文件 -> 启动redis服务；
2. 集群步骤：sentinel，传递redis包 -> 解压redis包 -> 创建用户 -> 生成redis目录 -> 放置bin命令 -> 生成data目录 -> 生成服务控制 -> 生成配置文件 -> 启动redis服务； 生成sentinel目录 -> 放置bin命令 -> 生成data目录 -> 生成服务控制 -> 生成配置文件 -> 启动sentinel服务；
3. 集群步骤：cluster，传递redis包 -> 解压redis包 -> 创建用户 -> 生成cluster目录 -> 放置bin命令 -> 生成data目录 -> 生成服务控制 -> 生成配置文件 -> 启动cluster服务 -> 设置集群模式。
```

## Middleware版本更新

<details> <summary>详细信息</summary>

<pre><code>

```text

### 20200220

  * 优化部署逻辑，去除多余tasks。

### 20200218

  * 建立Ansible功能。

```

</code></pre>

</details>
