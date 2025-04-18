# Dockerfile
FROM ubuntu:22.04

# Install dependencies and configure system
RUN apt-get update && apt-get install -y --no-install-recommends \ 
    sudo \
    openssh-server \
    wget \
    vim \
    net-tools \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables globally
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64
ENV HADOOP_HOME=/home/hadoop/hadoop
ENV HADOOP_INSTALL=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
ENV ZOOKEEPER_HOME=/home/hadoop/zookeeper
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$ZOOKEEPER_HOME/bin


# Create hadoop user and group
RUN groupadd hadoopG && \
    useradd -m -g hadoopG -s /bin/bash hadoop && \
    echo "hadoop ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "hadoop:123" | chpasswd

# Switch to hadoop user for remaining setup
USER hadoop
WORKDIR /home/hadoop

# Install Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz && \
    tar -xzvf hadoop-3.3.6.tar.gz && \
    mv hadoop-3.3.6 hadoop && \
    rm hadoop-3.3.6.tar.gz

# Install Zookeeper
RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-3.6.4/apache-zookeeper-3.6.4-bin.tar.gz && \
    tar -xzf apache-zookeeper-3.6.4-bin.tar.gz && \
    mv apache-zookeeper-3.6.4-bin zookeeper && \
    rm apache-zookeeper-3.6.4-bin.tar.gz && \
    mkdir -p zookeeper/data

# install Hive
ENV HIVE_HOME=/home/hadoop/hive
ENV PATH=$PATH:$HIVE_HOME/bin
RUN wget https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz && \
tar -xzf apache-hive-3.1.3-bin.tar.gz && \
mv apache-hive-3.1.3-bin hive && \
rm apache-hive-3.1.3-bin.tar.gz

# Install Tez
RUN wget https://dlcdn.apache.org/tez/0.9.2/apache-tez-0.9.2-bin.tar.gz && \
    tar -xzf apache-tez-0.9.2-bin.tar.gz && \
    mv apache-tez-0.9.2-bin tez && \
    rm apache-tez-0.9.2-bin.tar.gz

ENV TEZ_HOME=/home/hadoop/tez
ENV PATH=$PATH:$TEZ_HOME/bin
ENV TEZ_CONF_DIR=$TEZ_HOME/conf
ENV TEZ_JARS=$TEZ_HOME/*:$TEZ_HOME/lib/*
ENV HADOOP_CLASSPATH=$TEZ_CONF_DIR:$TEZ_JARS

# Configure SSH
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 640 ~/.ssh/authorized_keys 

# Create Hadoop data directories
RUN mkdir -p /home/hadoop/hadoopdata/hdfs/namenode \
    && mkdir -p /home/hadoop/hadoopdata/hdfs/datanode \
    && mkdir -p /home/hadoop/hadoopdata/hdfs/journalnode
    
# Copy configuration files
COPY config/ /home/hadoop/hadoop/etc/hadoop/
COPY config/zoo.cfg /home/hadoop/zookeeper/conf/zoo.cfg
COPY config/hive-site.xml /home/hadoop/hive/conf/hive-site.xml
COPY config/tez-site.xml /home/hadoop/tez/conf/tez-site.xml


ENTRYPOINT [ "bash", "/home/hadoop/hadoop/etc/hadoop/entrypoint.sh" ]