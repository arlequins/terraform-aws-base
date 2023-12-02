#--------------------------------------------------------------
# Project Settings
#--------------------------------------------------------------
deploy_user = "default"

tags = {
  env     = "dev"
  service = "base"
}
region = "ap-northeast-1"
#--------------------------------------------------------------
# Name prefix
# It is used as a prefix attached to various resource names.
#--------------------------------------------------------------
name_prefix = "base-"

#--------------------------------------------------------------
# Compute Optimizer
# AWS Compute Optimizer recommends optimal AWS resources for your workloads to reduce
# costs and improve performance by using machine learning to analyze historical utilization metrics.
# Over-provisioning resources can lead to unnecessary infrastructure cost, and under-provisioning resources
# can lead to poor application performance. Compute Optimizer helps you choose optimal configurations
# for three types of AWS resources: Amazon EC2 instances, Amazon EBS volumes, and AWS Lambda functions,
# based on your utilization data.
#--------------------------------------------------------------
compute_optimizer = {
  is_enabled = true
}
#--------------------------------------------------------------
# IAM: Users
#--------------------------------------------------------------
iam = {
  is_enabled = true
  user = {
    "user1" = {
      is_console_access = true
      is_access_key     = false
    },
    "user2" = {
      is_console_access = true
      is_access_key     = false
    },
    "infra-ci" = {
      is_console_access = false
      is_access_key     = true
    },
  }
  #--------------------------------------------------------------
  # Please specify the user with the same name that has been set in users.
  #--------------------------------------------------------------
  group = {
    administrator = {
      is_enabled_mfa = true
      users = [
      ]
      policy_document = null
      policy = [
        {
          policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
        }
      ]
    }
    # This name will be used as the group name.
    developer = {
      is_enabled_mfa = true
      users = [
        "user1",
        "user2",
      ]
      policy_document = {
        name        = "iam-group-developer-base-policy"
        path        = "/"
        description = ""
        statement = [
          {
            sid    = "AllowDefaultWidgetPage"
            effect = "Allow"
            actions = [
              "servicecatalog:ListApplications",
              "ce:GetCostAndUsage",
              "ce:GetCostForecast",
              "support:DescribeTrustedAdvisorChecks",
              "support:DescribeTrustedAdvisorCheckSummaries",
              "ram:ListResources",
              "health:DescribeEventAggregates",
            ]
            resources = [
              "*"
            ]
          },
          {
            sid    = "AllowS3LogList"
            effect = "Allow"
            actions = [
              "s3:ListAllMyBuckets",
            ]
            resources = [
              "*",
            ]
          },
          {
            sid    = "AllowAWSSecurityHubReadOnlyAccess"
            effect = "Allow"
            actions = [
              "securityhub:Get*",
              "securityhub:List*",
              "securityhub:Describe*",
            ]
            resources = [
              "*"
            ]
          },
          {
            sid    = "AllowAWSConfigUserAccess"
            effect = "Allow"
            actions = [
              "config:Get*",
              "config:Describe*",
              "config:Deliver*",
              "config:List*",
              "config:Select*",
              "tag:GetResources",
              "tag:GetTagKeys",
              "cloudtrail:DescribeTrails",
              "cloudtrail:GetTrailStatus",
              "cloudtrail:LookupEvents",
            ]
            resources = [
              "*"
            ]
          },
          {
            sid    = "AllowCloudWatchReadOnlyAccess"
            effect = "Allow"
            actions = [
              "autoscaling:Describe*",
              "cloudwatch:Describe*",
              "cloudwatch:Get*",
              "cloudwatch:List*",
              "logs:Get*",
              "logs:List*",
              "logs:StartQuery",
              "logs:StopQuery",
              "logs:Describe*",
              "logs:TestMetricFilter",
              "logs:FilterLogEvents",
              "sns:Get*",
              "sns:List*"
            ]
            resources = [
              "*"
            ]
          },
          {
            sid    = "DenyTfvars"
            effect = "Deny"
            actions = [
              "s3:Put*",
              "s3:Delete*",
            ]
            resources = [
              "arn:aws:s3:::terraform-tfstate-sync",
              "arn:aws:s3:::terraform-tfstate-sync/*",
            ]
          },
        ]
      }
      policy = [
        {
          policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
        },
      ]
    }
    deploy_infra = {
      is_enabled_mfa = false
      users = [
        "infra-ci",
      ]
      policy_document = null
      policy = [
        {
          policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
        }
      ]
    }
    deploy_code = {
      is_enabled_mfa = false
      users          = []
      policy_document = {
        name        = "iam-group-deploy-code-base-policy"
        path        = "/"
        description = ""
        statement = [
          {
            sid    = "AllowS3"
            effect = "Allow"
            actions = [
              "s3:*"
            ]
            resources = [
              "*",
            ]
          },
          {
            sid    = "AllowIAM"
            effect = "Allow"
            actions = [
              "iam:*"
            ]
            resources = [
              "*"
            ]
          },
          {
            sid    = "AllowDeploy"
            effect = "Allow"
            actions = [
              "cloudformation:*",
              "s3-object-lambda:*",
              "cloudfront:*",
              "logs:*",
              "lambda:*",
            ]
            resources = [
              "*"
            ]
          },
          {
            sid    = "DenyTfvars"
            effect = "Deny"
            actions = [
              "s3:Get*",
              "s3:List*",
              "s3:HeadBucket",
              "s3:PutObject",
              "s3:DeleteObject",
            ]
            resources = [
              "arn:aws:s3:::terraform-tfstate-sync",
              "arn:aws:s3:::terraform-tfstate-sync/*",
            ]
          },
        ]
      }
      policy = [
        {
          policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
        }
      ]
    }
  }
}
