variable "zone_name" {
	default     = "example.int"
}

variable "vpc_id_list" {
	description = "vpc id list"
	type        = "list"
	default = []
}

variable "need_attachment" {
	default     = "false"
}