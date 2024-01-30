output "datascientest-instance_ip_public" {
  value = {
    for instance in aws_instance.datascientest-instance :
    instance.public_ip => instance.instance_ip_public #renvoi l'ip publique de l'intance datascientest
  }
}