# Murawsky Network Base Components for AWS

This sets up some base components for the Murawsky Network. Currently, we configure...

* artifact-storage.tf - Creates an S3 bucket and policy for storage of build and deploy artifacts, and as a backend for a handful of services that deal with artifacts.
* [dns-updater.tf](docs/dns-updater.md) - Creates an IAM user that can update a specific DNS zone.

## Usage

This repo relies on terraform, terragrunt, and AWS. Ensure you have your AWS credentials configured properly. See [link](https://github.com/gruntwork-io/terragrunt#keep-your-remote-state-configuration-dry) for more details.

* Install terraform
* Install terragrunt
* Install AWSCLI
* Ensure iam credentials and profile are set up

## Notes

Terragrunt will create state and locking resources automatically if they do not already exist.
Use of the `AWS_DEFAULT_PROFILE` environment variable is strongly encouraged.
