variable "policy_name" {
  description = "The name of the SCP policy"
  type        = string
}

variable "target_account_id" {
  description = "The AWS account ID to which the SCP will be attached"
  type        = string
}
