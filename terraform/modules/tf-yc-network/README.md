<!-- BEGIN_TF_DOCS -->
# Модуль для создания сети

## Resources (ресурсы)

- data source.yandex_vpc_network.default (modules/tf-yc-network/main.tf#1)
- data source.yandex_vpc_subnet.default (modules/tf-yc-network/main.tf#5)

## Requirements (требования)

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.87.0 | 

## Providers (провайдер)

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.87.0 | 

 

## Examples

```hcl
data "yandex_vpc_network" "default" {
  name = "default"
}

data "yandex_vpc_subnet" "default" {
   for_each = var.network_zones
   name = "${data.yandex_vpc_network.default.name}-${each.key}" 
}
```

## Inputs (объявляемые переменные)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_zones"></a> [network\_zones](#input\_network\_zones) | Список доступных зон доступа | `set(string)` | <pre>[<br/>  "ru-central1-a",<br/>  "ru-central1-b",<br/>  "ru-central1-d"<br/>]</pre> | no | 

## Outputs (выходные данные)

| Name | Description |
|------|-------------|
| <a name="output_yandex_network"></a> [yandex\_network](#output\_yandex\_network) | сеть Яндекс.Облака |
| <a name="output_yandex_subnets"></a> [yandex\_subnets](#output\_yandex\_subnets) | подсеть Яндекс.Облака | 
<!-- END_TF_DOCS -->