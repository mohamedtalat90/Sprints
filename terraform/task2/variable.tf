variable "subnet_tags" {
  description = "Tags for subnets"
  type        = map(string)
  default     = {
    "subnet1" = "Public"
    "subnet2" = "Private"
  }
}

variable "public-securit-group_ingress_ports" {
  description = "public security group ingress ports"
  type        = list(number)
  default     = [443,80, 22]
}

variable "private-security-group_ingress_ports" {
  description = "private security group ingress ports"
  type        = list(number)
  default     = [22]
}
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "Public subnets CIDR blocks"
  type        = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}
 variable "route_cidr_block" {
description = "Route_table CIDR block"
type        = string
default = "0.0.0.0/0"
 }
