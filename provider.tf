# Configure the PagerDuty provider
provider "pagerduty" {
  token = var.PAGERDUTY_TOKEN
}

terraform {
  backend "gcs" {
    bucket = "some-gcs-bucket-for-state"
    prefix = "gcp"
  }
}
