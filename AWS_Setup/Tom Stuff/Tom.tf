provider "aws" {
  region = "us-east-1"  # Specify your AWS region
}

# Create a new IAM User
resource "aws_iam_user" "new_user" {
  name = "Tom"
}

# Attach AdministratorAccess policy to the user
resource "aws_iam_user_policy_attachment" "admin_policy_attachment" {
  user       = aws_iam_user.new_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create Access Keys for the IAM User (optional)
resource "aws_iam_access_key" "new_user_access_key" {
  user = aws_iam_user.new_user.name
}

# Output the Access Key and Secret Key (Sensitive data)
output "new_user_access_key_id" {
  value     = aws_iam_access_key.new_user_access_key.id
  sensitive = true
}

output "new_user_secret_access_key" {
  value     = aws_iam_access_key.new_user_access_key.secret
  sensitive = true
}
