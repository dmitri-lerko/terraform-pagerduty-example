variable "users" {
  type = map(object({
    name  = string
    email = string
    role  = string
  }))
}

variable "PAGERDUTY_TOKEN" {}
