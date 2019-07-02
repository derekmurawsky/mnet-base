# DNS Updater

The DNS Updater creates a user that can update a specific zone in route 53. The zone ID is stored in parameter store under `/terraform/dns-updater/zoneToUpdate`. This value can be manually or automatically provisioned. Additionally, this creates an access key and secret and stores them in `/terraform/dns-updater/access-key` and `/terraform/dns-updater/secret-access-key` respectively. 

> **WARNING**: Generating keys and storing them in this manner is only secure if your state files are encrypted. 