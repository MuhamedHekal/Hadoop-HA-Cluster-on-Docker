#!/bin/bash

echo $MYID > /home/hadoop/zookeeper/data/myid
sudo service ssh start
# Run ZooKeeper and JournalNode only on Master nodes
if [ "$ROLE" == "master" ]; then
    /home/hadoop/zookeeper/bin/zkServer.sh start
    hdfs --daemon start journalnode
    sleep 5

    if [ "$MYID" -eq 1 ]; then
        hdfs namenode -format mycluster
        hdfs --daemon start namenode
        hdfs zkfc -formatZK
    else
        hdfs namenode -bootstrapStandby
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