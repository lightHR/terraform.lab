variable "int_port" {
  default = 3000

  validation {
    condition     = var.int_port == 3000
    error_message = "Interal port must be 3000."
  }
}

variable "ext_port" {
  type = list(any)
}