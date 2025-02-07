terraform {
  required_version = ">= 1.7"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.87.0"
    }
  }

  backend "s3" {  # Описание бэкенда хранения состояния
    endpoints = { # Адрес S3 хранилища
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "terraform-student" # Название бакета
    region = "ru-central1"
    key    = "terraform.tfstate" # Путь к файлу

    skip_region_validation      = true # Пропускаем валидацию региона на стороне AWS
    skip_credentials_validation = true # Пропускаем валидацию ключей доступа на стороне AWS
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform вер
  }
}
