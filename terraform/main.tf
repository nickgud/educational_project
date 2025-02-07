module "tf-yc-instance" { # Модуль для создания ВМ
  source    = "./modules/tf-yc-instance"
  zone      = var.zone
  subnet_id = module.tf-yc-network.yandex_subnets[var.zone].id
  name      = "student-terraform"
  vm_size   = 40
  image_id  = "fd80qm01ah03dkqb14lc"
}

module "tf-yc-network" { # Модуль для создания сети
  source = "./modules/tf-yc-network"
}
