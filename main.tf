terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    organization = "succpinn-solutions-azure-policy"

    workspace {
      name = "aws-scp-deployment" # 👈 Replace with your actual TFC workspace name
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_organizations_policy" "restrict_region" {
  name        = var.policy_name
  description = "Allow only resource creation in us-east-1"
  content     = file("${path.module}/scp-policy.json")
  type        = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy_attachment" "attach_policy" {
  policy_id = aws_organizations_policy.restrict_region.id
  target_id = var.target_account_id
}
