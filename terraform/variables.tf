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

variable "hosted_zone_id" {
  description = "ID of the existing public Route 53 hosted zone"
  type        = string
}

variable "app_hostname" {
  description = "Application hostname within the public hosted zone"
  type        = string
}

variable "enable_https" {
  description = "Enable HTTPS after ACM has issued the certificate"
  type        = bool
  default     = false
}

variable "health_check_path" {
  description = "HTTP path used by the load balancer health check"
  type        = string
  default     = "/"
}

variable "health_check_matcher" {
  description = "Successful HTTP status codes for the health check"
  type        = string
  default     = "200-399"
}
