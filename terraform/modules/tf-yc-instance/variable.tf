variable "instance_platform_id" {
  description = "Yandex flatform id"
  type        = string
  default     = "standard-v2" # standard-v1 не поддерживается в зоне ru-default1-d
}

variable "name" {
  description = "name vm"
  type        = string
  default     = "chapter7-lesson2-student"
}

variable "zone" {
  description = "instance availability zone"
  type        = string
  validation {
    condition     = contains(toset(["ru-central1-a", "ru-central1-b", "ru-central1-d"]), var.zone)
    error_message = "Select availability zone from the list: ru-central1-a, ru-central1-b, ru-central1-d."
  }
  nullable = false
}

variable "vm_cores" {
  description = "number of CPU cores for the instance"
  type        = number
  default     = "2"
}

variable "vm_memory" {
  description = "size of RAM for the instance GB"
  type        = number
  default     = "2"
}

variable "image_id" {
  description = "id of the boot disk image"
  type        = string
  default     = "fd80qm01ah03dkqb14lc"
}

variable "vm_size" {
  description = "size of the vm disk GB"
  type        = number
  default     = "20"
}

variable "subnet_id" {
  description = "id of the subnet vm"
  type        = string
}
