
output "aws_region" {
  description = "Região AWS utilizada"
  value       = var.aws_region
}

output "ecr_app_repository" {
  description = "URL do repositório da aplicação"
  value       = aws_ecr_repository.app.repository_url
}

output "ecr_alloy_repository" {
  description = "URL do repositório do Alloy"
  value       = aws_ecr_repository.alloy.repository_url
}

output "ecs_cluster_name" {
  description = "Nome do ECS Cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "Nome do ECS Service"
  value       = aws_ecs_service.app.name
}

output "ecs_task_definition" {
  description = "ARN da Task Definition"
  value       = aws_ecs_task_definition.app.arn
}

output "security_group_id" {
  description = "Security Group da aplicação"
  value       = aws_security_group.app.id
}

output "application_url" {
  description = "Application HTTP URL; HTTPS is also available when enabled"
  value       = "http://${var.app_hostname}"
}

output "certificate_arn" {
  description = "ACM certificate ARN for checking issuance before enabling HTTPS"
  value       = aws_acm_certificate.app.arn
}
