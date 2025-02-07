variable "instance_cloud_id" {
  description = "Yandex cloud id"
  type        = string
  default     = ""
}

variable "instance_folder_id" {
  description = "Yandex folder id"
  type        = string
  default     = ""
}

variable "iam_token" {
  description = "IAM token"
  type        = string
  sensitive   = true
  default     = ""
}

variable "zone" {
  description = "instance availability zone"
  type        = string
  default     = "ru-central1-a"
  validation {
    condition     = contains(toset(["ru-central1-a", "ru-central1-b", "ru-central1-d"]), var.zone)
    error_message = "Select availability zone from the list: ru-central1-a, ru-central1-b, ru-central1-d."
  }
  nullable = false
}

variable "subnet_id" {
  description = "ID of the subnet for the instance"
  type        = string
  default     = ""
}
