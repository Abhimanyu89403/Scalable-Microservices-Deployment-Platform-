resource "aws_vpc" "my_vpc"{
    enable_dns_support = true
    enable_dns_hostnames = true
    cidr_block = var.vpc_cidr
    tags = { Name = "${var.project}-${var.environment}-vpc" }
}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.my_vpc.id
    tags = {Name = "${var.project}-${var.environment}-igw"}
}



resource "aws_subnet" "public_subnet_1"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "ap-south-1a"
    tags = {Name = "${var.project}-${var.environment}-public-subnet-1"}
}
resource "aws_subnet" "public_subnet_2"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "ap-south-1b"
    tags = {Name = "${var.project}-${var.environment}-public-subnet-2"}
}
resource "aws_subnet" "private_subnet"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-south-1a"
    tags = {Name = "${var.project}-${var.environment}-private-subnet_1"}
}
resource "aws_subnet" "private_subnet_2"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.11.0/24"
    availability_zone = "ap-south-1b"
    tags = {Name = "${var.project}-${var.environment}-private-subnet_2"}    
}




resource "aws_eip" "eip" {
    domain = "vpc"
}
resource "aws_nat_gateway" "nat-gateway"{
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.public_subnet.id
    tags = {Name = "${var.project}-${var.environment}-nat-gateway"}
}




resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {Name = "${var.project}-${var.environment}-public-route-table"}
}
resource "aws_route_table_association" "public_rta_1"{
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route.id
}
resource "aws_route_table_association" "public_rta_2"{
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route.id
}




resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/24"
        nat_gateway_id = aws_nat_gateway.nat-gateway.id
    }
    tags = {Name = "${var.project}-${var.environment}-private-route-table"}
    }
resource "aws_route_table_association" "private_rta_1"{
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private_route.id
}
resource "aws_route_table_association" "private_rta_2" {
    subnet_id = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private__route.id    
}