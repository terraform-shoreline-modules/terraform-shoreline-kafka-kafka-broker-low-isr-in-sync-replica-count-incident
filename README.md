
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Kafka Broker Low ISR (In-Sync Replica) Count Incident
---

In a Kafka cluster, each topic partition is replicated across multiple brokers to ensure high availability and fault tolerance. The In-Sync Replica (ISR) is the set of replicas that are fully caught up with the leader replica and in sync with the latest data. When the ISR count is low, it means that some replicas are lagging behind and are not up-to-date with the latest data. This can lead to data loss, inconsistent reads and writes, and eventual data corruption. Therefore, monitoring and maintaining a healthy ISR count is crucial for a stable Kafka cluster.

### Parameters
```shell
export KAFKA_LOG_FILE="PLACEHOLDER"

export KAFKA_BROKER="PLACEHOLDER"

export TOPIC_NAME="PLACEHOLDER"

export PORT="PLACEHOLDER"

export ZOOKEEPER_LOG_FILE="PLACEHOLDER"

export PARTITION_NUMBER="PLACEHOLDER"

export ZOOKEEPER_SERVER="PLACEHOLDER"

```

## Debug

### Check the status of the Kafka broker
```shell
systemctl status kafka
```

### Check the log file of the Kafka broker for errors
```shell
tail -n 100 ${KAFKA_LOG_FILE}
```

### Check the ISR count of the Kafka topic
```shell
kafka-topics --bootstrap-server ${KAFKA_BROKER}:${PORT} --topic ${TOPIC_NAME} --describe
```

### Check the replication factor of the Kafka topic
```shell
kafka-topics --bootstrap-server ${KAFKA_BROKER}:${PORT} --topic ${TOPIC_NAME} --describe
```

### Check the ISR count of the Kafka partition
```shell
zookeeper-shell ${ZOOKEEPER_SERVER}:${PORT} get /brokers/topics/${TOPIC_NAME}/partitions/${PARTITION_NUMBER}/state
```

### Check the preferred replica count of the Kafka partition
```shell
zookeeper-shell ${ZOOKEEPER_SERVER}:${PORT} get /brokers/topics/${TOPIC_NAME}/partitions/${PARTITION_NUMBER}/state
```

## Repair

### Increase the replication factor of the affected topic(s) in Kafka to ensure that there are enough replicas to maintain the minimum ISR count. This will ensure that the ISR count does not drop below the minimum threshold.
```shell


#!/bin/bash

# Set the replication factor and topic name

REPLICATION_FACTOR="PLACEHOLDER"

TOPIC_NAME="PLACEHOLDER"


# Increase the replication factor for the topic

kafka-topics.sh --bootstrap-server ${BOOTSTRAP_SERVER} --alter --topic $TOPIC_NAME --partitions ${NUM_PARTITIONS} --replication-factor $REPLICATION_FACTOR


```