resource "aws_instance" "datascientest-instance" {
  ami           = var.image_id                     # disponible uniquement en région eu-west-3
  instance_type = var.type_instance                # taille de l'instance (1vcpu, 1G de ram)
  count         = var.environment == "dev" ? 1 : 3 # si variable environnement est égale à "dev", lance une instance, sinon lance 3 instances
  # déclaration des user_data dans la ressource

  monitoring = var.monitoring
  network_interface {
    network_interface_id = aws_network_interface.interface_reseau_instance.id
    device_index         = 0
  }
  tags = {
    Name = "datascientest ${count.index}" #qui affichera datascientest 1, datascientest 2, datascientest 3
  }

  # création du vpc pour les ressources

  depends_on = [
    # le groupe de sécurité devra être crée avant que l'instance ne le soit
    aws_security_group.datascientest-sg,
  ]
}

# création du vpc pour les ressources
resource "aws_vpc" "datascientest_vpc" {
  cidr_block = var.cidr_block_vpc[0]

  tags = {
    Name = "datascientest_vpc"
  }
  depends_on = [
    # le groupe de sécurité devra être crée avant que l'instance ne le soit
    aws_security_group.datascientest-sg,
  ]
}
# création du sous réseau pour les ressources
resource "aws_subnet" "datascientest_subnet" {
  vpc_id            = aws_vpc.datascientest_vpc.id
  cidr_block        = var.cidr_block_subnet[0]
  availability_zone = var.availability_zone[0]

  tags = {
    Name = "datascientest_subnet"
  }
}

resource "aws_network_interface" "interface_reseau_instance" {
  subnet_id   = aws_subnet.datascientest_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "interface_reseau_instance"
  }
}

data "aws_ami" "datascientest-ami" { # déclaration de la source de données de type aws_ami (ami aws)
  most_recent = true                 # demande à avoir l'image la plus recente disponible
  owners      = ["amazon"]           # lorsque le proriétaire de l'image s'appele amazon

  filter {          # on ajoute un filtre
    name   = "name" # on veut filtrer l'image lorsque le nom à comme par amzn2-ami-hvm-, * pour n'importe quoi en suite
    values = ["amzn2-ami-hvm-*"]
  }
}