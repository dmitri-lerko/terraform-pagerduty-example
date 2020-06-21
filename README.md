# terraform-pagerduty-example
Example repository to manage PagerDuty with Terraform and GitHub Actions, using GCS as Remote State Backend. This example sets up 3 users, 2 schedules and 2 integrations that are compatible with Alertmanager. This is a fairly trivial example, but allows to automate quite a lot of repetitive UI work.

## Prerequisites
* PagerDuty API Token [Generation a general access REST API key](https://support.pagerduty.com/docs/generating-api-keys#section-generating-a-general-access-rest-api-key)
* GCP Account, Project, GCS bucket for state and [Service Account JSON Key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) with [Read/Write permissions](https://cloud.google.com/storage/docs/access-control/iam-roles) for the aforementioned bucket.

## Setup GitHub Actions
[Set GitHub secrets:](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets)
* PAGERDUTY_TOKEN
* GOOGLE_CREDENTIALS (Insert entire content of Service Account JSON key into the secret)

## Usage
#### PR Creation
Terraform will run init, fmt, validate and plan. Results of the plan will be set as a comment on the PR.
#### Master Merge
Terraform will run init, validate and apply. Output will print integration keys if you've chaned/added any.

## Managing existing PagerDuty setup via Terraform
I highly recommend playing with [API Reference](https://developer.pagerduty.com/api-reference/) to understand all the moving parts of your existing setup and then importing those with terraform.

e.g. of importing an existing user:
```bash
terraform import 'pagerduty_user.user["alice"]' AL123C
```
