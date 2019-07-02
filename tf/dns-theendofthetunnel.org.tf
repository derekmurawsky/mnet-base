variable "theendofthetunnel_root_cnames" {
  default = ["www", "ftp", "ssh"]
}
resource "aws_route53_zone" "dns_teott_org_zone" {
  name = "theendofthetunnel.org"
}

resource "aws_route53_record" "dns_teott_org_domainkey_policy" {
  zone_id = "${aws_route53_zone.dns_teott_org_zone.zone_id}"
  name    = "_domainkey.theendofthetunnel.org"
  type    = "TXT"
  ttl     = "3600"
  records = ["o=~; r=postmaster@theendofthetunnel.org"]
}
resource "aws_route53_record" "dns_teott_org_domainkey_record" {
  zone_id = "${aws_route53_zone.dns_teott_org_zone.zone_id}"
  name    = "theendofthetunnel.org._domainkey.theendofthetunnel.org"
  type    = "TXT"
  ttl     = "3600"
  records = [
    "k=rsa; t=y; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDpUEGPN/4NPUc2gNYaNBKD6p2Hc",
    "GC6eCM73oKiVCCUCc90LaJn7NQW3xe71oOu2WYo9C/JclgO2nxJlbFy/HjZqClqebtM444deueYsY/g6",
    "Iz+CVsQZAoLOPUAlPP40jcGWmwnM5gye4f9VPrQMKhyXy/aF/FZcyHo9wr1JqpgQIDAQAB"
  ]
}

resource "aws_route53_record" "dns_teott_org_mailexchangers" {
  zone_id = "${aws_route53_zone.dns_teott_org_zone.zone_id}"
  name    = "theendofthetunnel.org"
  type    = "MX"
  ttl     = "3600"
  records = [
    "0 fltr-in2.mail.dreamhost.com.",
    "0 fltr-in1.mail.dreamhost.com."
  ]
}

resource "aws_route53_record" "dns_teott_org_root" {
  zone_id = "${aws_route53_zone.dns_teott_org_zone.zone_id}"
  name    = "theendofthetunnel.org"
  type    = "A"
  ttl     = "3600"
  records = ["208.97.176.150"]
}
resource "aws_route53_record" "theendofthetunnel_root_cname_records" {
  count   = "${length(var.theendofthetunnel_root_cnames)}"
  zone_id = "${aws_route53_zone.dns_teott_org_zone.zone_id}"
  name    = "${element(var.theendofthetunnel_root_cnames, count.index)}"
  type    = "CNAME"
  ttl     = "3600"
  records = ["${aws_route53_record.dns_teott_org_root.fqdn}"]
}

