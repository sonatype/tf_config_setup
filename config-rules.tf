resource "aws_config_config_rule" "iam-user-no-policies-check" {
	name        = "iam-user-no-policies-check"
	description = "Ensure that none of your IAM users have policies attached. IAM users must inherit permissions from IAM groups or roles."

	source {
		owner             = "AWS"
		source_identifier = "IAM_USER_NO_POLICIES_CHECK"
	}

	depends_on = ["aws_config_configuration_recorder.main"]
}

resource "aws_config_config_rule" "rds-instance-public-access-check" {
	name        = "rds-instance-public-access-check"
	description = "Checks whether the Amazon Relational Database Service (RDS) instances are not publicly accessible. The rule is non-compliant if the publiclyAccessible field is true in the instance configuration item."

	source {
		owner             = "AWS"
		source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
	}

	depends_on = ["aws_config_configuration_recorder.main"]
}

resource "aws_config_config_rule" "rds-snapshots-public-prohibited" {
	name        = "rds-snapshots-public-prohibited"
	description = "Checks if Amazon Relational Database Service (Amazon RDS) snapshots are public."

	source {
		owner             = "AWS"
		source_identifier = "RDS_SNAPSHOTS_PUBLIC_PROHIBITED"
	}

	depends_on = ["aws_config_configuration_recorder.main"]
}

resource "aws_config_config_rule" "s3-bucket-public-write-prohibited" {
	name        = "s3-bucket-public-write-prohibited"
	description = "Checks that your S3 buckets do not allow public write access."

	source {
		owner             = "AWS"
		source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
	}

	depends_on = ["aws_config_configuration_recorder.main"]
}

resource "aws_config_config_rule" "required-tags" {
	name        = "required-tags"
	description = "Checks that the required tags are added to all resources."
	input_parameters = <<EOF
{
	"tag1Key": "owner",
	"tag2Key": "product",
	"tag3Key": "team",
	"tag4Key": "description",
	"tag5Key": "use-case"
}
	EOF

	source {
		owner             = "AWS"
		source_identifier = "REQUIRED_TAGS"
	}

	depends_on = ["aws_config_configuration_recorder.main"]
}