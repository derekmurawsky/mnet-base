resource "aws_s3_bucket" "mnet-artifacts" {
  bucket = "mnet-artifacts"
  acl    = "private"

  tags = "${merge(local.common_tags,
    map(
      "Name", "artifacts",
      "Environment", "Prod"
  ))}"
}

data "aws_iam_policy_document" "pd-mnet-artifact-rw" {
  statement {
    sid       = "pdMnetArtifactRWListbucket"
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.mnet-artifacts.arn}"]
  }
  statement {
    sid       = "pdMnetArtifactRWObjects"
    actions   = ["s3:*Object"]
    resources = ["${aws_s3_bucket.mnet-artifacts.arn}/*"]
  }
}

resource "aws_iam_policy" "p-mnet-artifact-rw" {
  name        = "p-mnet-artifact-rw"
  description = "MNet artifact bucket Read/Write role"
  policy      = "${data.aws_iam_policy_document.pd-mnet-artifact-rw.json}"
}
