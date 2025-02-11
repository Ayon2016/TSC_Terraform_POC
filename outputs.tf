output "alb_dns_name" {
  value = aws_lb.tsc_poc_alb.dns_name
}

output "locust_master_public_ip" {
  value = aws_instance.tsc_poc_locust_master.public_ip
}

output "locust_worker_public_ip" {
  value = aws_instance.tsc_poc_locust_worker.public_ip
}

