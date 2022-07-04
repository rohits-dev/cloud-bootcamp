resource "confluent_environment" "bootcamp" {
  display_name = local.cluster_name
}

resource "confluent_kafka_cluster" "bootcamp_basic" {
  display_name = local.cluster_name
  availability = "SINGLE_ZONE"
  cloud        = "AWS"
  region       = "eu-west-2"
  basic {}
  environment {
    id = confluent_environment.bootcamp.id
  }
}
