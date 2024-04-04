resource "aws_iam_role" "parameter_store_role" {
  name               = "parameter-store-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "parameter_store_policy" {
  name        = "parameter-store-policy"
  description = "Policy to allow read and write access to Parameter Store"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:GetParametersByPath",
        "ssm:PutParameter"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "parameter_store_attachment" {
  role       = aws_iam_role.parameter_store_role.name
  policy_arn = aws_iam_policy.parameter_store_policy.arn
}

resource "aws_iam_user" "ecr_user" {
  name = "ecr-user"
}

resource "aws_iam_user_policy" "ecr_user_policy" {
  name   = "ecr-user-policy"
  user   = aws_iam_user.ecr_user.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_access_key" "ecr_user_access_key" {
  user = aws_iam_user.ecr_user.name
}

resource "aws_ssm_parameter" "ecr_user_access_key_parameter" {
  name  = "/cei/k8s/access-key"
  type  = "SecureString"
  value = aws_iam_access_key.ecr_user_access_key.id
}

resource "aws_ssm_parameter" "ecr_user_secret_key_parameter" {
  name  = "/cei/k8s/secret-key"
  type  = "SecureString"
  value = aws_iam_access_key.ecr_user_access_key.secret
}
