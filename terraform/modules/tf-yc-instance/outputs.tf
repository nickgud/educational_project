output "internal_ip_address_vm_1" { # внутренний IP
  description = "внутренний IP адрес ВМ"
  value       = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" { # внешний IP
  description = "внешний IP адрес ВМ"
  value       = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "out_zone" { # подсеть ресурса
  description = "подсеть выбранная для ресурса"
  value       = yandex_compute_instance.vm-1.zone
}
