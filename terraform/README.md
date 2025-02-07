<!-- BEGIN_TF_DOCS -->
# Репозиторий с конфигурационными файлами для инфраструктуры. 

## Предварительные настройки
Для управления облачными ресурсами через командную строку необходимо установить Yandex Cloud (CLI) интерфейс командной строки.  
Для работы с terraform в Яндекс.Облаке нужно настроить профиль CLI для выполнения операций от имени сервисного аккаунта и добавить аутентификационные данные в переменные окружения:
```
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

 Где:
    YC_TOKEN — IAM-токен.
    YC_CLOUD_ID — идентификатор облака.
    YC_FOLDER_ID — идентификатор каталога.

 ``` 
Время жизни IAM-токена — не больше 12 часов, поэтому рекомендуется запрашивать его чаще.

Для загрузки состояний Terraform в Yandex Object Storage необходимо создать и сохранить статический ключ доступа для сервисного аккаунта.  
После можно добавить в переменные окружения идентификатор ключа и секретный ключ:
```
export AWS_ACCESS_KEY="<идентификатор_ключа>"
export AWS_SECRET_KEY="<секретный_ключ>"
```

# Project structure (структура проекта)
Файлы key.json (авторизованный ключ) и terraforms.tfvars (значения переменных) добавлены в .gitignore и не загружаются в репозиторий, так как содержат чувствительные данные.
```
.
├── LICENSE
├── README.md
└── terraform
    ├── key.json              
    ├── main.tf
    ├── modules
    │   ├── tf-yc-instance
    │   │   ├── cloud-init.yaml
    │   │   ├── main.tf
    │   │   ├── output.tf
    │   │   ├── ReadMe.md
    │   │   ├── README.md
    │   │   ├── terraforms.tfvars
    │   │   ├── variable.tf
    │   │   └── versions.tf
    │   └── tf-yc-network
    │       ├── main.tf
    │       ├── README.md
    │       └── versions.tf
    ├── outputs.tf
    ├── provider.tf
    ├── README.md
    ├── terraform.tfvars
    ├── variable.tf
    └── versions.tf

 ```


## Requirements (требования к версии)

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.87.0 |


## Modules (Модули в проекте)

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tf-yc-instance"></a> [tf-yc-instance](#module\_tf-yc-instance) | ./modules/tf-yc-instance | n/a |
| <a name="module_tf-yc-network"></a> [tf-yc-network](#module\_tf-yc-network) | ./modules/tf-yc-network | n/a |



## Examples (корневой модуль)

```hcl
module "tf-yc-instance" { # Модуль для создания ВМ
  source = "./modules/tf-yc-instance"
}

module "tf-yc-network" { # Модуль для создания сети 
  source = "./modules/tf-yc-network"
}
```

## Inputs (объявляемые переменные)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iam_token"></a> [iam\_token](#input\_iam\_token) | IAM token | `string` | n/a | yes |
| <a name="input_instance_cloud_id"></a> [instance\_cloud\_id](#input\_instance\_cloud\_id) | ID Яндекс.Облака | `string` | n/a | yes |
| <a name="input_instance_folder_id"></a> [instance\_folder\_id](#input\_instance\_folder\_id) | ID Каталога Яндекс.Облака | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID подсети Яндекс.Облака | `string` | `"e9bthtjlsk6ln3tgqtvn"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Зона доступности в Яндекс.Облаке | `string` | `"ru-central1-a"` | no |


## Outputs (выходные данные)

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address_vm_1"></a> [external\_ip\_address\_vm\_1](#output\_external\_ip\_address\_vm\_1) | внешний IP адрес ВМ |
| <a name="output_internal_ip_address_vm_1"></a> [internal\_ip\_address\_vm\_1](#output\_internal\_ip\_address\_vm\_1) | внутренний IP адрес ВМ |
| <a name="output_yandex_subnet"></a> [yandex\_subnet](#output\_yandex\_subnet) | облачная подсеть Яндекс.Облака |
<!-- END_TF_DOCS -->
