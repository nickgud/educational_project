<!-- BEGIN_TF_DOCS -->
# Модуль для создания виртуальной машины 


## Resources (ресурсы)

- resource.yandex_compute_instance.vm-1 (modules/tf-yc-instance/main.tf#1)

## Requirements (требования)

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.87.0 | 

## Providers (провайдер)

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.87.0 | 

 
## Inputs (объявляемые переменные)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Имя ВМ | `string` | `"chapter7-lesson2-student"` | no |
| <a name="input_instance_platform_id"></a> [instance\_platform\_id](#input\_instance\_platform\_id) | ID платформы ВМ | `string` | `"standard-v2"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID подсети ВМ | `string` | n/a | yes |
| <a name="input_vm_cores"></a> [vm\_cores](#input\_vm\_cores) | Количество ядер CPU ВМ | `number` | `"2"` | no |
| <a name="input_vm_image_id"></a> [image\_id](#input\image\_id) | ID образа загрузочного диска | `string` | `"fd89k85hm37bk6bfrtd2"` | no |
| <a name="input_vm_memory"></a> [vm\_memory](#input\_vm\_memory) | Размер ОЗУ ВМ в Гб | `number` | `"2"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Размер диска ВМ в Гб | `number` | `"20"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Зона доступности Яндекс.Облака | `string` | n/a | yes | 

## Output (выходные данные)

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address_vm_1"></a> [external\_ip\_address\_vm\_1](#output\_external\_ip\_address\_vm\_1) | внешний IP адрес ВМ |
| <a name="output_internal_ip_address_vm_1"></a> [internal\_ip\_address\_vm\_1](#output\_internal\_ip\_address\_vm\_1) | внутренний IP адрес ВМ |
| <a name="output_out_zone"></a> [out\_zone](#output\_out\_zone) | подсеть выбранная для ресурса | 
<!-- END_TF_DOCS -->
