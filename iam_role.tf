data "aws_caller_identity" "current" {}

###
### For terraform
###

resource "aws_iam_role" "terraform_role" {
  name = "terraform_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = data.aws_caller_identity.current.arn
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "custom_combined_policy_for_terraform" {
  name   = "UnifiedFullAccessPolicy_for_terraform"
  policy = file("combined_policy_for_terraform.json")
}

resource "aws_iam_role_policy_attachment" "attach_combined_policy_for_terraform" {
  role       = aws_iam_role.terraform_role.name
  policy_arn = aws_iam_policy.custom_combined_policy_for_terraform.arn
}

###
### For sizing script for organization (management account)
###

resource "aws_iam_role" "management_role" {
  name = "management_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = data.aws_caller_identity.current.arn
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "custom_combined_policy_for_management" {
  name   = "UnifiedFullAccessPolicy_for_management"
  policy = file("combined_policy_for_management.json")
}

resource "aws_iam_role_policy_attachment" "attach_combined_policy_for_management" {
  role       = aws_iam_role.management_role.name
  policy_arn = aws_iam_policy.custom_combined_policy_for_management.arn
}

###
### For sizing script for indivisual account (member account)
###

resource "aws_iam_role" "member_role" {
  name = "member_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = data.aws_caller_identity.current.arn
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "custom_combined_policy_for_member" {
  name   = "UnifiedFullAccessPolicy_for_member"
  policy = file("combined_policy_for_member.json")
}

resource "aws_iam_role_policy_attachment" "attach_combined_policy_for_member" {
  role       = aws_iam_role.member_role.name
  policy_arn = aws_iam_policy.custom_combined_policy_for_member.arn
}

#
# Output
#

output "caller_identity" {
  value = data.aws_caller_identity.current
}

output "ARN_for_managment_role" {
  value = aws_iam_role.management_role.arn
}

output "ARN_for_member_role" {
  value = aws_iam_role.member_role.arn
}
