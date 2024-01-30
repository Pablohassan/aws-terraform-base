variable "image_id" {
  type     = string
  nullable = false
  default  = "ami-064736ff8301af3ee"

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "La valeur image_id doit être un identifiant AMI valide, commençant par \"ami-\"."
  }
}


variable "type_instance" {
  type    = string
  default = "t3.micro"
}


variable "monitoring" {
  type    = bool
  default = false
}

variable "ebs_size" {
  type    = number
  default = "5"

}

variable "cidr_block_vpc" {
  type    = list(any)
  default = ["172.16.0.0/16"]
}

variable "aws_subnet" {
  type    = list(any)
  default = [0]

}

variable "availability_zone" {
  type    = list(string)
  default = ["eu-west-3a"]
}

variable "cidr_block_subnet" {
  type = list(string)

  default = ["172.16.10.0/24"]

}
variable "environment" {
  type    = string
  default = "prod"
}

# variable "motdepasse" {
#   type = string
#   default="Datascientest"
#   sensitive = true
# }

# l'appel dans la ressource
# resource "aws_instance" "datascientest" {
#   ami = var.instance_ami
#       = var.motdepasse
# }