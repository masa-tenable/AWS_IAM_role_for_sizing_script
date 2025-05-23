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
