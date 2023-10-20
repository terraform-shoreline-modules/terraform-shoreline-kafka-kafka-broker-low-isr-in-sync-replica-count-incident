resource "shoreline_notebook" "kafka_broker_low_isr_in_sync_replica_count_incident" {
  name       = "kafka_broker_low_isr_in_sync_replica_count_incident"
  data       = file("${path.module}/data/kafka_broker_low_isr_in_sync_replica_count_incident.json")
  depends_on = [shoreline_action.invoke_increase_replication]
}

resource "shoreline_file" "increase_replication" {
  name             = "increase_replication"
  input_file       = "${path.module}/data/increase_replication.sh"
  md5              = filemd5("${path.module}/data/increase_replication.sh")
  description      = "Increase the replication factor of the affected topic(s) in Kafka to ensure that there are enough replicas to maintain the minimum ISR count. This will ensure that the ISR count does not drop below the minimum threshold."
  destination_path = "/tmp/increase_replication.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_increase_replication" {
  name        = "invoke_increase_replication"
  description = "Increase the replication factor of the affected topic(s) in Kafka to ensure that there are enough replicas to maintain the minimum ISR count. This will ensure that the ISR count does not drop below the minimum threshold."
  command     = "`chmod +x /tmp/increase_replication.sh && /tmp/increase_replication.sh`"
  params      = ["TOPIC_NAME"]
  file_deps   = ["increase_replication"]
  enabled     = true
  depends_on  = [shoreline_file.increase_replication]
}

