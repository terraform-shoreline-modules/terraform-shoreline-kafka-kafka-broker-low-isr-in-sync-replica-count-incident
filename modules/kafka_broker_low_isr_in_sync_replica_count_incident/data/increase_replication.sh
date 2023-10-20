

#!/bin/bash

# Set the replication factor and topic name

REPLICATION_FACTOR="PLACEHOLDER"

TOPIC_NAME="PLACEHOLDER"


# Increase the replication factor for the topic

kafka-topics.sh --bootstrap-server ${BOOTSTRAP_SERVER} --alter --topic $TOPIC_NAME --partitions ${NUM_PARTITIONS} --replication-factor $REPLICATION_FACTOR