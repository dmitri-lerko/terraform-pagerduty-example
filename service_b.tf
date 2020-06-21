# Create Schedule
resource "pagerduty_schedule" "schedule_service_b" {
  name      = "Service B"
  time_zone = "Europe/London"

  layer {
    name                         = "Service B"
    start                        = "2020-06-08T08:00:00-00:00"
    rotation_virtual_start       = "2020-06-08T08:00:00-00:00"
    rotation_turn_length_seconds = 604800
    users = [
      pagerduty_user.user["alice"].id,
      pagerduty_user.user["mary"].id,
    ]
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to rotation_virtual_start
      layer[0].rotation_virtual_start,
    ]
  }
}

# Create Escalation policies
resource "pagerduty_escalation_policy" "service_b" {
  name      = "Service B"
  num_loops = 9

  rule {
    escalation_delay_in_minutes = 30

    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.schedule_service_b.id
    }
  }
}

resource "pagerduty_service" "alertmanager_service_b" {
  name                    = "Alertmanager Service B"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 1800
  escalation_policy       = pagerduty_escalation_policy.service_b.id
  alert_creation          = "create_incidents"
}

resource "pagerduty_service_integration" "integration_service_b" {
  name    = "${pagerduty_service.alertmanager_service_b.name} integration"
  service = pagerduty_service.alertmanager_service_b.id
  type    = "generic_events_api_inbound_integration"
}
