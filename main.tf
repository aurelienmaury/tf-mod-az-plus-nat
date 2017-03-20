
resource "aws_subnet" "public_subnet" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "${var.vpc_name}-${var.availability_zone}-public"
    Description = "${var.vpc_name} public subnet in AZ ${var.availability_zone}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "${var.vpc_name}-${var.availability_zone}-private"
    Description = "${var.vpc_name} private subnet in AZ ${var.availability_zone}"
  }
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-jessie-amd64-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["379101102735"] # Debian Project
}

resource "aws_instance" "nat_instance" {
  ami           = "${data.aws_ami.debian.id}"
  instance_type = "t2.micro"

  subnet_id     = "${aws_subnet.public_subnet.id}"

  associate_public_ip_address = true

  tags {
    Name = "${var.vpc_name}-${var.availability_zone}-NAT"
  }
}


resource "aws_route_table" "private_subnet_route" {

  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat_instance.id}"
  }

  tags {
    Name = "${var.vpc_name}-${var.availability_zone}-private"
  }
}

resource "aws_route_table_association" "private_subnet_to_nat" {
  subnet_id = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_subnet_route.id}"
}

resource "aws_route_table_association" "public_subnet_to_gateway" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${var.public_gateway_route_table_id}"
}
