# NOTE: refs. https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_users-self-manage-mfa-and-creds.html

resource "aws_iam_policy" "mfa" {
  description = "This policy allows users to manage their own passwords and MFA devices but nothing else unless they authenticate with MFA."
  name        = "Force_MFA"
  policy      = data.aws_iam_policy_document.mfa.json
}

data "aws_iam_policy_document" "mfa" {
  statement {
    sid = "AllowViewAccountInfo"

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:ListVirtualMFADevices",
      "iam:ListUsers", # NOTE: allow users to view the Users page in the IAM console or use that page to access their own user information
    ]

    resources = ["*"]
  }

  statement {
    sid = "AllowManageOwnPasswords"

    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
      "iam:CreateLoginProfile", # NOTE: allow users to change their password on their own user page
      "iam:DeleteLoginProfile", # NOTE: allow users to change their password on their own user page
      "iam:GetLoginProfile",    # NOTE: allow users to change their password on their own user page
      "iam:UpdateLoginProfile", # NOTE: allow users to change their password on their own user page
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid = "AllowManageOwnAccessKeys"

    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid = "AllowManageOwnSigningCertificates"

    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid = "AllowManageOwnSSHPublicKeys"

    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid = "AllowManageOwnGitCredentials"

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid = "AllowManageOwnVirtualMFADevice"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]

    resources = ["arn:aws:iam::*:mfa/$${aws:username}"]
  }

  statement {
    sid = "AllowManageOwnUserMFA"

    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid    = "DenyAllExceptListedIfNoMFA"
    effect = "Deny"

    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
      "sts:GetSessionToken",
      "iam:ListUsers",                # NOTE: allow users to view the Users page in the IAM console or use that page to access their own user information
      "iam:CreateLoginProfile",       # NOTE: allow users to change their password from their own user page without signing in using MFA
      "iam:ChangePassword",           # NOTE: allow users to reset a password while signing in for the first time
      "iam:GetAccountPasswordPolicy", # NOTE: allow users to reset a password while signing in for the first time
    ]

    resources = ["*"]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}
