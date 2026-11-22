
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

output "get_public_ip_command" {
  description = "Comando para consultar o IP público da aplicação"

  value = "TASK=$(aws ecs list-tasks --cluster ${aws_ecs_cluster.main.name} --service-name ${aws_ecs_service.app.name} --query 'taskArns[0]' --output text) && ENI=$(aws ecs describe-tasks --cluster ${aws_ecs_cluster.main.name} --tasks $TASK --query 'tasks[0].attachments[0].details[?name==`networkInterfaceId`].value | [0]' --output text) && aws ec2 describe-network-interfaces --network-interface-ids $ENI --query 'NetworkInterfaces[0].Association.PublicIp' --output text"
}
