variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "projeto-observabilidade"
}

variable "app_port" {
  description = "Porta da aplicação Node.js"
  type        = number
  default     = 3000
}

variable "app_image_tag" {
  description = "Tag da imagem da aplicação"
  type        = string
  default     = "latest"
}

variable "alloy_image_tag" {
  description = "Tag da imagem do Alloy"
  type        = string
  default     = "latest"
}

variable "grafana_secret_arn" {
  description = "ARN do segredo com as credenciais do Grafana Cloud"
  type        = string
  sensitive   = true
}
