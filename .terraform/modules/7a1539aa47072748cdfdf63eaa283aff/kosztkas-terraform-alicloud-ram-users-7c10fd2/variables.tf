variable "alicloud_access_key" {
  description = "The Alicloud Access Key ID to use"
  default = ""
}
variable "alicloud_secret_key" {
  description = "The Alicloud Secret Key to use"
  default = ""
}

#Note that these list should be in the same order
variable "usernames" {
  description = "List of usernames"
  default = [
  "tfuser1",
  "tfuser2",
  "tfuser3"
  ]
}

variable "emails" {
  description = "List of email addresses"
  default = [
  "tf.user1@example.com",
  "tf.user2@example.com",
  "tf.user3@example.com"
  ]
}

variable "dispnames"{
  description = "List of display names"
  default = [
  "1.TFUser",
  "2.TFUser",
  "3.TFUser",
  ]
}

variable "password" {
  description = "Default password given for the created users"
  default = "Password12345"
}

variable "group_name" {
  description = "The RAM user group, the new user will be assigned to"
  default = "TF-Users"
}

