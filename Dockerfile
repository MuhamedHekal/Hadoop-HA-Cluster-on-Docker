# Builder Stage
FROM ubuntu:22.04 AS hadoop_base

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    wget \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

# Create hadoop user and group
RUN groupadd hadoopG && \
    useradd -m -g hadoopG -s /bin/bash hadoop && \
    echo "hadoop ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "hadoop:123" | chpasswd

USER hadoop
WORKDIR /home/hadoop

# Download and extract hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz && \
    tar -xzvf hadoop-3.3.6.tar.gz && \
    mv hadoop-3.3.6 hadoop && \
    rm hadoop-3.3.6.tar.gz
# Download and extract zookeeper
RUN wget https://archive.apache.org/dist/zookeeper/zookeeper-3.6.4/apache-zookeeper-3.6.4-bin.tar.gz && \
    tar -xzf apache-zookeeper-3.6.4-bin.tar.gz && \
    mv apache-zookeeper-3.6.4-bin zookeeper && \
    rm apache-zookeeper-3.6.4-bin.tar.gz
#Download and extract hive and postgresql driver
RUN wget https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz && \
    tar -xzf apache-hive-3.1.3-bin.tar.gz && \
    mv apache-hive-3.1.3-bin hive && \
    rm apache-hive-3.1.3-bin.tar.gz && \
    wget -O /home/hadoop/hive/lib/postgresql-42.5.4.jar https://repo1.maven.org/maven2/org/postgresql/postgresql/42.5.4/postgresql-42.5.4.jar

# Download and extract tez
RUN wget https://dlcdn.apache.org/tez/0.9.2/apache-tez-0.9.2-bin.tar.gz && \
    tar -xzf apache-tez-0.9.2-bin.tar.gz && \
    mv apache-tez-0.9.2-bin tez && \
    rm apache-tez-0.9.2-bin.tar.gz

# Download and extract Sqoop
RUN wget https://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    tar -xzf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    mv sqoop-1.4.7.bin__hadoop-2.6.0 sqoop && \
    rm sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz && \
    wget -O /home/hadoop/sqoop/lib/ojdbc8.jar https://download.oracle.com/otn-pub/otn_software/jdbc/1912/ojdbc8.jar

# Download and extract HBase
RUN wget https://archive.apache.org/dist/hbase/2.5.11/hbase-2.5.11-bin.tar.gz && \
    tar -xzf hbase-2.5.11-bin.tar.gz && \
    mv hbase-2.5.11 hbase && \
    rm hbase-2.5.11-bin.tar.gz


# Runtime Stage
FROM ubuntu:22.04

# Install only runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    openssh-server \
    vim \
    openjdk-8-jdk \
    cron \ 
    && rm -rf /var/lib/apt/lists/*

# Create hadoop user and group (same as builder)
RUN groupadd hadoopG && \
    useradd -m -g hadoopG -s /bin/bash hadoop && \
    echo "hadoop ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "hadoop:123" | chpasswd

# Set environment variables
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
ENV HIVE_HOME=/home/hadoop/hive
ENV HIVE_CONF_DIR=$HIVE_HOME/conf
ENV TEZ_HOME=/home/hadoop/tez
ENV SQOOP_HOME=/home/hadoop/sqoop
ENV HBASE_HOME=/home/hadoop/hbase
ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$ZOOKEEPER_HOME/bin:$HIVE_HOME/bin:$TEZ_HOME/bin:$SQOOP_HOME/bin:$HBASE_HOME/bin
ENV TEZ_CONF_DIR=$TEZ_HOME/conf
ENV TEZ_JARS=$TEZ_HOME/*:$TEZ_HOME/lib/*
ENV HADOOP_CLASSPATH=$TEZ_CONF_DIR:$TEZ_JARS:$HBASE_HOME/lib/*:$HADOOP_HOME/share/hadoop/common/lib/*:$ZOOKEEPER_HOME/lib/*

USER hadoop
WORKDIR /home/hadoop

# Copy installed components from builder stage
COPY --from=hadoop_base --chown=hadoop:hadoopG /home/hadoop/hadoop /home/hadoop/hadoop
COPY --from=hadoop_base --chown=hadoop:hadoopG /home/hadoop/zookeeper /home/hadoop/zookeeper
COPY --from=hadoop_base --chown=hadoop:hadoopG /home/hadoop/hive /home/hadoop/hive
COPY --from=hadoop_base --chown=hadoop:hadoopG /home/hadoop/tez /home/hadoop/tez
COPY --from=hadoop_base --chown=hadoop:hadoopG /home/hadoop/sqoop /home/hadoop/sqoop
COPY --from=hadoop_base --chown=hadoop:hadoopG /home/hadoop/hive/lib/postgresql-42.5.4.jar /home/hadoop/hive/lib/postgresql-42.5.4.jar
COPY --from=hadoop_base --chown=hadoop:hadoopG /home/hadoop/hbase /home/hadoop/hbase

# SSH Setup (Secure + Non-Interactive)
RUN mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh && \
    # 1. Generate key pair (no password)
    ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa && \
    # 2. Allow self-connection
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 600 ~/.ssh/authorized_keys && \
    # 3. Disable host checking (for container environments only!)
    echo "Host *" >> ~/.ssh/config && \
    echo "  StrictHostKeyChecking no" >> ~/.ssh/config && \
    echo "  UserKnownHostsFile /dev/null" >> ~/.ssh/config && \
    chmod 600 ~/.ssh/config


# Create Hadoop data directories
RUN mkdir -p /home/hadoop/hadoopdata/hdfs/namenode \
    && mkdir -p /home/hadoop/hadoopdata/hdfs/datanode \
    && mkdir -p /home/hadoop/hadoopdata/hdfs/journalnode \
    && mkdir -p /home/hadoop/zookeeper/data

# Copy configuration files
COPY  config/ /home/hadoop/hadoop/etc/hadoop/
COPY  config/zoo.cfg /home/hadoop/zookeeper/conf/zoo.cfg
COPY  config/hive-site.xml /home/hadoop/hive/conf/hive-site.xml
COPY  config/tez-site.xml /home/hadoop/tez/conf/tez-site.xml

# Copy HBase configuration files
COPY config/hbase-site.xml $HBASE_HOME/conf/
COPY config/regionservers $HBASE_HOME/conf/
COPY config/backup-masters $HBASE_HOME/conf/
COPY config/hbase-env.sh $HBASE_HOME/conf/

ENTRYPOINT [ "bash", "/home/hadoop/hadoop/etc/hadoop/entrypoint.sh" ]