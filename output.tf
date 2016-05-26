output "vpc_id" {
  value = "${var.vpc_id}"
}

output "vpc_name" {
  value = "${var.vpc_name}"
}

output "availability_zone" {
  value = "${var.availability_zone}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "public_subnet_cidr" {
  value = "${var.public_subnet_cidr}"
}

output "private_subnet_id" {
  value = "${aws_subnet.private_subnet.id}"
}

output "private_subnet_cidr" {
  value = "${var.private_subnet_cidr}"
}
