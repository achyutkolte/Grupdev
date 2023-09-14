output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = values(aws_instance.ec2_instances)[*].id
}
