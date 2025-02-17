#get spot instance request public ip
output "public_ip" {
  value = local.use_spot ? aws_spot_instance_request.simple-computer.0.public_ip : aws_instance.simple-computer.0.public_ip
}
output "azs_available" {
  value = local.azs

}