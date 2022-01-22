resource "aws_iam_role" "terraform_plan" {
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy_pr.json
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "GitHubActions_Terraform_${var.name}_terraform_plan"
}

resource "aws_iam_role_policy_attachment" "terraform_plan_put_plan_file" {
  role       = aws_iam_role.terraform_plan.name
  policy_arn = aws_iam_policy.put_plan_file.arn
}

resource "aws_iam_role_policy_attachment" "terraform_plan_read_terraform_state" {
  count = var.s3_bucket_terraform_state_name == "" ? 1 : 0

  role       = aws_iam_role.terraform_plan.name
  policy_arn = aws_iam_policy.read_terraform_state[0].arn
}
