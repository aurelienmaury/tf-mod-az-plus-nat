variable "vpc_id" {}
variable "vpc_name" {}
variable "availability_zone" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "public_gateway_route_table_id" {}
variable "bastion_default_public_key" {}
variable "instance_type" {
  default = "t2.micro"
}
variable "bastion_security_group_id_list" {
  type = "list"
  default = []
}
