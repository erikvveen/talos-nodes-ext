output "id" {
  value = try(linode_instance.this[0].id)
}

output "ip_address" {
  value = linode_instance.this[0].ip_address
}

output "private_ip_address" {
  value = linode_instance.this[0].private_ip_address
}