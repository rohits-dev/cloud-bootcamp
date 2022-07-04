resource "confluent_kafka_topic" "perf_test" {
  kafka_cluster {
    id = confluent_kafka_cluster.dedicated.id
  }
  topic_name    = "perf-test"
  rest_endpoint = confluent_kafka_cluster.dedicated.rest_endpoint
  credentials {
    key    = confluent_api_key.app-manager-kafka-api-key-pl.id
    secret = confluent_api_key.app-manager-kafka-api-key-pl.secret
  }
}

