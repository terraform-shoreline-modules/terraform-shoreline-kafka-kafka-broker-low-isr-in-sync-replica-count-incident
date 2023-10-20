terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "kafka_broker_low_isr_in_sync_replica_count_incident" {
  source    = "./modules/kafka_broker_low_isr_in_sync_replica_count_incident"

  providers = {
    shoreline = shoreline
  }
}