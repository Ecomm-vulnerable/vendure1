
data "aws_iam_policy_document" "policy_document_for_ecr" {
  statement {
    sid = "allowecr"
    actions =  [
    "ecr:BatchGetImage",
    "ecr:BatchCheckLayerAvailability",
    "ecr:CompleteLayerUpload",
    "ecr:DescribeImages",
    "ecr:DescribeRepositories",
    "ecr:GetDownloadUrlForLayer",
    "ecr:InitiateLayerUpload",
    "ecr:ListImages",
    "ecr:PutImage",
    "ecr:UploadLayerPart",
    "ecr:CreateRepository",
    "ecr:DeleteRepository",
    "ecr:GetAuthorizationToken"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr_policy"
  description = "operate on ECR"
  path        = "/"

  policy = data.aws_iam_policy_document.policy_document_for_ecr.json
}


resource "aws_iam_role" "ecr_user_role" {
  name        = "ecr_user_role"
  description = "Role that operates on ECR"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
                "AWS": "*"
            }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
  role       = aws_iam_role.ecr_user_role.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}

resource "aws_iam_user" "John" {
  name = "John"
}

resource "aws_iam_user_policy" "John_policy" {
  name   = "John_policy"
  user   = aws_iam_user.John.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Resource": "*"
        }
    ]
  })
}

resource "aws_iam_access_key" "John_user_key" {
  user = aws_iam_user.John.name
}

output "access_key_id" {
  value = aws_iam_access_key.John_user_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.John_user_key.secret
  sensitive = true
}