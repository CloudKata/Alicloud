output "security_group_id" {
  value = "${module.security-group.security_group_id}"
}

output "instance_ids" {
  value = "${module.ecs-instance.instance_ids}"
}

output "disk_ids" {
  value = "${module.ecs-instance.disk_ids}"
}