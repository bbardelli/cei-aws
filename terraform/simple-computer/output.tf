#get spot instance request public ip
output "public_ip" {
  value = aws_spot_instance_request.simple-computer.public_ip
}
output "azs_available" {
  value = local.azs

}