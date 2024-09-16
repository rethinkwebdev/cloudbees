variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type = string
  default = "EKS-Cluster"
}

variable "cluster_version" {
  description = "EKS Cluster Version"
  type = string
  default = "1.30.3"
}