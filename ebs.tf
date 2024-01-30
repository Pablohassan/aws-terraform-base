resource "aws_ebs_volume" "datascientest-ebs" {
  availability_zone = var.availability_zone[0]
  size              = var.ebs_size
  count =  var.environment == "dev" ? 1 : 3
  tags = {
    Name = "datascientest-ebs"
  }
}

resource "aws_volume_attachment" "datascientest_ebs_att" {
  device_name = "/dev/sdh"
  volume_id = {

    for volume in aws_ebs_volume.datascientest-ebs :
    volume.id => volume.id
  }

  instance_id = {
    for instance in aws_instance.datascientest-instance :
    instance.id => instance.id
  }
}