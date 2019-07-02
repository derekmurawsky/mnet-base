variable "murawsky_net_google_cnames" {
  default = ["www", "sites", "mail", "calendar"]
}
resource "aws_route53_zone" "r53_murawsky_net" {
  name = "murawsky.net"
}

resource "aws_route53_record" "mnet-mailexchangers" {
  zone_id = "${aws_route53_zone.r53_murawsky_net.zone_id}"
  name    = "murawsky.net"
  type    = "MX"
  ttl     = "3600"
  records = ["5 aspmx.l.google.com"]
}

resource "aws_route53_record" "mnet-spf-google-verification" {
  zone_id = "${aws_route53_zone.r53_murawsky_net.zone_id}"
  name    = "murawsky.net"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "google-site-verification=rkiVLosxk4qSpswxxwchbgGb9r8RL0Be1wcI9yV16Ko",
    "v=spf1 mx include:amazonses.com include:_spf.google.com ~all"
  ]
}

resource "aws_route53_record" "murawsky_net_google_cname_records" {
  count   = "${length(var.murawsky_net_google_cnames)}"
  zone_id = "${aws_route53_zone.r53_murawsky_net.zone_id}"
  name    = "${element(var.murawsky_net_google_cnames, count.index)}"
  type    = "CNAME"
  ttl     = "3600"
  records = ["ghs.google.com"]
}
