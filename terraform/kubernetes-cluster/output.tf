
output "control_plane_public_ip" {
  value = aws_spot_instance_request.control-plane.public_ip
}

output "control_plane_private_ip" {
  value = aws_spot_instance_request.control-plane.private_ip
}