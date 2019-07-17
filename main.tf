terraform {
  required_version = ">= 0.11.13"

  backend "s3" {
  }
}

locals {
	tags = "${map("owner", "${var.owner}", "description", "${var.description}", "team", "${var.team}", 
	"use-case", "${var.use-case}", "product", "auditing", "expiration", "${var.expiration}")}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "config-logs"
  acl    = "private"

  tags = "${local.tags}"
}

resource "aws_config_configuration_recorder_status" "main" {
  name       = "aws-config"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.main"]
}

resource "aws_config_delivery_channel" "main" {
  name           = "aws-config"
  s3_bucket_name = "${aws_s3_bucket.bucket.id}"
  s3_key_prefix  = "config"

  snapshot_delivery_properties {
    delivery_frequency = "TwentyFour_Hours"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}

resource "aws_config_configuration_recorder" "main" {
  name     = "aws-config"
  role_arn = "${aws_iam_role.main.arn}"

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_configuration_aggregator" "organization" {
  depends_on = ["aws_iam_role_policy_attachment.organization"]

  name = "config_org_aggregator" # Required

  organization_aggregation_source {
    regions   = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
    role_arn  = "${aws_iam_role.organization.arn}"
  }
}