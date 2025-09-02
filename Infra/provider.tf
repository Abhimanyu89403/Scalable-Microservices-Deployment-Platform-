provider "aws" {
    region = ap-south-1
}

variable "project" {default = "microservices"}
variable "vpc_cidr" {default = "10.0.0.0/16"}
variable "environment" {default = "staging"}

