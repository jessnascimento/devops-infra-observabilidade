mock_provider "aws" {}

run "certificate_record_addresses_known" {
  command = plan
  variables {
    hosted_zone_id     = "Z123"
    app_hostname       = "app.example.com"
    grafana_secret_arn = "arn:aws:secretsmanager:us-east-1:123456789012:secret:example"
  }
}
