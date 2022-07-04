resource "confluent_service_account" "app-manager" {
  display_name = "app-manager"
  description  = "Service account to manage ${local.cluster_name} Kafka cluster"
}

resource "confluent_role_binding" "app-manager-kafka-cluster-admin" {
  principal   = "User:${confluent_service_account.app-manager.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.bootcamp_basic.rbac_crn
}
resource "confluent_api_key" "app-manager-kafka-api-key" {
  display_name = "app-manager-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-manager' service account"
  owner {
    id          = confluent_service_account.app-manager.id
    api_version = confluent_service_account.app-manager.api_version
    kind        = confluent_service_account.app-manager.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.bootcamp_basic.id
    api_version = confluent_kafka_cluster.bootcamp_basic.api_version
    kind        = confluent_kafka_cluster.bootcamp_basic.kind

    environment {
      id = confluent_environment.bootcamp.id
    }
  }
  depends_on = [
    confluent_role_binding.app-manager-kafka-cluster-admin
  ]
}

resource "confluent_service_account" "app-producer" {
  display_name = "app-producer"
  description  = "Service account to produce to 'orders' topic of 'inventory' Kafka cluster"
}

resource "confluent_api_key" "app-producer-kafka-api-key" {
  display_name = "app-producer-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-producer' service account"
  owner {
    id          = confluent_service_account.app-producer.id
    api_version = confluent_service_account.app-producer.api_version
    kind        = confluent_service_account.app-producer.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.bootcamp_basic.id
    api_version = confluent_kafka_cluster.bootcamp_basic.api_version
    kind        = confluent_kafka_cluster.bootcamp_basic.kind

    environment {
      id = confluent_environment.bootcamp.id
    }
  }
}

resource "confluent_service_account" "app-consumer" {
  display_name = "app-consumer"
  description  = "Service account to consume from 'orders' topic of 'inventory' Kafka cluster"
}

resource "confluent_api_key" "app-consumer-kafka-api-key" {
  display_name = "app-consumer-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-consumer' service account"
  owner {
    id          = confluent_service_account.app-consumer.id
    api_version = confluent_service_account.app-consumer.api_version
    kind        = confluent_service_account.app-consumer.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.bootcamp_basic.id
    api_version = confluent_kafka_cluster.bootcamp_basic.api_version
    kind        = confluent_kafka_cluster.bootcamp_basic.kind

    environment {
      id = confluent_environment.bootcamp.id
    }
  }
}
