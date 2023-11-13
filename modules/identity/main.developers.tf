resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_group_membership" "developers" {
  name  = aws_iam_group.developers.name
  users = var.users.developers
  group = aws_iam_group.developers.name
}

resource "aws_iam_group_policy_attachment" "developers" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "developers-mfa" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.mfa.arn
}

resource "aws_iam_group_policy_attachment" "developers-cloudwatch" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "developers-elastic_load_balancing" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingReadOnly"
}

resource "aws_iam_group_policy_attachment" "developers-sqs" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSReadOnlyAccess"
}
