# 基础镜像
FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.2

#作者
MAINTAINER Mr.J <852203465@qq.com>

# 安装
RUN echo y | elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.10.2/elasticsearch-analysis-ik-7.10.2.zip && \
echo y | elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v7.10.2/elasticsearch-analysis-pinyin-7.10.2.zip

