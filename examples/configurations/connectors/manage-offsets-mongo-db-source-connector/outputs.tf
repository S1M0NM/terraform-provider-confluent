output "resource-ids" {
  value = <<-EOT
  Environment ID:   ${confluent_environment.staging.id}
  Kafka Cluster ID: ${confluent_kafka_cluster.basic.id}
  Kafka topic name: ${local.topic_prefix}.${local.database}.${local.collection}

  Service Accounts and their Kafka API Keys (API Keys inherit the permissions granted to the owner):
  ${confluent_service_account.app-manager.display_name}:                     ${confluent_service_account.app-manager.id}
  ${confluent_service_account.app-manager.display_name}'s Kafka API Key:     "${confluent_api_key.app-manager-kafka-api-key.id}"
  ${confluent_service_account.app-manager.display_name}'s Kafka API Secret:  "${confluent_api_key.app-manager-kafka-api-key.secret}"

  ${confluent_service_account.app-consumer.display_name}:                    ${confluent_service_account.app-consumer.id}
  ${confluent_service_account.app-consumer.display_name}'s Kafka API Key:    "${confluent_api_key.app-consumer-kafka-api-key.id}"
  ${confluent_service_account.app-consumer.display_name}'s Kafka API Secret: "${confluent_api_key.app-consumer-kafka-api-key.secret}"

  In order to use the Confluent CLI v2 to produce and consume messages from topic '${local.topic_prefix}.${local.database}.${local.collection}' using Kafka API Keys
  of ${confluent_service_account.app-consumer.display_name} service accounts
  run the following commands:

  # 1. Log in to Confluent Cloud
  $ confluent login

  # 2. Consume records from topic '${local.topic_prefix}.${local.database}.${local.collection}' using ${confluent_service_account.app-consumer.display_name}'s Kafka API Key
  $ confluent kafka topic consume ${local.topic_prefix}.${local.database}.${local.collection} --from-beginning --environment ${confluent_environment.staging.id} --cluster ${confluent_kafka_cluster.basic.id} --api-key "${confluent_api_key.app-consumer-kafka-api-key.id}" --api-secret "${confluent_api_key.app-consumer-kafka-api-key.secret}"
  # When you are done, press 'Ctrl-C'.
  EOT

  sensitive = true
}
