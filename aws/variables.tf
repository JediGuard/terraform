variable "aws_region" {
  default = "us-east-2"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_count" {
  description = "Number of subnet"
  type = map(number)
  default = {
    private = 2
    public = 1
  }
}

variable "settings" {
  description = "Configuration settings"
  type = map(any)
  default = {
    "database" = {
        allocated_storage = 10
        engine = "mysql"
        engine_version = "8.0.35"
        instance_class = "db.t2.micro"
        db_name = "myapp"
        skip_final_snapshot = true
    },
    "web_app" = {
        count = 1
        instance_type = "t2.micro"
    }
  }
}

variable "public_subnet_cidr_bloks" {
  description = "Avalible CIDR blocs for public subnets"
  type = list(string)
  default = [ 
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}

variable "private_subnet_cidr_bloks" {
  description = "Avalible CIDR blocs for private subnets"
  type = list(string)
  default = [ 
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24"
  ]
}

variable "my_ip" {
  description = "My IP address"
  type = any
  sensitive = true
}

variable "db_username" {
  description = "Database master user"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "Database master user password"
  type = string
  sensitive = true
}
