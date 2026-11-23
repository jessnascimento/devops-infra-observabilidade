
# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"

  tags = local.common_tags
}

# ECS Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "512"
  memory = "1024"

  # Permissão para o ECS buscar imagens e secrets
  execution_role_arn = aws_iam_role.ecs_execution.arn

  # Permissão para o ECS Exec
  task_role_arn = "arn:aws:iam::345856463400:role/projeto-observabilidade-ecs-task-role"

  container_definitions = jsonencode([

    # Node.js Application
    {
      name      = "application"
      image     = "${aws_ecr_repository.app.repository_url}:${var.app_image_tag}"
      essential = true

      cpu    = 256
      memory = 512

      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "OTEL_SERVICE_NAME"
          value = "devops-observabilidade"
        },
        {
          name  = "OTEL_EXPORTER_OTLP_ENDPOINT"
          value = "http://localhost:4318"
        },
        {
          name  = "OTEL_EXPORTER_OTLP_PROTOCOL"
          value = "http/protobuf"
        }
      ]

      dependsOn = [
        {
          containerName = "grafana-alloy"
          condition     = "START"
        }
      ]
    },

    # Grafana Alloy
    {
      name      = "grafana-alloy"
      image     = "${aws_ecr_repository.alloy.repository_url}:${var.alloy_image_tag}"
      essential = true

      cpu    = 256
      memory = 512

      environment = [
        {
          name  = "OTEL_EXPORTER_OTLP_ENDPOINT"
          value = "https://otlp-gateway-prod-sa-east-1.grafana.net/otlp"
        }
      ]

      secrets = [
        {
          name      = "GRAFANA_CLOUD_AUTHORIZATION"
          valueFrom = var.grafana_secret_arn
        }
      ]
    }
  ])

  tags = local.common_tags

  depends_on = [
    aws_iam_role_policy_attachment.ecs_execution,
    aws_iam_role_policy.secrets
  ]
}

# ECS Service
resource "aws_ecs_service" "app" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = true
  }

  tags = local.common_tags
}
