provider "yandex" { # Название провайдера 
  cloud_id  = var.instance_cloud_id
  folder_id = var.instance_folder_id
  zone      = var.zone
  #token    = var.iam_token
  service_account_key_file = "key.json" # авторизованный ключ для сервисного аккаунта
}
