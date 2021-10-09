#  CloudWatch Log Group 
resource "aws_cloudwatch_log_group" "log_group" {

  name_prefix       = var.name
  retention_in_days = 3
  tags              = "${local.tags}"
}