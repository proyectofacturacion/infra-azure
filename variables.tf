variable "environment" {
  description = "Environment (dev, qa, prd)"
  type        = string
}

# Passwords de PostgreSQL por ambiente
variable "postgres_password_dev" {
  type      = string
  sensitive = true
}

variable "postgres_password_qa" {
  type      = string
  sensitive = true
}

variable "postgres_password_prd" {
  type      = string
  sensitive = true
}
