terraform {
  backend "s3" {
    bucket     = "datascientest-bucket-terraform-s33"
    key        = "terraform.tfstate"                        # le fichier dans le bucket qui sera garant de l'état de l'instructure
    region     = "eu-west-3"                                # la région ou se trouve le bucket
    access_key = "AKIAW4YWYD4TU6WBYQ6T"                     # la clé d’accès crée pour l'utilisateur qui sera utilisé par terraform
    secret_key = "1agqU7d4DYADBvOXYqGy952MpLqFopdHcME4wXNN" # la clé sécrète crée pour l'utilisateur qui sera utilisé par terraform
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# la région aws ou nous voulons déployer nos différentes ressources
provider "aws" {
  region     = "eu-west-3"
  access_key = "AKIAW4YWYD4TU6WBYQ6T"                     # la clé d’accès crée pour l'utilisateur qui sera utilisé par terraform
  secret_key = "1agqU7d4DYADBvOXYqGy952MpLqFopdHcME4wXNN" # la clé sécrète crée pour l'utilisateur qui sera utilisé par terraform
}
