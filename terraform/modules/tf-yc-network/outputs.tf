output "yandex_network" {
  description = "yandex cloud network"
  value       = data.yandex_vpc_network.default.name
}

output "yandex_subnets" {
  description = "yandex cloud subnet"
  value       = { 
    for default in data.yandex_vpc_subnet.default : default.zone =>{
    "zone" = default.zone
    "subnet_id" = default.id
    "folder_id" = default.folder_id
    "id" = default.id
    "v4_cidr_blocks" = default.v4_cidr_blocks
  }}
}
