resource "pagerduty_user" "user" {
  for_each = var.users

  name  = each.value.name
  email = each.value.email
  role  = each.value.role

  lifecycle {
    ignore_changes = [
      # Ignore changes to job_title
      job_title,
    ]
  }
}
