variable "project" {
  type = string
}

variable "pgp_key" {
  type = string
}

variable "users" {
  type = object({
    administrators = set(string),
    auditors       = set(string),
    developers     = set(string),
  })
}
