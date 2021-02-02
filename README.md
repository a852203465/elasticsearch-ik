# elasticsearch 安装 中文, 拼音分词器

## 提示
 - 镜像已push到阿里云仓库，可以直接运行, 
 - 镜像：registry.cn-shenzhen.aliyuncs.com/a852203465/elasticsearch-ik:7.10.2

## 构建
### 写Dockerfile文件
 - 已写好不再赘述了

### 构建镜像
 - 执行docker build -t a852203465/elasticsearch-ik:7.10.2 .
  或者
 - 执行 chmod +x build.sh && ./build.sh

 注意：elasticsearch 和 elasticsearch-analysis-ik 版本一定要相同的，否则会启动失败
    
### 查看构建信息
 - 执行命令docker history a852203465/elasticsearch-ik:7.10.2

## 运行
 - docker-compose up -d

## 问题说明

### ES 部署问题

 - 问题1：java.nio.file.AccessDeniedException: /usr/share/elasticsearch/data/nodes 
 - 处理：在相关目录上执行 chown -R user:user data, user-> 非root用户
    
 - 问题2：bootstrap checks failed
 - 原因：Swapping needs to be disabled for performance and node stability. For information about ways to do this
 - 处理：修改docker-compose.yml 增加配置"bootstrap.memory_lock=false"
 
 - 问题3：max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
 - 原因：最大虚拟内存太小,需要修改系统变量的最大值
 - 处理：执行 sudo sysctl -w vm.max_map_count=262144

## 验证分词效果
### 创建索引
 - 假设docker所在电脑的IP地址是192.168.1.101，执行以下命令来创建一个索引：
 ```text
    curl -X PUT http://192.168.1.101:9200/test001
 ```

### 执行以下命令验证ik分词器效果
 - 命令
 ```text
    curl -X POST 'http://192.168.1.101:9200/test001/_analyze?pretty=true' -H 'Content-Type: application/json' -d '{"text":"我们是软件工程师","tokenizer":"ik_smart"}'
 ```
 - 收到的相应如下，可见ik分词器已经生效：
 ```json
{ "tokens" : [ { "token" : "我们", "start_offset" : 0, "end_offset" : 2, "type" : "CN_WORD", "position" : 0 }, { "token" : "是", "start_offset" : 2, "end_offset" : 3, "type" : "CN_CHAR", "position" : 1 }, { "token" : "软件", "start_offset" : 3, "end_offset" : 5, "type" : "CN_WORD", "position" : 2 }, { "token" : "工程师", "start_offset" : 5, "end_offset" : 8, "type" : "CN_WORD", "position" : 3 } ] }

 ```