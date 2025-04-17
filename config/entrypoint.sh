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

if [ "$ROLE" = "hive" ]; then
    # Check if /tmp exists (hadoop fs -test returns 0 if exists)
    hadoop fs -test -d /tmp
    if [ $? -ne 0 ]; then
        echo "Creating /tmp directory..."
        hadoop fs -mkdir /tmp || { echo "Failed to create /tmp"; exit 1; }
        hadoop fs -chmod g+w /tmp || { echo "Failed to chmod /tmp"; exit 1; }
    fi

    # Check if warehouse directory exists
    hadoop fs -test -d /user/hive/warehouse
    if [ $? -ne 0 ]; then
        echo "Creating warehouse directory..."
        hadoop fs -mkdir -p /user/hive/warehouse ||  echo "Failed to create warehouse directory"
        hadoop fs -chmod g+w /user/hive/warehouse || echo "Failed to chmod warehouse directory"
    fi

    if [ ! -f "/home/hadoop/metastore_db/db.lck" ]; then
        echo "Initializing Derby metastore..."
        if [ ! -f "/home/hadoop/hive-metastore" ]; then
            # Create a symbolic link to the metastore_db directory
            sudo ln -s /home/hadoop/metastore_db /home/hadoop/hive-metastore
        fi
        sleep 5
        schematool -dbType derby -initSchema || echo "Failed to initialize Derby schema";
    else
        echo "Derby metastore already exists (metastore_db directory found)"
    fi

    # configure Hive to use TEZ
    echo "Configuring Hive to use TEZ..."
    hadoop fs -test -d /tez
    if [ $? -ne 0 ]; then
        echo "Creating /tez directory..."
        hadoop fs -mkdir /tez || echo "Failed to create /tez"
        hdfs dfs -chmod -R 755 /tez ||  echo "Failed to chmod /tez"
    fi
    
    # Check if tez.tar.gz exists in HDFS
    hadoop fs -test -f /tez/tez.tar.gz
    if [ $? -ne 0 ]; then
        echo "Uploading Tez libraries to HDFS..."
        hdfs dfs -put tez/share/tez.tar.gz  /tez/tez.tar.gz || echo "Failed to upload Tez libs" 
    
    fi

fi

tail -f /dev/null