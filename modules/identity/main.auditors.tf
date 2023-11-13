resource "aws_iam_group" "auditors" {
  name = "auditors"
}

resource "aws_iam_group_membership" "auditors" {
  name  = aws_iam_group.auditors.name
  users = var.users.auditors
  group = aws_iam_group.auditors.name
}

resource "aws_iam_group_policy_attachment" "auditors" {
  group      = aws_iam_group.auditors.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "auditors-mfa" {
  group      = aws_iam_group.auditors.name
  policy_arn = aws_iam_policy.mfa.arn
}

resource "aws_iam_group_policy_attachment" "auditors-billing" {
  group      = aws_iam_group.auditors.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_iam_group_policy_attachment" "auditors-cloudwatch" {
  group      = aws_iam_group.auditors.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "auditors-elastic_load_balancing" {
  group      = aws_iam_group.auditors.name
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingReadOnly"
}
