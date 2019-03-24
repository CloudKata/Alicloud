variable "name" {
	default = ""
}

variable "vswitch_id" {}

variable "instance_ids" {
	description = "List of instances ID to place in the SLB pool"
    type = "list"
}