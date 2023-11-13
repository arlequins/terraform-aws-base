#--------------------------------------------------------------
# module variables
#--------------------------------------------------------------
variable "aws_iam_role" {
  type = object(
    {
      eks = object({
        # Description of the role.
        description = string
        # Friendly name of the role. If omitted, Terraform will assign a random, unique name. See IAM Identifiers for more information.
        name = string
        # Path to the role. See IAM Identifiers for more information.
        path = string
        }
      )
      eks_worker_node = object({
        # Description of the role.
        description = string
        # Friendly name of the role. If omitted, Terraform will assign a random, unique name. See IAM Identifiers for more information.
        name = string
        # Path to the role. See IAM Identifiers for more information.
        path = string
        }
      )
    }
  )
  description = "(Optional) Provides an IAM role."
  default = {
    eks = {
      description = "Role for EKS."
      name        = "eks-role"
      path        = "/"
    }
    eks_worker_node = {
      description = "Role for EKS worker node."
      name        = "eks-worker-node-role"
      path        = "/"
    }
  }
}
variable "aws_iam_policy" {
  type = object(
    {
      eks_worker_node = object({
        # Description of the IAM policy.
        description = string
        # The name of the policy. If omitted, Terraform will assign a random, unique name.
        name = string
        # Path in which to create the policy. See IAM Identifiers for more information.
        path = string
        }
      )
    }
  )
  description = "(Optional) Provides an IAM policy."
  default = {
    eks_worker_node = {
      description = "Policy for EKS worker node."
      name        = "eks-worker-node-policy"
      path        = "/"
    }
  }
}
variable "aws_iam_instance_profile" {
  type = object(
    {
      eks_worker_node = object({
        # Name of the instance profile. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix. Can be a string of characters consisting of upper and lowercase alphanumeric characters and these special characters: _, +, =, ,, ., @, -. Spaces are not allowed.
        name = string
        # Path to the instance profile. For more information about paths, see IAM Identifiers in the IAM User Guide. Can be a string of characters consisting of either a forward slash (/) by itself or a string that must begin and end with forward slashes. Can include any ASCII character from the ! (\u0021) through the DEL character (\u007F), including most punctuation characters, digits, and upper and lowercase letters.
        path = string
        }
      )
    }
  )
  description = "(Optional) Provides an IAM instance profile."
  default = {
    eks_worker_node = {
      name = "eks-worker-node-profile"
      path = "/"
    }
  }
}
variable "tags" {
  type        = map(any)
  description = "(Optional) Key-value mapping of tags for the IAM role"
  default     = null
}
