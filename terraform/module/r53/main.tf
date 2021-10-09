# Add Load Balancer DNS Name as an Alias

resource "aws_route53_record" "www" {
  zone_id = "${var.zone_id}"
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${var.alb_dns}"
    zone_id                = "${var.zone_id}"
    evaluate_target_health = true
  }

}