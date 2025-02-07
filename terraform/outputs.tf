output "external_ip_address_vm_1" { # внешний IP
  description = "внешний IP адрес ВМ"
  value       = module.tf-yc-instance.external_ip_address_vm_1
}

output "internal_ip_address_vm_1" { # внутренний IP
  description = "внутренний IP адрес ВМ"
  value       = module.tf-yc-instance.internal_ip_address_vm_1
}

output "yandex_subnet" { # подсеть
  description = "yandex cloud subnet"
  value       = module.tf-yc-network.yandex_subnets[module.tf-yc-instance.out_zone]
}
