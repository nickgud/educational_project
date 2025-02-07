terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex" # Глобальный адрес источника провайдера
      version = ">= 0.87.0"           # Минимальная версия провайдера 
    }
  }

  required_version = ">= 1.7" # Минимальная необходимая версия terraform
}
