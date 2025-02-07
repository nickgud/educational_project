resource "yandex_compute_instance" "vm-1" {
  name                      = var.name
  platform_id               = var.instance_platform_id
  zone                      = var.zone
  allow_stopping_for_update = true # разрешить остановку ресурса для внесения изменений

  # Конфигурация ресурсов:
  # количество процессоров и оперативной памяти
  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  # Загрузочный диск:
  # здесь указывается образ операционной системы
  # для новой виртуальной машины
  boot_disk {
    initialize_params {
      image_id = var.image_id # id образа 
      size     = var.vm_size  # размер диска в GB
    }
  }

  # Сетевой интерфейс:
  # нужно указать идентификатор подсети, к которой будет подключена ВМ
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  # Метаданные машины:
  # здесь можно указать скрипт, который запустится при создании ВМ
  # или список SSH-ключей для доступа на ВМ
  metadata = {
    user-data = "${file("./modules/tf-yc-instance/cloud-init.yaml")}"
  }

  # Конфигурация политики планирования:
  scheduling_policy {
    preemptible = true # true - прерываевая
  }
}


