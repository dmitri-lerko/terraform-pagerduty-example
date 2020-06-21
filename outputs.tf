output "integration_key_service_a" {
  value = pagerduty_service_integration.integration_service_a.integration_key
}

output "integration_key_service_b" {
  value = pagerduty_service_integration.integration_service_b.integration_key
}
