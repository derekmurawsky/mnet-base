data "aws_ssm_parameter" "zoneToUpdate" {
  name = "/terraform/dns-updater/zoneToUpdate"
}
data "aws_iam_policy_document" "pd-mnet-dns-updater" {
  statement {
    sid       = "pdMnetArtifactRWListbucket"
    actions   = ["route53:ChangeResourceRecordSets"]
    resources = ["arn:aws:route53:::hostedzone/${data.aws_ssm_parameter.zoneToUpdate.value}"]
  }
}

resource "aws_iam_policy" "p-mnet-dns-updater" {
  name        = "p-mnet-dns-updater"
  description = "AllowDynamicUpdate"
  policy      = "${data.aws_iam_policy_document.pd-mnet-dns-updater.json}"
}

resource "aws_iam_user" "r53-homestead-updater" {
  name = "r53-homestead-update"
  tags = "${merge(local.common_tags, map("Environment", "Prod"))}"
}

resource "aws_iam_user_policy_attachment" "r53-homestead-updater-policy" {
  user       = "${aws_iam_user.r53-homestead-updater.name}"
  policy_arn = "${aws_iam_policy.p-mnet-dns-updater.arn}"
}

resource "aws_iam_access_key" "r53-homestead-updater" {
  user = "${aws_iam_user.r53-homestead-updater.name}"
}

resource "aws_ssm_parameter" "access-key" {
  name        = "/terraform/dns-updater/access-key"
  description = "The parameter description"
  type        = "String"
  value       = "${aws_iam_access_key.r53-homestead-updater.id}"
  tags        = "${merge(local.common_tags, map("Environment", "Prod"))}"
}

resource "aws_ssm_parameter" "secret" {
  name        = "/terraform/dns-updater/secret-access-key"
  description = "The parameter description"
  type        = "SecureString"
  value       = "${aws_iam_access_key.r53-homestead-updater.secret}"
  tags        = "${merge(local.common_tags, map("Environment", "Prod"))}"
}
