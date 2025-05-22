
# HBase in Hadoop-HA-Cluster-on-Docker

## HBase Docker Image & Cluster Setup

- **HBase runs inside Docker containers** designed to simulate a real distributed cluster.
- The cluster consists of:
  - **2 HBase Master**: Manages cluster metadata and coordinates RegionServers.
  - **2 RegionServers**: Store and serve parts (regions) of HBase tables.
  - **Zookeeper ensemble**: Provides coordination and failover support for HBase Master.
  - **Hadoop HDFS**: Underlying filesystem for persistent data storage.

- **Docker Compose** config orchestrates all containers, setting up networking, dependencies, and ports for easy communication.
- This setup supports **high availability** of the HBase Master via Zookeeper.
- You can scale the number of RegionServers by increasing container count to handle more load
add more Worker nodes.
```
docker container run --name worker3 -h worker3 --network hadoop-net -e ROLE=worker -v Worker3-datanode:/home/hadoop/hadoopdata/hdfs/datanode hadoop-ha-cluster-on-docker-worker1
```
---

## WebTable — HBase Table for Web Page Data

### Table Purpose

Stores web pages’ content, metadata, and link data efficiently for fast querying and analysis.

### Row Key Design

- Format:  
  `[1-byte hash] + reversed domain + ":" + page path`  
  Example:  
  URL `http://google.com/search` → Row key like `3-com.google:/search`

- **Why?**  
  - Group pages by domain (reversed domain groups similar sites together).  
  - Hash prefix distributes data evenly to avoid hotspots.  
  - Enables efficient scans by domain prefix.

### Column Families

| Family   | Description                         | Versions | TTL (seconds)      |
| -------- | --------------------------------- | -------- | ------------------ |
| Content  | Actual HTML content of the page    | 3        | 7,776,000 (90 days)|
| Metadata | Page title, status code, size, etc | 1        | None               |
| Outlinks | Outgoing links from the page       | 2        | 15,552,000 (180 days)|
| Inlinks  | Incoming links to the page         | 2        | 15,552,000 (180 days)|

### Table Creation

```shell
create 'WebTable',
  {NAME => 'Content', VERSIONS => 3, TTL => 7776000, BLOOMFILTER => 'ROW'},
  {NAME => 'Metadata', VERSIONS => 1},
  {NAME => 'Outlinks', VERSIONS => 2, TTL => 15552000},
  {NAME => 'Inlinks', VERSIONS => 2, TTL => 15552000},
  SPLITS => ['32-', '64-', '96-', '128-', '160-', '192-', '224-']  # Pre-split regions for performance
```

### Key Features

- **Pre-splitting** regions avoids region server hotspots during writes.
- **TTL** automatically expires old content and links, saving space.
- **Versioning** in Content allows tracking page changes over time.
- Supports efficient **exact lookups** and **domain-wide scans**.

### Example Queries

- Get latest HTML content by URL:

```hbase
get 'WebTable', '208-com.example:/page7', {COLUMN => 'Content:html'}
```

- List all pages for domain `example.com`:

```hbase
scan 'WebTable', {ROWPREFIXFILTER => '5-com.example'}
```

- Find pages modified after `2024-03-18`:

```hbase
scan 'WebTable', {FILTER => "SingleColumnValueFilter('Metadata', 'modified', >=, 'binary:20240318')"}
```

---

### How to Use
1. **Clone the repository**:
   ```bash
   git clone https://github.com/MuhamedHekal/Hadoop-HA-Cluster-on-Docker.git
   
   cd Hadoop-HA-Cluster-on-Docker
   ```

1. **Start cluster** with `docker-compose up -d`.
2. **Access HBase shell**:  
   `docker exec -it hbase-master hbase shell`
3. **Create WebTable** with the script above.
4. **Insert web page data** using provided ingestion scripts or HBase `put` commands in [WebTable/hbase_puts.hbase](WebTable/hbase_puts.hbase).
5. **Query data** with the example commands to test functionality.

