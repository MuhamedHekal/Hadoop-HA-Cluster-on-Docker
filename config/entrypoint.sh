#!/bin/bash

echo $MYID > /home/hadoop/zookeeper/data/myid
sudo service ssh start

# Run ZooKeeper and JournalNode only on Master nodes
if [ "$ROLE" == "master" ]; then
    /home/hadoop/zookeeper/bin/zkServer.sh start
    hdfs --daemon start journalnode
    sleep 5

    if [ "$MYID" -eq 1 ]; then
        # Check if namenode is already formatted
        if [ ! -f /home/hadoop/hadoopdata/hdfs/namenode/current/VERSION ]; then
            echo "Formatting NameNode for the first time..."
            hdfs namenode -format mycluster -force
            hdfs --daemon start namenode
            hdfs zkfc -formatZK -force
            hdfs --daemon start zkfc
        else
            echo "NameNode already formatted, starting..."
            hdfs --daemon start namenode
            hdfs --daemon start zkfc
        fi
    else
        # For standby nodes
        if [ ! -f /home/hadoop/hadoopdata/hdfs/namenode/current/VERSION ]; then
            echo "Bootstrapping standby NameNode..."
            hdfs namenode -bootstrapStandby
        fi
        hdfs --daemon start namenode
        hdfs --daemon start zkfc
    fi

    yarn --daemon start resourcemanager
fi

# Run DataNode and NodeManager only on Worker nodes
if [ "$ROLE" == "worker" ]; then
    hdfs --daemon start datanode
    yarn --daemon start nodemanager
fi

tail -f /dev/null