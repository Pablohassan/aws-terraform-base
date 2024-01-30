resource "aws_security_group" "datascientest-sg" {
  name        = "datascientest-sg"
  description = "Autorise le trafic entrant sur les ports 80, 443 et 22 et tout trafic sortant"

  ingress { #trafic entrant
    description = "Autorise le traffic entrant sur le port 443"
    from_port   = 443           #port source
    to_port     = 443           #port de destination
    protocol    = "tcp"         #protocole
    cidr_blocks = ["0.0.0.0/0"] #adresse source, aucune restrition. Possible de se connecter de n'importe ou
  }
  ingress { #trafic entrant
    description = "Autorise le traffic entrant sur le port 80"
    from_port   = 80            #port source
    to_port     = 80            #port de destination
    protocol    = "tcp"         #protocole
    cidr_blocks = ["0.0.0.0/0"] #adresse source, aucune restrition. Possible de se connecter de n'importe ou
  }
  ingress { #trafic entrant
    description = "Autorise le traffic entrant sur le port 22"
    from_port   = 22            #port source
    to_port     = 22            #port de destination
    protocol    = "tcp"         #protocole
    cidr_blocks = ["0.0.0.0/0"] #adresse source, aucune restrition. Possible de se connecter de n'importe ou
  }
  egress { #trafic sortant
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "datascientest-sg"
  }
}
resource "aws_network_interface_sg_attachment" "datascientest_sg_attachment" {
  security_group_id = aws_security_group.datascientest-sg.id
  network_interface_id = {
    for nic in aws_instance.datascientest-instance :
    nic.primary_network_interface_id => nic.primary_network_interface_id
  }
}