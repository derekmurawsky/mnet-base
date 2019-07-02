# Murawsky Network Base Components for AWS

This sets up some base components for the Murawsky Network. Currently, we configure...

* Artifact storage bucket - Used to store build and deploy artifacts and as a backend for a handful of services. 

## Usage

This repo relies on terraform, terragrunt, and AWS. Ensure you have your AWS credentials configured properly. See [link](https://github.com/gruntwork-io/terragrunt#keep-your-remote-state-configuration-dry) for more details.

* Install terraform
* Install terragrunt
* Install AWSCLI
* Ensure iam credentials and profile are set up

## Individual Components

* [dns-updater.tf](docs/dns-updater.md) - Creates an IAM user that can update a specific DNS zone. 

## Notes

Terragrunt will create state and locking resources automatically if they do not already exist.
Use of the `AWS_DEFAULT_PROFILE` environment variable is strongly encouraged.
