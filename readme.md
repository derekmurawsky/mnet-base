# Murawsky Network Base Components for AWS

This sets up some base components for the Murawsky Network.

## Usage

This repo relies on terraform, terragrunt, and AWS. Ensure you have your AWS credentials configured properly. See [link](https://github.com/gruntwork-io/terragrunt#keep-your-remote-state-configuration-dry) for more details.

* Install terraform
* Install terragrunt
* Install AWSCLI
* Ensure iam credentials and profile are set up

## Notes

Terragrunt will create state and locking resources automatically if they do not already exist.
Use of the `AWS_DEFAULT_PROFILE` environment variable is strongly encouraged.
