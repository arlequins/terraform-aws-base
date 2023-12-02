variable "deploy_user" {
  type    = string
  default = "default"
}
variable "tags" {
  type = map(string)
  default = {
    env     = "dev"
    service = "base"
  }
}
variable "region" {
  type    = string
  default = "ap-northeast-1"
}
variable "name_prefix" {
  type    = string
  default = "base-"
}
variable "compute_optimizer" {
  type = map(bool)
  default = {
    is_enabled = true
  }
}
variable "iam" {
  type = any
}
