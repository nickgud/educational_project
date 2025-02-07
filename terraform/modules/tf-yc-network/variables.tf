variable "network_zones" {
  description = "List of zones subnets"
  type        = set(string)
  default     = ["ru-central1-a", "ru-central1-b",  "ru-central1-d"]
}
