# Hadoop + Hive Data Warehouse on Docker (High Availability)

A Dockerized Big Data Analytics Platform with Hadoop High Availability and Apache Hive for scalable, cost-effective data warehousing.

##  Key Features

- **Hadoop HA Cluster**: 3-master-node setup with automatic failover (NameNode, ResourceManager, JournalNode)
- **Apache Hive Integration**: SQL-on-Hadoop engine layered over HDFS
- **Tez Execution Engine**: Optimized query execution for Hive
- **ACID Transactions in Hive**: For reliable insert/update/delete on fact/dimension tables
- **Incremental Loading**: Sqoop + Bash + Hive integration for daily delta loads
- **Schema-on-Read with ORC**: Efficient columnar storage
- **Data Validation**: Staging tables and row count comparison

---

## Architecture
- Hadoop HA Master and Worker Nodes
- HiveServer2, Hive Metastore (PostgreSQL), Tez Engine
- Sqoop + Bash for ELT automation
- HDFS Staging Area + Hive Final Tables

---

##  Project Structure

```
├── docker-compose.yml
├── config-hadoop/
│   └── core-site.xml, hdfs-site.xml, yarn-site.xml, mapred-site.xml, zoo.cfg
├── config_hive/
│   └── hive-site.xml, tez-site.xml, entrypoint scripts
├── scripts/
│   ├── entrypoint.sh
│   ├── IncLoadToStaging.sh
│   ├── StagingSchema.sh
│   └── IncLoadToHive.sh
|   └── migration.sh
├── sql/
│   ├── staging-tables.sql
│   ├── hive-DDL.sql
│   ├── insert-into-hive-schema.sql
│   └── validate-migration.sql
```

---

##  Getting Started

### Step 1: Clone the Repo

```bash
git clone https://github.com/MuhamedHekal/Hadoop-HA-Cluster-on-Docker.git
cd Hadoop-HA-Cluster-on-Docker
```

### Step 2: Start Hadoop + Hive Cluster

```bash
docker-compose up -d
```

---

##  Web Interfaces

| Service           | Master1          | Master2          | Master3          |
|------------------|------------------|------------------|------------------|
| NameNode         | http://localhost:9871 | http://localhost:9872 | http://localhost:9873 |
| ResourceManager  | http://localhost:8088 | http://localhost:8089 | http://localhost:8090 |


---

##  Hive Implementation Details

###  Schema Migration

- Migrated 9 dimensions + 1 fact table from Oracle DWH using `Sqoop`
- Schema design follows:
  - **Staging Layer**: External text-based Hive tables
  - **Final Layer**: ORC-formatted ACID-compliant tables with partitioning & bucketing

###  Data Ingestion

- `IncLoadToStaging.sh`: Bash + Sqoop to pull daily incremental data into HDFS
- `StagingSchema.sh`: Creates Hive staging tables pointing to new HDFS folders
- `IncLoadToHive.sh`: Handles SCD logic to update `is_current` flags and insert deltas

### Optimization Techniques

- **Partitioning**: By date/year, etc
- **Bucketing**: For join performance (especially for fact tables)
- **Tez Engine**: Fast execution with vectorized processing
- **Compression**: ORC + Snappy

---

##  Test and Validation

```bash
# HDFS test
hdfs dfs -mkdir /test
hdfs dfs -put localfile.csv /test
hdfs dfs -ls /test

# Hive row count validation
hive -f migration/validate-migration.sql
```

---

##  Automation

| Script                 | Frequency | Purpose                                 |
|------------------------|-----------|-----------------------------------------|
| `IncLoadToStaging.sh`  | Daily 12AM | Pulls changed Oracle rows via Sqoop     |
| `StagingSchema.sh`     | Daily 12AM | Maps new HDFS folders to staging tables |
| `IncLoadToHive.sh`     | Daily 12AM | Performs merge into final Hive tables   |

**Crontab Example:**
```bash
0 0 * * * /home/hadoop/IncLoadToStaging.sh
```

---


##  Sample Table DDL

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS AirLine.customer_dim (
  passenger_id INT,
  passenger_name STRING,
  passenger_dateOfBirth DATE,
  passenger_gender STRING,
  ...
)
PARTITIONED BY (start_year INT, is_current STRING)
CLUSTERED BY (passenger_id) INTO 4 BUCKETS
STORED AS ORC
TBLPROPERTIES ('transactional'='true', 'orc.compress'='SNAPPY');
```

---

##  Data Volumes

| Volume            | Used For         |
|-------------------|------------------|
| `hive-metastore`  | PostgreSQL metadata |
| `namenode-data`   | HDFS NN storage     |
| `datanode-data`   | HDFS data blocks    |

