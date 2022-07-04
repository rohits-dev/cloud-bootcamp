
locals {
  cluster_name               = "bootcamp"
  schema-registry_cluster_id = "lsrc-v7yddz"
  hosted_zone                = replace(regex("^[^.]+-([0-9a-zA-Z]+[.].*):[0-9]+$", confluent_kafka_cluster.dedicated.bootstrap_endpoint)[0], "glb.", "")
  bootstrap_prefix           = split(".", confluent_kafka_cluster.dedicated.bootstrap_endpoint)[0]
  endpoint_prefix            = split(".", aws_vpc_endpoint.privatelink.dns_entry[0]["dns_name"])[0]
}
